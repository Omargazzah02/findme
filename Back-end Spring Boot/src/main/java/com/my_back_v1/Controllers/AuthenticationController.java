package com.my_back_v1.Controllers;

import com.my_back_v1.Dto.UserLoginRequestDto;
import com.my_back_v1.Dto.UserRegisterRequestDto;
import com.my_back_v1.Models.AuthenticationResponse;
import com.my_back_v1.Services.AuthenticationService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class AuthenticationController {

   private final AuthenticationService authenticationService;

    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }


    @PostMapping("register/user")
    public ResponseEntity<String> registerUser(@RequestBody @Valid UserRegisterRequestDto userRequestDto) {
        authenticationService.registerUser(userRequestDto);
        return ResponseEntity.status(HttpStatus.CREATED).body("User registered successfully");
    }


    @PostMapping("login/user")
    public ResponseEntity<AuthenticationResponse> loginUser(@RequestBody @Valid UserLoginRequestDto  userLoginRequestDto) {
        return ResponseEntity.ok(authenticationService.loginUser(userLoginRequestDto));
    }


    @PostMapping("login/admin")
    public ResponseEntity<AuthenticationResponse> loginAdmin(@RequestBody @Valid UserLoginRequestDto  userLoginRequestDto) {
        return ResponseEntity.ok(authenticationService.loginAdmin(userLoginRequestDto));
    }




}
