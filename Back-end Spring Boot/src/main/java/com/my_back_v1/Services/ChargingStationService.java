package com.my_back_v1.Services;

import com.my_back_v1.Dto.*;
import com.my_back_v1.Exceptions.InvalidBatteryLevelException;
import com.my_back_v1.Models.*;
import com.my_back_v1.Repositories.ChargingStationRepository;
import com.my_back_v1.Util.MyUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service

public class ChargingStationService {
    final private ChargingStationRepository chargingStationRepository;
    final private MyUtils myUtils ;

    public ChargingStationService(ChargingStationRepository chargingStationRepository, MyUtils myUtils) {
        this.chargingStationRepository = chargingStationRepository;
        this.myUtils = myUtils;

    }



    public List<ChargingStationSearchDto> searchStations(SearchStationsRequestDto searchStationsRequestDto) {
        System.out.println(searchStationsRequestDto.getIsCompatibleMeth());
        if (isBatteryLevelInValid(searchStationsRequestDto)){
            throw new InvalidBatteryLevelException("The battery levels are invalid.");

        }


        // 1. Récupérer toutes les stations de recharge depuis le dépôt
        List<ChargingStationEntity> chargingStationEntities = chargingStationRepository.findAll();


        // 2. Initialiser la liste des résultats des stations de recharge
        List<ChargingStationSearchDto> chargingStationSearchDtos = new ArrayList<>();

        // 3. Récupérer l'utilisateur connecté
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();

        // 4. Récupérer le véhicule de l'utilisateur
        VehicleEntity vehicle = user.getVehicle();

        // 5. Calculer l'énergie restante en kWh dans la batterie
        double remainingBatteryEnergyKWh = vehicle.getBatteryCapacityKwh() * searchStationsRequestDto.getCurrentBatteryLevel() / 100;
        // 6. Calculer l'autonomie en km avec une marge de sécurité de 5 km
        double drivingRangeKm = (remainingBatteryEnergyKWh / vehicle.getAverageEnergyConsumptionKwhPerKm() /1.1) - 5;
        // 7. Récupérer les connecteurs supportés par le véhicule
        List<ConnectorSupportEntity> connectorSupportEntities = vehicle.getConnectorSupportEntities();
        List<ConnectorTypeEntity> compatibleConnectors = new ArrayList<>();
        for (ConnectorSupportEntity connectorSupportEntity : connectorSupportEntities) {
            compatibleConnectors.add(connectorSupportEntity.getConnectorType());
        }

        // 8. Récupérer la puissance max acceptée par le véhicule en AC et en DC en kW
        double acChargerMaxPower = vehicle.getAcChargerMaxPower();
        double dcChargerMaxPower = vehicle.getDcChargerMaxPower() != null ? vehicle.getDcChargerMaxPower() : 0;

        // 9. Parcourir toutes les stations de recharge
        for (ChargingStationEntity chargingStationEntity : chargingStationEntities) {
            // 10. Calculer la distance entre la station et le conducteur en km
            System.out.println(chargingStationEntity.getLatitude());
            System.out.println(chargingStationEntity.getLongitude());

            double distanceKm = myUtils.calculateDistance(searchStationsRequestDto.getLatitude(), searchStationsRequestDto.getLongitude(),
                    chargingStationEntity.getLatitude(), chargingStationEntity.getLongitude());

            // 11. Vérifier si la station est dans l'autonomie du véhicule
            if (distanceKm < drivingRangeKm) {
                ;
                // 12. Initialiser les équipements compatibles pour cette station
                List<EquipmentSearchDTO> equipmentSearchDTOS = new ArrayList<>();

                // 13. Calculer l'énergie restante en kWh quand le véhicule arrivera à la station
                double remainingEnergyKWh = remainingBatteryEnergyKWh - (vehicle.getAverageEnergyConsumptionKwhPerKm() * distanceKm);

                // 14. Calculer le niveau de batterie restant en pourcentage quand le véhicule arrivera à la station
                double remainingBatteryLevel = (remainingEnergyKWh / vehicle.getBatteryCapacityKwh()) * 100;



                // 15. Estimer la durée de trajet en minutes jusqu'à la station
                double durationMin = myUtils.estimateTravelTime(searchStationsRequestDto.getLatitude(), searchStationsRequestDto.getLongitude(),
                        chargingStationEntity.getLatitude(), chargingStationEntity.getLongitude());

                // 16. Parcourir les équipements de la station
                List<EquipmentEntity> equipmentEntities = chargingStationEntity.getEquipments();
                for (EquipmentEntity equipmentEntity : equipmentEntities) {
                    // Vérifier la compatibilité de l'équipement avec les connecteurs du véhicule
                    boolean isCompatible = checkCompatible(compatibleConnectors , equipmentEntity);
                    boolean isCompatibleMeth  = searchStationsRequestDto.getIsCompatibleMeth();

                    if (!isCompatibleMeth || isCompatible) {
                        // 17. Créer un nouveau DTO pour l'équipement
                        EquipmentSearchDTO equipmentSearchDTO = createEquipmentSearchDTO(vehicle, equipmentEntity, remainingEnergyKWh, durationMin, chargingStationEntity , searchStationsRequestDto.getDesiredBatteryLevel());

                        // 18. Ajouter l'équipement au résultat
                        equipmentSearchDTOS.add(equipmentSearchDTO);
                    }
                }

                // 19. Si des équipements compatibles ont été trouvés, ajouter les informations de la station au résultat
                if (!equipmentSearchDTOS.isEmpty()) {
                    ChargingStationSearchDto chargingStationSearchDto = createChargingStationSearchDTO(chargingStationEntity, distanceKm, durationMin, remainingBatteryLevel, equipmentSearchDTOS);
                    chargingStationSearchDtos.add(chargingStationSearchDto);
                }
            }
        }

        // 20. Retourner la liste des stations de recharge compatibles
        return chargingStationSearchDtos;
    }

    // Méthode utilitaire pour créer un DTO pour l'équipement
    private EquipmentSearchDTO createEquipmentSearchDTO(VehicleEntity vehicle, EquipmentEntity equipmentEntity, double remainingEnergyKWh, double durationMin, ChargingStationEntity chargingStationEntity, Integer desiredBatteryLevel ) {
        EquipmentSearchDTO equipmentSearchDTO = new EquipmentSearchDTO();
        List<ConnectorEntity> connectorEntities = equipmentEntity.getConnectors();

        // Déterminer la puissance maximale de charge du véhicule en fonction du type de courant (AC ou DC)
        double acChargerMaxPower = vehicle.getAcChargerMaxPower();
        double dcChargerMaxPower = vehicle.getDcChargerMaxPower() != null ? vehicle.getDcChargerMaxPower() : 0;
        double maxVehiclePower = equipmentEntity.getConnectorType().getCurrentType().equals(CurrentType.AC) ? acChargerMaxPower : dcChargerMaxPower;

        // Calculer la quantité d'énergie à charger en kWh
        double kWhToCharge = (desiredBatteryLevel * vehicle.getBatteryCapacityKwh() / 100) - remainingEnergyKWh;

        // Estimer le temps de chargement en minutes
        double chargingTimeMinutes = kWhToCharge / Math.min(equipmentEntity.getPowerKw(), maxVehiclePower) * 60;

        // Remplir les informations de l'équipement dans le DTO
        equipmentSearchDTO.setConnectorType(equipmentEntity.getConnectorType().getConnectorType());
        equipmentSearchDTO.setCurrentType(equipmentEntity.getConnectorType().getCurrentType().name());
        equipmentSearchDTO.setConnectorTypeId(equipmentEntity.getConnectorType().getId());
        equipmentSearchDTO.setPowerKw(equipmentEntity.getPowerKw());
        equipmentSearchDTO.setQuantity(equipmentEntity.getQuantity());
        equipmentSearchDTO.setPricePerKwh(equipmentEntity.getPricePerKwh());
        double price = kWhToCharge * equipmentEntity.getPricePerKwh();
        equipmentSearchDTO.setPrice(myUtils.roundToTwoDecimals(price));

        equipmentSearchDTO.setChargingDuration(myUtils.convertMinutesToDuration((int) chargingTimeMinutes));

        // Estimer l'heure de départ et de fin de chargement
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDateTime startTime = currentTime.plusMinutes((long) durationMin); // durationMin
        LocalDateTime endTime = startTime.plusMinutes((long) chargingTimeMinutes); //chargingTimeMinutes


        equipmentSearchDTO.setStartTime(myUtils.convertLocalDateTimeToString(startTime));
        equipmentSearchDTO.setEndTime(myUtils.convertLocalDateTimeToString(endTime));

        // Remplir les informations des connecteurs dans le DTO
        for (ConnectorEntity connectorEntity : connectorEntities) {
            ConnectorSearchDTO connectorSearchDTO = new ConnectorSearchDTO();
            connectorSearchDTO.setId(connectorEntity.getId());
            connectorSearchDTO.setAvailability(myUtils.isConnectorAvailable(connectorEntity, startTime, endTime));
            equipmentSearchDTO.addConnector(connectorSearchDTO);

        }

        return equipmentSearchDTO;
    }

    // Méthode utilitaire pour créer un DTO pour la station de recharge
    private ChargingStationSearchDto createChargingStationSearchDTO(ChargingStationEntity chargingStationEntity, double distanceKm, double durationMin, double remainingBatteryLevel, List<EquipmentSearchDTO> equipmentSearchDTOS) {
        ChargingStationSearchDto chargingStationSearchDto = new ChargingStationSearchDto();
        chargingStationSearchDto.setAddress(chargingStationEntity.getAddress());
        chargingStationSearchDto.setPostcode(chargingStationEntity.getPostCode());
        chargingStationSearchDto.setLatitude(chargingStationEntity.getLatitude());
        chargingStationSearchDto.setLongitude(chargingStationEntity.getLongitude());
        chargingStationSearchDto.setDistanceKm((int) distanceKm);
        chargingStationSearchDto.setDuration(myUtils.convertMinutesToDuration((int) durationMin));
        chargingStationSearchDto.setRemainingBatteryLevel((int) remainingBatteryLevel);
        chargingStationSearchDto.setEquipments(equipmentSearchDTOS);
        return chargingStationSearchDto;
    }


   private boolean  checkCompatible  (List<ConnectorTypeEntity> compatibleConnectors , EquipmentEntity equipmentEntity) {
        for (ConnectorTypeEntity connectorTypeEntity : compatibleConnectors) {
            if (connectorTypeEntity.getId().equals(equipmentEntity.getConnectorType().getId())) {
                return true;
            }
        }
        return false;

   }




    public boolean isBatteryLevelInValid(SearchStationsRequestDto searchStationsRequestDto) {
        int currentBatteryLevel = searchStationsRequestDto.getCurrentBatteryLevel();
        int desiredBatteryLevel = searchStationsRequestDto.getDesiredBatteryLevel();

        // Conditions à vérifier
        boolean isCurrentBatteryLevelInvalid = currentBatteryLevel > 100 || currentBatteryLevel < 0;
        boolean isDesiredBatteryLevelInvalid = desiredBatteryLevel > 100 || desiredBatteryLevel < 0;
        boolean isDesiredLessThanCurrent = desiredBatteryLevel < currentBatteryLevel;

        return (isCurrentBatteryLevelInvalid || isDesiredBatteryLevelInvalid || isDesiredLessThanCurrent);
    }



    public List<StationListDto> getAllStations() {
        List<StationListDto> stationListDtos = new ArrayList<>();
        List<ChargingStationEntity> chargingStationEntities = chargingStationRepository.findAll();
        for (ChargingStationEntity chargingStationEntity : chargingStationEntities) {
            StationListDto stationListDto = new StationListDto();
            stationListDto.setId(chargingStationEntity.getId());
            stationListDto.setName(chargingStationEntity.getAddress());
            stationListDtos.add(stationListDto);
        }
        return stationListDtos;
    }


}
