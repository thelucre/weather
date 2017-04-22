module.exports =

  # Convert string to kebab-case slug
  slugify: (str) ->
    return str.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')

  # Convert string to Title case 
  title: (str) ->
    return str.replace /\w\S*/g, (txt) ->
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

  parseErrorResponse: (error) -> return error.response?.status
