###
The main app root
###
config = require './config'

module.exports =
  el: '#app'

  components:
    controller: require './components/controller'

  computed:
    locations: -> return config.locations

  mounted: -> console.log @$router
