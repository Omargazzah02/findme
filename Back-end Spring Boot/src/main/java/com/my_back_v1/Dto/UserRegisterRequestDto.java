package com.my_back_v1.Dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.validation.annotation.Validated;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class UserRegisterRequestDto {

// username , email  , lastName , firstName , telephone , address , password , vehiculeId

    @NotBlank(message = "Username is mandatory")
    private String username;

    @Email(message = " Email should be valid")
    @NotBlank(message = " Email is mandatory")
    private String email;

    @NotBlank(message = "First name is mandatory")
    private String firstName;

    @NotBlank(message = "Last name is mandatory")
    private String lastName;

    @NotBlank(message = "Telephone is mandatory")
    private String telephone;

    @NotBlank(message = "Address is mandatory")
    private String address;

    @NotBlank (message = "Password is mandatory")
    private String password;


    @NotNull(message = "Vehicle ID is mandatory")
    private String vehiculeId;




}
