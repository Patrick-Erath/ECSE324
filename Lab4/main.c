#include <stdio.h>
#include "./drivers/inc/VGA.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/audio_port.h"

void test_char() {
		int x,y;
		char c = 0;
		
		for(y=0 ; y<=59 ; y++)
			for(x=0 ; x<=79 ; x++)
				VGA_write_char_ASM(x,y,c++);
	}

	void test_byte() {
		int x,y;
		char c = 0;
		
		for(y=0 ; y<=59 ; y++)
			for(x=0 ; x<=79 ; x+=3)
				VGA_write_byte_ASM(x,y,c++);
	}

	void test_pixel() {
		int x,y;
		unsigned short colour =0;
		
		for(y=0 ; y<=239 ; y++)
			for(x=0 ; x<=319 ; x++)
				VGA_draw_point_ASM(x,y,colour++);
	}


int main(){ 
/*
//VGA
int button = 0;
while(1){
	button =  read_PB_data_ASM();
	if(button == PB0){
		if(read_slider_switches_ASM()>0){	
			test_byte();
		}
		else{
			test_char();
		}
	}else if(button == PB1){
		test_pixel();
	}else if(button == PB2){
		VGA_clear_charbuff_ASM();
	}else if(button == PB3){
		VGA_clear_pixelbuff_ASM();
	}



}
*/
/*
//Keyboard
	char *data = (char *) malloc(sizeof(char));
	int x = 0;
	int y = 0;
	while(1) {
      if(read_slider_switches_ASM()>0){
		VGA_clear_charbuff_ASM();
		x = 0;
		y = 0;
	}
		if(read_PS2_data_ASM(data)) {
			VGA_write_byte_ASM(x,y,*data);
			x += 3;
			if(x > 79) {
				y++;
				x = 0;
			}
			if(y > 59) {
				y = 0;
			}
		}
	}
*/

//Audio
	int frequency = 100; 
	int sRate = 48000; 
	int sR = (sRate/frequency)/2; 
	int i = 0; 
	int signal = 0x00FFFFFF;
	while(1){
		if(write_audio_data(signal)){
				i++;
			
			if (i > sR) {
				i =0;
				if (signal == 0) {
				signal = 0x00FFFFFF;
				} else {
					signal = 0;
				}	
			}
		}
	}

return 0;

}
