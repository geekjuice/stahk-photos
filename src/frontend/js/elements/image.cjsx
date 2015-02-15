define [
  'zepto'
  'react'
], ($, React) ->

  GITHUB_PROJECT = 'https://github.com/geekjuice/StahkPhotos'

  ImageElement = React.createClass

    getDefaultProps: ->
      image: ''
      source: ''
      sourceURL: ''

    render: ->
      { image, source, sourceURL } = @props

      <div id='image'>
        <p>
          Image provided by <a href={ sourceURL } target='_blank'>{ source }</a> via <a href={ GITHUB_PROJECT } target='_blank'>API</a>
          <img src={ image } />
        </p>
      </div>
