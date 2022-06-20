package com.techelevator.dao;

import com.techelevator.model.Landmark;
import com.techelevator.model.LandmarkRating;
import com.techelevator.model.User;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcLandmarkDao implements LandmarkDao{

    private JdbcTemplate jdbcTemplate;
    public JdbcLandmarkDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Landmark> categorySearch(String category) {
        List<Landmark> categoryList = new ArrayList<>();
        String sql = "SELECT landmark.landmark_id, name, description, tagline, days_hours, category, " +
                "image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address, " +
                "monday, tuesday, wednesday, thursday, friday, saturday, sunday" +
                " FROM landmark JOIN landmark_open ON landmark.landmark_id = landmark_open.landmark_id" +
                " WHERE category = ?";
        try{
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, category);
            while(rowSet.next()){
                categoryList.add(mapRowToLandmarkOpen(rowSet));
            }
        } catch (DataAccessException e) {
            e.getStackTrace();
        }
        return categoryList;
    }

    @Override
    public List<Landmark> displayAll() {
        List<Landmark> allLandmarks = new ArrayList<>();
        String sql = "SELECT landmark.landmark_id, name, description, tagline, days_hours, category, " +
                "image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address, " +
                "monday, tuesday, wednesday, thursday, friday, saturday, sunday " +
                "FROM landmark  JOIN landmark_open ON landmark.landmark_id = landmark_open.landmark_id;";
        try{
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);
            while(rowSet.next()){
                allLandmarks.add(mapRowToLandmarkOpen(rowSet));
            }
        } catch (DataAccessException e) {
            e.getStackTrace();
        }
        return allLandmarks;
    }

    @Override
    public Landmark landmarkDetails(long landmarkId) {

        String sql = "SELECT landmark_id, name, description, tagline, days_hours, category, " +
                "image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address FROM landmark WHERE landmark_id = ?;";

        try {
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, landmarkId);

            if(rowSet.next()){
                return mapRowToLandmark(rowSet);
            }
        }catch(DataAccessException e){
            e.getStackTrace();
        }
        return null;
    }

    @Override
    public void updateRating(Landmark landmark, User user) {

        LandmarkRating landmarkRating = landmark.getUserLandmarkRatings().stream()
                .filter(landmarkRating1 -> (landmark.getId() == landmarkRating1.getLandmarkId()
                        && user.getId() == landmarkRating1.getUserId())).findAny().orElse(null);

        String sqlUpdate = "UPDATE landmark SET thumbs_up = ?, thumbs_down = ? WHERE landmark_id = ?";
        jdbcTemplate.update(sqlUpdate, landmark.getThumbsUp(), landmark.getThumbsDown(), landmark.getId());

        List<LandmarkRating> landmarkRatings = getRatings(landmark);
        boolean running = true;
            for (int i = 0; i < landmarkRatings.size(); i++) {
                if (user.getId() == landmarkRatings.get(i).getUserId()) ;
                String sqlUpdateRating = "UPDATE user_landmark SET gave_thumbs_up = ?, gave_thumbs_down = ? " +
                        "WHERE user_id = ? AND landmark_id = ?";
                jdbcTemplate.update(sqlUpdateRating, landmarkRating.isGaveThumbsUp(), landmarkRating.isGaveThumbsDown(), user.getId(), landmark.getId());
                running = false;
            }
        if(running) {
            String sqlInsert = "INSERT INTO user_landmark(user_id, landmark_id, gave_thumbs_up, gave_thumbs_down) " +
                    "VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sqlInsert, user.getId(), landmark.getId(),
                    landmarkRating.isGaveThumbsUp(), landmarkRating.isGaveThumbsDown());
        }
    }

    public List<LandmarkRating> getRatings(Landmark landmark){
        List<LandmarkRating> ratings = new ArrayList<>();

        String sql = "SELECT * FROM user_landmark WHERE landmark_id = ?";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, landmark.getId());
        while(rowSet.next()){
            LandmarkRating lr = new LandmarkRating();
            lr.setUserId(rowSet.getLong("user_id"));
            lr.setLandmarkId(rowSet.getLong("landmark_id"));
            lr.setGaveThumbsUp(rowSet.getBoolean("gave_thumbs_up"));
            lr.setGaveThumbsDown(rowSet.getBoolean("gave_thumbs_down"));
            ratings.add(lr);
        }
        return ratings;
    }

    private Landmark mapRowToLandmarkOpen(SqlRowSet rs){
        Landmark landmark = new Landmark();
        landmark.setId(rs.getLong("landmark_id"));
        landmark.setName(rs.getString("name"));
        landmark.setDescription(rs.getString("description"));
        landmark.setTagline(rs.getString("tagline"));
        landmark.setDaysHours(rs.getString("days_hours"));
        landmark.setCategory(rs.getString("category"));
        landmark.setImgUrl(rs.getString("image_url"));
        landmark.setThumbsUp(rs.getInt("thumbs_up"));
        landmark.setThumbsDown(rs.getInt("thumbs_down"));
        landmark.setPlaceId(rs.getString("place_id"));
        landmark.setLatitude(rs.getDouble("latitude"));
        landmark.setLongitude(rs.getDouble("longitude"));
        landmark.setAddress(rs.getString("address"));
        landmark.setMonday(rs.getBoolean("monday"));
        landmark.setTuesday(rs.getBoolean("tuesday"));
        landmark.setWednesday(rs.getBoolean("wednesday"));
        landmark.setThursday(rs.getBoolean("thursday"));
        landmark.setFriday(rs.getBoolean("friday"));
        landmark.setSaturday(rs.getBoolean("saturday"));
        landmark.setSunday(rs.getBoolean("sunday"));
        landmark.setUserLandmarkRatings(getRatings(landmark));
        return landmark;
    }

    private Landmark mapRowToLandmark(SqlRowSet rs) {
        Landmark landmark = new Landmark();
        landmark.setId(rs.getLong("landmark_id"));
        landmark.setName(rs.getString("name"));
        landmark.setDescription(rs.getString("description"));
        landmark.setTagline(rs.getString("tagline"));
        landmark.setDaysHours(rs.getString("days_hours"));
        landmark.setCategory(rs.getString("category"));
        landmark.setImgUrl(rs.getString("image_url"));
        landmark.setThumbsUp(rs.getInt("thumbs_up"));
        landmark.setThumbsDown(rs.getInt("thumbs_down"));
        landmark.setPlaceId(rs.getString("place_id"));
        landmark.setLatitude(rs.getDouble("latitude"));
        landmark.setLongitude(rs.getDouble("longitude"));
        landmark.setAddress(rs.getString("address"));
        landmark.setUserLandmarkRatings(getRatings(landmark));

        return landmark;
    }
}
