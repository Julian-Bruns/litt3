// Complete quotient-algebra evaluations of the actual normalized square tails.
// Every operation is a polynomial operation: no fibre-dependent inversion.
#include "field.cpp"
static EP epfrob(const EP&A,int j){
 uint64_t p=1;for(int i=0;i<j;i++)p*=5;
 EP B;if(!A.len())return B;B.a.resize(((A.len()-1)*p+1)*ED,0);
 for(int i=0;i<A.len();i++){E z=epower(A.coeff(i),p);copy(z.begin(),z.end(),B.a.begin()+i*p*ED);}B.norm();return B;
}
extern "C" {
int prefix_sample(const int* jets,int nu,int ns,const int* g,int u0,int first,int ntail,int width,int* out){
 try{
  if(!ready)ff_init();ED=9;EM.assign(10,0);
  for(int j=0;j<10;j++){int a=0;for(int i=2;i>=0;i--)a=add(mul(a,u0),g[j*3+i]);EM[j]=a;}
  if(EM[9]!=1)return -1;
  int stride=ns*7*9;KP val(stride,0);
  for(int i=nu-1;i>=0;i--)for(int k=0;k<stride;k++)val[k]=add(mul(val[k],u0),jets[(size_t)i*stride+k]);
  vector<EP>A(ns),A2(ns),A3(ns);for(int n=0;n<ns;n++)A[n]=EP(KP(val.begin()+n*7*9,val.begin()+(n+1)*7*9));
  E two(ED,0);two[0]=2;
  for(int i=0;i<ns;i++)for(int j=i;i+j<ns;j++){
   EP p=epmul(A[i],A[j]);if(i!=j)p=epscale(p,two);A2[i+j]=epadd(A2[i+j],p);
  }
  for(int n=0;n<ns;n++){
   bool needed=false;for(int h=0;h<ntail;h++)if(n<=first+h&&(first+h-n)%5==0)needed=true;
   if(!needed)continue;
   for(int j=0;j<=n;j++)A3[n]=epadd(A3[n],epmul(A2[j],A[n-j]));
  }
  vector<EP>F5(ns/5+1),F25(ns/25+1);for(int j=0;j<(int)F5.size();j++)F5[j]=epfrob(A2[j],1);for(int j=0;j<(int)F25.size();j++)F25[j]=epfrob(A2[j],2);
  std::fill(out,out+(size_t)ntail*width*9,0);
  for(int h=0;h<ntail;h++){
   int n=first+h;EP ans;
   for(int j2=0;j2*25<=n;j2++){
    EP t;for(int j1=0;j1*5+25*j2<=n;j1++)t=epadd(t,epmul(A3[n-25*j2-5*j1],F5[j1]));
    ans=epadd(ans,epmul(t,F25[j2]));
   }
   if(ans.len()>width)return -2;copy(ans.a.begin(),ans.a.end(),out+(size_t)h*width*9);
  }
  return 0;
 }catch(const exception&e){fprintf(stderr,"prefix sample: %s\n",e.what());return -3;}
}
}
