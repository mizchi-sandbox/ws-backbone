express   = require 'express'
app = express.createServer()

# session options
RedisStore = require('connect-redis')(express)
session_store =  new RedisStore()
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session
  secret: 'dafdasfjdasofjdas;fjaf'
  store: session_store
  cookie:
    maxAge: 60*60*1000

# asset pipeline
app.use (require "connect-assets")()
app.use express.static(__dirname + '/public')

# templating
coffeekup = require 'coffeekup'
app.register '.coffee', coffeekup.adapters.express
app.set 'view engine', 'coffee'

app.get '/*', (req, res)->
  if req.session.times?
    req.session.times += 1
  else
    req.session.times = 1
  res.render 'index', layout:false

exports.app = app
exports.session_store = session_store
