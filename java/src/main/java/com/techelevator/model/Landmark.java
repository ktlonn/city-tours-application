package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;

public class Landmark {

    private Long id;
    private String name;
    private String description;
    private String tagline;
    private String daysHours;
    private String category;
    private String imgUrl;
    private int thumbsUp;
    private int thumbsDown;
    private boolean monday;
    private boolean tuesday;
    private boolean wednesday;
    private boolean thursday;
    private boolean friday;
    private boolean saturday;
    private boolean sunday;
    private String placeId;
    private double latitude;
    private double longitude;
    private String address;
    private List<LandmarkRating> userLandmarkRatings = new ArrayList<>();


    public Landmark() {}
    public Landmark(Long id, String name, String description, String daysHours,
                    String category, String imgUrl, int thumbsUp, int thumbsDown) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.daysHours = daysHours;
        this.category = category;
        this.imgUrl = imgUrl;
        this.thumbsUp = thumbsUp;
        this.thumbsDown = thumbsDown;
    }

    public Landmark(Long id, String name, String description, String tagline, String daysHours, String category, String imgUrl, int thumbsUp, int thumbsDown, boolean monday, boolean tuesday, boolean wednesday, boolean thursday, boolean friday, boolean saturday, boolean sunday, String placeId, double latitude, double longitude, String address, List<LandmarkRating> userLandmarkRatings) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.tagline = tagline;
        this.daysHours = daysHours;
        this.category = category;
        this.imgUrl = imgUrl;
        this.thumbsUp = thumbsUp;
        this.thumbsDown = thumbsDown;
        this.monday = monday;
        this.tuesday = tuesday;
        this.wednesday = wednesday;
        this.thursday = thursday;
        this.friday = friday;
        this.saturday = saturday;
        this.sunday = sunday;
        this.placeId = placeId;
        this.latitude = latitude;
        this.longitude = longitude;
        this.address = address;
        this.userLandmarkRatings = userLandmarkRatings;
    }

    public List<LandmarkRating> getUserLandmarkRatings() {
        return userLandmarkRatings;
    }

    public void setUserLandmarkRatings(List<LandmarkRating> landmarkRatings) {
        userLandmarkRatings = landmarkRatings;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTagline() {
        return tagline;
    }

    public void setTagline(String tagline) {
        this.tagline = tagline;
    }

    public String getDaysHours() {
        return daysHours;
    }

    public void setDaysHours(String daysHours) {
        this.daysHours = daysHours;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public int getThumbsUp() {
        return thumbsUp;
    }

    public void setThumbsUp(int thumbsUp) {
        this.thumbsUp = thumbsUp;
    }

    public int getThumbsDown() {
        return thumbsDown;
    }

    public void setThumbsDown(int thumbsDown) {
        this.thumbsDown = thumbsDown;
    }

    public boolean isMonday() {
        return monday;
    }

    public void setMonday(boolean monday) {
        this.monday = monday;
    }

    public boolean isTuesday() {
        return tuesday;
    }

    public void setTuesday(boolean tuesday) {
        this.tuesday = tuesday;
    }

    public boolean isWednesday() {
        return wednesday;
    }

    public void setWednesday(boolean wednesday) {
        this.wednesday = wednesday;
    }

    public boolean isThursday() {
        return thursday;
    }

    public void setThursday(boolean thursday) {
        this.thursday = thursday;
    }

    public boolean isFriday() {
        return friday;
    }

    public void setFriday(boolean friday) {
        this.friday = friday;
    }

    public boolean isSaturday() {
        return saturday;
    }

    public void setSaturday(boolean saturday) {
        this.saturday = saturday;
    }

    public boolean isSunday() {
        return sunday;
    }

    public void setSunday(boolean sunday) {
        this.sunday = sunday;
    }

    public String getPlaceId() {
        return placeId;
    }

    public void setPlaceId(String placeId) {
        this.placeId = placeId;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


}
