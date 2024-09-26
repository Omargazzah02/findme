package com.my_back_v1.Services;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import com.my_back_v1.Dto.*;
import com.my_back_v1.Exceptions.EntityAlreadyExistsException;
import com.my_back_v1.Exceptions.EntityNotFoundException;
import com.my_back_v1.Models.Role;
import com.my_back_v1.Models.UserEntity;
import com.my_back_v1.Models.VehicleEntity;
import com.my_back_v1.Repositories.UserRepository;
import com.my_back_v1.Repositories.VehicleRepository;
import org.apache.catalina.User;
import org.springframework.context.support.BeanDefinitionDsl;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final VehicleRepository vehicleRepository;
    private final JavaMailSender    emailSender;


    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, VehicleRepository vehicleRepository, JavaMailSender emailSender) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.vehicleRepository = vehicleRepository;
        this.emailSender = emailSender;
    }


    public UserEntity userDetails() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        if (user == null) {
            throw new EntityNotFoundException("User not found");
        }

        return user;


    }


    public void updatePersonalInformation(PersonalInformationDto personalInformationDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        if (user == null) {
            throw new EntityNotFoundException("User not found");
        } else {

            user.setFirstName(personalInformationDto.getFirstName());
            user.setLastName(personalInformationDto.getLastName());
            user.setAddress(personalInformationDto.getAddress());
            user.setTelephone(personalInformationDto.getTelephone());
            user.setEmail(personalInformationDto.getEmail());
            userRepository.save(user);


        }


    }


    public void updatePassword(PasswordDto passwordDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserEntity user = (UserEntity) authentication.getPrincipal();
        if (user == null) {
            throw new EntityNotFoundException("User not found");
        } else {
            user.setPassword(passwordEncoder.encode(passwordDto.getPassword()));
            userRepository.save(user);
        }
    }


    public List<UserListDto> getAllUserList() {
        List<UserListDto> userList = new ArrayList<>();
        List<UserEntity> userEntities = userRepository.findAll();
        for (UserEntity user : userEntities) {
            UserListDto userListDto = new UserListDto();
            userListDto.setId(user.getId());
            userListDto.setName(user.getUsername());
            userList.add(userListDto);

        }
        return userList;

    }


    public void addUser(UserRequestDto userRequestDto) {
        // Vérifier si un autre utilisateur avec le même nom d'utilisateur existe
        Optional<UserEntity> userByUsername = userRepository.findByUsername(userRequestDto.getUsername());
        if (userByUsername.isPresent()) {
            throw new EntityAlreadyExistsException("Username already exists");
        }

        // Vérifier si un autre utilisateur avec le même email existe
        Optional<UserEntity> userByEmail = userRepository.findByEmail(userRequestDto.getEmail());
        if (userByEmail.isPresent() ) {
            throw new EntityAlreadyExistsException("Email already exists");
        }


        UserEntity user = new UserEntity();
        userSave(userRequestDto , user);


    }


    public UserRequestDto getUserRequestDto(int id) {
        UserEntity userEntity = userRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("User not found"));
        UserRequestDto userRequestDto = new UserRequestDto();
        userRequestDto.setUsername(userEntity.getUsername());
        userRequestDto.setEmail(userEntity.getEmail());
        userRequestDto.setFirstname(userEntity.getFirstName());
        userRequestDto.setLastname(userEntity.getLastName());
        userRequestDto.setTelephone(userEntity.getTelephone());
        userRequestDto.setAddress(userEntity.getAddress());
        userRequestDto.setRole(userEntity.getRole().toString());
        if (userEntity.getVehicle() != null) {
            userRequestDto.setVehicleId(userEntity.getVehicle().getId());

        }
        return userRequestDto;


    }


    public void updateUser(UserRequestDto userRequestDto, int id) {
        UserEntity userEntity = userRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("User not found"));

        // Vérifier si un autre utilisateur avec le même nom d'utilisateur existe
        Optional<UserEntity> userByUsername = userRepository.findByUsername(userRequestDto.getUsername());
        if (userByUsername.isPresent() && userByUsername.get().getId() != userEntity.getId()) {
            throw new EntityAlreadyExistsException("Username already exists");
        }

        // Vérifier si un autre utilisateur avec le même email existe
        Optional<UserEntity> userByEmail = userRepository.findByEmail(userRequestDto.getEmail());
        if (userByEmail.isPresent() && userByEmail.get().getId() != userEntity.getId()) {
            throw new EntityAlreadyExistsException("Email already exists");
        }




         userSave(userRequestDto , userEntity);

    }





    public void userSave (UserRequestDto userRequestDto , UserEntity user) {
        user.setUsername(userRequestDto.getUsername());
        user.setEmail(userRequestDto.getEmail());
        user.setFirstName(userRequestDto.getFirstname());
        user.setLastName(userRequestDto.getLastname());
        user.setTelephone(userRequestDto.getTelephone());

        user.setAddress(userRequestDto.getAddress());
        user.setRole(Role.valueOf(userRequestDto.getRole()));
        if (userRequestDto.getRole().equals("user")) {
            VehicleEntity vehicleEntity = vehicleRepository.findById(userRequestDto.getVehicleId()).orElseThrow(() -> new EntityNotFoundException("Vehicle not found"));
            user.setVehicle(vehicleEntity);

            if (userRequestDto.getPassword() != null ) {
                user.setPassword(passwordEncoder.encode(userRequestDto.getPassword()));
            }


        }


        userRepository.save(user);

    }



    public void deleteUser(int id) {
        UserEntity userEntity = userRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("User not found"));
        userRepository.delete(userEntity);
    }






    public void sendSimpleMessage(String to) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("gazzahomar2001@gmail.com");
        message.setTo(to);
        message.setSubject("Votre mot de passe");
        message.setText("hinega");
        emailSender.send(message);
    }


}



