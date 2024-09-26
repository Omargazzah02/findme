package com.my_back_v1.Controllers;

import com.my_back_v1.Models.BrandEntity;
import com.my_back_v1.Services.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("brand")
public class BrandController {
    final BrandService brandService;

    public BrandController(BrandService brandService) {
        this.brandService = brandService;
    }




    @GetMapping("getall")
    public List<BrandEntity> getAllBrands() {
        return brandService.getAllBrands();
    }
}
