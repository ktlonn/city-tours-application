import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import Landmark from '../views/Landmark.vue'
import Itinerary from '../views/Itinerary.vue'
import CreateItinerary from '../views/CreateItinerary.vue'
import AllItineraries from '../views/AllItineraries'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/landmark/:id",
      name: "landmark",
      component: Landmark
    },
    {
      path: "/itinerary",
      name: "create-itinerary",
      component: CreateItinerary,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/itinerary/:id",
      name: "itinerary",
      component: Itinerary,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/itineraries",
      name: "all-itineraries",
      component: AllItineraries,
      meta: {
        requiresAuth: true
      }
    },
  ]
})

router.beforeEach((to, from, next) => {
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    next();
  }
});

export default router;