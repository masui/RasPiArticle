var gpio = require('rpi-gpio');

gpio.setup(2, gpio.DIR_IN, function(){});

gpio.read(2, function(err, value) {
    console.log('The value is ' + value);
});

