# Load stylus entry point
require './stylus/main.styl'

# Plugins that should be made available globally
require 'velocity-animate'
require('fastclick').attach(document.body);
require './vendor/local-storage-polyfill'

# App config
config = require './config'

# Boot and configure Vue
import Vue from 'vue'

# Setup XHR config
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use VueAxios, axios
Vue.axios.defaults.baseURL = config.api.root

# Router definition
import VueRouter from 'vue-router'
import router from './logic/router'
Vue.use VueRouter

router.beforeEach (to, from, next) ->
  window.scrollTo(0, 0)
  next()

# Controller logic
import store from './logic/store'
import { sync } from 'vuex-router-sync'
sync store, router

# Boot the app!
app = require './logic/app'
app.router = router
app.store = store
new Vue app
