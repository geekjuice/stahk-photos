###
Life of Pix API
###

baseAPI = require('./baseAPI')

SOURCE = 'Life of Pix'
URL = 'http://lifeofpix.com/'
SELECTOR = '.portfolio-item img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
