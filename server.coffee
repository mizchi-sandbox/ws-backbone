require 'sugar'
Object.extend()

{app, session_store} = require './lib/web/app'
io   = (require './lib/web/io' )(app, session_store)
game = (require './lib/game')(app, io)

app.listen port = process.argv[2] or 3000, ->
  console.log "Express Server; start on port " + port

