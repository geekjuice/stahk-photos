###
Superfamous API
###

baseAPI = require('./baseAPI')

SOURCE = 'Superfamous Studios'
URL = 'http://superfamous.com/'
SELECTOR = '.project_content img'
QUERY = ($img) -> $img.attr('src_o')

# Export API
module.exports = baseAPI({SOURCE, URL, SELECTOR, QUERY})

