#include "address_map_arm.h"

extern int MAX_2(int x, int y);

int main(){
	int a[5] = {1, 20, 3, 4, 5};
    int max_val=0;
    int i=0;
    for (i = 0; i < 5; i++) {
      max_val = MAX_2(a[i],max_val);	// Return twice max val
 }
	return max_val;
   
}




