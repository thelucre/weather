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
