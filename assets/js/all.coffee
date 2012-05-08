#= require vendor/jquery
#= require vendor/jquery.metro
#= require vendor/bootstrap
#= require vendor/underscore-min
#= require vendor/backbone-min
#= require vendor/coffeekup
#= require namespace
#= require util
#= require view/view
#= require view/layout
#= require view/menu
#= require view/status
#= require view/dungeon
#= require view/index
#= require io_controller

class AppRouter extends Backbone.Router
  routes:
    '': 'index'
    'menu': 'menu'
    'login': 'login'
    'dungeons': 'dungeons'
    'dungeon/:location/:depth': 'dungeon'

  initialize: ->
    myapp.view.layout = new myapp.view.LayoutView

  index:    -> new myapp.view.IndexView
  menu:     -> new myapp.view.MenuView
  dungeons: -> new myapp.view.DungeonListView
  dungeon: (location,depth)->
    new myapp.view.DungeonView location,depth

ioc = new IOController
myapp.socket = ioc.socket

$ ->
  # ioc.socket.emit "ready"

  window.router = new AppRouter
  Backbone.history.start
    pushState: true
    root: "/"
