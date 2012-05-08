(->
  class @IndexView extends @View
    events:
      "click .btn":"hey"

    template: ->
      p "This is the dungeon crawling"

    initialize: ->
      @$el = $("div#content")
      @render()

    hey : ->
      window.router.navigate "dungeon/a/1",true

).call myapp.view