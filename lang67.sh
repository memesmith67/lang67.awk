#!/usr/bin/env sh
#licensed 2026 john morris beck gpl2 @ gnu.org
#this is a tool suite for trying to make the easiest programming language in the world
#part of the design is to have a design which is completely undersatndable and memorizable in a short time.
#part of the design is to have completely flexible syntax at runtime
optimized_cc(){ gcc -O3 -march=native -ffast-math -flto -shared -fPIC -x c -o "$1.exe" -;};
c_comb(){ awk '{j["declare"]="int ia,ib,ic,id,ie,if,ig,ih,ii,ij,ik,il,im,in,io,ip;void *pa,*pb,*pc,*pd,*pe,*pf,*pg,*ph,*pi,*pj,*pk,*pl,*pm,*pn,*po,*pp";
	j["loop"]="while("$2"){";
	j["end"]="}";p
	j["return"]="return "$2;
   	j["size"]=$2"=sizeof("$3")";
	j["operate"]=$2"="$3" "$4" "$5;
	j["assign"]=$2"="$3;
	j["get"]=$2 "=*("$3"*)("$4")";
	j["set"]="*("$2"*)("$3")="$4;
	j["jump"]=$2"=(void*)((char*)"$2" + (intptr_t)("$3"))";
	j["allocate"]=$2"=malloc("$3")";
	j["free"]="free("$2")";
	j["mmap"]=$2"=mmap("$3","$4","$5","$6","$7","$8")";
	j["munmap"]=$2"=munmap("$3","$4")";
	j["read"]="fread("$2",1,(size_t)"$3",stdin)";
	j["write"]="fwrite("$2",1,(size_t)"$3",stdout);fflush(stdout)";
	if($0=="inline"){inline=!inline}
	else if(inline){print}
	else{print j[$1] ";"}}';};
awk_comb(){ awk '{if(z == "-"){r[$2]-=r[$3]}
	    	    else if(z=="<"){r[$2]=r[$2]<r[$3]}
		    else if(z=="m"){r[$3]=r[$2]}
		    else if(z=="$"){r[$2]=system(r[$3])}
		    else if(z=="r"){r[$2]=r[r[$3]]}
		    else if(z=="w"){r[r[$3]]=r[$2]}
		    else if(z=="i"){getline r[$2]}
		    else if(z=="o"){printf "%s",r[$2]}
		    else if(z=="+"){r[$2]=r[$2] r[$3]}
		    else if(z=="c"){r[$2]=sprintf("%c",r[$3])}
		    else if(z=="s"){r[$2]=substr(r[$2],r[$3],1)}';};
sovlavra67365(){ awk '{gsub(/ /,"\n");print}'|awk '{#this is gonna be a forth
    if($0=="\""){if(building_string){string=1}
    else if(string){string!=0;stack[stack_head++]=$0}
    else if($0=="define"){naming=1}
    else if(naming){naming=0;dictionary[$0]=stack[head--]}
    else{
    call_stack[call_stack_head++]=dictionary[$0];

    }';};
lang67(){ sovlara67365|awk_comb|c_comb|optimized_cc "$1";"$1.exe";rm "$1.exe";};
mcr(){ trap "rm /tmp/mcr$$in /tmp/mcr$$out" EXIT; mkfifo "/tmp/mcr$$"in "/tmp/mcr$$"out;sh -c "$1"<"/tmp/mcr$$"in|sh>"/tmp/mcr$$"out &};
mcr_send(){ cat > "/tmp/mcr$$"in;};
foolang(){ mcr '
	   some langauage
';};
 

