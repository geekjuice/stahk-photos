define [
  'zepto'
  'react'
], ($, React) ->

  GITHUB_URL = "https://github.com/geekjuice"

  FooterElement = React.createClass

    render: ->
      <footer>
        made with &hearts; by <a href={ GITHUB_URL } target="_blank">Nicholas Hwang</a>
      </footer>


