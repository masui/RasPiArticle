express = require 'express'
exec    = require('child_process').exec
path    = require 'path'

app = express()
app.use express.static path.resolve 'public'  # public以下

reset = (callback) ->
  exec "killall omxplayer omxplayer.bin", (error, stdout, stderr)->
    console.log 'stdout: ' + stdout
    console.log 'stderr: ' + stderr
    if error != null
      console.log 'exec error: ' + error
    callback()

app.get '/', (req, res) ->
  res.send 'Hello World'

app.get '/youtube/:id', (req, res) ->
  reset ->
    source = "https://www.youtube.com/watch?v=#{req.params.id}"
    exec "/usr/bin/youtube-dl -g #{source}", (error, stdout, stderr)->
      source = stdout.replace /\n/,''
      exec "omxplayer '#{source}'", (error, stdout, stderr)->
      # exec "omxplayer --win '0 0 800 500' '#{source}'", (error, stdout, stderr)->

app.get '/run1', (req, res) ->
  reset ->
    exec "/usr/bin/omxplayer /home/pi/PlanetEarthA-1.mp4"

app.get '/run2', (req, res) ->
  reset ->
    exec "/usr/bin/omxplayer /home/pi/RockyHorrowPictureShow.mp4"

app.get '/run3', (req, res) ->
  reset ->
    exec "/usr/bin/omxplayer /home/pi/Family.mp3"

app.get '/stop', (req, res) ->
  reset ->
    res.send 'STOPPED'

app.listen 80, ->
  console.log "Express server listening on port 80."

# http://raspi.local/youtube/123456 とかで再生できる
