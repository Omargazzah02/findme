package com.my_back_v1.Controllers;

import com.my_back_v1.Dto.*;
import com.my_back_v1.Models.BrandEntity;
import com.my_back_v1.Services.BrandService;
import com.my_back_v1.Services.ChargingStationService;
import com.my_back_v1.Services.UserService;
import com.my_back_v1.Services.VehicleService;
import com.my_back_v1.Services.connectors.ConnectorTypeService;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("admin_only/")
public class AdminController {

 private    final BrandService brandService;
  private   final VehicleService vehicleService;
 private    final ConnectorTypeService connectorTypeService;
 private    final UserService userService;
 private final ChargingStationService chargingStationService;

    public AdminController(BrandService brandService, VehicleService vehicleService, ConnectorTypeService connectorTypeService, UserService userService, ChargingStationService chargingStationService) {
        this.brandService = brandService;
        this.vehicleService = vehicleService;
        this.connectorTypeService = connectorTypeService;
        this.userService = userService;
        this.chargingStationService = chargingStationService;
    }


    @GetMapping("get-all-brands")
    public List<BrandEntity> getAllBrands() {

        return brandService.getAllBrands();


    }
    @GetMapping("get-vehicles-by-brand/{id}")
    public List<VehicleResponseDto> findAllByBrand(@PathVariable String  id) {


        return  vehicleService.getAllByBrand(id);


    }

    @GetMapping("get-connectortypes")
    public List<ConnectorTypeDto> getAllConnectorTypes() {
        return connectorTypeService.getAllConnectorTypes();

    }

    @GetMapping("get-vehicle-by-id/{id}")
    public VehicleResponseDto getVehicleById(@PathVariable String id) {
        return vehicleService.getVehicleById(id);
    }

    @GetMapping ("get-connectors-by-vehicle/{id}")
    public List<ConnectorSupportDto> getConnectorsByVehicle(@PathVariable String id ) {
        return  vehicleService.getConnectorsByVehicle(id);
    }

    @GetMapping ("get-brand-by-id/{id}")
    public BrandEntity getBrandById(@PathVariable String id) {
      return   brandService.getBrandById(id);

    }


    @PostMapping ("add-vehicle")
    public void addVehicle(@RequestBody VehicleRequestDto vehicleRequestDto) {
        vehicleService.addVehicle(vehicleRequestDto);
    }


    @PutMapping ("update-vehicle/{id}")
    public void updateVehicle(@RequestBody VehicleRequestDto vehicleRequestDto ,  @PathVariable String id) {
        vehicleService.updateVehicleAdmin(vehicleRequestDto , id);
    }

    @DeleteMapping("delete-vehicle/{id}")
    public void deleteVehicle(@PathVariable String id) {
        vehicleService.deleteVehicleById(id);

    }

    @PostMapping ("add-brand")
    public void addBrand(@RequestBody BrandRequestDto brandRequestDto) {
        brandService.addBrand(brandRequestDto);
    }

    @PutMapping("update-brand/{id}")
    public void updateBrand(@PathVariable String id, @RequestBody BrandRequestDto brandRequestDto) {
        brandService.updateBrand(brandRequestDto,id);
    }

    @DeleteMapping("delete-brand/{id}")
    public void deleteBrand (@PathVariable String id )
    {
        brandService.deleteBrand(id);
    }


    @GetMapping ("get-all-users")
    public List<UserListDto> getAllUsers() {
        return userService.getAllUserList();
    }




    @GetMapping("get-all-vehicles")
    public List<VehicleResponseDto> getAllVehicles() {
        return vehicleService.getAllVehicles();
    }



    @PostMapping("add-user")
    public void addUser(@RequestBody UserRequestDto userRequestDto) {
        userService.addUser(userRequestDto);
    }

    @GetMapping("get-user/{id}")
    public UserRequestDto getUserRequestDto(@PathVariable int  id) {
       return userService.getUserRequestDto(id);
    }

    @PutMapping ("update-user/{id}")
    public void updateUser(@RequestBody UserRequestDto userRequestDto, @PathVariable int id) {
        userService.updateUser(userRequestDto,id);
    }

    @GetMapping("/get-all-stations")

    public List<StationListDto>getAllStations () {
        return chargingStationService.getAllStations();


    }


    @DeleteMapping("/delete-user/{id}")
    public void  deleteUser(@PathVariable  int id) {
        userService.deleteUser(id );
    }


}
