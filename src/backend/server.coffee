
###
Backend
###

Enviro  = require('./lib/enviro')

## Env
{ NODE_ENV, PORT } = process.env

NAME = 'StahkPhotos'
ENV_KEY = "#{NAME}-Env"

## New Relic
require('newrelic') if Enviro.isDeployed()

## Requires
express     = require('express')
bodyParser  = require('body-parser')
logger      = require('morgan')
debug       = require('debug')(NAME)

## Start Express
app = express()

## Setup Middleware
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded(extended: true))
app.use (req, res, next) ->
  res.cookie(ENV_KEY, NODE_ENV)
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'GET,POST')
  res.header("Access-Control-Allow-Headers", 'Origin, X-Requested-With, Content-Type')
  next()

## Static
app.use(express.static("#{__dirname}/public"))

## Routes
require('./router')(app)

## Start Server
app.set('port', PORT or 7000)
server = app.listen app.get('port'), ->
  debug('Server listening on port ' + server.address().port)

## Export App
module.exports = app
