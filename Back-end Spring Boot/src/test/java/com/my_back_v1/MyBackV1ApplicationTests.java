package com.my_back_v1;

import com.my_back_v1.Controllers.AdminController;
import com.my_back_v1.Controllers.VehicleController;
import com.my_back_v1.Controllers.ReservationController;
import com.my_back_v1.Dto.ReservationResponseDto;
import com.my_back_v1.Dto.StationListDto;
import com.my_back_v1.Models.VehicleEntity;
import com.my_back_v1.Services.BrandService;
import com.my_back_v1.Services.ChargingStationService;
import com.my_back_v1.Services.VehicleService;
import com.my_back_v1.Services.ReservationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Collections;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.content;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test") // Utilisez un profil spécifique pour les tests si nécessaire
public class MyBackV1ApplicationTests {

    @LocalServerPort
    private int port;

    @Autowired
    private WebApplicationContext webApplicationContext;

    private MockMvc mockMvc;

    @Mock
    private VehicleService vehicleService;

    @Mock
    private BrandService brandService;

    @Mock
    private ReservationService reservationService;

    @Mock
    ChargingStationService chargingStationService;


    @InjectMocks
    private VehicleController vehicleController;

    @InjectMocks
    private ReservationController reservationController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    @WithMockUser(username = "user", roles = {"USER"})

    public void testFindAllByBrand() throws Exception {
        VehicleEntity vehicle = new VehicleEntity(); // Configurez votre entité comme nécessaire
        when(vehicleService.findAllByBrand("a462c115-33b4-438b-b590-bc4a33382d1c")).thenReturn(Collections.singletonList(vehicle));

        mockMvc.perform(get("/vehicle/getallbybrand/a462c115-33b4-438b-b590-bc4a33382d1c")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
    }



    @Test
    @WithMockUser(username = "user", roles = {"USER"})

    public void testGetAllBrands() throws Exception {
        // Configurez le mock du service pour retourner une liste vide ou des valeurs de test si nécessaire
        when(brandService.getAllBrands()).thenReturn(Collections.emptyList());

        // Effectuez la requête et vérifiez que le statut de la réponse est 200 OK
        mockMvc.perform(get("/brand/getall")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }



    @Test
    @WithMockUser(username = "user", roles = {"USER"})

    public void testGetAllStations() throws Exception {
        // Configurez le mock du service pour retourner une liste vide ou des valeurs de test si nécessaire
        when(chargingStationService.getAllStations()).thenReturn(Collections.emptyList());

        // Effectuez la requête et vérifiez que le statut de la réponse est 200 OK
        mockMvc.perform(get("/admin_only/get-all-stations")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }









}




