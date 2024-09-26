package com.my_back_v1.Repositories;

import com.my_back_v1.Models.ConnectorEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface ConnectorRepository extends JpaRepository<ConnectorEntity, String> {
}
