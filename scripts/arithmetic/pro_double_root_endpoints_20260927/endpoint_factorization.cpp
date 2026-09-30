// Whole-algebra checks of every coefficient of the expanded endpoint product.
#include "field.cpp"
extern "C" int endpoint_factor_checks(const int*raw,int rows,const int*gq,int count,int*out){
 try{
  ff_init();ED=9;
  // Columns 0..9: Omega coefficients. Columns 10..21: three cubic factors.
  for(int u=0;u<count;u++){
   EM.assign(10,0);for(int i=0;i<10;i++)EM[i]=add(gq[3*i],mul(u,add(gq[3*i+1],mul(u,gq[3*i+2]))));
   if(EM[9]!=1)return -1;vector<E>v(22,E(9,0));
   for(int k=0;k<22;k++)for(int j=0;j<9;j++){
    int z=0;for(int i=rows-1;i>=0;i--)z=add(mul(z,u),raw[((size_t)i*22+k)*9+j]);v[k][j]=z;
   }
   EP p(eone());
   for(int a=0;a<3;a++){
    EP f;f.a.assign(4*ED,0);for(int i=0;i<4;i++)copy(v[10+4*a+i].begin(),v[10+4*a+i].end(),f.a.begin()+9*i);
    p=epmul(p,f);
   }
   for(int i=0;i<10;i++){
    E w=p.coeff(i);if(w!=v[i])return u+1;copy(w.begin(),w.end(),out+(u*10+i)*9);
   }
  }
  return 0;
 }catch(const exception&ex){fprintf(stderr,"endpoint product verification: %s\n",ex.what());return -2;}
}
