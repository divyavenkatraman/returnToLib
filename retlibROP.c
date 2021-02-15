#include <stdlib.h>
#include <stdio.h>
#include <string.h>
int foo(char *str){
	char buffer[100];
	unsigned int *framep; 

	asm( "movl %%ebp , %0 " : "=r " (framep )); 
	/*printout information for experiment purpose*/
	printf ("Address of buffer [] : Ox%.8x\n ", (unsigned)(buffer)) ;
	printf ( " Frame Pointer value : Ox%.8x \n ", (unsigned)framep );

	strcpy (buffer, str) ;
	return 1 ;
}
// For the purpose of experiment
void bar(){
	static int i = 0 ;
	printf (" The function bar () is invoked %d times ! \n ", ++i );
	// For the purpose of e xperiment
}
void baz (int x){
	printf ( "The value of baz( )' s argument : Ox%.8X\n ", x );
}
int main (int argc, char **argv){
	char str[2000];
	FILE *badfile ;
	char *shell= (char *) getenv("MYSHELL"); 
	if (shell) {
		printf ( "The ' %s ' string' s address : Ox%.8x\n ", shell ,
		(unsigned int)shell);
		badfile = fopen ("badfile", "r") ;
		fread (str, sizeof (char), 2000 , badfile );
		foo (str) ;
		printf("Returned Properly\n");
		return 1;
	}
}
