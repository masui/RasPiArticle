outbuf = "x" * 20;
io = File.open("/dev/input/event0")
p io.read(10,outbuf)
p outbuf
