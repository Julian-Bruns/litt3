// Independent absolute-F5 replay of the reciprocal zero-character test.
#define main unused_odd_matching_verifier_main
#include "verify_klein_four_odd_matching.cpp"
#undef main
struct SixAbs{E p,q,u,t,v,w;};
SixAbs sum6(SixAbs a,SixAbs b){return {sum(a.p,b.p),sum(a.q,b.q),sum(a.u,b.u),sum(a.t,b.t),sum(a.v,b.v),sum(a.w,b.w)};}
int main(){
 E one{};one[0]=1;E z{};z[1]=1;E beta={1,1,0,0,4,3,3,1,1,3,1,2,1,1};
 assert(times(beta,beta)==sum(beta,scalar(one,3)));
 auto code=[&](int n){return sum(scalar(one,n%5),scalar(beta,n/5));};
 int f7[8]={4,22,7,20,21,7,24,1};E ev{};for(int i=7;i>=0;--i)ev=sum(times(ev,z),code(f7[i]));assert(ev==E{});
 E roots[30];roots[0]=one;for(int j=1;j<=29;++j)roots[j]=times(roots[j-1],z);assert(roots[29]==one);
 SixAbs ls[116];int t2[4]={1,2,4,3},t3[4]={1,3,4,2};
 for(int i=0;i<4;++i)for(int j=0;j<29;++j)ls[29*i+j]={scalar(roots[5*j%29],t2[i]),scalar(roots[5*j%29],t3[i]),scalar(roots[17*j%29],t2[i]),scalar(roots[17*j%29],t3[i]),scalar(roots[5*j%29],i%2?4:1),scalar(roots[17*j%29],i%2?4:1)};
 uint64_t total=0,eligible=0;
 for(int c=0;c<116;++c)for(int b=0;b<=c;++b)for(int a=0;a<=b;++a){++total;
  if(a%29==0&&b%29==0&&c%29==0)continue;
  SixAbs s=sum6(sum6(ls[0],ls[a]),sum6(ls[b],ls[c]));
  E D=sum(times(code(5),times(s.q,s.u)),scalar(times(code(17),times(s.p,s.t)),4));if(D==E{})continue;++eligible;
  E ab1=times(code(9),times(times(s.p,s.t),times(s.v,s.w)));
  E ab2=times(code(8),times(times(s.p,s.q),times(s.w,s.w)));
  E ab3=times(code(6),times(times(s.u,s.t),times(s.v,s.v)));
  E ab4=times(code(10),times(times(s.u,s.q),times(s.v,s.w)));
  E AB=sum(sum(ab1,scalar(ab2,4)),sum(scalar(ab3,4),ab4));
  assert(times(D,D)!=scalar(AB,2));
 }
 assert(total==266916&&eligible==266840);
 std::cout<<"PASS: independent F5 degree14 model; all266840 eligible endpoints exclude simultaneous reciprocal character3 vanishing.\n";
}
