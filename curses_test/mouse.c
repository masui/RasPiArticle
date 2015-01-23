// sudo apt-get install libncurses5-dev
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <linux/input.h> // struct input_event とか
#include <ncurses.h>


void display(int y){
  erase();// 画面表示
  move(y, 5);
  addstr("Hello World");
  refresh();
}

int main()
{
  initscr();// 端末制御の開始

  start_color();// カラーの設定
  init_pair(1, COLOR_YELLOW, COLOR_BLUE);// 色番号１を赤文字／青地とする
  bkgd(COLOR_PAIR(1));// 色１をデフォルト色とする

  int mouse_fd = open("/dev/input/event0", O_RDONLY);
  if (mouse_fd < 0) {
    fprintf(stderr,"can't open mouse device\n");
    exit(0);
  }

  int y = 5;

  struct input_event mouse;
  display(y);
  for(;;){
    int bytes = read(mouse_fd, &mouse, sizeof(struct input_event));
    if(bytes >= 0){
      if(mouse.type == EV_REL){
	if(mouse.code == REL_WHEEL){
	  y += mouse.value;
	  display(y);
	}
      }
    }
  }
}

