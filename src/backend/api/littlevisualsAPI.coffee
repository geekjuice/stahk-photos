###
Little Visuals API
###

baseAPI = require('./baseAPI')

SOURCE = 'Little Visuals'
URL = 'http://littlevisuals.co'
SELECTOR = 'img.better-photo'
QUERY = ($img) -> $img.data('1280u')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
