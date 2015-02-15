###
Unsplash API
###

baseAPI = require('./baseAPI')

SOURCE = 'Unsplash'
URL = 'http://unsplash.com'
SELECTOR = '.photo img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
