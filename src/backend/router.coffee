###
Router
###

_            = require('lodash')
errorHandler = require('errorhandler')

Enviro    = require('./lib/enviro')
ENDPOINTS = require('./api/endpoints')

ENV_KEY = 'StahkPhotos-Env'

STATIC_ROUTES =
  '/': 'index'

_route = (file) ->
  (req, res, next) ->
    res.sendFile("#{__dirname}/public/#{file}.html")

module.exports = (app) ->

  ## Photo Endpoints
  for ENDPOINT in ENDPOINTS
    app.use "/#{ENDPOINT}", require("./api/#{ENDPOINT}API")

  ## List Endpoints
  app.use "/endpoints", (req, res, next) ->
    res.json
      endpoints: ENDPOINTS
      fetchedAt: +(new Date)
      status: 200

  ## Random Endpoint
  app.use '/random/:debug?', (req, res) ->
    { debug } = req.params
    res.redirect("/#{_.sample(ENDPOINTS)}/random/#{debug or ''}")

  ## Integrate test
  app.use '/integrate', (req, res) ->
    res.render('integrate')

  ## Static Routes
  for route, file of STATIC_ROUTES
    app.use route, _route(file)

  ## Catch 404
  app.get '*', (req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next(err)

  ## Error Handlers
  switch
    when Enviro.isLocal() or Enviro.isQA()
      app.use(errorHandler())
    when Enviro.isProd()
      app.use (err, req, res, next) ->
        res.status(err.status or 500)
        res.render 'error',
          message: err.message,
          error: {}
