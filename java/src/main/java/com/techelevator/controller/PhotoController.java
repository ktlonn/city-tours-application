package com.techelevator.controller;

import com.techelevator.model.Photo;
import com.techelevator.service.PhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
public class PhotoController {

    @Autowired
    PhotoService photoService;

    @RequestMapping(path="/photo", method= RequestMethod.GET)
    public List<Photo> retrievePhoto(@RequestParam String placeId) {

        return photoService.getPhotos(placeId);

    }

}
