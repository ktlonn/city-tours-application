<template>
  <div class="container">
    <div class="welcome-container">
    <div class="welcome">
      <div class="welcome-message">
        <div id="banner-img"><img src="../../public/img/small-white-logo.png"></div>
        <h1 id="welcome-header">Welcome to Windy City Tours!</h1>
        <div id="welcome-text">
          <p>Whether you are a city regular or visiting Chicago for the first time, Windy City Tours can help you design a fun, 
              one-day itinerary using our curated list of must-see landmarks, and optimized route mapping.</p>
          <p>To make the most of our app:</p>
          <ul>
            <li>Visit the <strong>Login</strong> page to sign in or create an account</li>
            <li>Once logged in, <strong>Create an Itinerary</strong> by adding a name, date, and starting point</li>
            <li>Under <strong>Active Itinerary</strong>, select the itinerary to which you would like to add landmarks</li>
            <li>Explore the curated list of landmarks, and use the <strong>Add to Itinerary</strong> button on the landmark’s detail page to add it to your Active Itinerary</li>
            <li>Visit the <strong>Itineraries</strong> page to manage the itinerary and view your optimized route map</li>
          </ul>
          <h4>Happy Touring!</h4>
        </div>
      </div>
    </div>
    </div>
    <div class="search-bar-container">
    <input
      class="search-bar"
      type="text"
      v-model="filter"
      placeholder="Search for landmark..."
    />
    </div>
    <br />
    <div class="search-filter">
   
      <div class="category-filters">
        <b-dropdown
          id="category-filter"
          text="Filter categories"
          class="dropdown"
          variant="none">
          <b-checkbox value="Entertainment" v-model="entertainment">Entertainment</b-checkbox>
          <b-checkbox value="Food-Beverage" v-model="foodBeverage">Food & Beverage</b-checkbox>
          <b-checkbox value="Landmark" v-model="landmark">Landmark</b-checkbox>
          <b-checkbox value="Sports" v-model="sports">Sports</b-checkbox>
          <b-checkbox value="Museum" v-model="museum">Museum</b-checkbox>
        </b-dropdown>
      </div>
      <div></div>
      <div class="day-filters">
        <b-dropdown
          id="days-filter"
          text="Filter days"
          class="dropdown"
          variant="none">
          <b-checkbox value="Monday" v-model="monday">Monday</b-checkbox>
          <b-checkbox value="Tuesday" v-model="tuesday">Tuesday</b-checkbox>
          <b-checkbox value="Wednesday" v-model="wednesday">Wednesday</b-checkbox>
          <b-checkbox value="Thursday" v-model="thursday">Thursday</b-checkbox>
          <b-checkbox value="Friday" v-model="friday">Friday</b-checkbox>
          <b-checkbox value="Saturday" v-model="saturday">Saturday</b-checkbox>
          <b-checkbox value="Sunday" v-model="sunday">Sunday</b-checkbox>
        </b-dropdown>
      </div>
    </div>
    <div class="card-container">
      <div>
        <b-modal
          id="landmarkModal"
          hide-footer
          v-bind:title="landmarkPopup(activeId).name"
          size="lg"
        > <div class="modal-img-container">
            <div class="main-photo" 
              v-on:click.stop="activatePhoto(landmarkPopup(activeId).photo1)">
              <img :key="componentKey" v-bind:src="activePhoto" />
            </div> 
            <div id="gallery">
              <div id="gallery-container" v-on:click.stop="activatePhoto(landmarkPopup(activeId).photo2)">
              <img v-bind:src="this.activeAlbum[1]" />
              </div>
              <div id="gallery-container" v-on:click.stop="activatePhoto(landmarkPopup(activeId).photo3)">     
              <img v-bind:src="this.activeAlbum[2]"/>
              </div>
               <div id="gallery-container" v-on:click.stop="activatePhoto(landmarkPopup(activeId).photo4)">
              <img v-bind:src="this.activeAlbum[3]" />
              </div>
            </div>
          </div>
          <div class="modal-content-container">
          <p>{{ landmarkPopup(activeId).category }}</p>
          <p>{{ landmarkPopup(activeId).description }}</p>
          <p>{{ landmarkPopup(activeId).daysHours }}</p>
          </div>
          
          <b-button-group id="modal-buttons">
            <b-button :disabled="!itineraryIsSelected" v-if="!landmarkExists && this.$store.state.token != ''" v-on:click="addToItinerary()">Add to Itinerary</b-button>
            <b-button v-else-if="this.$store.state.token != ''" @click="removeFromItinerary()">Remove from Itinerary</b-button>
          </b-button-group>

        <b-button-group id="modal-buttons" class="thumbs-btn">
            <b-button :disabled="this.$store.state.token == '' || checkIfThumbsUp(activeLandmark)" @click="giveThumbsUp(activeLandmark)"><b-icon icon="hand-thumbs-up" class="h1 mb-0"></b-icon>&emsp;
             {{ landmarkPopup(activeId).thumbsUp }}
            </b-button>
            <b-button :disabled="this.$store.state.token == '' || checkIfThumbsDown(activeLandmark)" @click="giveThumbsDown(activeLandmark)">
              <b-icon icon="hand-thumbs-down" class="h1 mb-0"></b-icon>&emsp;{{
                landmarkPopup(activeId).thumbsDown
              }}
            </b-button>
        </b-button-group>

        </b-modal>
      </div>
      <div
        v-for="filtered in filteredList"
        v-bind:key="filtered.id"
        @click="
          activeAlbum.length = 0
          activeAlbum.push(filtered.photo1)
          activeAlbum.push(filtered.photo2)
          activeAlbum.push(filtered.photo3)
          activePhoto = filtered.photo1
          $bvModal.show('landmarkModal');
          activeId = filtered.id;
        "
      >
        <div class="card">
          <div class="card-contents">
            <div class="card-img-container">
                <img id="card-img" :src='filtered.imgUrl' />
              </div>
              <div class="card-text-container">
              <h4 style="text-align: center">{{ filtered.name }}</h4>
              <p class="tagline">{{ filtered.tagline }}</p>
               <div id="emphasis-text">
                {{ filtered.category }}
              </div>
              <div class="proximity-line" v-if="itineraryIsSelected"> 
                {{ proximityDistance(filtered).toFixed(2) }} miles away
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import LandmarkService from "../services/LandmarkService";
import PhotoService from "../services/PhotoService";
import itineraryService from "@/services/ItineraryService";

export default {
  name: "landmarks",
  data() {
    return {
      finalLandmarksArray: [],
      activeId: 0,
      startingPoint: {
        latitude: 0,
        longitude: 0,
      },
      landmarkDistance: [],
      landmarks: [],
      filter: "",
      entertainment: "",
      activeLandmark: {},
      landmark: "",
      foodBeverage: "",
      sports: "",
      museum: "",
      monday: "",
      tuesday: "",
      wednesday: "",
      thursday: "",
      friday: "",
      saturday: "",
      sunday: "",
      proxDistance: "",
      activeAlbum: [],
      activePhoto: ''
    };
  },
  created() {
    LandmarkService.getAllLandmarks().then((response) => {
      this.landmarks = response.data;
      this.landmarks.forEach((landmark) => {
        PhotoService.getPhoto(landmark.placeId).then((response) => {
          landmark.photo1 = this.getPhoto(response.data[0].photoReference);
          landmark.photo2 = this.getPhoto(response.data[1].photoReference);
          landmark.photo3 = this.getPhoto(response.data[2].photoReference);
        });
      });
    });
  },
 
  computed: {
    itineraryIsSelected() {
      return this.$store.state.activeItinerary != "";
    },
    landmarkExists() {
      if (this.$store.state.activeItinerary != "") {
        let found = false;
        let currentItineraryLandmarks = this.$store.state.activeItinerary
          .landmarkOnItinerary;
        for (let i = 0; i < currentItineraryLandmarks.length; i++) {
          if (currentItineraryLandmarks[i].id === this.activeId) {
            found = true;
          }
        }
        return found;
      } else {
        return false;
      }
    },
    filteredList() {
      let isCheckBoxChecked = false;
      let filteredLandmarks = this.landmarks;
      let filteredCheckboxes = this.landmarks;

      //this is filtering by the check boxes
      filteredCheckboxes = filteredCheckboxes.filter((place) => {
        let isEntertainment = false;
        let isLandmark = false;
        let isFoodBev = false;
        let isSports = false;
        let isMuseum = false;
        let isMonday = false;
        let isTuesday = false;
        let isWednesday = false;
        let isThursday = false;
        let isFriday = false;
        let isSaturday = false;
        let isSunday = false;
        if (this.entertainment != "") {
          isCheckBoxChecked = true;
          isEntertainment = place.category.toLowerCase() == "entertainment";
        }
        if (this.landmark != "") {
          isCheckBoxChecked = true;
          isLandmark = place.category.toLowerCase() == "landmark";
        }
        if (this.foodBeverage != "") {
          isCheckBoxChecked = true;
          isFoodBev = place.category.toLowerCase() == "food & beverage";
        }
        if (this.sports != "") {
          isCheckBoxChecked = true;
          isSports = place.category.toLowerCase() == "sports";
        }
        if (this.museum != "") {
          isCheckBoxChecked = true;
          isMuseum = place.category.toLowerCase() == "museum";
        }
        if (this.monday == "Monday") {
          isCheckBoxChecked = true;
          isMonday = place.monday == true;
        }
        if (this.tuesday == "Tuesday") {
          isCheckBoxChecked = true;
          isTuesday = place.tuesday == true;
        }
        if (this.wednesday == "Wednesday") {
          isCheckBoxChecked = true;
          isWednesday = place.wednesday == true;
        }
        if (this.thursday == "Thursday") {
          isCheckBoxChecked = true;
          isThursday = place.thursday == true;
        }
        if (this.friday == "Friday") {
          isCheckBoxChecked = true;
          isFriday = place.friday == true;
        }
        if (this.saturday == "Saturday") {
          isCheckBoxChecked = true;
          isSaturday = place.saturday == true;
        }
        if (this.sunday == "Sunday") {
          isCheckBoxChecked = true;
          isSunday = place.sunday == true;
        }
        return (
          isEntertainment ||
          isLandmark ||
          isFoodBev ||
          isSports ||
          isMuseum ||
          isMonday ||
          isTuesday ||
          isWednesday ||
          isThursday ||
          isFriday ||
          isSaturday ||
          isSunday
        );
      });

      //filtering by the text box
      filteredLandmarks = filteredLandmarks.filter((place) => {
        let landmarkName = true;
        if (isCheckBoxChecked) {
          landmarkName = false;
        }
        if (this.filter != "") {
          landmarkName = place.name
            .toLowerCase()
            .includes(this.filter.toLowerCase());
        }
        return landmarkName;
      });

      let selectedLandmarks = new Set(filteredLandmarks);
      filteredCheckboxes.forEach((item) => {
        selectedLandmarks.add(item);
      });

      if (isCheckBoxChecked == false && this.filter === "") {
        let final = [];
        this.landmarks.forEach((x) => final.push(x));
        final.sort(
          (a, b) =>
            parseFloat(this.proximityDistance(a)) -
            parseFloat(this.proximityDistance(b))
        );
        return final;
      }

      let final = [];
      selectedLandmarks.forEach((x) => final.push(x));
      final.sort(
        (a, b) =>
          parseFloat(this.proximityDistance(a)) -
          parseFloat(this.proximityDistance(b))
      );

      return final;
    },
  },

  methods: {
    
     activatePhoto(photo = this.activeAlbum[1]) {
      this.activePhoto = photo;
      this.componentKey += 1;
      
    },
    // printArr(a) {
    //   console.log(a);
    // },
    viewLandmarkDetails(id) {
      this.$router.push(`/landmark/${id}`);
    },
    landmarkPopup(id) {
      for (let i = 0; i < this.landmarks.length; i++) {
        if (this.landmarks[i].id == id) {
          this.activeLandmark = this.landmarks[i];
          return this.landmarks[i];
        }
      }
      return -1;
    },
    getPhoto(photoReference) {
      let url =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=" +
        photoReference +
        "&key=";
        if (photoReference != "") {
          return url;
        }
    },
    proximityDistance(landmark) {
      let lat1 = this.$store.state.activeItinerary.startingLatitude;
      let lon1 = this.$store.state.activeItinerary.startingLongitude;
      let lat2 = landmark.latitude;
      let lon2 = landmark.longitude;
      const R = 3957;
      let dLat = toRad(lat2 - lat1);
      let dLon = toRad(lon2 - lon1);
      let a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.sin(dLon / 2) *
          Math.sin(dLon / 2) *
          Math.cos(lat1) *
          Math.cos(lat2);
      let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
      let distance = R * c;
      return distance;

      function toRad(value) {
        return (value * Math.PI) / 180;
      }
    },
    addToItinerary() {
      //need to add active itinerary
      itineraryService
        .addLandmarkToItinerary(
          this.$store.state.activeItinerary.itineraryId,
          this.activeId
        )
        .then((response) => {
          if (response.status === 200) {
            alert("Successfully Added");
          }
        })
        .catch((error) => {
          if (error.response) {
            this.errorMsg =
              "Error adding landmark. Response received was '" +
              error.response.statusText +
              "'.";
          } else if (error.request) {
            this.errorMsg =
              "Error adding landmark. Server could not be reached.";
          } else {
            this.errorMsg =
              "Error adding landmark. Itinerary could not be created.";
          }
        });
    },
    giveThumbsUp() {
      if(this.checkIfThumbsDown(this.activeLandmark)){
        this.activeLandmark.thumbsDown -= 1;
        let list = this.activeLandmark.userLandmarkRatings;
        for(let i = 0; i < list.length; i++){
          if(list[i].userId == this.$store.state.user.id){
            this.activeLandmark.userLandmarkRatings.splice(i, 1);
          }
        }
      }
      this.activeLandmark.thumbsUp += 1
      this.activeLandmark.userLandmarkRatings
          .push({userId: this.$store.state.user.id, landmarkId: this.activeLandmark.id, gaveThumbsUp: true, gaveThumbsDown: false});
      LandmarkService.updateLandmarkRating(this.activeLandmark)
    },
    giveThumbsDown() {
      if(this.checkIfThumbsUp(this.activeLandmark)) {
        this.activeLandmark.thumbsUp -= 1
        let list = this.activeLandmark.userLandmarkRatings;
        for(let i = 0; i < list.length; i++){
          if(list[i].userId == this.$store.state.user.id){
            this.activeLandmark.userLandmarkRatings.splice(i, 1);
          }
        }
      }
      this.activeLandmark.thumbsDown += 1
      this.activeLandmark.userLandmarkRatings
          .push({userId: this.$store.state.user.id, landmarkId: this.activeLandmark.id, gaveThumbsUp: false, gaveThumbsDown: true});
      LandmarkService.updateLandmarkRating(this.activeLandmark)
    },
    checkIfThumbsUp(checkLandmark){
      if(checkLandmark.userLandmarkRatings != null) {
        for (let i = 0; i < checkLandmark.userLandmarkRatings.length; i++) {
          if (checkLandmark.userLandmarkRatings[i].userId == this.$store.state.user.id) {
            return checkLandmark.userLandmarkRatings[i].gaveThumbsUp;
          }
        }
      }
    },
    checkIfThumbsDown(checkLandmark){
      if(checkLandmark.userLandmarkRatings != null) {
        for (let i = 0; i < checkLandmark.userLandmarkRatings.length; i++) {
          if (checkLandmark.userLandmarkRatings[i].userId == this.$store.state.user.id) {
            return checkLandmark.userLandmarkRatings[i].gaveThumbsDown;
          }
        }
      }
    },
    removeFromItinerary() {
      itineraryService
        .removeLandmarkFromItinerary(
          this.$store.state.activeItinerary.itineraryId,
          this.activeId
        )
        .then((response) => {
          if (response.status === 200) {
            alert("Successfully Removed");
          }
        })
        .catch((error) => {
          if (error.response) {
            this.errorMsg =
              "Error removing landmark. Response received was '" +
              error.response.statusText +
              "'.";
          } else if (error.request) {
            this.errorMsg =
              "Error removing landmark. Server could not be reached.";
          } else {
            this.errorMsg =
              "Error removing landmark. Itinerary could not be modified.";
          }
        });
    }
  }
};
</script>

<style scoped>
#emphasis-text {
  position: absolute;
  bottom: 0;
  right: 0;
  font-size: 20px;
  margin-right: 5px;
}

.dropdown {
  margin: 10px;
  background-color: #28527a;
  border-radius: 5px;
  width: 100%;
  align-self: center;
  font-size: 20px !important;
  color: white !important;
}

.search-filter {
  display: flex;
  justify-content: center;
  padding: 1%;
  color: #28527a;
  font-weight: 600;
  gap: 10%;
}

.category-filters {
  padding: 5px;
  color: #28527a;
}

.day-filters {
  padding: 5px;
}

.card-container {
  display: flex;
  flex-wrap: wrap;
}

.card {
  width: 400px;
  height: 350px;
  box-shadow: 0 4px 8px 0 rgba(90, 167, 238, 0.6);
  transition: 0.3s;
  margin: 15px;
  border-radius: 5px;
  transition: transform 500ms;
  border-radius: 5px;
  color: #28527a;
}

.card:hover {
  transform: scale(1.05);
}

.card-contents {
  padding: 5px;
  height: 100%;
}

label {
  color: #28527a;
}

#category-filter::v-deep button {
  font-size: 1.3vw !important;
  font-weight: 600;
  color: white !important;
}

#days-filter::v-deep button {
  font-size: 1.3vw !important;
  font-weight: 600;
  color: white !important;
}

#days-filter::v-deep .dropdown-item {
  font-size: 20px !important;
  font-weight: 600;
  color: white !important;
  padding: 10px;
}

.search-filter::v-deep label {
  font-size: 16px !important;
  font-weight: 700;
  padding-left: 5px;
  color: #28527a !important;
}

.search-bar {
  margin-top: 1%;
}

.card-img-container {
  height: 200px;
}

.card-text-container {
  height: 120px;
  margin: 3% 0;
  padding: -5px;
  position: relative;
}

.card-text-container h4 {
  font-weight: 600;
  font-size: 20px;
}

.card-text-container p {
  font-size: 16px;
}

#card-img {
  width: 100%;
  height: 200px;
}

#modal-buttons::v-deep button {
  font-size: 20px !important;
  font-weight: 600;
  background-color: #f5d888;
  color: white !important;
  border: none;
}

#landmarkModal img{
  width: 100%;
  height: 390px;
  padding: 1px
}

.modal-content-container {
  color: #28527a;
  font-size: 16px;
  font-weight: 500;
}

h4 {
  margin-bottom: 0;
}

.proximity-line {
  position: absolute;
  margin-top: -15px;
  left: 0;
  bottom: 0;
}

.search-bar {
  display: block;
  width: 50%;
  margin-left: 20px;
  margin-top: 2%;
  font-size: 20px;
}

.welcome {
  background: linear-gradient(to top, rgba(40,82,122,.7), rgba(40,82,122,.7)), no-repeat center/cover url(../../public/img/smaller-banner-img.jpg);
  border-radius: 5px;
}

.welcome-message {
  font-style: bold;
  padding: 5px 30px 30px 30px;
}

#welcome-header {
  color: white;
  /* font-family: 'Oswald', sans-serif; */
  /* font-family: 'Shrikhand', cursive; */
  font-weight: 800;
  }

#welcome-text {
  color: white;
}

#banner-img img {
  height: 250px;
}

#banner-img {
  text-align: center;
  margin-top: 0;
}

.welcome-container {
  margin-top: 2%;
  font-weight: 500;
}

#welcome-text > ul > li {
  padding: 3px 0 3px 0;
}

.tagline {
  margin-top: 10px;
}

.thumbs-btn{
    position: absolute;
    right: 1rem;
    bottom: 1rem;
}

.search-bar-container {
  display: flex;
  justify-content: center;
}

.modal-img-container {
  display: grid;
  grid-template-columns: 1fr;
  grid-template-areas:
  "main-photo"
  "gallery";
}

.main-photo {
  display: flex;
  padding: 3px;
}

#gallery {
  display: flex;
  padding: 1px;
}



#gallery img {
  width: 100%;
  height: 130px;
  padding: 3px;
}

#gallery-container {
  width: 100%
}

@media (max-width: 991px) {
  .modal-img-container {
  display: grid;
  grid-template-columns: 1fr;
  grid-template-areas:
  "main-photo";
  }

  .main-photo {
    display: flex;
    padding: 1px;
  }

  #gallery {
    display: none;
  }

  #landmarkModal img{
  width: 100%;
  height: 300px;
  padding: 1px
  }
}

@media (max-width:768px) {
  .card-container {
    justify-content: center;
  }

  .container, .welcome-container, .welcome, .welcome-message, #banner-img, #welcome-header {
    width: 100%;
    margin: auto;
    padding: 5px;
    font-size: 2vw;
  }

  @media (max-width:480px) {
   #welcome-text, #welcome-header {
    display: none;
   }

    #category-filter::v-deep button, #days-filter::v-deep button {
     font-size: 3vw !important;
   }

    #landmarkModal img{
    width: 100%;
    height: 200px;
    padding: 1px
    }
  }
}
</style>