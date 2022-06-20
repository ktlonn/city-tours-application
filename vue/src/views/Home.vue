<template>
  <div class="home-container">
    <div class="responsive-bar">
      <vue-position-sticky :offsetTop="50">
    <itinerary-list/>
    </vue-position-sticky>
    </div>
  <div v-bind:class="{home:$store.state.token != ''}">
<vue-position-sticky :offsetTop="50" class="sticky-bar">
 <div class="left-panel" v-if="$store.state.token != ''">
      <create-itinerary/>
      <itinerary-list/>
    </div>
</vue-position-sticky>

    
      <div class="main">
        <landmarks/>
      </div>
    </div>
    </div>
</template>

<script>
import Landmarks from "../components/Landmarks.vue"
import CreateItinerary from "@/components/CreateItinerary";
import ItineraryList from "@/components/ItineraryList";
export default {
  components: {
    Landmarks,
    CreateItinerary,
    ItineraryList
  },
  name: "home"
};
</script>
<style scoped>

.responsive-bar {
  display: none;
}

.home {
  height: 100%;
  display: grid;
  grid-template-columns: 20% 80%;
  grid-template-areas: 
  "left-panel main";
}
.left-panel {
  /* height: 100%; */
  display: flex;
  flex-direction: column;
  align-items: left;
  margin-left: 10%;
  margin-right:10px;
  margin-top: 20%;
  grid-area: left-panel;
}

.main{
  grid-area: main;
  display: flex;
}

@media (max-width:768px) {
  .sticky-bar {
    display: none;
  }

  .home {
    display: block;
    /* width: 100%; */
  }

  .main {
    align-items: stretch;
  }

  .responsive-bar {
    display: block;
  }
}

</style>