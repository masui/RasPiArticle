express = require 'express'
exec = require('child_process').exec

app = express()

app.get '/', (req, res) ->
  res.send 'Hello World'

child = null

app.get '/run', (req, res) ->
  child = exec '/usr/bin/omxplayer /home/pi/PlanetEarthA-1.mp4', (err, stdout, stderr) ->
    if !err
      console.log 'stdout: ' + stdout
      console.log 'stderr: ' + stderr
    else
      console.log err
      console.log err.code
      console.log(err.signal);

app.get '/stop', (req, res) ->
  child kill ## Doesn't work

app.listen 3000
