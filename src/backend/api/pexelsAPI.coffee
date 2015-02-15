###
Pexels API
###

baseAPI = require('./baseAPI')

SOURCE = 'Pexels'
URL = 'http://pexels.com/'
SELECTOR = '.image img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})

