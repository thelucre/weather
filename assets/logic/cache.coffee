config = require '../config'
utils = require '../utils'

# Private singleton cache object
cache = JSON.parse(localStorage.getItem(config.key)) || {}

module.exports =
  ###
  Get a copy of the cache obj
  return object
  ###
  get: -> return _.clone cache, deep: true

  ###
  Insert a location into the cache
  param - location object
  ###
  addLocation: (location) ->
    cache[location.slug] = location
    @write()

  ###
  Attempts to retrieve a location from the cache
  ###
  readLocation: (slug) -> return cache[slug]

  ###
  Removes a location from the cache
  param - location slug
  ###
  removeLocation: (slug) ->
    delete cache[slug]
    @write()

  ###
  Check if a location exists in the cache
  param - location slug
  return bool
  ###
  locationExists: (slug) -> return cache.hasOwnProperty slug

  ###
  Check if a location's cached entry is out of date
  param - location slug
  return bool
  ###
  locationNeedsUpdate: (slug, units = 'imperial') ->
    # If there's no matching cache slug, we definitely need to update
    return true if !@locationExists slug

    # If there's not weather data, skip the cache
    latest = cache[slug].weather?[units]
    return true if !latest

    # If the weather data is old, skip the cache
    now = utils.makeTimestamp()
    return true if (now - latest.timestamp > config.cache.period)

  ###
  Load locations from cache
  param - location collection
  return object - location collection from cache data
  ###
  loadLocations: (locations) ->
    # Save default office locations to cache, if they don't exist already
    _.each locations, (location) =>
      location.userDefined = false
      @addLocation location if !@locationExists location.slug

    return _.clone cache, deep: true

  ###
  Writes curernt cache to local storage
  ###
  write: -> localStorage.setItem config.key, JSON.stringify cache

  ###
  Build out location object properties for caching
  ###
  timestampData: (location, data, units) ->
    location.weather = {} if !location.weather
    location.weather[units] = data
    location.weather[units].timestamp = utils.makeTimestamp()
    return location
