package com.my_back_v1.Models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;


@Data
@NoArgsConstructor

@Entity
@Table(name = "reservations")
public class ReservationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserEntity user;
    @ManyToOne

    @JoinColumn(name="connector_id")

    private ConnectorEntity connector;


    @Column(nullable = false)
    LocalDateTime startTime ;
    @Column(nullable = false)
    LocalDateTime endTime ;



    @Column()
    Status  status ;














}
