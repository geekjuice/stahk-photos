###
Picography API
###

baseAPI = require('./baseAPI')

SOURCE = 'Picography'
URL = 'http://picography.co'
SELECTOR = '.photoList img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
