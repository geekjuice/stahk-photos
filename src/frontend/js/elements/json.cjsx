define [
  'zepto'
  'react'
], ($, React, Prism) ->

  JsonElement = React.createClass

    getDefaultProps: ->
      id: ''
      name: ''
      json: ''

    jsonify: (json) ->
      str = JSON.stringify(json, null, 4)
      str.replace(/\"([^(\")"]+)\":/g, "$1:")

    render: ->
      { id, name, json } = @props

      unless _.isEmpty(json)
        json = @jsonify(json)

      <div id={ id }>
        <h2>[ <span>{ name }</span> ]</h2>
        <pre className='language-javascript preview'>
          <code className='language-javascript'>
            { json }
          </code>
        </pre>
      </div>
