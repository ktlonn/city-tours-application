<template>
  <div>
    
    <h2>{{landmark.name}}</h2>
    <p>
      {{landmark.description}} <br>
      {{landmark.daysHours}} <br> 
      {{landmark.category}} <br>
      {{landmark.thumbsUp}} <br>
      {{landmark.thumbsDown}}
    </p>
  </div>
</template>

<script>
import landmarkService from '../services/LandmarkService'
export default {
    name: 'landmark-details',
    data() {
      return {
        landmark: {
          id: null,
          name: '',
          description: '',
          daysHours: '',
          category: '',
          thumbsUp: null,
          thumbsDown: null
          }
      }
    },
    created() {
      landmarkService
      .viewLandmarkDetails(this.$route.params.id)
      .then((response) => {
          this.landmark = response.data
      })
    }
}
</script>

<style>

</style>