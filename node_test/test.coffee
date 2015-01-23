gpio = require 'rpi-gpio'

gpio.setup 3, gpio.DIR_IN, (err) ->
  console.log "setup error (#{err})"
  unless err
    gpio.read 3, (err, value) ->
      console.log 'The value is ' + value
      console.log err
