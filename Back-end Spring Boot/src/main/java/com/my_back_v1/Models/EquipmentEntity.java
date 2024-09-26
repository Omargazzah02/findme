package com.my_back_v1.Models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Table(name = "equipments")

@Entity
@NoArgsConstructor
@Data
public class EquipmentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;


    @ManyToOne
    @JoinColumn(name = "charging_station_id")
    private ChargingStationEntity chargingStation;

    @ManyToOne
    @JoinColumn(name = "connector_type_id")
    private ConnectorTypeEntity connectorType;



    @Column(nullable = false)
    private double powerKw;

    @Column(nullable = false)
    private Integer quantity;


    @Column
    private double pricePerKwh;


    @Column(nullable = false)
    private boolean activate;






    @OneToMany(mappedBy = "equipment" , cascade = CascadeType.ALL,fetch = FetchType.EAGER )
    private List<ConnectorEntity> connectors ;











}
