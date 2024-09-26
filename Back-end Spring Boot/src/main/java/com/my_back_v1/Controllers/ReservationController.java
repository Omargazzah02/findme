package com.my_back_v1.Controllers;

import com.my_back_v1.Dto.ReservationRequestDto;
import com.my_back_v1.Dto.ReservationResponseDto;
import com.my_back_v1.Services.ReservationService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("reservation")
public class ReservationController {
    final ReservationService reservationService;

    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @PostMapping("add")
    public void addReservation (@RequestBody ReservationRequestDto reservationRequestDto)
    {
        reservationService.addReservation(reservationRequestDto);
    }


    @GetMapping("get")

    public List<ReservationResponseDto> getAllReservations () {
        return reservationService.getAllReservations();


    }

    @DeleteMapping("cancel/{id}" )
    public void cancelReservation (@PathVariable int id) {
        reservationService.cancelReservation(id);
    }



    @GetMapping("get-history")

    public List<ReservationResponseDto> getReservationHistory () {
        return reservationService.getReservationHistory();


    }





}
