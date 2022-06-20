package com.techelevator.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.techelevator.model.Photo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Component
public class PhotoService {

    @Value("${place.api.url}")
    private String apiURL1;
    @Value("${photo.api.url}")
    private String apiURL2;
    @Value("${maps.api.key}")
    private String key;

    public List<Photo> getPhotos(String placeId) {

        RestTemplate restTemplate = new RestTemplate();
        String url = apiURL1 + placeId + apiURL2 + key;

        HttpEntity<String> entity = new HttpEntity<>("");
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET,
                entity, String.class);

        JsonNode jsonNode;
        ObjectMapper objectMapper = new ObjectMapper();

        List<Photo> photoList = new ArrayList<>();

        try {
            jsonNode = objectMapper.readTree(response.getBody());
            JsonNode root = jsonNode.path("result").path("photos");

            for (int i=0; i<root.size(); i++) {
                String photoReference = root.path(i).path("photo_reference").asText();

                Photo photo = new Photo(photoReference);
                photoList.add(photo);
                
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return photoList;

    }

}
