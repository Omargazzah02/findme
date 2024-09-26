package com.my_back_v1.Controllers;

import com.my_back_v1.Dto.VehicleDto;
import com.my_back_v1.Models.VehicleEntity;
import com.my_back_v1.Services.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("vehicle")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

   @GetMapping("getallbybrand/{brand}")
    public List<VehicleEntity> findAllByBrand (@PathVariable String brand) {
        return vehicleService.findAllByBrand(brand);

    }

    @GetMapping("get")
    public VehicleEntity getVehicle() {
       return vehicleService.getVehicle();
    }


    @PutMapping("update")
    public void updateVehicle(@RequestBody VehicleDto vehicleDto) {
       vehicleService.updateVehicle(vehicleDto);
    }





 }
