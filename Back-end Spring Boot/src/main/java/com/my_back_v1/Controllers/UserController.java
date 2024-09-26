package com.my_back_v1.Controllers;

import com.my_back_v1.Dto.PasswordDto;
import com.my_back_v1.Dto.PersonalInformationDto;
import com.my_back_v1.Models.UserEntity;
import com.my_back_v1.Services.UserService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("user")
public class UserController {


 final    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("user_details")
    public UserEntity userDetails(){
        return  userService.userDetails();




    }



    @PutMapping("update/pi")
    public void updatePersonalInformation(@RequestBody @Valid PersonalInformationDto personalInformationDto) {
        userService.updatePersonalInformation(personalInformationDto);
    }


    @PutMapping ("update/password")

    public void updatePassword (@RequestBody PasswordDto passwordDto){
        userService.updatePassword(passwordDto);
    }






        @GetMapping("/send-password")
        public void sendEmail() {
            userService.sendSimpleMessage("gazzahomar2001@gmail.com");

        }
    }






