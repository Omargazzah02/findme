package com.my_back_v1.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@Data
@Entity
@Table(name = "operators")
public class OperatorEntity {


     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)

    private String name;

    @Column
    private String websiteUrl;

    @Column
    private String phonePrimaryContact;

    @Column
    private String phoneSecondaryContact;

    @Column
    private String address;

    @Column
    private String email;
@JsonIgnore
    @OneToMany(mappedBy = "operator",  cascade = CascadeType.ALL,fetch = FetchType.LAZY )
    private List<ChargingStationEntity> chargingStations;




}
