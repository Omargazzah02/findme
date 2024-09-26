package com.my_back_v1.Dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class PersonalInformationDto {


    @NotBlank(message = "First name is mandatory")
    private String firstName;
    @NotBlank(message = "Last name is mandatory")

    @NotBlank(message = "Last name is mandatory")
    private String lastName;
    @NotBlank(message = "Telephone is mandatory")

    private String telephone;

    @NotBlank(message = "Address is mandatory")
    private String address;


    @Email(message = " Email should be valid")
    @NotBlank(message = " Email is mandatory")
    private String email;




}
