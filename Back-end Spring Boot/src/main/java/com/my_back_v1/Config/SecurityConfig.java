package com.my_back_v1.Config;
import com.my_back_v1.Services.UserDetailsServiceImp;
import com.my_back_v1.filter.JwtAuthentificationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity

public class SecurityConfig {
    private final JwtAuthentificationFilter jwtAuthenticationFilter;
    private final UserDetailsServiceImp userDetailsServiceImp;
    private  final CustomAcessDeinedHandler customAcessDeinedHandler;

    public SecurityConfig(JwtAuthentificationFilter jwtAuthenticationFilter, UserDetailsServiceImp userDetailsServiceImp, CustomAcessDeinedHandler customAcessDeinedHandler) {
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
        this.userDetailsServiceImp = userDetailsServiceImp;
        this.customAcessDeinedHandler = customAcessDeinedHandler;
    }


    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        return http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(
                        req->req.requestMatchers("/login/**","/register/**" ,"brand/getall" , "vehicle/getallbybrand/{brand}")
                                .permitAll()
                                .requestMatchers("/admin_only/**").hasAuthority("admin")
                                .anyRequest()
                                .authenticated()
                ).userDetailsService(userDetailsServiceImp).exceptionHandling(e->e.accessDeniedHandler(customAcessDeinedHandler)
                        .authenticationEntryPoint(new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED))).
                sessionManagement(session->session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)).
                addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class).build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }

}
