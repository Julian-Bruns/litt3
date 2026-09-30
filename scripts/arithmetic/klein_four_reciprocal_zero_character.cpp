// Test the necessary endpoint identity when both epsilon and its inverse
// have zero sigma-eigenvalue3 component. Uses the received exact field code.
#define main unused_incoming_endpoint_main
#include "pro_quadratic_scalar_20260926/endpoint_scan.cpp"
#undef main
#include <set>
struct Six {E p,q,u,t,v,w;};
Six plus(Six a,Six b){return {add(a.p,b.p),add(a.q,b.q),add(a.u,b.u),add(a.t,b.t),add(a.v,b.v),add(a.w,b.w)};}
int main(int argc,char**argv){
 assert(argc==2);for(int a=0;a<25;++a){neg25[a]=(5-a%5)%5+5*((5-a/5)%5);for(int b=0;b<25;++b){
  add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  mul25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
 E one{};one[0]=1;E z{};z[1]=1;E roots[30];roots[0]=one;for(int j=1;j<=29;++j)roots[j]=mul(roots[j-1],z);assert(roots[29]==one);
 Six labels[116];int two[4]={1,2,4,3},three[4]={1,3,4,2};
 for(int i=0;i<4;++i)for(int j=0;j<29;++j)labels[29*i+j]={scale(roots[5*j%29],two[i]),scale(roots[5*j%29],three[i]),scale(roots[17*j%29],two[i]),scale(roots[17*j%29],three[i]),scale(roots[5*j%29],i%2?4:1),scale(roots[17*j%29],i%2?4:1)};
 std::ofstream out(argv[1]);assert(out);out<<"q0\tq1\tq2\tq3\n";uint64_t count=0,eligible=0,survivors=0;
 for(int a=0;a<116;++a)for(int b=a;b<116;++b)for(int c=b;c<116;++c){++count;Six s=plus(plus(labels[0],labels[a]),plus(labels[b],labels[c]));
  if(a%29==0&&b%29==0&&c%29==0)continue;
  E D=add(scale(mul(s.q,s.u),5),scale(mul(s.p,s.t),neg25[17]));if(zero(D))continue;++eligible;
  E vw=mul(s.v,s.w);
  E AB=add(add(scale(mul(mul(s.p,s.t),vw),9),scale(mul(mul(s.p,s.q),mul(s.w,s.w)),neg25[8])),
           add(scale(mul(mul(s.u,s.t),mul(s.v,s.v)),neg25[6]),scale(mul(mul(s.u,s.q),vw),10)));
  if(mul(D,D)==scale(AB,2)){++survivors;out<<0<<'\t'<<a<<'\t'<<b<<'\t'<<c<<'\n';}}
 assert(count==266916);std::cout<<"complete endpoints "<<count<<" eligible "<<eligible<<" reciprocal zero-character survivors "<<survivors<<std::endl;
}
