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

  addLocation: ({ commit, state, dispatch }, city) ->
    location = utils.locationFromSlug city

    # If the city immediately appears to be invalid, show an error message
    return if location.slug == ''

    # If the location already exists, set that location as active
    if cache.locationExists location.slug
      EventBus.$emit 'location-created'
      return dispatch 'setActiveLocation', location.slug

    # Check if the OpenWeather API can find this location
    api.getWeather location.slug, state.units,
      (response) =>
        # Commit the city, with a timestamp and units
        location = cache.timestampData location, response.data, state.units

        # Locations added here will always be user-defined
        location.userDefined = true
        commit types.SET_ACTIVE_LOCATION, location
        EventBus.$emit 'location-created'
        
    , (error) =>
      console.log error
      console.log utils.parseErrorResponse error

  setActiveLocation: ({ commit, state }, slug, callback) ->
    # Read location from cache or build a starter object for a new location
    location = cache.readLocation(slug) || utils.locationFromSlug(slug)

    # Request new data if the location cache is empty/outdated
    if cache.locationNeedsUpdate location.slug, state.units
      api.getWeather location.slug, state.units,
        (response) =>
          location = cache.timestampData location, response.data, state.units

          # Set current location
          commit types.SET_ACTIVE_LOCATION, location
      , (error) =>
        console.log error
        console.log utils.parseErrorResponse error
    else
      # If the cache is up-to-date, use that data
      commit types.SET_ACTIVE_LOCATION, location

###
Private methods to change the app state
###
mutations =
  "#{types.ADD_LOCATION}": (state, location) ->
    cache.addLocation location
    Vue.set state.locations, location.slug, location

  "#{types.REMOVE_LOCATION}": (state, slug) ->
    state.location = null if state.location.slug == slug
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
