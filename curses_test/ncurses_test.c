// sudo apt-get install libncurses5-dev
#include <ncurses.h>

int main()
{
  initscr();// 端末制御の開始

  start_color();// カラーの設定
  init_pair(1, COLOR_YELLOW, COLOR_BLUE);// 色番号１を赤文字／青地とする
  bkgd(COLOR_PAIR(1));// 色１をデフォルト色とする

  erase();// 画面表示
  move(3, 4);
  addstr("Hello World");
  refresh();

  timeout(-1);
  getch();// キー入力

  endwin();// 端末制御の終了
  return (0);
}

