#!/usr/bin/env coffee
sio = require 'socket.io'
parseCookie = require('connect').utils.parseCookie

module.exports = (app,session_store) ->
  io = sio.listen app
  io.configure ->
    io.set 'log level', 1
    io.set 'authorization', (handshake, callback) ->
      cookie = parseCookie handshake.headers.cookie
      handshake.sid = cookie['connect.sid']
      session_store.get handshake.sid, (e, data) ->
        handshake.session = data
        callback null, true
  io