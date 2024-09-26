package com.my_back_v1.Services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class ApiService {

    private final String BASE_API_URL = "https://router.project-osrm.org/route/v1/driving/";

    private final RestTemplate restTemplate;

    @Autowired
    public ApiService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public double fetchDurationInMinutesFromApi(double lat1, double lon1, double lat2, double lon2) {
        // Construire l'URL avec les paramètres de latitude et longitude

        String apiUrl = buildApiUrl(lat1, lon1, lat2, lon2);
        System.out.println(apiUrl);



        // Appel GET pour récupérer les données sous forme de String
        String jsonResponse = restTemplate.getForObject(apiUrl, String.class);

        // Extraire la valeur de "duration" à partir du JSON
        double durationInMinutes = extractDurationFromJson(jsonResponse);

        return durationInMinutes;
    }

    public double fetchDistanceInKilometersFromApi(double lat1, double lon1, double lat2, double lon2) {
        // Construire l'URL avec les paramètres de latitude et longitude
        String apiUrl = buildApiUrl(lat1, lon1, lat2, lon2);
        System.out.println(apiUrl);


        // Appel GET pour récupérer les données sous forme de String
        String jsonResponse = restTemplate.getForObject(apiUrl, String.class);

        // Extraire la valeur de "distance" à partir du JSON
        double distanceInKilometers = extractDistanceFromJson(jsonResponse);

        return distanceInKilometers;
    }

    private String buildApiUrl(double lat1, double lon1, double lat2, double lon2) {
        return UriComponentsBuilder.fromHttpUrl(BASE_API_URL)
                .path(lon1 + "," + lat1 + ";" + lon2 + "," + lat2)
                .queryParam("overview", false)
                .toUriString();

    }

    private double extractDurationFromJson(String jsonResponse) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(jsonResponse);

            JsonNode routes = jsonNode.get("routes");
            if (routes.isArray() && routes.size() > 0) {
                JsonNode legs = routes.get(0).get("legs");
                if (legs.isArray() && legs.size() > 0) {
                    JsonNode duration = legs.get(0).get("duration");
                    if (duration != null && duration.isNumber()) {
                        return duration.asDouble() / 60.0; // Convertir en minutes
                    }
                }
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return 0.0; // Valeur par défaut si la durée n'est pas trouvée
    }

    private double extractDistanceFromJson(String jsonResponse) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(jsonResponse);

            JsonNode routes = jsonNode.get("routes");
            if (routes.isArray() && routes.size() > 0) {
                JsonNode legs = routes.get(0).get("legs");
                if (legs.isArray() && legs.size() > 0) {
                    JsonNode distance = legs.get(0).get("distance");
                    if (distance != null && distance.isNumber()) {
                        return distance.asDouble() / 1000.0; // Convertir en kilomètres
                    }
                }
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return 0.0; // Valeur par défaut si la distance n'est pas trouvée
    }
}
