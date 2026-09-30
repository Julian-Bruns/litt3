#include "jets.hpp"
#include <chrono>
using namespace comp;
uint64_t state=8307138129;
F rnd(){state^=state<<13;state^=state>>7;state^=state<<17;return F(state%F::N);}
template<class T>T random_scalar(){if constexpr(std::is_same_v<T,F2>)return F2(rnd(),rnd());else return rnd();}
template<class J>J determinant_permutations(const std::vector<std::vector<J>>&a){int n=a.size();std::vector<int>p(n);for(int i=0;i<n;i++)p[i]=i;J z;do{int inv=0;J x(1);for(int i=0;i<n;i++){x*=a[i][p[i]];for(int j=i+1;j<n;j++)inv+=p[i]>p[j];}z+=inv%2?-x:x;}while(std::next_permutation(p.begin(),p.end()));return z;}
template<class T>void check(){using J=Jet<T>;for(jet_order=1;jet_order<=8;jet_order++){
 for(int rep=0;rep<20;rep++){
  int n=1+rep%5;std::vector<std::vector<J>>a(n,std::vector<J>(n));for(auto&r:a)for(auto&v:r)for(int i=0;i<jet_order;i++)v.c[i]=random_scalar<T>();if(rep%3==0)for(auto&r:a)for(auto&v:r)v.c[0]=T(0);
  auto expected=determinant_permutations(a);assert(berkowitz_det(a)==expected&&determinant_local(a)==expected);
 }
 for(auto[m,n]:std::vector<std::pair<int,int>>{{3,4},{10,11},{53,54}}){
  std::vector<J>a(m),b(n);for(auto*p:{&a,&b})for(auto&v:*p)for(int i=0;i<jet_order;i++)v.c[i]=random_scalar<T>();if(jet_order>=2){b[0].c[0]=a[0].c[0];if(jet_order>=4){b[1].c[0]=a[1].c[0];b[2].c[0]=a[2].c[0];}}
  Poly<J>f(1),g(1);for(auto&v:a)f*=Poly<J>(std::vector<J>{-v,J(1)});for(auto&v:b)g*=Poly<J>(std::vector<J>{-v,J(1)});J expected(1);for(auto&x:a)for(auto&y:b)expected*=x-y;assert(resultant_jet(f,g,m,n)==expected);
 }
 // Fixed (2,2), with leading coefficients zero only in the residue field.
 for(int rep=0;rep<8;rep++){std::vector<J>f(3),g(3);for(auto*p:{&f,&g})for(auto&v:*p)for(int i=0;i<jet_order;i++)v.c[i]=random_scalar<T>();f[2].c[0]=T(0);if(rep%2)g[2].c[0]=T(0);Poly<J>F(f),G(g);std::vector<std::vector<J>>s(4,std::vector<J>(4));for(int i=0;i<2;i++)for(int j=0;j<3;j++){s[i][i+2-j]=f[j];s[i+2][i+2-j]=g[j];}assert(resultant_jet(F,G,2,2)==determinant_permutations(s));}
 std::cout<<"{\"jet_order\":"<<jet_order<<",\"determinants_factored_resultants_and_degree_drops\":\"PASS\"}"<<std::endl;
}}
int main(){F::init();check<F>();F2::parameter=F(25);assert(F::logs[F2::parameter.v]%2==1);check<F2>();std::cout<<"{\"jet_arithmetic\":\"PASS\",\"fallbacks\":"<<jet_fallbacks<<"}"<<std::endl;}
