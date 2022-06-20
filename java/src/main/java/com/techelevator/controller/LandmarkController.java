package com.techelevator.controller;

import com.techelevator.dao.LandmarkDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Landmark;
import com.techelevator.model.User;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
public class LandmarkController {

    private LandmarkDao landmarkDao;
    private UserDao userDao;

    public LandmarkController(LandmarkDao landmarkDao, UserDao userDao) {
        this.landmarkDao = landmarkDao;
        this.userDao = userDao;
    }

    @RequestMapping(path = "/landmarks/", method = RequestMethod.GET)
    public List<Landmark> displayAllLandmarks() {
        return landmarkDao.displayAll();
    }

    @RequestMapping(path = "/landmarks/{category}", method = RequestMethod.GET)
    public List<Landmark> categorySearch(@PathVariable String category) {
        return landmarkDao.categorySearch(category);
    }

    @RequestMapping(path = "/landmark/{id}", method = RequestMethod.GET)
    public Landmark landmarkDetails(@PathVariable long id){
        return landmarkDao.landmarkDetails(id);
    }

    @RequestMapping(path = "/landmark/rating", method = RequestMethod.PUT)
    public void updateRating(@RequestBody Landmark landmark, Principal principal) {
        User user = userDao.findByUsername(principal.getName());
        landmarkDao.updateRating(landmark, user);
    }
}
