package com.techelevator.model;

public class LandmarkRating {
    private long landmarkId;
    private long userId;
    private boolean gaveThumbsUp;
    private boolean gaveThumbsDown;

    public LandmarkRating() {
    }

    public LandmarkRating(long landmarkId, long userId, boolean gaveThumbsUp, boolean gaveThumbsDown) {
        this.landmarkId = landmarkId;
        this.userId = userId;
        this.gaveThumbsUp = gaveThumbsUp;
        this.gaveThumbsDown = gaveThumbsDown;
    }

    public long getLandmarkId() {
        return landmarkId;
    }

    public void setLandmarkId(long landmarkId) {
        this.landmarkId = landmarkId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public boolean isGaveThumbsUp() {
        return gaveThumbsUp;
    }

    public void setGaveThumbsUp(boolean gaveThumbsUp) {
        this.gaveThumbsUp = gaveThumbsUp;
    }

    public boolean isGaveThumbsDown() {
        return gaveThumbsDown;
    }

    public void setGaveThumbsDown(boolean gaveThumbsDown) {
        this.gaveThumbsDown = gaveThumbsDown;
    }
}
