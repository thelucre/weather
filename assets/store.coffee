import Vue from 'vue'
import Vuex from 'vuex'
Vue.use Vuex

# Tools
import EventBus from './events'
cache = require './cache'
config = require './config'
utils = require './utils'
api = require './api'
types = require './types'

###
The global app state
###
state =
  # List of locations for weather API
  locations: cache.loadLocations config.locations

  # Current active location
  location: null

  # Celcius (metric) or Degrees (imperial)
  units: 'imperial'

  # Loading flag to manage user input
  loading: false

###
Public accessors to read the app state
###
getters =
  allLocations: (state) -> return state.locations

  activeLocation: (state) -> return state.location

###
Public methods that may attempt to change the app state
###
actions =

  getWeatherForLocation: (location) ->
    console.log 'getting weather for location'

  toggleUnits: ({ commit }) -> commit types.TOGGLE_UNITS

  removeLocation: ({ commit }, slug) ->
    commit types.REMOVE_LOCATION, slug if cache.locationExists slug

  addLocation: ({ commit, state }, city) ->
    location = utils.locationFromSlug city

    # If the city immediately appears to be invalid, show an error message
    return if location.slug == ''

    # If the location already exists, just activate the weather detail
    return console.log 'already exists' if cache.locationExists location.slug

    # Check if the OpenWeather API can find this location
    api.getWeather location.slug, state.units,
      (response) =>
        # Commit the city
        location.weather = response.data
        location.userDefined = true
        commit types.SET_ACTIVE_LOCATION, location
        EventBus.$emit 'location-created'
    , (error) =>
      console.log error
      console.log utils.parseErrorResponse error

  setActiveLocation: ({ commit, state }, slug, callback) ->
    location = utils.locationFromSlug slug
    api.getWeather location.slug, state.units,
      (response) =>
        location.weather = response.data
        # Set current location
        commit types.SET_ACTIVE_LOCATION, location
    , (error) =>
      console.log error
      console.log utils.parseErrorResponse error


###
Private methods to change the app state
###
mutations =
  "#{types.ADD_LOCATION}": (state, location) ->
    cache.addLocation location
    Vue.set state.locations, location.slug, location

  "#{types.REMOVE_LOCATION}": (state, slug) ->
    cache.removeLocation slug
    Vue.delete state.locations, slug

  "#{types.SET_ACTIVE_LOCATION}": (state, location) ->
    cache.addLocation _.clone location, deep: true
    Vue.set state.locations, location.slug, location
    state.location = location

  "#{types.TOGGLE_UNITS}": (state, units) ->
    if state.units == 'metric'
      state.units = 'imperial'
    else state.units = 'metric'

export default new Vuex.Store
  state:      state
  getters:    getters
  actions:    actions
  mutations:  mutations
