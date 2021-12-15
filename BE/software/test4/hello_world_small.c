#include "sys/alt_stdio.h"
#include "unistd.h"
#include "system.h"

#define freq (unsigned int *)  TEST_PWM_0_BASE
#define duty (unsigned int *) ( TEST_PWM_0_BASE  + 4)
#define control (unsigned int *) ( TEST_PWM_0_BASE  + 8)
 int main()
 {
  *freq = 0x0400;  // divise clk par 1024
  *duty = 0x0200;
  *control=0x0003;


  return 0;

}
