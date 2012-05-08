(->
  class @StatusView extends @View

    constructor:->
      @$el = $("div#status")

    template: ->
      p h "HP: #{@data.hp}/#{@data.HP}"
      p h "gold: #{@data.gold}"

    on_status_change: (@data) ->
      @render()

).call myapp.view