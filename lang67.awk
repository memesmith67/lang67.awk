#!/usr/bin/env sh
lang67(){ #license: 2026 john morris beck gpl2 @ gnu.org
    sh < "$1" | awk '
    BEGIN{
	printf "%s" "#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\nmain(){int i0,i1,i2,i3,i4,i5,i6,i7;void* p0,p1,p2,p3,p4,p5,p6,p7;"}{
	if($1=="loop"){j="while(" $2 "){"}
	else if($1=="end"){j="}"}
	else if($1=="exit"){j="exit(0)"}
	else if($1=="operate"){j=$1 "=" $3 $2 $4}
	else if($1=="assign"){j=$2 "=" $3 }
	else if($1=="get"){j=$2 "=*(void**)(" $3 ")"}
	else if($1=="set"){j="*(void**)(" $2 ")=" $3}
	else if($1=="jump"){j=$2 "=(void*)((char*)" $2 " + (intptr_t)(" $3 "))"}
	else if($1=="allocate"){j=$3 "=malloc(" $2 ");" $2 "=(" $3 "==NULL)"}
	else if($1=="free"){j=$2 "=(" $3 "==NULL);free(" $3 ")"}
	else if($1=="read"){j="fread(" $2 ",1,(size_t)" $3 ",stdin)"}
	else if($1=="write"){j="fwrite(" $2 ",1,(size_t)" $3 ",stdout);fflush(stdout))"}
	printf "%s%s" j ";"}
    ' > "$1.c" ;
    gcc -03 -march=native -flto lang.c "$1.c" -o "$1.exe" ; } ;
