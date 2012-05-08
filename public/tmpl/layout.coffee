html ->
  head ->
    title 'Hello, World!'
    meta charset: 'utf-8'

    script src:"/socket.io/socket.io.js"
    js 'all'

  body class:"whitebg blue", ->
    h1 "Adventure"

    div class: 'tiles', ->
      div class:'tilerows' ,->
        div class: 'tile one bluebg', ->

    div class:'metro-pivot', ->
      div class:'pivot-item', ->
        h3 'page1'
        p 'content 1'
      div class:'pivot-item', ->
        h3 'page2'
        p 'content 2'

    @body
