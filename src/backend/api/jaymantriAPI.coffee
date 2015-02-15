###
Jay Mantri API
###

baseAPI = require('./baseAPI')

SOURCE = 'Jay Mantri'
URL = 'http://jaymantri.com'
SELECTOR = '.hresPhoto img:first-child'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
