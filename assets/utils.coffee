module.exports =

  # Convert string to kebab-case slug
  slugify: (str) ->
    return str.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')

  # Convert string to Title Case
  title: (str) ->
    return str.replace /\w\S*/g, (txt) ->
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

  # Try to determine the status code of a failed API request
  # Returns null if none found
  parseErrorResponse: (error) -> return error.response?.status

  # Convert a slug or city name to a baseline location object
  locationFromSlug: (slug) ->
    return {
      slug: @slugify(slug).trim()
      label: @title(slug).trim()
    }
