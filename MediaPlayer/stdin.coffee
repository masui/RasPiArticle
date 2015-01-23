spawn   = require('child_process').spawn

child = null

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (chunk) ->
  if chunk.match /^1/
    child.stdin.write 'q' if child
    child.kill() if child
    child = spawn '/usr/bin/omxplayer', ['/home/pi/PlanetEarthA-1.mp4']
  if chunk.match /^2/
    child.stdin.write 'q' if child
    child.kill() if child
    child = spawn '/usr/bin/omxplayer', ['/home/pi/RockyHorrowPictureShow.mp4']
  if chunk.match /^q/
    child.stdin.write 'q' if child
    child.kill() if child

process.stdin.on 'end', ->
  console.log "end"

