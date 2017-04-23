module.exports =

  # Convert string to kebab-case slug
  slugify: (str) ->
    return str.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')

  # Convert string to Title Case
  title: (str) ->
    return str.replace('-',' ').replace /\w\S*/g, (txt) ->
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

  # Try to determine the status code of a failed API request
  # Returns null if none found
  parseErrorResponse: (error) -> return error.response?.status

  # Convert a slug or city name to a baseline location object
  locationFromSlug: (slug, userDefined = true) ->
    return {
      label: @title(slug).trim()
      slug: @slugify(slug).trim()
      userDefined: userDefined
      weather:
        imperial: null
        metric: null
    }

  ###
  Create a unix-style timestamp (seconds) for comparing against
  caching updates
  ###
  makeTimestamp: -> return Math.round new Date().getTime()/1000

  ###
  Format a barometric pressure reading for imperial or metric
  ###
  formatPressure: (pressure, units) ->
    return (pressure*0.02953).toFixed(2)+' in.' if units == 'imperial'
    return pressure+' mb'

  ###
  Format unix time stamp to an object with time and meridiem
  ###
  formatTime: (date) ->
    seconds = date.getSeconds().toString().padStart(2, '0')
    minutes = date.getMinutes().toString().padStart(2, '0')
    hours = date.getHours()%12
    hours = 12 if hours == 0
    return {
      time: "#{hours}:#{minutes}:#{seconds}"
      meridiem: if date.getHours() > 12 then 'pm' else 'am'
    }
