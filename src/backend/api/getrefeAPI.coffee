###
Getrefe API
###

baseAPI = require('./baseAPI')

SOURCE = 'Getrefe'
URL = 'http://getrefe.tumblr.com'
SELECTOR = '.displaynone img'
QUERY = ($img) -> $img.attr('src')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})
