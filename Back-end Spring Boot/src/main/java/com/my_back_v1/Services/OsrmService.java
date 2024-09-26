package com.my_back_v1.Services;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.List;

@Service
public class OsrmService {

    private final RestTemplate restTemplate;

    public OsrmService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public double getDistance(double lat1, double lon1, double lat2, double lon2) {
        String baseUrl = "https://router.project-osrm.org/route/v1/driving/";
        String coordinates = String.format("%f,%f;%f,%f", lon1, lat1, lon2, lat2);
        String url = UriComponentsBuilder.fromHttpUrl(baseUrl + coordinates)
                .queryParam("overview", "false")
                .toUriString();

        OsrmResponse response = restTemplate.getForObject(url, OsrmResponse.class);
        if (response != null && !response.getRoutes().isEmpty()) {
            return response.getRoutes().get(0).getDistance() / 1000; // Convert distance to kilometers
        } else {
            throw new RuntimeException("No routes found");
        }
    }

    private static class OsrmResponse {
        private List<Route> routes;

        public List<Route> getRoutes() {
            return routes;
        }

        public void setRoutes(List<Route> routes) {
            this.routes = routes;
        }
    }

    private static class Route {
        private double distance;

        public double getDistance() {
            return distance;
        }

        public void setDistance(double distance) {
            this.distance = distance;
        }
    }
}
