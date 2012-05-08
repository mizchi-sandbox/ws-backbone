(->
  class @DungeonListView extends @View
    events:
      'click a.to_dungeon': 'to_dungeon'

    constructor: ->
      @$el = $("div#content")
      $.getJSON "/dungeons.json", (data) =>
        @data = data
        @render()

    to_dungeon: (ev) ->
      ev.preventDefault()
      $el = $(ev.currentTarget)
      console.log $el.attr('href')
      window.router.navigate $el.attr('href'), true

    template: ->
      ul ->
        for k, v of @data
          li -> a class:'to_dungeon', href:"dungeon/#{h k}/1", -> h k

  class @DungeonView extends @View
    events:{}

    constructor: (@location,@depth)->
      @$el = $("div#content")
      @render()

    template: ->
      h2 "Dungeon:#{@location}:#{@depth}"

).call myapp.view