/* Exhaustive finite checks only, not a search over geometric covers.
   See REPORT.md sections 4 and 9 for the proof of orbit coverage. */
#include <algorithm>
#include <array>
#include <cstdint>
#include <iostream>
#include <vector>
#include <chrono>
using namespace std;
using Mask=uint32_t;
constexpr Mask full=(Mask(1)<<29)-1;
int mod5(int x){x%=5;return x<0?x+5:x;}
using F=array<int,14>;
const int ff[15]={1,2,4,0,4,4,3,1,3,4,4,0,4,2,1};
F red(array<int,29>a){for(int&i:a)i=mod5(i);for(int j=28;j>=14;j--){int c=a[j];if(c)for(int i=0;i<=14;i++)a[j-14+i]=mod5(a[j-14+i]-c*ff[i]);} F z;copy(a.begin(),a.begin()+14,z.begin());return z;}
F mul(const F&a,const F&b){array<int,29>c{};for(int i=0;i<14;i++)for(int j=0;j<14;j++)c[i+j]+=a[i]*b[j];return red(c);}
F add(F a,const F&b,int scalar=1){for(int i=0;i<14;i++)a[i]=mod5(a[i]+scalar*b[i]);return a;}
bool zero(const F&a){return all_of(a.begin(),a.end(),[](int x){return x==0;});}
Mask rot(Mask m,int r){if(!r)return m;return ((m>>r)|(m<<(29-r)))&full;}
Mask frob(Mask m){Mask z=0;while(m){int r=__builtin_ctz(m);m&=m-1;z|=Mask(1)<<((5*r)%29);}return z;}
// Canonical under t -> omega^a t and t -> t^5 on nodes.
bool canonical(Mask m){Mask v=m;for(int b=0;b<14;b++){Mask bits=v;while(bits){int r=__builtin_ctz(bits);bits&=bits-1;if(rot(v,r)<m)return false;}v=frob(v);}return true;}
int orbit_normalized(Mask m){vector<Mask>all;Mask v=m;for(int b=0;b<14;b++){Mask bits=v;while(bits){int r=__builtin_ctz(bits);bits&=bits-1;all.push_back(rot(v,r));}v=frob(v);}sort(all.begin(),all.end());return unique(all.begin(),all.end())-all.begin();}
F small_det(const vector<int>&roots,int d){int N=roots.size();vector<int>p(N),ex;for(int i=0;i<N;i++)p[i]=i;for(int i=0;i<=d;i++)ex.push_back(i);for(int i=0;i<=d;i++)ex.push_back(7+i);array<int,29>pol{};do{int inv=0,deg=0;for(int i=0;i<N;i++){deg+=roots[i]*ex[p[i]];for(int j=i+1;j<N;j++)inv+=p[i]>p[j];}pol[deg%29]+=(inv&1)?-1:1;}while(next_permutation(p.begin(),p.end()));return red(pol);}
F schur(const vector<int>&roots,int d){
 array<array<int,29>,7>e{};e[0][0]=1;int used=0;
 for(int r:roots){used++;for(int k=min(6,used);k>=1;k--){for(int i=0;i<29;i++){int j=i+r;if(j>=29)j-=29;int c=e[k][j]+e[k-1][i];e[k][j]=(c>=5)?c-5:c;}}}
 F e2=red(e[2]),e3=red(e[3]),e4=red(e[4]),e5=red(e[5]),e6=red(e[6]);
 if(d==5)return e6;
 if(d==4)return add(mul(e5,e5),mul(e4,e6),-1);
 // s_(3,3,3,3) = e4^3 - 2 e3 e4 e5 + e2 e5^2 + e3^2 e6 - e2 e4 e6.
 F z=mul(mul(e4,e4),e4);
 z=add(z,mul(mul(e3,e4),e5),-2);
 z=add(z,mul(e2,mul(e5,e5)));
 z=add(z,mul(mul(e3,e3),e6));
 return add(z,mul(mul(e2,e4),e6),-1);
}
void work(int d){int N=2*d+2;long visited=0,representatives=0,covered=0,zeros=0;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
 while(comb<limit){Mask m=(comb<<1)|1;visited++;
  if(canonical(m)){representatives++;covered+=orbit_normalized(m);vector<int>rs;Mask bits=m;while(bits){int r=__builtin_ctz(bits);bits&=bits-1;rs.push_back(r);}F val=(d<=2)?small_det(rs,d):schur(rs,d);if(zero(val)){zeros++;cout<<"ZERO d="<<d<<" nodes=";for(int r:rs)cout<<r<<",";cout<<"\n";}}
  Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
 }
 cout<<"d="<<d<<" rows="<<N<<" normalized_subsets="<<visited<<" representatives="<<representatives<<" covered="<<covered<<" zero_orbits="<<zeros<<"\n";
 if(covered!=visited || zeros!=0)exit(2);
}
void brute_small(int d){
 int N=2*d+2;long checked=0;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
 while(comb<limit){
  Mask bits=(comb<<1)|1;vector<int>rs;
  while(bits){int r=__builtin_ctz(bits);bits&=bits-1;rs.push_back(r);}
  if(zero(small_det(rs,d))){cerr<<"FAIL brute small minor\n";exit(3);}
  checked++;
  Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
 }
 cout<<"BRUTE d="<<d<<" normalized_subsets="<<checked<<" zero_minors=0\n";
}
int main(){
 cout<<"EXACT F5^14 FOURIER MINOR CHECK; no floating-point arithmetic.\n";
 for(int d=0;d<=5;d++)work(d);
 for(int d=0;d<=2;d++)brute_small(d);
 cout<<"PASS every claimed finite Fourier minor check.\n";
}
