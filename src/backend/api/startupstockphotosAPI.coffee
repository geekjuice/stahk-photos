###
Startup Stock Photos API
###

baseAPI = require('./baseAPI')

SOURCE = 'Startup Stock Photos'
URL = 'http://startupstockphotos.com/'
SELECTOR = '.media img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})

