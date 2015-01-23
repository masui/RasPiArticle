gpio = require 'rpi-gpio'

gpio.setup 7, gpio.DIR_IN, (err) ->
  if err
     console.log "setup error (#{err})"
  else
    setInterval ->
      gpio.read 7, (err, value) ->
        if err
          console.log err
        else
          console.log 'The value is ' + value
    , 100



