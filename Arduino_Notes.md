# Arduino Notes


## Serial I/O

### stty settings

First, test that the code works with the built-in Arduino Serial Monitor. While that's running, you can use `stty` to snoop on the tty settings. Replace `/dev/cu.usbmodem1451` with the path to the Arduino device.

```bash
sudo stty -g -f /dev/cu.usbmodem1451 >> stty_settings.sh
```

Those settings can now be replayed as part of code that accesses the serial port.


### Using echo and scripts

```bash
echo "cmd" > /dev/cu.usbmodem1451
```

Echo typically closes the device after issuing the command, and before waiting for a response. This causes the Arduino to reset. 

One way to get around this is mentioned in this video on [Arduino Serial PHP Fix](https://www.youtube.com/watch?v=S-BQWP69wtw). The solution described there (and other places) is to put a 100 Ohm resistor between the reset pin and the +5V pin on the Arduino. This solution didn't work for me.

Another approach that worked in my case was to use a 100 uF capacitor between the reset and ground pins. This is described at the bottom of this forum post on [using Bash to send commands to Arduino](https://forum.arduino.cc/index.php?topic=61127.0).


