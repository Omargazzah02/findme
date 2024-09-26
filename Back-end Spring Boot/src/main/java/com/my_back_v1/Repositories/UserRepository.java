package com.my_back_v1.Repositories;

import com.my_back_v1.Models.Role;
import com.my_back_v1.Models.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    Optional<UserEntity> findByUsername(String username);
    Optional<UserEntity> findByUsernameOrEmail(String username, String email);
    Optional<UserEntity> findByUsernameAndRole(String username, Role role);
    Optional<UserEntity> findByEmail(String email);
}
