package com.my_back_v1.Dto;

import com.my_back_v1.Models.ConnectorEntity;
import com.my_back_v1.Models.EquipmentEntity;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class EquipmentSearchDTO {
    String connectorType ;
    Integer connectorTypeId;
    String currentType;
    double powerKw ;

    Integer quantity ;
    double  pricePerKwh;
    String  chargingDuration;
    double price  ;
    String  startTime;
    String  endTime;
    List <ConnectorSearchDTO> connectors = new ArrayList<ConnectorSearchDTO>();




    public void addConnector (ConnectorSearchDTO connector) {

        connectors.add(connector);
    }
}
