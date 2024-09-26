package com.my_back_v1.Models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@Table(name = "connector_supports"  , uniqueConstraints = @UniqueConstraint(columnNames = {"vehicle_id", "connector_type_id"}))

public class ConnectorSupportEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;


    @ManyToOne
    @JoinColumn(name = "vehicle_id")
    private VehicleEntity vehicle;

    @ManyToOne
    @JoinColumn(name= "connector_type_id")
    private ConnectorTypeEntity connectorType;

}
