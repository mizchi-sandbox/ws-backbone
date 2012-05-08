Log   = require 'log'
log   = new Log Log.info

redis = require 'redis'
rcli  = redis.createClient()

class Dungeon
class Home extends Dungeon
class Plane extends Dungeon
class Valley extends Dungeon

dungeons =
  "home" : new Home
  "plane" : new Plane
  "valley": new Valley

save = (key, obj, cb = ->) ->
  console.log "on save"
  rcli.hmset key, obj, cb

load = (key, cb) ->
  console.log "on load"
  rcli.hgetall key, cb

JSONLoader = require './lib/util/json_loader'

class Player extends JSONLoader
  _init_:
    HP: 100
    gold: 0

  _ignore_:
    socket: true

  constructor: (obj, @socket)->
    super obj
    @hp = @HP
    @location = ""

  emit: (name, data) -> @socket.emit name, data

class BloadCaster
  constructor: (io) ->
    @sockets = io.sockets.sockets
    @active_players = {}

    @attr_events = [
      'disconnect'
    ]

    io.sockets.on 'connection', (socket) => @connection(socket)

    (mainloop = =>
      setTimeout =>
        for __, p of @active_players
          p.gold += 1
          p.emit 'status', p.to_json()
        mainloop()
      , 1000)()

  connection: (socket) ->
    console.log "sid", socket.handshake.sid
    player = @active_players[socket.id] = new Player {},socket

    load socket.handshake.sid, (e,data) ->
      throw e if e
      if data
        player = new Player data, socket
      else
        player = new Player {}, socket
        save socket.handshake.sid, player.to_json(), console.log
      console.log player.to_json()

    socket.emit 'connection', player.to_json()
    log.info "join #{socket.id}", @active_players.keys()
    @bind socket, @attr_events

  bind: (socket, event_names) ->
    for e in event_names
      socket.on e, (data)=> @[e](socket, data)

  disconnect: (socket, data) ->
    console.log "on disconnet"
    log.info "leave #{socket.id}", @active_players.keys()
    p = @active_players[socket.id]
    data = p.to_json()
    save socket.handshake.sid, data , (data) ->
      console.log "save done",data
      delete @active_players[socket.id]

  update: (socket, data) ->
    socket.emit "dungeons", {depth:1}

module.exports = BloadCaster