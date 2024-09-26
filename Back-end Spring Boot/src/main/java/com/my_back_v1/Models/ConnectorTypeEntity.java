package com.my_back_v1.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@NoArgsConstructor
@Data
@Table(name = "connector_types")
public class ConnectorTypeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String connectorType;

    @Column(nullable = false)
    private CurrentType currentType;

    @JsonIgnore
    @OneToMany(mappedBy="connectorType" , cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    List<EquipmentEntity> equipmentEntities;

    @JsonIgnore

    @OneToMany (mappedBy = "connectorType" , cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    private List<ConnectorSupportEntity> connectorSupportEntities;


}
