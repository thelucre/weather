config = require './config'

# Private singleton cache object
cache = JSON.parse(localStorage.getItem(config.cacheKey)) || {}

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
    @writeCache()

  ###
  Removes a location from the cache
  param - location slug
  ###
  removeLocation: (slug) ->
    delete cache[slug]
    @writeCache()

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
  locationNeedsUpdate: (slug) -> return true

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
  writeCache: -> localStorage.setItem config.cacheKey, JSON.stringify cache
