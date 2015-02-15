define [
  'zepto'
  'react'
  'prism'
  'elements/image'
  'elements/json'
  'elements/footer'
], (
  $
  React
  Prism
  ImageElement
  JsonElement
  FooterElement
) ->

  URL =
    DEBUG: 'random/debug'
    FIELDS: 'endpoints'

  App = React.createClass

    getDefaultProps: ->
      title: 'Stahk Photos'

    getInitialState: ->
      image: ''
      source: ''
      sourceURL: ''
      debug: ''
      endpoints: ''

    componentWillMount: ->
      @requestImage()
      @requestFields()

    componentDidMount: ->
      Prism.highlightAll()

    componentDidUpdate: ->
      Prism.highlightAll()

    requestImage: ->
      $.getJSON URL.DEBUG, (debug) =>
        { image, source, sourceURL } = debug
        @setState { debug, image, source, sourceURL }

    requestFields: ->
      $.getJSON URL.FIELDS, (endpoints) =>
        @setState { endpoints }

    render: ->
      { title } = @props
      { image, source, sourceURL, debug, endpoints } = @state

      if image and source and sourceURL and debug and endpoints
        $('body').addClass('loaded')

      <div>
        <h1>{ title }</h1>
        {if image and source and sourceURL
          <ImageElement image={ image } source={ source } sourceURL= { sourceURL } />
        }
        {if debug
          <JsonElement id='debug' name='Image response' json={ debug } />
        }
        {if endpoints
          <JsonElement id='fields' name='Endpoints' json={ endpoints } />
        }
        <FooterElement />
      </div>
