#!/usr/bin/env awk
#licensed 2026 john morris beck gpl2 @ gnu.org 
{j["declare"]="int i0=0,i1=0,i2=0,i3=0,i4=0,i5=0,i6=0,i7=0;void *p0=NULL,*p1=NULL,*p2=NULL,*p3=NULL,*p4=NULL,*p5=NULL,*p6=NULL,*p7=NULL";
	j["loop"]="while(" $2 "){";
	j["end"]="}";
	j["exit"]="exit(0)";
	j["size"]=$2 "=sizeof(" $3 ")";
	j["operate"]=$2 "=" $3 " " $4 " " $5;
	j["assign"]=$2 "=" $3;p
	j["get"]=$2 "=*(" $3 "*)(" $4 ")";
	j["set"]="*(" $2 "*)(" $3 ")=" $4;
	j["jump"]=$2 "=(void*)((char*)" $2 " + (intptr_t)(" $3 "))";
	j["allocate"]=$3 "=malloc(" $2 ")";
	j["free"]="free(" $2 ")";
	j["read"]="fread(" $2 ",1,(size_t)" $3 ",stdin)";
	j["write"]="fwrite(" $2 ",1,(size_t)" $3 ",stdout);fflush(stdout)";
	if($0=="inline"){inline=!inline}
	else if(inline){
	    print $0
	}
	else if(j[$1]==""){exit(1)}
	else{printfff j[$1] ";"}}
