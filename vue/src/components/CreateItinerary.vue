<template>
  <div>
    <div class="create-itinerary-container">
    <b-form class="create-itinerary-form">
        <b-form-group id="input-name-group" label="Itinerary Name:" label-for="input-name">
            <b-form-input id="input-name" v-model="newItinerary.itineraryName" placeholder="Enter name" required>
            </b-form-input>
        </b-form-group>
        <div class="date-styling">
        <b-form-group id="date-picker-group" label="Itinerary Date:" label-for="date-picker">
                <b-form-datepicker id="date-picker" v-model="newItinerary.itineraryDate" required>
                </b-form-datepicker>
        </b-form-group>
        </div>
        <b-form-group id="input-startingPoint-group" label="Itinerary Starting Point:" label-for="input-startingPoint">
            <input id="input-startingPoint" ref="autocomplete" placeholder="Enter a starting point" class="form-control">
                
            
            
        </b-form-group>
        <div id="itinerary-button">
        <b-button id="submit-button" type="submit" variant="none" v-on:click="saveItinerary" :disabled="this.newItinerary.startingAddress == '' || this.newItinerary.itineraryName == '' || this.newItinerary.itineraryDate == ''">Create Itinerary</b-button>
        <b-button id="reset-button" type="reset" variant="none" v-on:click.prevent="resetForm">Cancel</b-button>
        </div>
    </b-form>
    </div>
  </div>
</template>

<script>
import ItineraryService from '../services/ItineraryService'

export default {
    name: 'created-itinerary',
    props: {
        currentUser: Object
    },
    data(){
        return {
            newItinerary: {
                itineraryName: '',
                userId: this.$store.state.user.id,
                startingName: '',
                startingAddress: '',
                startingLatitude: '',
                startingLongitude: '',
                itineraryDate: '',
                shared: false,
            },
           
            options: { 
    bounds: new window.google.maps.LatLngBounds(
    new window.google.maps.LatLng(41.7206, -87.7017),
    new window.google.maps.LatLng(42.0126, -87.6746)),
    strictBounds: true,
     
    fields: ['formatted_address', 'name', 'geometry']
  }
        }
    },
   
   mounted() {
    this.autocomplete = new window.google.maps.places.Autocomplete(
      (this.$refs.autocomplete),
      this.options
    );
   
 this.autocomplete.addListener('place_changed', () => {
  let place = this.autocomplete.getPlace();
  
  this.newItinerary.startingName = place.name;
  this.newItinerary.startingAddress = place.formatted_address
  this.newItinerary.startingLatitude = place.geometry.location.lat()
  this.newItinerary.startingLongitude = place.geometry.location.lng()
  this.newItinerary.shared = false
  }); 
  },
 
    methods: {
        saveItinerary(){
            
            ItineraryService.createItinerary(this.newItinerary).then(response => {
                if (response.status === 200) {
                    alert("New Itinerary Created"); 
                    this.newItinerary = {
                        itineraryName : '',
                        itineraryDate: '',
                        startingName: '',
                        shared: false
                    }
                    
                }
            }).catch(error => {
                if (error.response) {
                    this.errorMsg = "Error submitting new itinerary. Response received was '" + error.response.statusText + "'.";
                } else if (error.request) {
                    this.errorMsg = "Error submitting new itinerary. Server could not be reached.";
                } else {
                    this.errorMsg = "Error submitting new itinerary. Itinerary could not be created.";
                }
            });
        } ,
        resetForm(){
            this.newItinerary= {
                itineraryName : '',
                itineraryDate: '',
                startingName: ''
            }
        },
    
        },
}
</script>

<style scoped>

.create-itinerary-container {
    display: flex;
    align-content: center;
}

#itinerary-button {
    margin: 5px;
    display: flex;
    flex-wrap: nowrap;
    width: 100%;
}

.create-itinerary-form {
    font-size: 1.2vw;
    font-weight: 600;
    margin-top: 15px;
    color: #28527A;
    width: 80%;

}

#itinerary-button::v-deep #submit-button {
    font-size: .8vw;
    margin-right: 10px;
    font-weight: 600;
    color:white !important;
    background-color: #28527A !important;
    width: 50%;
}

#itinerary-button::v-deep #reset-button {
    font-size: .8vw;
    font-weight: 600;
    color:white !important;
    background-color: #a78d8df3 !important;
}

.date-styling .form-control {
    font-size: 1vw;
}

#input-startingPoint-group, #date-picker-group, #input-name-group {
    display: inline;
    font-size: 1vw;
}

</style>