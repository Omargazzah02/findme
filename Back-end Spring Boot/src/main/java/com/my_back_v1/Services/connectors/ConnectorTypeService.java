package com.my_back_v1.Services.connectors;

import com.my_back_v1.Dto.ConnectorTypeDto;
import com.my_back_v1.Models.ConnectorTypeEntity;
import com.my_back_v1.Repositories.ConnectorTypeRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service

public class ConnectorTypeService {
    private final ConnectorTypeRepository connectorTypeRepository;


    public ConnectorTypeService(ConnectorTypeRepository connectorTypeRepository) {
        this.connectorTypeRepository = connectorTypeRepository;
    }


    public List<ConnectorTypeDto> getAllConnectorTypes() {
        List<ConnectorTypeDto> connectorTypeDtos = new ArrayList<>();
        List <ConnectorTypeEntity> connectorTypeEntities = connectorTypeRepository.findAll();
        for (ConnectorTypeEntity connectorTypeEntity : connectorTypeEntities) {
            ConnectorTypeDto connectorTypeDto = new ConnectorTypeDto();
            connectorTypeDto.setId(connectorTypeEntity.getId());
            connectorTypeDto.setName(connectorTypeEntity.getConnectorType()+" "+connectorTypeEntity.getCurrentType());
            connectorTypeDtos.add(connectorTypeDto);
        }
        return connectorTypeDtos;
    }
}

