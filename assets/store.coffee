import Vue from 'vue'
import Vuex from 'vuex'
Vue.use Vuex

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

  # Celcius (metric) or Degrees (imperial)
  units: 'imperial'

  # Loading flag to manage user input
  loading: false

###
Public accessors to read the app state
###
getters =
  allLocations: (state) -> return state.locations

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
    slug = utils.slugify city
    city = utils.title city
    # If the city immediately appears to be invalid, show an error message
    return if slug.trim() == ''

    # If the location already exists, just activate the weather detail
    return console.log 'already exists' if cache.locationExists slug

    # TODO: is the city found in the OpenWeather API (look for 404), if so, error
    api.getWeather slug, state.units,
      (response) =>
        # Commit the city
        commit types.ADD_LOCATION, label: city, slug: slug, userDefined: true

    , (error) =>
      console.log error
      console.log utils.parseErrorResponse error


###
Private methods to change the app state
###
mutations =
  "#{types.REMOVE_LOCATION}": (state, slug) ->
    cache.removeLocation slug
    Vue.delete state.locations, slug

  "#{types.ADD_LOCATION}": (state, location) ->
    cache.addLocation location
    Vue.set state.locations, location.slug, location

  "#{types.TOGGLE_UNITS}": (state, units) ->
    if state.units == 'metric'
      state.units = 'imperial'
    else state.units = 'metric'

export default new Vuex.Store
  state:      state
  getters:    getters
  actions:    actions
  mutations:  mutations
