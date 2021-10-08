/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "system.h"
#include "unistd.h"

#define leds (char *) LEDS_BASE
#define boutons (char *) BOUTONS_BASE

int main()
{
	unsigned int switch1;
  printf("Hello from Nios II!\n");

  while(1){
	  switch1 = *boutons;
	  switch(switch1)
	   {
	   case 0: *leds=1;break;
	   case 1: *leds=1<<1;break;
	   case 2: *leds=1<<2;break;
	   case 3: *leds=1<<3;break;
	   default:*leds=0;
	   }
  }
  return 0;
}
