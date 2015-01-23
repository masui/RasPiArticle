gpio = require 'pi-gpio'

gpio.open 16, "input", (err) ->
  console.log "open error = #{err}"
  gpio.read 16, 1, (err,val) ->
    console.log "read error = #{err}"
    console.log val


