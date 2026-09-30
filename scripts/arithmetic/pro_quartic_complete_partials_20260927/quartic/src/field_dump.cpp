#include "fast_field.hpp"
#include <random>
using namespace exact;
void pk(K v){std::cout<<'['<<v.a<<','<<v.b<<']';}
void pf(F v){std::cout<<'[';for(int j=0;j<4;++j){if(j)std::cout<<',';pk(v.c[j]);}std::cout<<']';}
int main(){
 init();init_labels();std::mt19937 rng(20260926);
 for(int j=0;j<10000;++j){int a=rng()%q,b=rng()%q;if(mul(a,b)!=raw_mul(a,b)||add(a,b)!=raw_add(a,b))throw std::runtime_error("log/add self test failed");}
 std::cout<<"{\"primitive\":"<<primitive<<",\"raw_field_checks\":10000,\"samples\":[";
 for(int n=0;n<8;++n){
  K a(rng()%q,rng()%q),b(rng()%q,rng()%q);
  std::array<int,4> ix;for(int&v:ix)v=rng()%116;std::sort(ix.begin(),ix.end());auto R=endpoint(ix);
  if(n)std::cout<<',';std::cout<<"{\"a\":";pk(a);std::cout<<",\"b\":";pk(b);std::cout<<",\"product\":";pk(a*b);std::cout<<",\"frob7\":";pk(a.frob(7));std::cout<<",\"Q\":";print_ix(ix,std::cout);std::cout<<",\"traces\":[";
  for(int h=0;h<4;++h){if(h)std::cout<<',';pf(R[h]);}std::cout<<"]}";
 }
 std::cout<<"]}\n";
}
