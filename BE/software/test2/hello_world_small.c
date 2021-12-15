
#include "sys/alt_stdio.h"
#include "unistd.h"
#include "system.h"

#define freq (unsigned int *) AVALON_PWM_0_BASE
#define duty (unsigned int *) (AVALON_PWM_0_BASE + 4)
 int main()
 {
  *freq = 0x0400;  // divise clk par 1024
  *duty = 0x0200;



  return 0;

}
