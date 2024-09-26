package com.my_back_v1.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@Table(name = "charging_stations")
public class ChargingStationEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "operator_id")
    private OperatorEntity operator;



    @Column(nullable = false)
    private String address;
    @Column

    private String postCode;



    @Column(nullable = false)
    private Double latitude;

    @Column(nullable = false)
    private Double longitude;



    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCreated;



    @Temporal(TemporalType.TIMESTAMP)
    private Date dateLastStatusUpdate;





    @OneToMany (mappedBy = "chargingStation",  cascade = CascadeType.ALL,fetch = FetchType.EAGER )
    private List<EquipmentEntity> equipments;



















}
