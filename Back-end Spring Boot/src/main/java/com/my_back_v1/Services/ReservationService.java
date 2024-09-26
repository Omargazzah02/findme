package com.my_back_v1.Services;

import com.my_back_v1.Dto.ReservationRequestDto;
import com.my_back_v1.Dto.ReservationResponseDto;
import com.my_back_v1.Exceptions.EntityNotFoundException;
import com.my_back_v1.Exceptions.ReservationExistsException;
import com.my_back_v1.Exceptions.ReservationIsAlreadyCanceledException;
import com.my_back_v1.Models.*;
import com.my_back_v1.Repositories.ConnectorRepository;
import com.my_back_v1.Repositories.ReservationRepository;
import com.my_back_v1.Util.MyUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service

public class ReservationService {
    private  final MyUtils myUtils;
    private  final ReservationRepository reservationRepository;
    private final ConnectorRepository connectorRepository;

    public ReservationService(MyUtils myUtils, ReservationRepository reservationRepository, ConnectorRepository connectorRepository) {
        this.myUtils = myUtils;
        this.reservationRepository = reservationRepository;

        this.connectorRepository = connectorRepository;
    }

    public void addReservation (ReservationRequestDto reservationRequestDto) {

        // verifier l'id de connecteur

      ConnectorEntity connectorEntity = connectorRepository.findById(reservationRequestDto.getConnectorId()).orElseThrow(() -> new EntityNotFoundException("Connector not found"));





        // 3. Récupérer l'utilisateur connecté
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        //verifier si l'utilisateur a une reservation en cours
        List<ReservationEntity>  reservationEntities = user.getReservations();
        for (ReservationEntity reservationEntity : reservationEntities) {
            if (reservationEntity.getStatus() == Status.In_progress) {
                throw new ReservationExistsException("Reservation already exists");

            }

        }











        // créer la reservation
        ReservationEntity reservationEntity = new ReservationEntity();
        reservationEntity.setStatus(Status.In_progress);
        reservationEntity.setUser(user);
        reservationEntity.setStartTime(myUtils.convertStringToLocalDateTime(reservationRequestDto.getStartTime()));
        reservationEntity.setEndTime(myUtils.convertStringToLocalDateTime(reservationRequestDto.getEndTime()));
        reservationEntity.setConnector(connectorEntity);
        reservationRepository.save(reservationEntity);




    }

  public List<ReservationResponseDto> getAllReservations() {
      //  Récupérer l'utilisateur connecté
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
      UserEntity user = (UserEntity) authentication.getPrincipal();
      List<ReservationEntity>  reservationEntities = user.getReservations();
      List<ReservationResponseDto> reservationResponseDtos = new ArrayList<>();

      for (ReservationEntity reservationEntity : reservationEntities) {
         if (reservationEntity.getStatus() == Status.In_progress) {
             ReservationResponseDto reservationResponseDto = new ReservationResponseDto();
             reservationResponseDto = getReservationResponseDto(reservationEntity);
             reservationResponseDtos.add(reservationResponseDto);


         }


      }

      return reservationResponseDtos;


  }







    public List<ReservationResponseDto> getReservationHistory() {
        //  Récupérer l'utilisateur connecté
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        List<ReservationEntity>  reservationEntities = user.getReservations();
        List<ReservationResponseDto> reservationResponseDtos = new ArrayList<>();

        for (ReservationEntity reservationEntity : reservationEntities) {
            if (reservationEntity.getStatus() == Status.Completed || reservationEntity.getStatus() == Status.Cancelled) {
               ReservationResponseDto reservationResponseDto = new ReservationResponseDto();
               reservationResponseDto = getReservationResponseDto(reservationEntity);
               reservationResponseDtos.add(reservationResponseDto);

            }


        }

        return reservationResponseDtos;


    }









    public void cancelReservation (Integer reservationId) {
    ReservationEntity reservationEntity = reservationRepository.findById(reservationId).orElseThrow(() -> new EntityNotFoundException("Reservation not found"));

    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        List<ReservationEntity>  reservationEntities = user.getReservations();



    // Vérifier si la réservation avec le même ID est dans la liste des réservations de l'utilisateur
    boolean reservationExists = reservationEntities.stream()
            .anyMatch(reservation -> reservation.getId().equals(reservationId));

    System.out.println(reservationExists);


        if (!reservationExists) {
            throw new EntityNotFoundException("Reservation not found for this user");
        }
        if (reservationEntity.getStatus() == Status.Cancelled) {
            throw new ReservationIsAlreadyCanceledException("Reservation is already cancelled");
        }

        reservationEntity.setStatus(Status.Cancelled);
        reservationRepository.save(reservationEntity);




}






public ReservationResponseDto getReservationResponseDto (ReservationEntity reservationEntity) {
    ReservationResponseDto reservationResponseDto = new ReservationResponseDto();
    ChargingStationEntity chargingStationEntity = reservationEntity.getConnector().getEquipment().getChargingStation();
    reservationResponseDto.setIdReservation(reservationEntity.getId());
    reservationResponseDto.setIdConnector(reservationEntity.getConnector().getId());
    reservationResponseDto.setConnectorType(reservationEntity.getConnector().getEquipment().getConnectorType().getConnectorType());
    reservationResponseDto.setCurrentType(reservationEntity.getConnector().getEquipment().getConnectorType().getCurrentType().name());
    reservationResponseDto.setStartTime(myUtils.convertLocalDateTimeToString(reservationEntity.getStartTime()));
    reservationResponseDto.setEndTime(myUtils.convertLocalDateTimeToString(reservationEntity.getEndTime()));
    reservationResponseDto.setStationName(chargingStationEntity.getAddress());
    reservationResponseDto.setLatitude(chargingStationEntity.getLatitude());
    reservationResponseDto.setLongitude(chargingStationEntity.getLongitude());
    reservationResponseDto.setStatus(reservationEntity.getStatus());
    return reservationResponseDto;

}




}
