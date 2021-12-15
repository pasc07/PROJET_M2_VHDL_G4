/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

/*
 * "Small Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It requires a STDOUT  device in your system's hardware.
 *
 * The purpose of this example is to demonstrate the smallest possible Hello
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete
 * description.
 *
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 *
 *    - Set the Optimization Level to -Os
 *
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 *
 *    - Set the Optimization Level to -Os
 *
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION
 *      This removes software exception handling, which means that you cannot
 *      run code compiled for Nios II cpu with a hardware multiplier on a core
 *      without a the multiply unit. Check the Nios II Software Developers
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks
 *      support for buffering, file IO, floating point and getch(), etc.
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "alt_types.h"
#include "system.h"
#include "unistd.h"
#include "stdio.h"
#include "time.h"
#include "io.h"

#include "altera_avalon_pio_regs.h"


// Pour le verin
#define control (char *) LEDS_BASE
//#define code_fonction (char *) SWITCHS_BASE
//#define compas (int *)COMPAS_BASE
#define butee_d (int *)(AVALON_VERIN_0_BASE+12)
#define butee_g (int *)(AVALON_VERIN_0_BASE+8)
#define freq (int *)AVALON_VERIN_0_BASE
#define duty (int *)(AVALON_VERIN_0_BASE+4)
#define config (int *)(AVALON_VERIN_0_BASE+16)
#define angle_barre (int *)(AVALON_VERIN_0_BASE+20)
// Fin verin

// getter
unsigned int getCode(){
	unsigned int code = 233;
	unsigned int  masque = 0xF;
	code = IORD_32DIRECT(AVALON_BOUTON_0_BASE+4, 0);
	code = masque & code ;
	return code;
}

// setter

void setRaz(unsigned int data){
	IOWR_32DIRECT(TEST_ANEMO_0_BASE, 0, data);
}

int main()
{ 
  alt_putstr("Hello from Nios II!\n");

  /* Event loop never exits. */

  unsigned int code = 25;
  unsigned int raz_n = 0x1;

  unsigned int a,c,d;
  unsigned char b;
  /* Event loop never exits. */

  *control=(*control) | 3;//active circuits gestion_bp et gestion_compas
   *butee_d=1320;
   *butee_g=410;
   *freq= 2000;
   *duty=1500;
   *config=1; // circuit gestion_verin actif, sortie pwm inactiv

  setRaz(raz_n); // continue = 00010;
  usleep(5000);
  setRaz(0x0);

  while (1) {
	  code = getCode();
	  b = code;
 	  //if (code > 0 && code != 3)
 		//  printf("Code  = %u \n", code	);

 	 //test bp en mode manuel seul
 	 // b=*code_fonction;
 	  printf("code_fonction= %d\n", b);

 	  switch(b)
 	  {
 	  case 0: *config=1;break;
 	  case 1: *config=7;break;
 	  case 2: *config=3;break;
 	  default:*config=1;
 	  }
 	  //a=((*compas)-10)&511;
 	  //printf("compas= %d\n", a);

 	  c=*freq;
 	  printf("freq= %d\n", c);
 	  d=*duty;
 	  printf("duty= %d\n", d);
 	  c=*butee_d;
 	  printf("butee_d= %d\n", c);
 	  d=*butee_g;
 	  printf("butee_g= %d\n", d);
 	  c=*config;
 	  printf("config= %d\n", c);
 	  d=*angle_barre;
 	  printf("angle_barre= %d\n", d);
 	  usleep(100000);
  }

  return 0;
}
