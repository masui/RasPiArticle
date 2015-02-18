# -*- coding: utf-8 -*-
require "curses"
include Curses

init_screen
start_color # これがないと色が出ないorz ... アホな仕様か

init_pair 1, COLOR_YELLOW, COLOR_BLUE
init_pair 2, COLOR_BLACK, COLOR_WHITE

stdscr.bkgd color_pair(1)
stdscr.attrset color_pair(1)
refresh
clear

getch
exit

begin
  #win = stdscr.subwin(5,30,2,2)
  # win.box(?|,?-,?*)
  # bkgd color_pair(1)

  stdscr.setpos 10, 10
  attrset(color_pair(1)) # Curses.attrset メソッドに Curses.color_pair(id) を渡す
  stdscr.addstr "サブウィンドウです!!!"

  attrset(color_pair(2)) # Curses.attrset メソッドに Curses.color_pair(id) を渡す
  stdscr.setpos 12, 10
  stdscr.addstr "abcdefg"

  # stdscr.refresh

  getch
ensure
  close_screen
end
