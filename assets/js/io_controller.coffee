class @IOController
  constructor: ->
    @socket = io.connect '#{ host }'
    @socket.on 'connection', @connection
    @socket.on 'dungeons', @dungeons
    @socket.on 'status', @dungeons
    @interval = 1000/15

  connection: (chunk) ->
    myapp.view.status.on_status_change(chunk)

  dungeons: (chunk) ->
    myapp.view.status.on_status_change(chunk)

  status: (chunk) ->
    console.log "stautus",chunk
    myapp.view.status.on_status_change(chunk)
