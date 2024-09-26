package com.my_back_v1.Repositories;

import com.my_back_v1.Models.ConnectorSupportEntity;
import com.my_back_v1.Models.VehicleEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ConnectorSupportRepository extends JpaRepository<ConnectorSupportEntity , Integer> {
     @Modifying
     @Transactional

     @Query("DELETE FROM ConnectorSupportEntity c WHERE c.vehicle = :vehicle")
    public void deleteAllByVehicle(VehicleEntity vehicle);
}
