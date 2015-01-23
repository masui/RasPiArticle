#
# Raspberry Piでビデオ/音楽を再生するためのExpressサーバ
#
express = require 'express'
exec    = require('child_process').exec
path    = require 'path'

app = express()
app.use express.static path.resolve 'public'  # public以下をスタティックなファイルとして扱う

reset = (callback) ->
  exec "killall omxplayer omxplayer.bin", (error, stdout, stderr)->
    console.log 'stdout: ' + stdout
    console.log 'stderr: ' + stderr
    if error != null
      console.log 'exec error: ' + error
    callback()

app.get '/', (req, res) ->
  res.redirect "/player.html"
  # res.send 'Hello World'

#
# IDを指定してYouTube再生
#
app.get '/youtube/:id', (req, res) ->
  reset ->
    source = "https://www.youtube.com/watch?v=#{req.params.id}"
    exec "/usr/bin/youtube-dl -g #{source}", (error, stdout, stderr)->
      source = stdout.replace /\n/,''
      exec "omxplayer '#{source}'", (error, stdout, stderr)->
      # exec "omxplayer --win '0 0 800 500' '#{source}'", (error, stdout, stderr)->

#
# 再生ファイルを絶対パス指定
#
app.get /play\/(.*)$/, (req, res) ->
  path = "/#{req.params[0]}"
  reset ->
    exec "/usr/bin/omxplayer #{path}"

#
# 再生停止
#
app.get '/stop', (req, res) ->
  reset ->
    res.send 'STOPPED'

app.listen 80, ->
  console.log "Express server listening on port 80."
