#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdbool.h>

#include <linux/input.h> // struct input_event


char mouseDev[] = "/dev/input/event#";
int numMouseIndex = 0;
int mouse_fd;

//------------------------------------------------------------------------------
bool read_mouse_event(struct input_event *mousee)
{
  int bytes;
  if(mouse_fd > 0){
    bytes = read(mouse_fd, mousee, sizeof(struct input_event));
    if (bytes == -1){
      printf("----\n");
      return false;
    }
    if (bytes == sizeof(struct input_event)){
      //printf("bytes = %d\n",bytes);
      //printf("type = %d\n",.type);
      return true;
    }
  }
  return false;
}

main()
{
  // open_mouse()
  mouseDev[sizeof(mouseDev)-2] = '0' + (char) numMouseIndex;
  //mouse_fd = open(mouseDev, O_RDONLY | O_NONBLOCK);
  mouse_fd = open(mouseDev, O_RDONLY);
  if (mouse_fd < 0) {
    fprintf(stderr,"can't open mouse\n");
    exit(0);
  }
  printf("%d\n",mouse_fd);

  struct input_event mousee;
  while(1){
    if(read_mouse_event(&mousee)){
      printf("%d %d %d\n",mousee.type, mousee.code, mousee.value);
    }
  }
}

