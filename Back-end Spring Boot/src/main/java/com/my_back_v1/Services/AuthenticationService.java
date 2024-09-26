package com.my_back_v1.Services;

import com.my_back_v1.Dto.UserLoginRequestDto;
import com.my_back_v1.Dto.UserRegisterRequestDto;
import com.my_back_v1.Exceptions.EntityAlreadyExistsException;
import com.my_back_v1.Exceptions.EntityNotFoundException;
import com.my_back_v1.Models.AuthenticationResponse;
import com.my_back_v1.Models.Role;
import com.my_back_v1.Models.UserEntity;
import com.my_back_v1.Models.VehicleEntity;
import com.my_back_v1.Repositories.UserRepository;
import com.my_back_v1.Repositories.VehicleRepository;
import org.modelmapper.ModelMapper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
public class AuthenticationService {
    private  final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private  final AuthenticationManager authenticationManager;
    private final ModelMapper modelMapper;
   private final VehicleRepository vehicleRepository;


    public AuthenticationService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtService jwtService, AuthenticationManager authenticationManager, ModelMapper modelMapper, VehicleRepository vehicleRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.modelMapper = modelMapper;
        this.vehicleRepository = vehicleRepository;
    }



    public void registerUser (UserRegisterRequestDto userRequestDto) {

        Optional<UserEntity> existingUsername = userRepository.findByUsername(userRequestDto.getUsername());
        if (existingUsername.isPresent()) {
            throw new EntityAlreadyExistsException("Username already exists");

        }
        Optional<UserEntity> existingEmail = userRepository.findByEmail(userRequestDto.getEmail());
        if (existingEmail.isPresent()) {
            throw new EntityAlreadyExistsException("Email already exists");

        }


        VehicleEntity vehicleEntity = vehicleRepository.findById(userRequestDto.getVehiculeId()).orElseThrow(() ->  new RuntimeException("Vehicle not exist"));
        UserEntity userEntity = new UserEntity();
        userEntity.setVehicle(vehicleEntity);
        userEntity.setAddress(userRequestDto.getAddress());
        userEntity.setUsername(userRequestDto.getUsername());
        userEntity.setPassword(passwordEncoder.encode(userRequestDto.getPassword()));
        userEntity.setEmail(userRequestDto.getEmail());
        userEntity.setFirstName(userRequestDto.getFirstName());
        userEntity.setLastName(userRequestDto.getLastName());
        userEntity.setTelephone(userRequestDto.getTelephone());
        userEntity.setRole(Role.user);
        userRepository.save(userEntity);



    }

    public AuthenticationResponse loginUser(UserLoginRequestDto userLoginRequestDto)  {

UserEntity userEntity = userRepository.findByUsername(userLoginRequestDto.getUsername()).orElseThrow(()-> new EntityNotFoundException("User not exist"));
authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(userLoginRequestDto.getUsername(),userLoginRequestDto.getPassword())

);
String token = jwtService.generateToken(userEntity);
return new AuthenticationResponse(token);

    }








    public AuthenticationResponse loginAdmin(UserLoginRequestDto userLoginRequestDto)  {

        UserEntity userEntity = userRepository.findByUsernameAndRole(userLoginRequestDto.getUsername() , Role.admin).orElseThrow(()-> new EntityNotFoundException("Admin not exist"));
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(userLoginRequestDto.getUsername(),userLoginRequestDto.getPassword())

        );
        String token = jwtService.generateToken(userEntity);
        return new AuthenticationResponse(token);

    }




}
