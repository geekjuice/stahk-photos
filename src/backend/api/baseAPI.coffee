###
Base API
###

_       = require('lodash')
url     = require('url')
http    = require('http')
request = require('request')
cheerio = require('cheerio')
sizeOf  = require('image-size')


###
Random Integer
###
_rand = (limit=1000) ->
  Math.floor(Math.random() * limit)


###
Make Image URL
###
_imageURL = (href) ->
  "#{URL}/#{href}"


###
Get Image Size
###
_getImageSize = (src, res, callback) ->
  src = src.replace(/^https/, 'http')
  options = url.parse(src)
  http
    .get options, (resp) ->
      chunks = []
      resp
        .on 'data', (chunk) -> chunks.push(chunk)
        .on 'end', ->
          buffer = Buffer.concat chunks
          callback(sizeOf(buffer))
    .on 'error', (e) -> _error(res)


###
Return Error
###
_error = (res, msg="He's dead, Jim...") ->
  res.json
    status: 400
    responseText: msg


###
Export Router
###
module.exports = ({ SELECTOR, SOURCE, URL, QUERY }) ->

  ###
  Require Router
  ###
  router  = require('express').Router()

  ###
  API Route
  ###
  router.get "/", (req, res, next) ->
    request URL, (err, resp, body) ->
      console.log err if err

      # Load DOM and relevant table rows
      $ = cheerio.load(body)
      $imgs = $(SELECTOR)
      length = $imgs.length

      # Get image urls
      images = []
      for i in [0...length]
        images.push QUERY($imgs.eq(i))

      # Add additional API information
      json = _.extend { images },
        source: SOURCE
        sourceUrl: URL
        fetchedAt: +(new Date)
        status: 200

      # Send JSON
      res.json json

  router.param "debug", (req, res, next, name) ->
    req.params.debug = /^debug$/i.test(name)
    do next

  router.get "/:num/:debug?", (req, res, next) ->
    { num, debug } = req.params

    # Check if random
    num = if num is 'random' then _rand() else num

    # Error check
    switch
      when num < 0
        return _error(res, 'A negative page? Seriously? Come on!')
      when not /^\d+$/.test num
        return _error(res, "#{num} is not a number...")

    request URL, (err, resp, body) ->
      console.log err if err

      # Load DOM and extract image src
      $ = cheerio.load(body)
      $imgs = $(SELECTOR)
      length = $imgs.length
      img = QUERY($imgs.eq(num % length))

      # Return debug response
      if img and debug
        _getImageSize img, res, ({ width, height }) ->
          res.json
            source: SOURCE
            sourceURL: URL
            image: img
            width: width
            height: height
            fetchedAt: +(new Date)
            status: 200

      # Return image
      else
        # http.get img, (proxy) -> proxy.pipe(res)
        res.redirect(img)

  return router
