(->
  class @LayoutView extends @View
    events:
      "click .to_index": "to_index"
      "click button#to_menu": "to_menu"
      "click button#to_dungeons": "to_dungeons"

    constructor:->
      @$el = $("body")
      @render()
      myapp.view.status = new myapp.view.StatusView

    template: ->
      h1 class:'to_index', -> "Dungeon Walker"

      header ->
        button class:"to_index", "home"
        button id:"to_menu", "menu"
        button id:"to_dungeons", "dungeons"

      div id: "status", ->

      div id: "content", ->
        img src:'/ajax-loader.gif'

    to_index:(ev) ->
      # $(e.currentTarget).text()
      window.router.navigate '', true

    to_menu: (ev) ->
      window.router.navigate 'menu', true

    to_dungeons: (ev) ->
      window.router.navigate 'dungeons', true


).call myapp.view