// Exact necessary boundary test for the genus-zero branch.
// E = F25[alpha,zeta]/(A_monic(alpha), L(zeta)), dimension 28 over F25.
#include <array>
#include <vector>
#include <iostream>
#include <fstream>
#include <chrono>
#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <stdexcept>
#include "boundary_input.hpp"
using std::array;
static uint8_t at[25][25],mt[25][25],nt[25];
static uint32_t pt[25][25];
struct E { array<uint8_t,28> c{}; bool zero()const {for(auto x:c)if(x)return false;return true;} bool operator==(const E&b)const{return c==b.c;} };
static void tables(){for(int a=0;a<25;a++){nt[a]=(5-a%5)%5+5*((5-a/5)%5);for(int b=0;b<25;b++){at[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);int r=(a%5*(b%5)+3*(a/5)*(b/5))%5;int i=(a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5;mt[a][b]=r+5*i;pt[a][b]=r+(uint32_t(i)<<16);}}}
static E one(){E r;r.c[0]=1;return r;}
static E add(const E&a,const E&b){E r;for(int i=0;i<28;i++)r.c[i]=at[a.c[i]][b.c[i]];return r;}
static E neg(const E&a){E r;for(int i=0;i<28;i++)r.c[i]=nt[a.c[i]];return r;}
static E sub(const E&a,const E&b){E r;for(int i=0;i<28;i++)r.c[i]=at[a.c[i]][nt[b.c[i]]];return r;}
static E sc(const E&a,int k){E r;for(int i=0;i<28;i++)r.c[i]=mt[a.c[i]][k];return r;}
static E mul(const E&a,const E&b){
 uint32_t conv[13][7]{};uint8_t vv[13][7]{};
 for(int i=0;i<7;i++)for(int j=0;j<4;j++){auto x=a.c[4*i+j];if(!x)continue;for(int k=0;k<7;k++)for(int l=0;l<4;l++){auto y=b.c[4*k+l];if(y)conv[i+k][j+l]+=pt[x][y];}}
 for(int i=0;i<13;i++)for(int j=0;j<7;j++)vv[i][j]=(conv[i][j]&65535u)%5+5*((conv[i][j]>>16)%5);
 for(int i=0;i<13;i++)for(int j=6;j>=4;j--){auto x=vv[i][j];if(x)for(int k=0;k<4;k++)vv[i][j-4+k]=at[vv[i][j-4+k]][mt[x][nt[KM[k]]]];}
 for(int i=12;i>=7;i--)for(int j=0;j<4;j++){auto x=vv[i][j];if(x)for(int k=0;k<7;k++)vv[i-7+k][j]=at[vv[i-7+k][j]][mt[x][nt[LM[k]]]];}
 E r;for(int i=0;i<7;i++)for(int j=0;j<4;j++)r.c[4*i+j]=vv[i][j];return r;
}
static E sq(const E&a){return mul(a,a);}
static E embedK(const int*a){E r;for(int i=0;i<4;i++)r.c[i]=a[i];return r;}
static E outer(const int*a,const int*b){E r;for(int i=0;i<7;i++)for(int j=0;j<4;j++)r.c[4*i+j]=mt[a[j]][b[i]];return r;}
using Poly=array<E,4>;
static void plus(Poly&out,const E&c,int pos){if(pos<4)out[pos]=add(out[pos],c);}
static void linprod(Poly&out,const E&a0,const E&a1,const E&b0,const E&b1,const E&factor,int shift){plus(out,mul(factor,mul(a0,b0)),shift);plus(out,mul(factor,add(mul(a0,b1),mul(a1,b0))),shift+1);plus(out,mul(factor,mul(a1,b1)),shift+2);}
static E bezoutdet(const Poly&p,const Poly&q){auto minor=[&](int i,int j){return sub(mul(p[i],q[j]),mul(p[j],q[i]));};E a=minor(1,0),b=minor(2,0),c=minor(3,0),d=add(minor(2,1),c),e=minor(3,1),f=minor(3,2);return add(sub(mul(a,sub(mul(d,f),sq(e))),mul(b,sub(mul(b,f),mul(c,e)))),mul(c,sub(mul(b,e),mul(c,d))));}
static E HP[4][29],FP[4][29],GP[4][29],JP[4][29],AR[4];
static void preload(){for(int i=0;i<4;i++){AR[i]=embedK(ROOTS[i]);for(int e=0;e<29;e++){HP[i][e]=outer(HS[i],ZP[e]);FP[i][e]=outer(FS[i],ZP[(4*e)%29]);GP[i][e]=outer(GS[i],ZP[(5*e)%29]);JP[i][e]=outer(JS[i],ZP[(8*e)%29]);}}}
int main(int argc,char**argv){
 tables();preload();
 if(argc!=3){std::cerr<<"Usage: genus0_boundary --write|--verify|--check-arithmetic FILE\n";return 2;}
 std::string mode=argv[1],path=argv[2];
 if(mode=="--check-arithmetic"){
  std::ifstream f(path,std::ios::binary);if(!f){std::cerr<<"Cannot open arithmetic vectors\n";return 2;}
  unsigned n=0;array<uint8_t,84> bytes;
  while(f.read(reinterpret_cast<char*>(bytes.data()),84)){
   E a,b,c;std::copy(bytes.begin(),bytes.begin()+28,a.c.begin());std::copy(bytes.begin()+28,bytes.begin()+56,b.c.begin());std::copy(bytes.begin()+56,bytes.end(),c.c.begin());
   if(!(mul(a,b)==c)){std::cerr<<"Arithmetic mismatch at vector "<<n<<'\n';return 1;}n++;
  }
  if(f.gcount()!=0){std::cerr<<"Truncated arithmetic vectors\n";return 1;}
  std::cout<<"PASS: "<<n<<" independent arithmetic vectors\n";return 0;
 }
 bool writing=mode=="--write";if(!writing&&mode!="--verify"){std::cerr<<"Unknown mode\n";return 2;}
 std::fstream cert(path,std::ios::binary|(writing?(std::ios::out|std::ios::trunc):std::ios::in));
 if(!cert){std::cerr<<"Cannot open certificate\n";return 2;}
 auto start=std::chrono::steady_clock::now();
 std::vector<array<int,3>> reps;
 for(int u=0;u<29;u++)for(int t=0;t<29;t++)for(int v=0;v<29;v++){array<int,3>a{u,t,v},b=a;bool keep=true;for(int m=0;m<6;m++){for(auto&x:b)x=x*24%29;if(b<a){keep=false;break;}}if(keep)reps.push_back(a);}
 std::cout<<"orbit representatives "<<reps.size()<<std::endl;
 uint64_t total=0,zeros=0,pzeros=0,dzeros=0;
 for(int j=0;j<4;j++)for(int k=0;k<4;k++)for(int l=0;l<4;l++){
  uint64_t count=0,z=0,pz=0,dz=0;E a=sub(AR[0],AR[j]),b=sub(AR[k],AR[l]);
  for(auto r:reps){int u=r[0],t=r[1],v=r[2];if(j==0&&u==0)continue;if(k==l&&t==0)continue;count++;int vm=(v+t)%29;
   E f=sub(HP[0][0],HP[j][u]),c=sub(FP[0][0],FP[j][u]),d=sub(GP[0][0],GP[j][u]),e=sub(JP[0][0],JP[j][u]);
   E h=sub(HP[k][v],HP[l][vm]),ii=sub(FP[k][v],FP[l][vm]),jj=sub(GP[k][v],GP[l][vm]),kk=sub(JP[k][v],JP[l][vm]);
   E D=sub(mul(h,ii),mul(b,jj));
   if(D.zero()){std::cerr<<"D_zero: certificate failed\n";return 1;}
   E T0=sub(mul(h,d),mul(b,c)),T1=sub(mul(b,a),mul(h,f)),U0=sub(mul(jj,d),mul(ii,c)),U1=sub(mul(ii,a),mul(jj,f));
   if(U0.zero()){std::cerr<<"U0_zero: p=0 branch not excluded\n";return 1;}
   Poly P{},Q{};
   E fac=sc(mul(e,D),2);plus(P,mul(fac,U0),0);plus(P,mul(fac,U1),1);
   linprod(P,T0,T1,U0,U1,sc(h,3),0);
   fac=sc(mul(c,D),3);plus(P,mul(fac,U0),1);plus(P,mul(fac,U1),2);
   fac=sc(mul(a,D),3);plus(P,mul(fac,U0),2);plus(P,mul(fac,U1),3);
   fac=neg(mul(a,D));plus(P,mul(fac,T0),1);plus(P,mul(fac,T1),2);
   linprod(Q,T0,T1,T0,T1,sc(kk,2),1);
   fac=sc(mul(f,D),3);plus(Q,mul(fac,T0),1);plus(Q,mul(fac,T1),2);
   linprod(Q,T0,T1,U0,U1,sc(ii,3),1);
   linprod(Q,U0,U1,U0,U1,sc(b,3),1);
   linprod(Q,T0,T1,U0,U1,neg(b),0);
   E determinant=bezoutdet(P,Q);
   if(determinant.zero()){std::cerr<<"Bezout determinant zero: certificate failed\n";return 1;}
   array<uint8_t,90> record{};record[0]=j;record[1]=k;record[2]=l;record[3]=u;record[4]=t;record[5]=v;
   std::copy(D.c.begin(),D.c.end(),record.begin()+6);
   std::copy(U0.c.begin(),U0.c.end(),record.begin()+34);
   std::copy(determinant.c.begin(),determinant.c.end(),record.begin()+62);
   if(writing)cert.write(reinterpret_cast<const char*>(record.data()),90);
   else {array<uint8_t,90> stored{};if(!cert.read(reinterpret_cast<char*>(stored.data()),90)||stored!=record){std::cerr<<"Certificate mismatch at case "<<j<<' '<<k<<' '<<l<<" exponents "<<u<<' '<<t<<' '<<v<<'\n';return 1;}}
  }
  total+=count;zeros+=z;pzeros+=pz;dzeros+=dz;double sec=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
  std::cout<<"case 0 "<<j<<' '<<k<<' '<<l<<" tested "<<count<<" bezout_zero "<<z<<" p_zero "<<pz<<" D_zero "<<dz<<" elapsed "<<sec<<std::endl;
 }
 std::cout<<"TOTAL tested "<<total<<" bezout_zero "<<zeros<<" p_zero "<<pzeros<<" D_zero "<<dzeros<<std::endl;
 if(total!=219188){std::cerr<<"Unexpected total\n";return 1;}
 if(!writing&&cert.peek()!=std::char_traits<char>::eof()){std::cerr<<"Certificate has trailing data\n";return 1;}
 if(writing&&!cert){std::cerr<<"Certificate write failed\n";return 1;}
 std::cout<<"PASS: genus-zero "<<(writing?"certificate generated":"certificate reproduced")<<std::endl;return 0;
}
