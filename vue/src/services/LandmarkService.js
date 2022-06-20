import axios from 'axios';

export default {

    getByCategory(category) {
        return axios.get(`/landmarks/${category}`)
    },

    getAllLandmarks() {
        return axios.get('/landmarks/')
    },

    viewLandmarkDetails(id) {
        return axios.get(`/landmark/${id}`)
    },

    updateLandmarkRating(landmark) {
        return axios.put(`/landmark/rating`, landmark)
    }
}