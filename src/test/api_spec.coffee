{ expect } = require('chai')
superagent = require('superagent')

PORT = process.env.PORT or 7000

PATHNAME = if process.env.LIVE is 'true'
then "api.stahk.photos"
else "localhost:#{PORT}"


###
Endpoints
###
endpoints = require('../backend/api/endpoints')


###
Helper Utils
###
sourceToEndpoint = (source) ->
  source.replace(/\s+/g, '').toLowerCase()


###
Tests
###
describe "[Endpoints]", ->
  it 'should return endpoints', (done) ->
    @timeout(0)
    superagent.get("http://#{PATHNAME}/endpoints")
      .end (e, res) ->
        expect(e).to.eql(null)
        expect(typeof res.body).to.eql('object')
        expect(res.body.endpoints).to.have.members(endpoints)
        expect(res.body.status).to.eql(200)
        done()

for endpoint in endpoints
  do (endpoint) ->
    describe "[#{endpoint}] API", ->

      it 'should return OK on valid request', (done) ->
        @timeout(0)
        superagent.get("http://#{PATHNAME}/#{endpoint}")
          .end (e, res) ->
            expect(e).to.eql(null)
            expect(typeof res.body).to.eql('object')
            expect(res.body.fetchedAt).to.be.above(0)
            expect(res.body.status).to.eql(200)
            done()

      it 'should return valid debug response', (done) ->
        @timeout(0)
        superagent.get("http://#{PATHNAME}/#{endpoint}/random/debug")
          .end (e, res) ->
            expect(e).to.eql(null)
            expect(typeof res.body).to.eql('object')
            expect(res.body).to.include.keys(['source', 'sourceURL', 'image', 'height', 'width'])
            expect(sourceToEndpoint(res.body.source)).to.match(new RegExp(endpoint, 'ig'))
            expect(res.body.status).to.eql(200)
            done()

      it 'should return error when page is not a number', (done) ->
        @timeout(0)
        superagent.get("http://#{PATHNAME}/#{endpoint}/abc")
          .end (e, res) ->
            expect(e).to.eql(null)
            expect(typeof res.body).to.eql('object')
            expect(res.body.status).to.eql(400)
            done()

      it 'should return error when page is negative', (done) ->
        @timeout(0)
        superagent.get("http://#{PATHNAME}/#{endpoint}/-1")
          .end (e, res) ->
            expect(e).to.eql(null)
            expect(typeof res.body).to.eql('object')
            expect(res.body.status).to.eql(400)
            done()

