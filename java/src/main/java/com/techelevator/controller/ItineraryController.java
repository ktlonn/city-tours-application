package com.techelevator.controller;

import com.techelevator.dao.ItineraryDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Itinerary;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping(path = "/itinerary")
public class ItineraryController {
    private ItineraryDao itineraryDao;
    private UserDao userDao;

    private ItineraryController(ItineraryDao itineraryDao, UserDao userDao){
        this.itineraryDao = itineraryDao;
        this.userDao = userDao;
    }

    @PostMapping
    public void createItinerary(@RequestBody Itinerary itinerary){
        itineraryDao.createItinerary(itinerary);
    }

    @GetMapping(path = "/{itineraryId}")
    public Itinerary retrieveItineraryById(@PathVariable String itineraryId) {
        return itineraryDao.retrieveItinerary(Long.parseLong(itineraryId));
    }

    @GetMapping(path = "/all")
    public List<Itinerary> retrieveItineraryList(Principal principal) {
        Long id = userDao.findByUsername(principal.getName()).getId();
        return itineraryDao.allUserItineraries(id);
    }

    @GetMapping(path = "/shared")
    public List<Itinerary> retrieveSharedItineraries(Principal principal) {
        Long id = userDao.findByUsername(principal.getName()).getId();
        return itineraryDao.sharedUserItineraries(id);
    }

    @PostMapping(path = "/add/{itineraryId}/{landmarkId}")
    public void addLandmarkToItinerary(@PathVariable Long itineraryId, @PathVariable Long landmarkId) {
        itineraryDao.addToItinerary(landmarkId, itineraryId);
    }

    @DeleteMapping(path = "/delete/{itineraryId}/{landmarkId}")
    public void removeLandmarkFromItinerary(@PathVariable Long itineraryId, @PathVariable Long landmarkId) {
        itineraryDao.removeFromItinerary(landmarkId, itineraryId);
    }

    @DeleteMapping(path = "/remove/{itineraryId}")
    public void deleteItinerary(@PathVariable Long itineraryId) {
        itineraryDao.deleteItinerary(itineraryId);
    }

    @PutMapping(path = "/update")
    public void updateStartingPoint(@RequestBody Itinerary itinerary) {
        itineraryDao.updateItineraryStarting(itinerary);
    }
}
