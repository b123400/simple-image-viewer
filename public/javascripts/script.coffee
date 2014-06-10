do ->
  size = localStorage['thumb-size']
  return if not size
  size = Number size
  return if Number.isNaN size

  css = """
  div.list-thumb{
    width: #{size}px;
    height: #{size}px;
  }
  """
  head = document.head || document.getElementsByTagName('head')?[0]
  style = document.createElement('style')

  style.type = 'text/css'
  if style.styleSheet
    style.styleSheet.cssText = css
  else
    style.appendChild(document.createTextNode(css))

  head.appendChild(style);
window.addEventListener 'load', ->
  buttons = document.querySelectorAll('.size-control button')
  buttons = [].slice.apply buttons
  buttons.forEach (button)->
    button.addEventListener 'click', ->
      localStorage['thumb-size'] = Number(button.innerHTML)
      [].slice.apply(document.querySelectorAll('.list-thumb')).forEach (e)->
        e.style.width = localStorage['thumb-size']+'px'
        e.style.height = localStorage['thumb-size']+'px'