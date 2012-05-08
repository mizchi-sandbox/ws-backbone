(->
  class @MenuView extends @View
    template: ->
      h2 "Menu"

    initialize: ->
      @$el = $("div#content")
      @render()

).call myapp.view
