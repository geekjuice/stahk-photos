###
Gratisography API
###

baseAPI = require('./baseAPI')

SOURCE = 'Gratisography'
URL = 'http://gratisography.com'
SELECTOR = 'img[data-original]'
QUERY = ($img) -> "#{URL}/#{$img.data('original')}"

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
