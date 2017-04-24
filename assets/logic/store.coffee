import Vue from 'vue'
import Vuex from 'vuex'
Vue.use Vuex

# Tools
import router from './router'
import EventBus from './events'
config = require '../config'
utils = require '../utils'
cache = require './cache'
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
  units: cache.readSetting 'units'

  # Loading flag to manage user input
  loading: false

  # Navigation state in mobile
  navigationOpen: false

  error: null

###
Public accessors to read the app state
###
getters =
  allLocations: (state) -> return state.locations

  officeLocations: (state) ->
    return _.filter state.locations, userDefined: false

  userLocations: (state) ->
    return _.filter state.locations, userDefined: true

  activeLocation: (state) -> return state.location

  unitSystem: (state) -> return state.units

  navigationOpen: (state) -> return state.navigationOpen

  errorMessage: (state) -> return state.error

###
Public methods that may attempt to change the app state
###
actions =
  setError: ({ commit }, code) ->
    msg = 'Having some trouble accessing the API. Please try again later.'
    if code == 404
      msg = 'The name entered didn\'t match any cities. Try another?'
    commit types.SET_ERROR, msg

  clearError: ({ commit }) ->
    commit types.CLEAR_ERROR

  toggleNavigation: ({ commit }) ->
    commit types.TOGGLE_NAVIGATION

  closeNavigation: ({ commit }) ->
    commit types.CLOSE_NAVIGATION

  toggleUnits: ({ commit, state, dispatch }) ->
    commit types.TOGGLE_UNITS

    # If there's a current location, update the data for the new units
    dispatch 'setActiveLocation', state.location.slug if state.location

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

    commit types.SET_LOADING, true

    # Check if the OpenWeather API can find this location
    api.getWeather location.slug, state.units,
      (response) =>
        # Commit the city, with a timestamp and units
        location = cache.timestampData location, response.data, state.units

        # Locations added here will always be user-defined
        location.userDefined = true
        commit types.SET_ACTIVE_LOCATION, location
        EventBus.$emit 'location-created'
        commit types.SET_LOADING, false

    , (error) =>
      code = utils.parseErrorResponse error
      dispatch 'setError', code
      commit types.SET_LOADING, false

  clearActiveLocation: ({ commit }) ->
    commit types.CLEAR_ACTIVE_LOCATION

  setActiveLocation: ({ commit, state, dispatch }, slug, callback) ->
    # Read location from cache or build a starter object for a new location
    location = cache.readLocation(slug) || utils.locationFromSlug(slug)

    # Request new data if the location cache is empty/outdated
    if cache.locationNeedsUpdate location.slug, state.units
      commit types.SET_LOADING, true
      api.getWeather location.slug, state.units,
        (response) =>
          location = cache.timestampData location, response.data, state.units

          # Set current location
          commit types.SET_ACTIVE_LOCATION, location
          commit types.SET_LOADING, false
      , (error) =>
        code = utils.parseErrorResponse error
        dispatch 'setError', code
        router.push name: 'home'
        commit types.SET_LOADING, false
    else
      # If the cache is up-to-date, use that data
      commit types.SET_ACTIVE_LOCATION, location

###
Private methods to change the app state
###
mutations =
  "#{types.SET_ERROR}": (state, error) ->
    state.error = error

  "#{types.CLEAR_ERROR}": (state) ->
    state.error = null

  "#{types.CLOSE_NAVIGATION}": (state) ->
    state.navigationOpen = false

  "#{types.TOGGLE_NAVIGATION}": (state) ->
    state.navigationOpen = !state.navigationOpen

  "#{types.ADD_LOCATION}": (state, location) ->
    cache.addLocation location
    Vue.set state.locations, location.slug, location

  "#{types.REMOVE_LOCATION}": (state, slug) ->
    state.location = null if state.location?.slug == slug
    cache.removeLocation slug
    Vue.delete state.locations, slug

  "#{types.SET_ACTIVE_LOCATION}": (state, location) ->
    cache.addLocation _.clone location, deep: true
    Vue.set state.locations, location.slug, location
    state.location = location

  "#{types.CLEAR_ACTIVE_LOCATION}": (state) ->
    state.location = null

  "#{types.TOGGLE_UNITS}": (state, units) ->
    if state.units == 'metric'
      state.units = 'imperial'
    else state.units = 'metric'
    cache.updateSetting 'units', state.units

  "#{types.SET_LOADING}": (state, isLoading) ->
    state.loading = isLoading

export default new Vuex.Store
  state:      state
  getters:    getters
  actions:    actions
  mutations:  mutations
