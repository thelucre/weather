module.exports =

  # Convert string to kebab-case slug
  slugify: (str) ->
    return str.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')
