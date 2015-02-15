console.log "{ StahkPhotos }"

stahkPhotos = {}

require.config
  paths:
    bluebird: 'vendor/bluebird'
    zepto: 'vendor/zepto'
    lodash: 'vendor/lodash'
    react: 'vendor/react'
    flux: 'vendor/flux'
    event: 'vendor/event'
    prism: 'vendor/prism'
  shim:
    zepto:
      exports: '$'
    prism:
      exports: 'Prism'

require [
  'zepto'
  'react'
  'setup'
  'elements/app'
], ($, React, Setup, App) ->

  $ ->
    do Setup
    React.render(<App />, $('#StahkPhotos').get(0))
