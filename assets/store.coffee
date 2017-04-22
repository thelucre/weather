import Vue from 'vue'
import Vuex from 'vuex'
Vue.use Vuex

###
The global app state
###
state =
  # List of locations for weather API
  locations: []

  # Celcius (metric) or Degrees (imperial)
  units: 'imperial'

  # Loading flag to manage user input
  loading: false

###
Public accessors to read the app state
###
getters = {}

###
Public methods that may attempt to change the app state
###
actions =
  getWeatherForLocation: (location) ->
    console.log 'getting weather for location'

  addLocation: ({ commit }, location) ->
    console.log 'trying to add location: ', location

###
Private methods to change the app state
###
mutations = {}


export default new Vuex.Store
  state:      state
  getters:    getters
  actions:    actions
  mutations:  mutations
