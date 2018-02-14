/* *************************************************
 * Programming in FreeRTOS Zybo Zynq-7000:
 *  SoC: ARM Cortex-A9 and FPGA fabric
 * Developpment kit: Xilinx SDK
 * Bitstream for FPGA generated in Xilinx Vivado 
 * *************************************************
 * zybo.c:
 *  input: 4 dip switches (dp0 - dp3)
 *  output: 4 leds (led0 -led3)
 *  
 *  led blinking depending by the value of the dip switch
 *  
 *  led<i> | freq(dp<i> down) | freq(dp<i> up)
 *  -------|------------------|---------------
 *  led0   | 500ms            | 1000ms
 *  led1   | 1000ms           | 2000ms
 *  led2   | 1500ms           | 3000ms
 *  led3   | 3000ms           | 4000ms
 * 
 * */

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"

#include <stdio.h>
#include <sys/types.h>

#include <xgpio.h>
#include "xparameters.h"
#include "sleep.h"

static void ledTaskFun( void *pvParameters );
static void ledfunc(int ledid, int up_delay, int down_delay);

static TaskHandle_t ledTask1, ledTask2, ledTask3, ledTask4;

TickType_t xLastWakeTime;

XGpio input, output;

int mask_ledno = 0;

int main()
{
   XGpio_Initialize(&input, XPAR_AXI_GPIO_0_DEVICE_ID);		//initialize input XGpio variable
   XGpio_Initialize(&output, XPAR_AXI_GPIO_1_DEVICE_ID);	//initialize output XGpio variable

   XGpio_SetDataDirection(&input, 1, 0xF);			//set first channel tristate buffer to input
   XGpio_SetDataDirection(&input, 2, 0xF);			//set second channel tristate buffer to input

   XGpio_SetDataDirection(&output, 1, 0x0);			//set first channel tristate buffer to output


   xTaskCreate( 	ledTaskFun, 					
   					( const char * ) "led0", 	
   					configMINIMAL_STACK_SIZE,
   					(void *)1, 
   					tskIDLE_PRIORITY,
   					&ledTask1 );

   xTaskCreate( 	ledTaskFun,
      					( const char * ) "led1", 
      					configMINIMAL_STACK_SIZE,
      					(void *)2,
      					tskIDLE_PRIORITY,	
      					&ledTask2 );

   xTaskCreate( 	ledTaskFun, 				
      					( const char * ) "led2", 
      					configMINIMAL_STACK_SIZE,
      					(void *)3, 		
      					tskIDLE_PRIORITY + 2,	
      					&ledTask3 );
   xTaskCreate( 	ledTaskFun, 				
      					( const char * ) "led3", 
      					configMINIMAL_STACK_SIZE,
      					(void *)4,
      					tskIDLE_PRIORITY + 3,
      					&ledTask4 );

   vTaskStartScheduler();

   for( ;; );

   return 0;
}
// Delays 
#define DELAY_500_MS		    500UL
#define DELAY_1_SECOND		    1000UL
#define DELAY_1_5_SECONDS   	1500UL
#define DELAY_2_SECONDS     	2000UL
#define DELAY_3_SECONDS     	3000UL
#define DELAY_4_SECONDS     	4000UL


static void ledTaskFun( void *pvParameters ) {
	xLastWakeTime = xTaskGetTickCount ();
	for( ;; ) {
		uint32_t e = (uint32_t)pvParameters;
		switch(e) {
			case 1:
				ledfunc(1, DELAY_500_MS, DELAY_1_SECOND,);
				break;

			case 2:
				ledfunc(2, DELAY_1_SECOND, DELAY_2_SECONDS);
				break;

			case 3:
				ledfunc(4, DELAY_1_5_SECONDS, DELAY_3_SECONDS);
				break;

			case 4:
				ledfunc(8, DELAY_2_SECONDS, DELAY_4_SECONDS);
				break;

			default:
				XGpio_DiscreteWrite(&output, 1, 0b1111);

		}
	}
}


static void ledfunc(int ledid, int down_delay, int up_delay) {

	const TickType_t xUP   = pdMS_TO_TICKS( up_delay );
	const TickType_t xDOWN = pdMS_TO_TICKS( down_delay );

	int switch_data = XGpio_DiscreteRead(&input, 2);

	if((switch_data = switch_data & ledid) == ledid) {
		XGpio_DiscreteWrite(&output, 1, (mask_ledno = mask_ledno | ledid));

		vTaskDelay(xUP);

		XGpio_DiscreteWrite(&output, 1, (mask_ledno = mask_ledno & (~ledid)));

		vTaskDelay( xUP );
	}
	else {
		XGpio_DiscreteWrite(&output, 1, (mask_ledno = mask_ledno | ledid));

		vTaskDelay(xDOWN);

		XGpio_DiscreteWrite(&output, 1, (mask_ledno = mask_ledno & (~ledid)));

		vTaskDelay( xDOWN );
	}

}


