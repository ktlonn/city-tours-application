import Vue from 'vue'
import App from './App.vue'
import router from './router/index'
import store from './store/index'
import axios from 'axios'
// import * as VueGoogleMaps from 'vue2-google-maps'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import vuePositionSticky from 'vue-position-sticky'


Vue.config.productionTip = false
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(vuePositionSticky)
axios.defaults.baseURL = process.env.VUE_APP_REMOTE_API;


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')