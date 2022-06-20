<template>
  <div>

      <div class="heading">
          <div id="banner-img"><img src="../../public/img/small-white-logo.png"></div>
        <h1>Your Itineraries</h1>
           <ul class="details">
               <li>Select one of your itineraries to view more details and your travel route</li>
               <li>Click the share button to share your itinerary with other users</li>
               <li>To create a new itinerary, navigate back to the home page</li>
           </ul>
      </div>
    <div class="itinerary" v-for="itinerary in itineraries" v-bind:key="itinerary.itineraryId">
      
        <div class="list" @click="viewItineraryDetails(itinerary.itineraryId)">
           <h3>{{itinerary.itineraryName}}</h3>
           <p class="date">{{dateConverter(itinerary.itineraryDate)}}</p>
        <div class="shared-button">
            <div v-if="itinerary.shared">
        
            <b-button class="is-shared" variant="success" v-on:click.stop='itinerary.shared = !itinerary.shared; updateShared(itinerary)'>Shared</b-button>
            </div>
            <div v-else>
                <b-button class="is-not-shared" v-on:click.stop='itinerary.shared = !itinerary.shared; updateShared(itinerary)'>Share</b-button>
                </div>
        </div>

        <div class="landmark-list"> 
        <b-table-simple responsive class="table">
            <b-thead>
                <b-tr>
                    <b-th>Landmarks</b-th>
                    <b-th id="daysHours">Hours</b-th>
                    <b-th id="address">Address</b-th>
                </b-tr>
            </b-thead>
            <b-tbody>
                <b-tr v-for="landmark in itinerary.landmarkOnItinerary" v-bind:key="landmark.name">
                    <b-td><h6 id="name">{{landmark.name}}</h6></b-td>
                    <b-td><p id="daysHours">{{landmark.daysHours}}</p></b-td>
                    <b-td><p id="address">{{landmark.address}}</p></b-td>
                </b-tr>
            </b-tbody>
        </b-table-simple>
        </div>

        </div>
    </div>

    <div >
        <div class="shared-heading">
            <h2>Public Itineraries</h2>
            <p>View other user's itineraries to inspire your own adventures.</p>
        </div>
        <div class="shared" v-for="itinerary in shared" v-bind:key="itinerary.id">
            <div class="list">
            <h3>{{itinerary.itineraryName}}</h3>
                <div class="landmark-list"> 
                <b-table-simple responsive class="table">
                    <b-thead>
                        <b-tr>
                            <b-th>Landmarks</b-th>
                            <b-th id="daysHours">Hours</b-th>
                            <b-th id="address">Address</b-th>
                        </b-tr>
                    </b-thead>
                    <b-tbody>
                        <b-tr v-for="landmark in itinerary.landmarkOnItinerary" v-bind:key="landmark.name">
                            <b-td><h6 id="name">{{landmark.name}}</h6></b-td>
                            <b-td><p id="daysHours">{{landmark.daysHours}}</p></b-td>
                            <b-td><p id="address">{{landmark.address}}</p></b-td>
                        </b-tr>
                    </b-tbody>
                </b-table-simple>
                </div>
            </div>
        </div>

    </div>

  </div>
</template>

<script>
import ItineraryService from '../services/ItineraryService'
export default {
    name: 'Itineraries',
      data() {
       
    return {
      itineraries: [],
      shared: []
    }
  },
  created(){
    ItineraryService.retrieveAllUserItineraries().then((response) => {
      this.itineraries = response.data;
      
    }),
    ItineraryService.retrieveAllSharedItineraries().then((response) => {
      this.shared = response.data;
      
    })
  },
    methods: {
    viewItineraryDetails(id) {
      this.$router.push(`/itinerary/${id}`);
    },
    dateConverter(date){
        let newDate = new Date(date).toString();
        return newDate.substring(0, 11);
    },
    updateShared(itin) {
     ItineraryService.updateItinerary(itin);
    } 
  }
}
</script>

<style>
.table{
    width: 100%;
    border-style: hidden !important;
}

tr{
    border-style: hidden !important;
}

td{
    padding: 0 !important;
    width: 2%;
}

th{
    padding: 0 !important;
    padding-bottom: 1% !important;
    color: #28527A;
}

.itinerary, .shared{
    padding: 1% 1% 0% 1%;
    /* border: 3px solid #28527A; */
    border-radius: 10px;
    width: 76%;
    margin-left: 12%;
    margin-bottom: 2%;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
    position: relative;
}

.itinerary:hover{
    transform: scale(1.01);
    cursor: pointer;
}

.details{
    margin-left: 12%;
    margin-top: 2%;
}

h3{
    color: #28527A;
}

h2{
    color: #28527A;
    font-weight: bold !important;
}

.shared-heading{
    margin-left: 12%;
    padding: 1% 0%;
}

.shared-button{
    position: absolute;
    top: 10px;
    right: 10px;
}

.is-shared{
    background-color: #28527A !important;
}

.date{
    font-style: italic;
    color: rgb(102, 102, 102);
}

h1{
    color: white;
    font-weight: bold !important;
}

.heading {
  background: linear-gradient(to top, rgba(40,82,122,.7), rgba(40,82,122,.7)), no-repeat center/cover url(../../public/img/header-blue-tint.png);
  border-radius: 0px 0px 5px 5px;
  padding: 1%;
  margin-bottom: 20px;
  color: white;
}

#banner-img img {
  height: 250px;
}

#banner-img {
  text-align: center;
  margin-top: 0;
}

@media only screen and (max-width: 767px) {
  #daysHours{
      display: none;
  }
  #address{
      display: none;
  }
  #name{
      width: 100%;
  }
 
}

</style>