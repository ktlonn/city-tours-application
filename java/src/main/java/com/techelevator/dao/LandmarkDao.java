package com.techelevator.dao;

import com.techelevator.model.Landmark;
import com.techelevator.model.User;

import java.util.List;

public interface LandmarkDao {
    List<Landmark> categorySearch(String category);

    List<Landmark> displayAll();

    Landmark landmarkDetails(long landmarkId);

    void updateRating(Landmark landmark, User user);
}
