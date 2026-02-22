#!/usr/bin/env sh
#licensed 2026 john morris beck gpl2 @ gnu.org
#this is a tool suite for trying to make the easiest programming language in the world
#part of the design is to have a design which is completely undersatndable and memorizable in a short time.
#part of the design is to have completely flexible syntax at runtime

#this is below the level of understanding that the user is intended to go. the user isnt intended to care how gcc works, only that
#it is invoked to make the code runnable.
optimized_cc(){ gcc -O3 -march=native -ffast-math -flto -shared -fPIC -x c -o "$1.exe" -;};

#this is a replacement for asm langauge. the user isnt intended to think of asm as the baseape of the system, but to think of c as the base of the system
#this attempts to simplify c so that works much more like an assembly language. adding in things like includes or functions is done
#with the inline keyword. in addition, the inline intended to be how the user hooks up c libraries to the c_come asm langauge. inline also allows
#for a nested inline so taht the user can write optimizations in inline barematal assembly.
#new users arent expected to learn this part. the users understanding is intended to work its way from the bottom of this file to the top.
#I still need to test if this functions on arm and riscv but that is later down the road. For now running on x86_64 is fine, because there are
#new tools all the time to port that to arm and riscv without virtualization.

#one thing worth noting is that this is intended to be used to generate very small c files that share memory across processes using mmap. This is a scheme
#to make JITs that compile to c instead fo asm and are machine architecture independent.
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

#this is a small virtual machine that ideally will do everything awk can do. it is true that this could be re-written in the c_comb language
#above, howeer that would take up many lines of code, and reqquire some bootstrapping. I want it to be seamless for the user to get this compiler
#toolchain working if they have posix and gcc

#grok has complained tthat this layer adds complexity to a user who wants to learn how the entire compiler stack works. that is certainly true. it requires
#for the user to learn another asm language as well as potentially to learn awk.
awk_comb(){ awk '{if($1=="-"){r[$2]-=r[$3]}
	    	    else if($1=="<"){r[$2]=r[$2]<r[$3]}
		    else if($1=="m"){r[$3]=r[$2]}
		    else if($1=="$"){r[$2]=system(r[$3])}
		    else if($1=="r"){r[$2]=r[r[$3]]}
		    else if($1=="w"){r[r[$3]]=r[$2]}
		    else if($1=="i"){getline r[$2]}
		    else if($1=="o"){printf "%s",r[$2]}
		    else if($1=="+"){r[$2]=r[$2] r[$3]}
		    else if($1=="c"){r[$2]=sprintf("%c",r[$3])}
		    else if($1=="s"){r[$2]=substr(r[$2],r[$3],1)}';};

#this is intended to be a very spartan forth which has a design very different from how classical forth works. This forth really only has the ability to
#compose anonymous functions and push them to the stack, to name things that are on the stack as variables, and to call variables as functions that
#push things to the stack. currently this part is the part that is in development.

#the way sovlavra is intened to work is to pipe it into either comb. so one can pipe it into the awk comb if they want a live vm in the shell
#or of they want to generate a binary they can pipe it to the c comb, pipe that into the cc, and then execute it immediately.

#because both the awk comb and the c comb have things like arithmetic, memory management, reading,, and printing, that means taht
#I don't have to include that kind of stuff necessarily in the implementation of this forth. So this forth wont for example have the + keyword.
sovlavra67365(){ awk '{gsub(/ /,"\n");print}'|awk '{#this is gonna be a forth
    call_stack[call_stack_head++]=dictionary[$0];
    if(string){string!=0;stack[stack_head++]=$0}
    else if(dictionary[$0]=="\""){if(building_string){string=1}
    else if($0=="define"){naming=1}
    else if(naming){naming=0;dictionary[$0]=stack[head--]}
    else{

    }
}';};

#this is an example which is close to how the full pipeline of the language might look. Except that I would want to keep sovlavra|awk_comb running
#continuously like in the mcr below so that I wouldnt have to keep re-evaluating the definitions of all of the words.
#currently this does not re-use any code that is frequently used or HOT, like a proper JIT would. I'm going to work on that.
lang67(){ sovlavra67365|awk_comb|c_comb|optimized_cc "$1";"$1.exe";rm "$1.exe";};

#this is a system for creating servers for the shell.
server67_close(){ rm -f "/tmp/.server67$1$$in" "/tmp/.server67$1$$out" EXIT;};
server67(){ trap server67_close "$1";
	    mkfifo "./tmp/.server67$1$$in" "/tmp/.server67$1$$out";
	    sh<"/tmp/.server67$1$$in">"/tmp/.server67$1$$out"&};
server67_send(){ cat > "/tmp/.server67$1$$in";};

foolang(){

    server67 "$1";
    printf "%s" '
	   some langauage
' | server67_send "$1";};
 

