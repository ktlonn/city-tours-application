package com.techelevator.dao;

import com.techelevator.model.Itinerary;
import com.techelevator.model.Landmark;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcItineraryDao implements ItineraryDao {

    private JdbcTemplate jdbcTemplate;
    public JdbcItineraryDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void createItinerary(Itinerary itinerary) {
        String sql = "INSERT INTO itinerary(itinerary_name, user_id, starting_name, starting_address, starting_latitude, " +
                "starting_longitude, itinerary_date, shared) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, itinerary.getItineraryName(), itinerary.getUserId(), itinerary.getStartingName(),
                itinerary.getStartingAddress(), itinerary.getStartingLatitude(), itinerary.getStartingLongitude(), itinerary.getItineraryDate(), itinerary.isShared());
    }

    @Override
    public void addToItinerary(Long landmarkId, Long itineraryId) {
        String sql = "INSERT INTO  landmark_itinerary(landmark_id, itinerary_id) VALUES (?,?)";
        jdbcTemplate.update(sql, landmarkId, itineraryId);
    }

    @Override
    public void removeFromItinerary(Long landmarkId, Long itineraryId) {
        String sql = "DELETE from landmark_itinerary WHERE landmark_id = ? AND itinerary_id = ?";
        jdbcTemplate.update(sql, landmarkId, itineraryId);
    }

    @Override
    public void deleteItinerary(Long itineraryId) {
        String sqlDeleteFromJoined = "DELETE from landmark_itinerary WHERE itinerary_id = ?";
        jdbcTemplate.update(sqlDeleteFromJoined, itineraryId);
        String sqlDeleteFromItinerary = "DELETE from itinerary WHERE itinerary_id = ?";
        jdbcTemplate.update(sqlDeleteFromItinerary, itineraryId);
    }

    @Override
    public void updateItineraryStarting(Itinerary itinerary) {
        String sql = "UPDATE itinerary SET starting_name = ?, starting_address = ?, starting_latitude = ?," +
                " starting_longitude = ?, shared = ? WHERE itinerary_id = ?";
        jdbcTemplate.update(sql, itinerary.getStartingName(), itinerary.getStartingAddress(), itinerary.getStartingLatitude(),
                            itinerary.getStartingLongitude(), itinerary.isShared(), itinerary.getItineraryId());
    }

    @Override
    public Itinerary retrieveItinerary(Long itineraryId) {
        Itinerary itinerary = new Itinerary();
        String sql = "SELECT * FROM itinerary WHERE itinerary_id = ?";
        try {
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, itineraryId);
            if (rowSet.next()) {
               itinerary = mapRowToItinerary(rowSet);
            }
            } catch (DataAccessException e) {
            e.getStackTrace();
        }
        return itinerary;
    }

    @Override
    public List<Landmark> retrieveListOfLandmarksByItinerary(Long itineraryId) {
        List<Landmark> landmarkList = new ArrayList<>();
        String sql = "SELECT * FROM landmark " +
                     "JOIN landmark_itinerary ON landmark_itinerary.landmark_id = landmark.landmark_id " +
                     "WHERE itinerary_id = ?";
        SqlRowSet rs = jdbcTemplate.queryForRowSet(sql, itineraryId);
        try {
            while(rs.next()) {
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
                landmark.setLatitude(rs.getDouble("latitude"));
                landmark.setLongitude(rs.getDouble("longitude"));
                landmark.setAddress(rs.getString("address"));
                landmarkList.add(landmark);
            }
        } catch (DataAccessException e) {
            e.getStackTrace();
        }
        return landmarkList;
    }

    @Override
    public List<Itinerary> allUserItineraries(Long userId) {
        List<Itinerary> itineraryList = new ArrayList<>();
        String sql = "SELECT * FROM itinerary WHERE user_id = ?";
        try {
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userId);
            while (rowSet.next()) {
                itineraryList.add(mapRowToItinerary(rowSet));
            }
        } catch (DataAccessException e) {
            e.getStackTrace();
        }
        return itineraryList;
    }

    public List<Itinerary> sharedUserItineraries(Long userId) {
        List<Itinerary> itineraryList = new ArrayList<>();
        String sql = "SELECT * FROM itinerary WHERE user_id <> ? AND shared = true";

        try {
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userId);
            while (rowSet.next()) {
                itineraryList.add(mapRowToItinerary(rowSet));
            }
        } catch (DataAccessException e) {
            e.getStackTrace();
        }
        return itineraryList;
    }

    private Itinerary mapRowToItinerary(SqlRowSet rowSet) {
        Itinerary itinerary = new Itinerary();
        itinerary.setItineraryId(rowSet.getLong("itinerary_id"));
        itinerary.setItineraryName(rowSet.getString("itinerary_name"));
        itinerary.setUserId(rowSet.getLong("user_id"));
        itinerary.setStartingName(rowSet.getString("starting_name"));
        itinerary.setStartingAddress(rowSet.getString("starting_address"));
        itinerary.setStartingLatitude(rowSet.getDouble("starting_latitude"));
        itinerary.setStartingLongitude(rowSet.getDouble("starting_longitude"));
        itinerary.setItineraryDate(rowSet.getDate("itinerary_date").toLocalDate());
        itinerary.setLandmarkOnItinerary(retrieveListOfLandmarksByItinerary(itinerary.getItineraryId()));
        itinerary.setShared(rowSet.getBoolean("shared"));
        return itinerary;
    }
}
