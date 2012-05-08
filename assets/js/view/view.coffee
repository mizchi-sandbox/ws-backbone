(->
  class @View extends Backbone.View
    template: ->
    render: (args = {})->
      (@$el).html ck.render @template, @
      @delegateEvents()
).call myapp.view
