import axios from 'axios';

export default {

    getPhoto(placeId) {
        return axios.get(`/photo?placeId=${placeId}`)
    }

}