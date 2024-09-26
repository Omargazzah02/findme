package com.my_back_v1.Models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@Table(name = "brands")
public class BrandEntity {

    @Id
    private String id;

    @PrePersist
    public void generateId() {
        if (this.id == null) {
            this.id = UUID.randomUUID().toString();
            System.out.println(this.id);
        }
    }





    @Column
    private String name;


   @JsonIgnore
    @OneToMany (mappedBy = "brand" , cascade = CascadeType.ALL,fetch = FetchType.LAZY)
  private   List<VehicleEntity> vehicles ;


}
