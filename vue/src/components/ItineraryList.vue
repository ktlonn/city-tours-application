<template>
  <div>
    <div class="list-container">
    <div id="current-itinerary">
      <p>Active Itinerary: {{this.$store.state.activeItinerary.itineraryName}} </p>
    </div>
        <b-dropdown id="active-itinerary" text="Select Active Itinerary" class="dropdown" variant="none">
          <b-dropdown-item class="itinerary-selector" v-for="itinerary in itineraries" :key="itinerary.id" @click="setActiveItinerary(itinerary)">
          {{itinerary.itineraryName}}
          </b-dropdown-item>
        </b-dropdown>
    </div>
  </div>
</template>

<script>
import ItineraryService from "@/services/ItineraryService";
export default {
  name: "ItineraryList.vue",
  data() {
    return {
      itineraries: [],
      user: ''
    }
  },
  created(){
    ItineraryService.retrieveAllUserItineraries()
      .then((response) => {
      this.itineraries = response.data;
    })
  },
  methods: {
    viewItineraryDetails(id) {
      this.$router.push(`/itinerary/${id}`);
    },
    setActiveItinerary(itinerary){
      this.$store.commit("SET_ACTIVE_ITINERARY", itinerary);
    }
  },
}
</script>

<style scoped>

#current-itinerary {
  background-color: white;
  height: 100%;
  display: inline;
  font-size: 1vw;
}

.list {
  margin-top: 10px;
  background-color: #28527A;
  border: 1px solid #28527A;
}
.list:hover{
  background-color: rgb(173, 172, 172);
  border: 1px solid rgb(173, 172, 172);
}

.itinerary-list {
  font-size: 1vw;
}

h3 {
  color:#28527A !important;
}

.list-container {
  margin-top: 20px;
  display: flex;
  flex-direction: column;
  color:#28527A !important;
}

.dropdown {
  /* margin: 10px; */
  background-color: #28527A;
  border-radius: 5px;
  width: 100%;
  align-self: center;
  font-size: 1vw !important;
  color:white !important;
}
 
#active-itinerary::v-deep button  {
  font-size: 1vw !important;
  font-weight: 600;
  color:white !important;
} 

@media (max-width:768px) {
  #current-itinerary {
  background-color: white;
  height: 100%;
  margin: 0;
  font-size: 3vw;
  font-weight: 700;
  text-align: center;
}
  .list-container {
    margin: 0;
}

  #active-itinerary {
  width: 50%;
  margin: 0;
  }

  #active-itinerary::v-deep button  {
  font-size: 3vw !important;
  font-weight: 600;
  color:white !important;

} 

}
</style>