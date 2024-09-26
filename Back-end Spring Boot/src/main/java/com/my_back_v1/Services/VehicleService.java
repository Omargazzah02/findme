package com.my_back_v1.Services;

import com.my_back_v1.Dto.ConnectorSupportDto;
import com.my_back_v1.Dto.VehicleRequestDto;
import com.my_back_v1.Dto.VehicleResponseDto;
import com.my_back_v1.Exceptions.EntityNotFoundException;
import com.my_back_v1.Models.*;
import com.my_back_v1.Dto.VehicleDto;
import com.my_back_v1.Repositories.*;
import jakarta.transaction.Transactional;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class VehicleService {
    final private VehicleRepository vehicleRepository;
    final  private BrandRepository brandRepository;
    final  private  UserRepository userRepository;
  final   private ConnectorSupportRepository connectorSupportRepository;

  final  private ConnectorTypeRepository connectorTypeRepository;


    public VehicleService(VehicleRepository vehicleRepository, BrandRepository brandRepository, UserRepository userRepository, ConnectorSupportRepository connectorSupportRepository, ConnectorTypeRepository connectorTypeRepository) {
        this.vehicleRepository = vehicleRepository;

        this.brandRepository = brandRepository;
        this.userRepository = userRepository;
        this.connectorSupportRepository = connectorSupportRepository;
        this.connectorTypeRepository = connectorTypeRepository;
    }

    public List<VehicleEntity>  findAllByBrand(String brandId) {
   BrandEntity brandEntity = brandRepository.findById(brandId).orElseThrow(()-> new EntityNotFoundException("Brand not found"));



       return vehicleRepository.findAllByBrand(brandEntity);







    }

    public VehicleEntity getVehicle () {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        if (user== null) {
            throw new EntityNotFoundException("User not found");
        }



        return user.getVehicle();
    }



    public void updateVehicle (VehicleDto vehicleDto) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        if (user == null) {
            throw new EntityNotFoundException("User not found");
        }
        else
        {
            VehicleEntity vehicleEntity = vehicleRepository.findById(vehicleDto.getId()).get();
            user.setVehicle(vehicleEntity);
            userRepository.save(user);

        }
    }








    public List<VehicleResponseDto>  getAllByBrand(String brandId ) {
        List<VehicleResponseDto> vehicleResponseDtos = new ArrayList<>();
       BrandEntity brand= brandRepository.findById(brandId).orElseThrow(()-> new EntityNotFoundException("Brand not found"));
      List<VehicleEntity> vehicleEntities =  vehicleRepository.findAllByBrand(brand);
      for (VehicleEntity vehicleEntity : vehicleEntities) {
          VehicleResponseDto vehicleResponseDto = new VehicleResponseDto();
         vehicleResponseDto = entityToResponseDto(vehicleEntity);
          vehicleResponseDtos.add(vehicleResponseDto);
      }
      return vehicleResponseDtos;

    }



    public VehicleResponseDto getVehicleById(String id)  {
        VehicleResponseDto vehicleResponseDto = new VehicleResponseDto();
        VehicleEntity vehicleEntity = vehicleRepository.findById(id).orElseThrow(()-> new EntityNotFoundException("Vehicle not found"));
        vehicleResponseDto = entityToResponseDto(vehicleEntity);

        return vehicleResponseDto;
    }





    public List<ConnectorSupportDto> getConnectorsByVehicle(String vehicleId) {
        VehicleEntity vehicleEntity = vehicleRepository.findById(vehicleId).orElseThrow(()-> new EntityNotFoundException("Vehicle not found"));
        List<ConnectorSupportDto> connectorSupportDtos = new ArrayList<>();
        List<ConnectorSupportEntity> connectorSupportEntities = vehicleEntity.getConnectorSupportEntities();
        for ( ConnectorSupportEntity connectorSupportEntity : connectorSupportEntities) {
            ConnectorSupportDto connectorSupportDto = new ConnectorSupportDto();
            connectorSupportDto.setId(connectorSupportEntity.getConnectorType().getId());
            connectorSupportDtos.add(connectorSupportDto);
        }

        return connectorSupportDtos;
    }



    @Transactional

    public void addVehicle(VehicleRequestDto vehicleRequestDto) {
        VehicleEntity vehicleEntity = new VehicleEntity();
        saveVehicle(vehicleRequestDto, vehicleEntity);



    }


    @Transactional
    public void updateVehicleAdmin(VehicleRequestDto vehicleRequestDto , String VehicleId) {
        VehicleEntity vehicleEntity = vehicleRepository.findById(VehicleId).orElseThrow(()-> new EntityNotFoundException("Vehicle not found"));
        saveVehicle(vehicleRequestDto, vehicleEntity);



    }



    public void deleteVehicleById(String vehicleId) {

        VehicleEntity vehicleEntity = vehicleRepository.findById(vehicleId).orElseThrow(()-> new EntityNotFoundException("Vehicle not found"));
        connectorSupportRepository.deleteAllByVehicle(vehicleEntity);

        vehicleRepository.delete(vehicleEntity);


    }




    public List<VehicleResponseDto> getAllVehicles () {
        List<VehicleResponseDto> vehicleResponseDtos = new ArrayList<>();
        List<VehicleEntity> vehicleEntities =  vehicleRepository.findAll();
        for (VehicleEntity vehicleEntity : vehicleEntities) {
            VehicleResponseDto vehicleResponseDto = entityToResponseDto(vehicleEntity);
            vehicleResponseDtos.add(vehicleResponseDto);
        }
        return vehicleResponseDtos;

    }




































    public VehicleResponseDto entityToResponseDto(VehicleEntity vehicleEntity) {
        VehicleResponseDto vehicleResponseDto = new VehicleResponseDto();
        vehicleResponseDto.setId(vehicleEntity.getId());
        vehicleResponseDto.setName(vehicleEntity.getName());
        vehicleResponseDto.setModel(vehicleEntity.getModel());
        vehicleResponseDto.setBrandId(vehicleEntity.getBrand().getId());
        vehicleResponseDto.setVehicleType(vehicleEntity.getVehicleType());
        vehicleResponseDto.setVariant(vehicleEntity.getVariant());
        vehicleResponseDto.setModel(vehicleEntity.getModel());
        vehicleResponseDto.setReleaseYear(vehicleEntity.getReleaseYear());
        vehicleResponseDto.setBatteryCapacityKwh(vehicleEntity.getBatteryCapacityKwh());
        vehicleResponseDto.setAverageEnergyConsumptionKwhPerKm(vehicleEntity.getAverageEnergyConsumptionKwhPerKm());
        vehicleResponseDto.setAcChargerMaxPower(vehicleEntity.getAcChargerMaxPower());
        vehicleResponseDto.setDcChargerMaxPower(vehicleEntity.getDcChargerMaxPower() != null ? vehicleEntity.getDcChargerMaxPower() : 0);
        return vehicleResponseDto;
    }

    @Transactional
    public void saveVehicle(VehicleRequestDto vehicleRequestDto, VehicleEntity vehicleEntity) {
        // Mettre à jour les informations du véhicule
        BrandEntity brandEntity = brandRepository.findById(vehicleRequestDto.getBrandId())
                .orElseThrow(() -> new EntityNotFoundException("Brand not found"));
        vehicleEntity.setBrand(brandEntity);
        vehicleEntity.setVehicleType(vehicleRequestDto.getVehicleType());
        vehicleEntity.setVariant(vehicleRequestDto.getVariant());
        vehicleEntity.setModel(vehicleRequestDto.getModel());
        vehicleEntity.setReleaseYear(vehicleRequestDto.getReleaseYear());
        vehicleEntity.setBatteryCapacityKwh(vehicleRequestDto.getBatteryCapacityKwh());
        vehicleEntity.setAverageEnergyConsumptionKwhPerKm(vehicleRequestDto.getAverageEnergyConsumptionKwhPerKm());
        vehicleEntity.setAcChargerMaxPower(vehicleRequestDto.getAcChargerMaxPower());
        vehicleEntity.setDcChargerMaxPower(vehicleRequestDto.getDcChargerMaxPower());

        vehicleEntity.setName(brandEntity.getName() + " " + vehicleRequestDto.getModel() + " " + vehicleRequestDto.getReleaseYear() + " " + vehicleRequestDto.getVariant());
        vehicleRepository.save(vehicleEntity);

        // Supprimer tous les connecteurs existants associés au véhicule
        connectorSupportRepository.deleteAllByVehicle(vehicleEntity);

        // Ajouter les nouveaux connecteurs
        List<Integer> connectors = vehicleRequestDto.getConnectors();
        for (Integer connectorId : connectors) {
            ConnectorTypeEntity connectorType = connectorTypeRepository.findById(connectorId)
                    .orElseThrow(() -> new EntityNotFoundException("Connector type not found"));
            ConnectorSupportEntity csEntity = new ConnectorSupportEntity();
            csEntity.setConnectorType(connectorType);
            csEntity.setVehicle(vehicleEntity);
            connectorSupportRepository.save(csEntity);
        }
    }
















}
