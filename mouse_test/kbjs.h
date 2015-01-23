bool kbHit(void);
bool jsESC(void);
bool rbPressed(void);
int readKb(void);
void dumpKb(void);
void dumpJs(void);
void initKb(void);
void restoreKb(void);
int handleESC(void);
int readKb_mouse(void);
void do_joystick_test(void);
int open_mouse();
void close_mouse();
int open_joystick();
void free_mouse_BGImage(void);
void close_joystick();
extern int jsXAxis;
extern int jsYAxis;
extern int jsThreshold;
extern int jsSelect;
extern int jsBack;
extern int jsInfo;
extern int jsMenu;
extern tPointXY mouseXY;
extern tPointXY clickXY;
extern tPointXY pointerOffsetXY;
extern bool mouseEnabled;
extern int numMouseIndex;
extern int numJoystickIndex;
extern int numPointerIndex;
extern int numPointerSize;
extern int numTimer;
extern char mouseDev[];
extern char jsDev[];
extern bool bQScreen;
void x_window_loop(int * key, bool checkMouse);
bool create_x_window();
bool destroy_x_window();