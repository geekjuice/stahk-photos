###
Picjumbo API
###

baseAPI = require('./baseAPI')

SOURCE = 'Picjumbo'
URL = 'http://picjumbo.com'
SELECTOR = 'img.image'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
