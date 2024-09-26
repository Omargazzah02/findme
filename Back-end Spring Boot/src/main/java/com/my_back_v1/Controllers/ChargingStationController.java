package com.my_back_v1.Controllers;

import com.my_back_v1.Dto.ChargingStationSearchDto;
import com.my_back_v1.Dto.SearchStationsRequestDto;
import com.my_back_v1.Dto.StationListDto;
import com.my_back_v1.Services.ChargingStationService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("station")
public class ChargingStationController {

    final  private ChargingStationService chargingStationService;

    public ChargingStationController(ChargingStationService chargingStationService) {
        this.chargingStationService = chargingStationService;
    }


    @GetMapping ("search")

    public List<ChargingStationSearchDto> searchStations (@ModelAttribute SearchStationsRequestDto searchStationsRequestDto) {

        return  chargingStationService.searchStations(searchStationsRequestDto);
    }




}
