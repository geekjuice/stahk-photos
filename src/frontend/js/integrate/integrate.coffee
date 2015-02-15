###
Integrate
###

$ ->
  test = new TestBuilder
  test.visit '/'

  test.assert 'h1', 'Stahk Photos'
  test.assert '#image p', 'Image provided by'
  test.assert ($page) ->
    /Image response/.test $page.find('#debug h2').text()
  test.assert ($page) ->
    /Endpoint/.test $page.find('#fields h2').text()
  test.assert 'footer', 'by Nicholas Hwang'

# Start
  do test.run
