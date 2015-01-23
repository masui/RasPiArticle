gpio = require 'rpi-gpio'

if false
  gpio.setup 3, gpio.DIR_IN, (err) ->
    if err
       console.log "setup error (#{err})"
    else
      setInterval ->
        gpio.read 3, (err, value) ->
          if err
            console.log err
          else
            console.log 'The value is ' + value
      , 1000

if false
  gpio.setup 3, gpio.DIR_IN, (err) ->
    if err
      console.log "setup error (#{err})"
    else
      gpio.on 'change', (channel, value) ->
        console.log 'Channel ' + channel + ' value is now ' + value

# gpio.setPollFrequency 200

gpio.on 'change', (channel, value) ->
  console.log 'Channel ' + channel + ' value is now ' + value

gpio.setup 7, gpio.DIR_IN, (err) ->
  if err
    console.log "ERROR: #{err}"


