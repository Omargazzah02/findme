package com.my_back_v1.Services;

import com.my_back_v1.Dto.BrandDto;
import com.my_back_v1.Dto.BrandRequestDto;
import com.my_back_v1.Models.BrandEntity;
import com.my_back_v1.Repositories.BrandRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BrandService {
    final BrandRepository brandRepository;

    public BrandService(BrandRepository brandRepository) {
        this.brandRepository = brandRepository;
    }

    public List<BrandEntity> getAllBrands() {
        return brandRepository.findAll();

    }

    public BrandEntity getBrandById(String id) {
        return brandRepository.findById(id).orElseThrow(()-> new RuntimeException("Brand not found"));
    }



    public void addBrand(BrandRequestDto requestDto) {
        BrandEntity brandEntity = new BrandEntity();
        brandEntity.setName(requestDto.getName());
        brandRepository.save(brandEntity);

    }



    public void deleteBrand(String id) {
        BrandEntity brandEntity = brandRepository.findById(id).orElseThrow(()-> new RuntimeException("Brand not found"));
        brandRepository.deleteById(id);

    }


    public void updateBrand(BrandRequestDto requestDto , String id ) {
        BrandEntity brandEntity = brandRepository.findById(id).orElseThrow(()-> new RuntimeException("Brand not found"));
        brandEntity.setName(requestDto.getName());
        brandRepository.save(brandEntity);

    }



}

