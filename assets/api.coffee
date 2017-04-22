axios = require 'axios'
config = require './config'

module.exports =
  getWeather: (city, units, callback, error)->
    axios.get('/weather', {
      params:
        q: city
        units: units
        appid: config.api.key
    }).then(callback).catch(error)
