package com.techelevator.model;

import java.time.LocalDate;
import java.util.List;

public class Itinerary {
    private Long itineraryId;
    private String itineraryName;
    private Long userId;
    private String startingName;
    private String startingAddress;
    private double startingLatitude;
    private double startingLongitude;
    private LocalDate itineraryDate;
    private List<Landmark> landmarkOnItinerary;
    private boolean isShared;

    public Itinerary() {
    }

    public Itinerary(Long itineraryId, String itineraryName, Long userId, String startingName, String startingAddress, double startingLatitude, double startingLongitude, LocalDate itineraryDate, boolean isShared) {
        this.itineraryId = itineraryId;
        this.itineraryName = itineraryName;
        this.userId = userId;
        this.startingName = startingName;
        this.startingAddress = startingAddress;
        this.startingLatitude = startingLatitude;
        this.startingLongitude = startingLongitude;
        this.itineraryDate = itineraryDate;
        this.isShared = isShared;
    }

    public List<Landmark> getLandmarkOnItinerary() {
        return landmarkOnItinerary;
    }

    public void setLandmarkOnItinerary(List<Landmark> landmarkOnItinerary) {
        this.landmarkOnItinerary = landmarkOnItinerary;
    }

    public Long getItineraryId() {
        return itineraryId;
    }

    public void setItineraryId(Long itineraryId) {
        this.itineraryId = itineraryId;
    }

    public String getItineraryName() {
        return itineraryName;
    }

    public void setItineraryName(String itineraryName) {
        this.itineraryName = itineraryName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getStartingName() {
        return startingName;
    }

    public void setStartingName(String startingName) {
        this.startingName = startingName;
    }

    public String getStartingAddress() {
        return startingAddress;
    }

    public void setStartingAddress(String startingAddress) {
        this.startingAddress = startingAddress;
    }

    public double getStartingLatitude() {
        return startingLatitude;
    }

    public void setStartingLatitude(double startingLatitude) {
        this.startingLatitude = startingLatitude;
    }

    public double getStartingLongitude() {
        return startingLongitude;
    }

    public void setStartingLongitude(double startingLongitude) {
        this.startingLongitude = startingLongitude;
    }

    public LocalDate getItineraryDate() {
        return itineraryDate;
    }

    public void setItineraryDate(LocalDate itineraryDate) {
        this.itineraryDate = itineraryDate;
    }

    public boolean isShared() {
        return isShared;
    }

    public void setShared(boolean shared) {
        isShared = shared;
    }
}
