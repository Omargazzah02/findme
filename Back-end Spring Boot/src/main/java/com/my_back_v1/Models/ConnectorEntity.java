package com.my_back_v1.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
@Data
@Entity
@Table (name =  "connectors")
public class ConnectorEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "equipment_id")
    private EquipmentEntity equipment ;

      @JsonIgnore
    @OneToMany(mappedBy = "connector" , cascade = CascadeType.ALL,fetch = FetchType.EAGER )
    private List<ReservationEntity> reservations ;



}
