gpio = require 'rpi-gpio'

gpio.setup 4, gpio.DIR_OUT, ->
  gpio.write 4, true, (err) ->
    if err
      throw err
    else
      console.log 'Written to pin'
