package com.my_back_v1.Repositories;

import com.my_back_v1.Models.BrandEntity;
import com.my_back_v1.Models.VehicleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository

public interface VehicleRepository extends JpaRepository<VehicleEntity, String> {
public List<VehicleEntity> findAllByBrand(BrandEntity brand);

}
