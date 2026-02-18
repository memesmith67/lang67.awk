#!/usr/bin/env sh
lang67(){ #license: 2026 john morris beck gpl2 @ gnu.org
    sh < "$1" | awk '
    BEGIN{
	print "#include <stdio.h>";
	print "#include <stdlib.h>";
	print "#include <string.h>";
	print "#include <stdint.h>";
	print "int main(void){"
	print "int i0=0,i1=0,i2=0,i3=0,i4=0,i5=0,i6=0,i7=0;"
	print "void* p0=NULL,p1=NULL,p2=NULL,p3=NULL,p4=NULL,p5=NULL,p6=NULL,p7=NULL;"
	indent=1;
    }
    {
	if($1=="loop"){j="while(" $2 "){";indent++}
	else if($1=="end"){j="}";indent--}
	else if($1=="exit"){j="exit(0);"}
	else if($1=="operate"){j=$2 "=" $3 " " $4 " " $5 ";"}
	else if($1=="assign"){j=$2 "=" $3 ";"}
	else if($1=="get"){j=$2 "=*(void**)(" $3 ");"}
	else if($1=="set"){j="*(void**)(" $2 ")=" $3 ";"}
	else if($1=="jump"){j=$2 "=(void*)((char*)" $2 " + (intptr_t)(" $3 "));"}
	else if($1=="allocate"){j=$3 "=malloc(" $2 ");" $2 "=(" $3 "==NULL);"}
	else if($1=="free"){j=$2 "=(" $3 "==NULL);free(" $3 ");"}
	else if($1=="read"){j="fread(" $2 ",1,(size_t)" $3 ",stdin);"}
	else if($1=="write"){j="fwrite(" $2 ",1,(size_t)" $3 ",stdout);fflush(stdout);"}
	for(i=0;i<indent;i++){printf "%s" "    "}
	print j;
    }
    ' > "$1.c" ;
    gcc -O3 -march=native -flto lang.c "$1.c" -o "$1.exe" ; } ;

