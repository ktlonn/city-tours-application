<template>
  <div id="app">
    <b-card-header id="nav" header-tag="nav">
      <b-nav card-header pills>
      <b-nav-item :to="{ name: 'home' }" exact exact-active-class="active">Home</b-nav-item>
      <b-nav-item :to="{ name: 'all-itineraries'}" v-if="$store.state.token != ''" exact exact-active-class="active">Itineraries </b-nav-item>
      <!-- <img src="../public/img/small-white-logo.png"> -->
      <!-- <b-nav-item :to="{ name: 'itinerary'}" v-if="$store.state.token != ''" exact exact-active-class="active">Itinerary </b-nav-item> -->
      <b-nav-item class="logout" :to="{ name: 'logout' }" v-if="$store.state.token != ''" exact exact-active-class="active">Logout</b-nav-item>
      <b-nav-item :to="{ name: 'login'}" v-else exact exact-active-class="active">Login</b-nav-item>
    </b-nav>
    </b-card-header>
      <router-view />
  </div>
</template>

<style>

@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@500&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Shrikhand&display=swap');

html, body {
  font-family: 'Montserrat', sans-serif;
  /* font-size: 1vw; */

}

#app {
  font-family: 'Montserrat', sans-serif;
  /* font-size: 1vw; */
}

#nav {
  background-color: #28527A;
  text-decoration: none;
  border: none;
  padding-bottom: 10px;
  position: sticky;
  width: 100%;
  z-index: 200;
  height: auto;
  top: 0;
  /* display: inline; */
  font-size: 2vw;
}

#nav a {
  font-size: 20px;
  font-weight: bold;
  text-decoration: none;
  color: white;
  margin-right: 15px;
}

.nav-pills .nav-link.active{
  background-color: #f5d888 !important;
  border-radius: 8%;
  color: #28527A !important;
}

.logout{
  margin-left: auto;
}


</style>