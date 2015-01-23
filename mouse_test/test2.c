#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <linux/input.h> // struct input_event とか

main()
{
  int mouse_fd = open("/dev/input/event0", O_RDONLY);
  if (mouse_fd < 0) {
    fprintf(stderr,"can't open mouse device\n");
    exit(0);
  }

  struct input_event mouse;
  for(;;){
    //int bytes = read(mouse_fd, &mouse, sizeof(struct input_event));
    unsigned char mouse[100];
    int bytes = read(mouse_fd, &mouse, sizeof(struct input_event));
    int i;
    for(i=0;i<bytes;i++){
      printf("%02x ",mouse[i]);
    }
    printf("\n");
    /*
    if(bytes >= 0){
      if(mouse.type == EV_REL){
	if(mouse.code == REL_WHEEL){
	  // printf("%d\n",mouse.value);
	}
      }
    }
    */
  }
}
