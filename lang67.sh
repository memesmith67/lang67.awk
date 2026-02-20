#!/usr/bin/env sh
#licensed 2026 john morris beck gpl2 @ gnu.org
#note to self use tmpfiles as arrays
mcr(){ sh|sh;};
lang67(){ awk '{j["declare"]="int ia,ib,ic,id,ie,if,ig,ih,ii,ij,ik,il,im,in,io,ip;void *pa,*pb,*pc,*pd,*pe,*pf,*pg,*ph",*pi,*pj,*pk,*pl,*pm,*pn,*po,*pp;
	j["loop"]="while("$2"){";
	j["end"]="}";
	j["return"]="return "$1;
	j["size"]=$2"=sizeof("$3")";
	j["operate"]=$2"="$3" "$4" "$5;
	j["assign"]=$2"="$3;
	j["get"]=$2 "=*("$3"*)("$4")";
	j["set"]="*("$2"*)("$3")="$4;
	j["jump"]=$2"=(void*)((char*)"$2" + (intptr_t)("$3"))";
	j["allocate"]=$3"=malloc("$2")";
	j["free"]="free("$2")";
	j["read"]="fread("$2",1,(size_t)"$3",stdin)";
	j["write"]="fwrite("$2",1,(size_t)"$3",stdout);fflush(stdout)";
	if($0=="inline"){inline=!inline}
	else if(inline){print}
	else{print j[$1] ";"}}';};
fastcc(){ gcc -O3 -march=native -ffast-math -flto -shared -fPIC -x c -o "$1.exe" -;};
