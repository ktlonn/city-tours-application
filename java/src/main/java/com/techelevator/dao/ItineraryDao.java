package com.techelevator.dao;

import com.techelevator.model.Itinerary;
import com.techelevator.model.Landmark;

import java.util.List;

public interface ItineraryDao {
    void createItinerary(Itinerary itinerary);

    void addToItinerary(Long itineraryId, Long landmarkId);

    void removeFromItinerary(Long itineraryId, Long landmarkId);

    void deleteItinerary(Long itineraryId);

    void updateItineraryStarting(Itinerary itinerary);

    Itinerary retrieveItinerary(Long itineraryId);

    List<Itinerary> allUserItineraries(Long userId);

    List<Itinerary> sharedUserItineraries(Long userId);

    List<Landmark> retrieveListOfLandmarksByItinerary(Long itineraryId);

}
