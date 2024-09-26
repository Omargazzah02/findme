package com.my_back_v1.Util;

import com.my_back_v1.Models.ConnectorEntity;
import com.my_back_v1.Models.ConnectorTypeEntity;
import com.my_back_v1.Models.ReservationEntity;
import com.my_back_v1.Models.Status;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
@Component
public class MyUtils {



    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // Rayon de la terre en km

        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);
        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // Retourne la distance en kilomètres
    }



    public double estimateTravelTime(double lat1, double lon1, double lat2, double lon2) {
        final double EARTH_RADIUS_KM = 6371.0;
        // Convertir les degrés en radians
        double lat1Rad = Math.toRadians(lat1);
        double lon1Rad = Math.toRadians(lon1);
        double lat2Rad = Math.toRadians(lat2);
        double lon2Rad = Math.toRadians(lon2);

        // Calculer la différence entre les longitudes et les latitudes
        double deltaLat = lat2Rad - lat1Rad;
        double deltaLon = lon2Rad - lon1Rad;

        // Formule de Haversine pour calculer la distance en kilomètres
        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2)
                + Math.cos(lat1Rad) * Math.cos(lat2Rad)
                * Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distanceKm = EARTH_RADIUS_KM * c;

        // Vitesse de voyage moyenne en km/h (par exemple 60 km/h)
        double averageSpeedKmh = 50;

        // Calculer le temps de trajet en heures
        double travelTimeHours = distanceKm / averageSpeedKmh;

        // Convertir en minutes
        double travelTimeMinutes = travelTimeHours * 60;

        return travelTimeMinutes;
    }










    public boolean isConnectorAvailable (ConnectorEntity connector, LocalDateTime startTime , LocalDateTime endTime) {
        List<ReservationEntity> reservations = connector.getReservations();
        for (ReservationEntity reservation : reservations) {
            LocalDateTime reservationStartTime = reservation.getStartTime();
            LocalDateTime reservationEndTime = reservation.getEndTime();
            if (startTime.isBefore(reservationEndTime) && endTime.isAfter(reservationStartTime) && reservation.getStatus()== Status.In_progress) {
                return  false ;

            }
        }
        return  true ;

     }




    public  double roundToTwoDecimals(double number) {
        BigDecimal bd = new BigDecimal(number);
        bd = bd.setScale(2, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }








    // Méthode pour convertir minutes en durée formatée
    public String convertMinutesToDuration(int minutes) {
        if (minutes < 0) {
            throw new IllegalArgumentException("Le nombre de minutes ne peut pas être négatif");
        }

        int hours = minutes / 60;
        int remainingMinutes = minutes % 60;

        if (hours > 0) {
            return hours + "h:" + remainingMinutes + "mn";
        } else {
            return remainingMinutes + "mn";
        }
    }


























    public  LocalDateTime convertStringToLocalDateTime(String dateString) {
        // Définir le format de la chaîne d'entrée
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");

        // Convertir la chaîne en LocalDateTime
        LocalDateTime dateTime = LocalDateTime.parse(dateString, formatter);

        return dateTime;
    }



    public  String convertLocalDateTimeToString(LocalDateTime dateTime) {
        // Définir le format de la chaîne de sortie
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");

        // Convertir LocalDateTime en String
        String formattedDateTime = dateTime.format(formatter);

        return formattedDateTime;

    }

































}
