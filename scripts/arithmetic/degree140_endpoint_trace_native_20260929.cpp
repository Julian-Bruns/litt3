#include "degree140_endpoint_trace_native_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc<5||argc>8)throw std::runtime_error("usage: endpoint_trace FIELD FAMILY H W [PRECISION] [T_POWER] [PROPER]");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);if(argc>=6)endpointtrace::CAP=std::stoi(argv[5]);int tp=argc>=7?std::stoi(argv[6]):0;bool proper=argc==8?std::stoi(argv[7]):true;auto start=std::chrono::steady_clock::now();
 auto a=endpointtrace::correction(std::stoi(argv[3]),std::stoi(argv[4]),exact::ppow(criticaltrace::T,tp),proper);
 std::cout<<"{\"h\":"<<argv[3]<<",\"w\":"<<argv[4]<<",\"precision\":"<<endpointtrace::CAP<<",\"t_power\":"<<tp<<",\"corrections\":{";bool first=true;
 for(int t=0;t<2;t++)for(int n=0;n<(t?6:3);n++){if(!first)std::cout<<',';first=false;std::cout<<'\"'<<-t<<','<<n<<"\":[";for(int j=0;j<3;j++){if(j)std::cout<<',';std::cout<<a[t][n][j];}std::cout<<']';}
 auto ct=endpointtrace::closed_constants(std::stoi(argv[3]),std::stoi(argv[4]));
 std::cout<<"},\"closed_constants\":[["<<ct[0][0]<<','<<ct[0][1]<<','<<ct[0][2]<<"],["<<ct[1][0]<<','<<ct[1][1]<<','<<ct[1][2]<<"]],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
