#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <string.h>


int main(int ac , char **av){

	int i =1;
	int j =0;
	long res;
	int v_flag =0;
	if(ac == 1){
		printf("usage :mkdir folderName !!!");
		return 1;
	}
	
	if(strcmp(av[1] , "-v") == 0) {
		v_flag = 1;	
		i++;
	}


	while(i < ac){
		
		res = mkdir(av[i] , 0755);
		if(res < 0){
			printf("we cannot create this folder!!!\n");
			i++;
			continue;
		}
		
		if(v_flag == 1) {
			printf("mkdir: created directory '%s'\n" , av[i]);

		}

		
		i++;
	}


	return 0;
}



