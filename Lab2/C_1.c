#include "address_map_arm.h"

int main(){
	int a[5] = {1, 20, 3, 4, 5}; //Inililize array
    int max_val=0;
    int i=0;
    for (i = 0; i < 5; i++) {		// Iterate through array 
       if ( a[i] > max_val) {		// update max value
       max_val=a[i];
   }	
 }
	return max_val;
   
}

