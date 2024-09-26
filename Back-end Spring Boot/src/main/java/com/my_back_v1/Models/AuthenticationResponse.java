package com.my_back_v1.Models;

public class AuthenticationResponse {


    private String token;

    public AuthenticationResponse(String token) {
        this.token = token;
    }


    public String getToken() {
        return token;
    }
}
