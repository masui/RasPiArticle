express = require 'express'
#spawn   = require('child_process').spawn
exec    = require('child_process').exec
path    = require 'path'

app = express()
app.use express.static path.resolve 'public'  # public以下

child = null

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
      exec "omxplayer --win '0 0 800 500' '#{source}'", (error, stdout, stderr)->

app.get '/run1', (req, res) ->
  # child.stdin.write 'q' if child 
  reset ->
    child = exec "/usr/bin/omxplayer /home/pi/PlanetEarthA-1.mp4"
    # child = spawn '/usr/bin/omxplayer', ['/home/pi/PlanetEarthA-1.mp4']

app.get '/run2', (req, res) ->
  # child.stdin.write 'q' if child
  reset ->
    child = exec "/usr/bin/omxplayer /home/pi/RockyHorrowPictureShow.mp4"

app.get '/run3', (req, res) ->
  # child.stdin.write 'q' if typeof(child) != 'undefined'
  # child.stdin.write 'q' if child
  reset ->
    child = exec "/usr/bin/omxplayer /home/pi/Family.mp3"

app.get '/stop', (req, res) ->
  #if child
  #  console.log child.stdin
  # child.stdin.write 'q'
  reset ->
    res.send 'STOPPED'

app.listen 80, ->
  console.log "Express server listening on port 80."

# http://raspi.local/youtube/123456 とかで再生できる
