File.open("/dev/input/event0","rb"){ |f|
  while true do
    s = f.read 16
    (time, type, code, value) = s.unpack "qssi"
    if type == 2 and code == 8 then
      puts value
    end
  end
}

