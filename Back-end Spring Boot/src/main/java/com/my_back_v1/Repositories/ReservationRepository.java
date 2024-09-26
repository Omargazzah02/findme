package com.my_back_v1.Repositories;

import com.my_back_v1.Models.ReservationEntity;
import com.my_back_v1.Models.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping
public interface ReservationRepository extends JpaRepository<ReservationEntity , Integer> {


}
