# -*- coding: utf-8 -*-
require "curses"
include Curses

init_screen
begin
  win = stdscr.subwin(5,30,2,2)
  win.box(?|,?-,?*)
  win.setpos(2,2)
  win.addstr("サブウィンドウです")
  win.refresh
  getch
ensure
  close_screen
end
