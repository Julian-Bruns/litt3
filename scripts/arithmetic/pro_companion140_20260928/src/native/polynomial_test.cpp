#define main companion_main
#include "companion.cpp"
#undef main
#include "polynomial_tools.hpp"
int main(int argc,char**argv){assert(argc==2);init(argv[1]);setup_rational();
 for(auto[n,m]:std::vector<std::pair<int,int>>{{120,47},{256,119},{1024,515},{4096,2024}}){
  std::vector<F>b(m+1),q(n-m+1),r(m);for(auto*p:{&b,&q,&r})for(auto&v:*p)v=factor_random();b.back()=1;q.back()=1;FP B(b),Q(q),R(r),A=B*Q+R;auto[qq,rr]=fast_divide(A,B);assert(qq==Q&&rr==R);
  std::cout<<"{\"fast_division_degrees\":["<<n<<','<<m<<"],\"known_quotient_remainder\":\"PASS\"}"<<std::endl;
 }
 for(int k=0;k<5;k++){
  auto fs=factor_squarefree(Rat::factors[k]);FP prod(1);std::cout<<"{\"pole_index\":"<<k<<",\"factor_degrees\":[";for(size_t i=0;i<fs.size();i++){if(i)std::cout<<',';std::cout<<fs[i].deg();prod*=fs[i];Valuation va(fs[i]);FP t=fs[i].pow(127)*FP(std::vector<F>{3,1});auto[e,q]=va.remove(t);assert(e>=127&&fs[i].pow(e)*q==t);}std::cout<<"],\"factorization_and_valuations\":\"PASS\"}"<<std::endl;assert(prod==Rat::factors[k]);
 }
 // The two Sylvester matchings for constant coefficient weights are exact.
 for(int m:{2,4,53})for(int n:{2,5,54}){std::vector<int>f(m+1,3),g(n+1,-7);assert(resultant_lower_valuation(f,g)==3*n-7*m);}
 std::cout<<"{\"tropical_Sylvester_constant_weight_checks\":\"PASS\"}"<<std::endl;
}
