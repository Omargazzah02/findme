package com.my_back_v1.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

@NoArgsConstructor
@Entity
@Data
@Table(name = "vehicles")
public class VehicleEntity implements Serializable {
    @Id

    private String id;


    @PrePersist
    public void generateId() {
        if (this.id == null) {
            this.id = UUID.randomUUID().toString();
            System.out.println(this.id);
        }
    }


    @ManyToOne
    @JoinColumn(name="brandId")
    private BrandEntity brand;

    @Column(nullable = false)
    private String name ;

@Column (nullable = false)
private  String vehicleType;
@Column
    private String variant;

    @Column(nullable = false)
    private String model;

    private Integer releaseYear;
    @Column(nullable = false )

    private Double batteryCapacityKwh;
    @Column(nullable = false)

    private Double averageEnergyConsumptionKwhPerKm;


    @Column
    private  Double acChargerMaxPower ;

@Column
private  Double dcChargerMaxPower;

@JsonIgnore
    @OneToMany(mappedBy = "vehicle" , cascade = CascadeType.ALL,fetch = FetchType.LAZY  )
    private List<UserEntity> users;

@JsonIgnore
    @OneToMany (mappedBy = "vehicle" , cascade = CascadeType.ALL,fetch = FetchType.EAGER , orphanRemoval = true)
    private List<ConnectorSupportEntity> connectorSupportEntities;


}
