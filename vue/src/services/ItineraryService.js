import axios from 'axios';

export default {

    createItinerary(itinerary) {
        return axios.post('/itinerary', itinerary)
    },
    retrieveAllUserItineraries(user){
        return axios.get('/itinerary/all', user)
    },
    retrieveItinerary(id) {
        return axios.get(`/itinerary/${id}`)
    },
    addLandmarkToItinerary(itineraryId, landmarkId) {
        return axios.post(`/itinerary/add/${itineraryId}/${landmarkId}`)
    },
    updateItinerary(itinerary) {
        return axios.put('/itinerary/update/', itinerary)
    },
    removeLandmarkFromItinerary(itineraryId, landmarkId) {
        return axios.delete(`/itinerary/delete/${itineraryId}/${landmarkId}`)
    },
    deleteItinerary(itineraryId) {
        return axios.delete(`/itinerary/remove/${itineraryId}`)
    },
    retrieveAllSharedItineraries(user){
        return axios.get('/itinerary/shared', user)
    },
}