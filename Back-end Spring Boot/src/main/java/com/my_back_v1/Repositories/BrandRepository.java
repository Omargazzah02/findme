package com.my_back_v1.Repositories;

import com.my_back_v1.Models.BrandEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface BrandRepository  extends JpaRepository<BrandEntity,String> {




}
