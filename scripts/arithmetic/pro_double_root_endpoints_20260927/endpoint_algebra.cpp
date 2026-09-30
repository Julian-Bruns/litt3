// Exact batch evaluation in K[q]/M, preserving nonreduced quotients.
#include "field.cpp"
extern "C" int endpoint_eval(const int*raw,int rows,int count,const int*mod,int d,const int*uin,int*out){
 try{
  ff_init();if(d<1||d>4096||mod[d]!=1)return -1;
  ED=d;EM.assign(mod,mod+d+1);E u(uin,uin+d),up=eone();fill(out,out+(size_t)count*d,0);
  for(int i=0;i<rows;i++){
   E mon=up;
   for(int j=0;j<9;j++){
    for(int k=0;k<count;k++){
     int c=raw[((size_t)i*count+k)*9+j];if(!c)continue;
     int*dst=out+(size_t)k*d;
     for(int h=0;h<d;h++)if(mon[h])dst[h]=add(dst[h],mul(c,mon[h]));
    }
    int top=mon.back();for(int h=d-1;h>=0;h--)mon[h]=sub(h?mon[h-1]:0,mul(top,EM[h]));
   }
   if(i+1<rows)up=emul(up,u);
  }
  return 0;
 }catch(const exception&ex){fprintf(stderr,"endpoint eval: %s\n",ex.what());return -3;}
}
