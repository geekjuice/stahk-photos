define [
  'zepto'
  'lib/enviro'
], ($, Enviro) ->

  ENV_KEY = 'StahkPhotos-Env'

  EnvElement = (env) ->
    """<div id="StahkPhotos-Env">#{env}</div>"""

  Setup = ->
    switch
      when Enviro.isQA(ENV_KEY)
        $('body').append EnvElement('QA')
      when Enviro.isLocal(ENV_KEY)
        $('body').append EnvElement('Local')

