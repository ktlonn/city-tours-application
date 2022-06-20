<template>

  <div class="details-container">
    <div id="address-container">
    <div class="address-info">
      <h3>{{ itinerary.itineraryName }}</h3>
      <p class="date">{{dateConverter(itinerary.itineraryDate)}}</p>
    <br />
    <p><strong>Starting Point: </strong>{{ itinerary.startingName }}</p>
    <p><strong>Starting Address: </strong>{{ itinerary.startingAddress }}</p>
    <br />
    <p id="update-instructions">To change the <strong>starting point</strong>, please enter a new address below:</p>
    <div>
      <input
        ref="autocomplete"
        class="controls"
        type="text"
        onfocus="value = ''"
        placeholder="Enter address..."
      />
    </div>
    <div class="details-header">
      <div>
        <b-button @click="changeStartingPoint">Update Route</b-button>
      </div>
    </div>
    </div>
    <div id="map"></div>
    <div class="report-container">
    <div id="report"></div>
    </div>
    </div>
    <div id="route-container">
    <h4>Your selected landmarks:</h4>
    <div class="card-container">
      <div
        v-for="landmark in itinerary.landmarkOnItinerary"
        v-bind:key="landmark.id"
      >
        <div class="card">
          <div class="card-contents">
            <div class="card-img-container">
            <img id="card-img" :src='landmark.imgUrl' />       
          </div>
          <div class="content-container">
           <h4 style="text-align: center">{{ landmark.name }}</h4>
           <p class="tagline">{{landmark.tagline}}</p>
            <div id="emphasis-text">
                {{ landmark.category }}
            </div> 
            <div id="delete-btn">
            <b-button
              @click="
                selectedLandmark = landmark.id;
                removeFromItinerary(itinerary.itineraryId, selectedLandmark);
              " variant="none"
              >Remove From Itinerary</b-button>
              </div>
            </div>    
          </div>
        </div>
      </div>
    </div>
    </div>
    <br>
    <div id="delete">
        <b-button @click="deleteItinerary()">Delete Itinerary</b-button>
      </div>
  </div>
</template>

<script>
import itineraryService from "../services/ItineraryService";

export default {
  name: "itinerary-details",
 
  data() {
    return {
      itinerary: {
        itineraryId: null,
        itineraryName: "",
        userId: null,
        startingName: "",
        startingAddress: "",
        startingLatitude: null,
        startingLongitude: null,
        itineraryDate: "",
        landmarkOnItinerary: [],
        selectedLandmark: 0,
      },
      map: null,
     
      listOfPlaces: [],
      options: {
        bounds: new window.google.maps.LatLngBounds(
          new window.google.maps.LatLng(41.606201, -88.069839),
          new window.google.maps.LatLng(42.108411, -87.396240)
        ),
        strictBounds: true,
        

        fields: ["formatted_address", "name", "geometry"],
      },
    };
  },
  created() {
    itineraryService
      .retrieveItinerary(this.$route.params.id)
      .then((response) => {
        this.itinerary = response.data;
        this.populateList();
      });
  },
  mounted() {
    this.initMap();
    this.autocomplete = new window.google.maps.places.Autocomplete(
      this.$refs.autocomplete,
      this.options
    );
    this.autocomplete.addListener("place_changed", () => {
      let place = this.autocomplete.getPlace();

      this.itinerary.startingName = place.name;
      this.itinerary.startingAddress = place.formatted_address;
      this.itinerary.startingLatitude = place.geometry.location.lat();
      this.itinerary.startingLongitude = place.geometry.location.lng();
    });
  },
  methods: {
    populateList() {
      this.listOfPlaces.push([this.itinerary.startingName, {lat: this.itinerary.startingLatitude , lng: this.itinerary.startingLongitude}]);
      this.itinerary.landmarkOnItinerary.forEach((arrayItem) =>
      this.listOfPlaces.push([arrayItem.name, {lat: arrayItem.latitude, lng: arrayItem.longitude}]));
      this.listOfPlaces.forEach(element => 
      new window.google.maps.Marker({
      position: element[1],
      label: {color: 'blue', fontWeight: 'bold', fontSize: '14px', text: element[0]},
      map: this.map,}));
      var directionsService = new window.google.maps.DirectionsService;
      var directionsDisplay = new window.google.maps.DirectionsRenderer({
      map: this.map,
      panel: document.getElementById("report"),
      suppressMarkers: true
      });
      this.calculateAndDisplayRoute(directionsService, directionsDisplay, this.listOfPlaces[0][1], this.listOfPlaces[0][1])
     
     },
    changeStartingPoint() {
      this.listOfPlaces.splice(0, 1, [this.itinerary.startingName, {lat: this.itinerary.startingLatitude , lng: this.itinerary.startingLongitude}]); 
      let input = this.itinerary;
      console.log(input);
      itineraryService
        .updateItinerary(input)
        .then((response) => {
          if (response.status === 200) {
            location.reload();
            alert("Itinerary Changed!");
          }
        })
        .catch((error) => {
          if (error.response) {
            window.alert(
              "Error submitting new itinerary. Response received was '" +
                error.response.statusText +
                "'."
            );
          } else if (error.request) {
            window.alert(
              "Error submitting new itinerary. Server could not be reached."
            );
          } else {
            window.alert(
              "Error submitting new itinerary. Itinerary could not be created."
            );
          }
        });
    },
    dateConverter(date){
        let newDate = new Date(date).toString();
        return newDate.substring(0, 11);
    },
    removeFromItinerary() {
      itineraryService
        .removeLandmarkFromItinerary(
          this.itinerary.itineraryId,
          this.selectedLandmark
        )
        .then((response) => {
          if (response.status === 200) {
            location.reload();
          }
        })
        .catch((error) => {
          if (error.response) {
            this.errorMsg =
              "Error removed landmark. Response received was '" +
              error.response.statusText +
              "'.";
          } else if (error.request) {
            this.errorMsg =
              "Error removed landmark. Server could not be reached.";
          } else {
            this.errorMsg =
              "Error removed landmark. Itinerary could not be modified.";
          }
        });
    },
    deleteItinerary() {
      itineraryService
        .deleteItinerary(this.itinerary.itineraryId)
        .then((response) => {
          if (response.status === 200) {
            alert("Successfully Deleted");
            this.$router.push("/");
          }
        });
    },
    initMap() {
        this.map = new window.google.maps.Map(document.getElementById("map"), {
        center: this.mapCenter,
        zoom: 12,
        maxZoom: 20,
        minZoom: 3,
        streetViewControl: true,
        mapTypeControl: true,
        fullscreenControl: true,
        zoomControl: true,
      });
    },
    calculateAndDisplayRoute(directionsService, directionsDisplay, pointA, pointB) {
      let waypointsArray = [];
      for(let i = 1; i < this.listOfPlaces.length; i++) {
        waypointsArray.push({location: new window.google.maps.LatLng(this.listOfPlaces[i][1].lat, this.listOfPlaces[i][1].lng), stopover: true})
      }
      directionsService.route({
          origin: pointA,
          destination: pointB,
          avoidTolls: false,
          avoidHighways: false,
          travelMode: window.google.maps.TravelMode.DRIVING,
          waypoints: waypointsArray,
          optimizeWaypoints: true
      }, function (response, status) {
          if (status == window.google.maps.DirectionsStatus.OK) {
              directionsDisplay.setDirections(response);
          } else {
              window.alert('Directions request failed due to ' + status);
          }
      });
    }
  }
};
</script>

<style scoped>

#address-container {
  display: grid;
  grid-template-columns: 30% 45% 45%;
  margin-top: 2%;
} 

div #map {
  height: 100%;
  width: 75%;
  margin: auto;
}

div #map button {
  background-color: red;
}

#delete-btn {
  position: absolute;
  bottom: 0;
  left: 0;
  margin-bottom: 5px;
}

.address-info {
  font-size: 20px;
  margin: auto;
}

.category-text {
  position: absolute;
  bottom: 0;
  right: 0;
  font-size: 20px;
  margin-right: 5px;
}

.details-container::v-deep button {
  font-size: 16px;
  padding: 5px;
  margin: 5px;
} 

#delete {
  justify-content: left;
}

.card-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.card-container::v-deep button {
  font-weight: 600;
  color:white !important;
  background-color: #28527A;
}

.card {
  width: 400px;
  height: 380px;
  box-shadow: 0 4px 8px 0 rgba(90, 167, 238, 0.6);
  transition: 0.3s;
  margin: 15px;
  border-radius: 5px;
  transition: transform 500ms;
  color: #28527a;
}

.card-contents {
  padding: 5px;
  height: 100%;
}

.card-img-container {
  height: 200px;
}

#card-img {
  height: 200px;
  width: 100%;
} 

.address-info::v-deep button {
  font-weight: 600;
  color:white !important;
  background-color: #28527A;
}

.details-container {
  color: #28527A;
  margin-left: 1%;

}

#delete::v-deep button {
  background-color: red;
}

.card:hover {
  transform: scale(1.05);
}

.content-container {
  height: 150px;
  margin: 3% 0;
  padding: -5px;
  position: relative;
}

.content-container h4 {
  font-weight: 600;
}

#map {
  width: 100%;
  height: 100%;
  /* padding: px; */
  margin: 25px;
}

.report-container {
  height: 500px;
  overflow-y: scroll;
  width: 400px;
  margin-right: 20px;
}

#report {
  /* overflow-y: scroll; */
  display: flex;
  width: 100%;
  padding-right: 10px;
}

.tagline {
  margin-top: 10px;
  margin-left: 5px;
}

#emphasis-text {
  position: absolute;
  bottom: 0;
  right: 0;
  /* color: #f5d888; */
  font-size: 16px;
  margin-right: 5px;
  margin-bottom: 12px;
}

.date {
    font-style: italic;
    color: rgb(102, 102, 102);
}

#update-instructions {
  font-size: 16px;
}

</style>
