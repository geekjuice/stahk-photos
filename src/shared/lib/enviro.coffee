###
Enviro
###

Enviro = (_) ->

  ->
    KEYS =
      qa: ['qa']
      prod: ['production']
      local: ['development', 'local']

    Env =
      get: _.memoize (key) ->
        (
          process?.env?.NODE_ENV ?
          window?[key] ?
          window?.localStorage?[key] ?
          @getCookie(key) ?
          KEYS.prod
        ).toLowerCase?()

      isProd: _.memoize (key) ->
        @get(key) in KEYS.prod

      isQA: _.memoize (key) ->
        @get(key) in KEYS.qa

      isDeployed: _.memoize (key) ->
        @get(key) in [KEYS.qa, KEYS.prod]

      isLocal: _.memoize (key) ->
        @get(key) in KEYS.local

      isDev: _.memoize (key) ->
        @get(key) in KEYS.local

      getCookie: _.memoize (key) ->
        cookies = document?.cookie?.split(/\s*;\s*/g)
        return null unless cookies?.length
        for cookie in cookies
          [_key, _value] = cookie.split('=')
          return _value if _key is key
        return null


if typeof module is "object"
  module.exports = do Enviro(require('lodash'))
else
  define 'lib/enviro', ['lodash'], (_) -> do Enviro(_)

