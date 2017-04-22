axios = require 'axios'
config = require './config'

module.exports =
  ###
  Get Weather data for a single city
  ###
  getWeather: (city, units = 'imperial', callback, error) ->
    axios.get('/weather', {
      params:
        q: city
        units: units
        appid: config.api.key
    }).then(callback).catch(error)
