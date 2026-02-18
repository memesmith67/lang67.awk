#gcc -O3 -march=native -flto lang.c#license:john morris beck gpl2 @ gnu.org
#in case i die future design envolves incresasing register space for speedy caching, and replacing
#malloc and free for mmap an munmap, and make the files be in /dev/shm or fallback to /dev/tmp if shm is unavailable
#a special naming scheme with guarnteed unique filenames based on timestamp, process id, and a random string from /dev/urandom allows
#for optional shared memory between vm processes. shared memory is intended to be used immutably where possible else with locks



BEGIN{print %s "#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#define c(x,y) case x: y;break;\nprint main(){int x=0,y,z,i[16],f[999],*t=f;void* p[16];*i=1;*p=&t;while(t[x++]=getchar());while(1){"}
{
    if( $1 == 0 ){
	printf %s "exit(0)"


    }
    else if ($1 == 1 ){
	printf %s "i[" $2 "]-=i[" $3 "]"
    }
        else if ($1 == 2 ){
	    printf %s "i[" $2 "]=i[" $2 "]<i[" $3 "]"

    }
        else if ($1 == 3 ){
	    printf %s "p[" $3 "]=p[" $2 "]"
    }
        else if ($1 == 4 ){
	    printf %s "i[" $3 "]=i[" $2 "]"
    }
        else if ($1 == 5 ){
	    printf %s "p[" $3 "]=*(void**)p[" $2 "]"
    }
        else if ($1 == 6 ){
	    printf %s "*(void**)p[" $3 "]=p[" $2 "]"
    }
        else if ($1 == 7 ){
	    printf %s "p[" $3 "]=(void*)((char*)(p[" $3 "]+(int)i[" $2 "]))"
    }
        else if ($1 == 8 ){
	    printf %s "p[" $3 "]=malloc(i[" $2 "]);i[" $2 "]=(p[" $3 "]==NULL)"
    }    else if ($1 ==  9 ){
	    printf %s "i[" $2 "]=(p[" $3 "]==NULL);free(p[" $3 "])"
    }
        else if ($1 == 10 ){
	    printf %s "fread(p[" $3 "],1,i[" $3 "],stdin)"
    }
        else if ($1 == 11 ){
	    printf %s "fwrite(p[" $3 "],1,i[" $3 "],stdout);fflush(stdout))"
    }
    printf ";"}

END{print %s "}}}"}

