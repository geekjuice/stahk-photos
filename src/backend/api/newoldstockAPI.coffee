###
New Old Stock API
###

baseAPI = require('./baseAPI')

SOURCE = 'New Old Stock'
URL = 'http://nos.twnsnd.co/'
SELECTOR = '.photo-wrapper-inner img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
