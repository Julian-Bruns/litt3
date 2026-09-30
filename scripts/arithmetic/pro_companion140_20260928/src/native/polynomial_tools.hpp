#ifndef COMPANION_POLYNOMIAL_TOOLS_HPP
#define COMPANION_POLYNOMIAL_TOOLS_HPP
#include "algebra.hpp"
#include <boost/multiprecision/cpp_int.hpp>
namespace comp {
using boost::multiprecision::cpp_int;
inline FP trunc(const FP&a,int n){std::vector<F>v(a.c.begin(),a.c.begin()+std::min(n,(int)a.c.size()));return FP(v);}
inline FP rev(const FP&a,int n){std::vector<F>v(n);for(int i=0;i<n;i++)v[i]=a[n-1-i];return FP(v);}
inline std::pair<FP,FP> fast_divide(const FP&a,const FP&b){
 if(!b)throw std::runtime_error("fast polynomial division by zero");int n=a.deg()-b.deg()+1;
 if(n<=32||b.deg()<32)return a.divmod(b);
 FP rb=rev(b,b.deg()+1),ra=trunc(rev(a,a.deg()+1),n),g(rb[0].inverse());
 for(int len=1;len<n;){int m=std::min(2*len,n);g=trunc(g*(FP(2)-trunc(trunc(rb,m)*g,m)),m);len=m;}
 FP q=rev(trunc(ra*g,n),n),r=a-b*q;if(r.deg()>=b.deg())throw std::runtime_error("Newton division identity failed");return {q,r};
}
inline FP mod_fast(const FP&a,const FP&m){return fast_divide(a,m).second;}
inline FP exact_fast(const FP&a,const FP&b){auto[q,r]=fast_divide(a,b);if(r)throw std::runtime_error("inexact fast polynomial division");return q;}
inline FP gcd_fast(FP a,FP b){while(b){auto r=mod_fast(a,b);a=std::move(b);b=std::move(r);}return a.monic();}
inline FP power_mod(FP a,cpp_int e,const FP&f){FP z(1);while(e!=0){if(bool(e&1))z=mod_fast(z*a,f);e>>=1;if(e!=0)a=mod_fast(a*a,f);}return z;}
inline FP frob_K(FP a,const FP&f){for(int j=0;j<8;j++)a=mod_fast(a.fifth(),f);return a;}
inline FP derivative(const FP&a){std::vector<F>z(std::max(0,a.deg()));for(int i=1;i<=a.deg();i++)z[i-1]=a[i]*F(i%5);return FP(z);}
inline bool irreducible(const FP&f){
 int d=f.deg();if(d<1)return false;FP x(std::vector<F>{0,1}),h=x;
 std::vector<int>checks;int rem=d;for(int p=2;p*p<=rem;p++)if(rem%p==0){checks.push_back(d/p);while(rem%p==0)rem/=p;}if(rem>1)checks.push_back(d/rem);
 for(int i=1;i<=d;i++){h=frob_K(h,f);if(std::find(checks.begin(),checks.end(),i)!=checks.end()&&gcd_fast(f,h-x).deg()!=0)return false;}
 return !mod_fast(h-x,f);
}
inline uint64_t factor_state=819731838119;
inline F factor_random(){factor_state^=factor_state<<13;factor_state^=factor_state>>7;factor_state^=factor_state<<17;return F(factor_state%F::N);}
inline void equal_factor(const FP&f,int d,std::vector<FP>&out){
 if(f.deg()==d){assert(irreducible(f));out.push_back(f.monic());return;}
 cpp_int e=1;for(int j=0;j<d;j++)e*=F::N;e=(e-1)/2;
 for(int attempt=0;attempt<1000;attempt++){
  std::vector<F>v(f.deg());for(auto&z:v)z=factor_random();FP a(v),g=gcd_fast(f,power_mod(a,e,f)-FP(1));
  if(g.deg()>0&&g.deg()<f.deg()){equal_factor(g,d,out);equal_factor(exact_fast(f,g),d,out);return;}
 }
 throw std::runtime_error("deterministic equal-degree split attempts exhausted");
}
inline std::vector<FP> factor_squarefree(FP f){
 f=f.monic();if(gcd_fast(f,derivative(f)).deg()!=0)throw std::runtime_error("factorization requires squarefree polynomial");
 FP original=f,x(std::vector<F>{0,1}),h=x;std::vector<FP>out;
 for(int d=1;2*d<=f.deg();d++){
  h=frob_K(h,f);FP g=gcd_fast(f,h-x);if(g.deg()>0){equal_factor(g,d,out);f=exact_fast(f,g);h=mod_fast(h,f);}
 }
 if(f.deg()>0){assert(irreducible(f));out.push_back(f.monic());}
 std::sort(out.begin(),out.end(),[](const FP&a,const FP&b){if(a.deg()!=b.deg())return a.deg()<b.deg();for(int i=a.deg();i>=0;i--)if(a[i].v!=b[i].v)return a[i].v<b[i].v;return false;});
 FP prod(1);for(auto&p:out)prod*=p;assert(prod==original);return out;
}
struct Valuation {
 FP f;std::vector<FP> binary,reciprocal;int reciprocal_length=0;
 explicit Valuation(FP ff):f(ff.monic()),binary{f}{}
 void prepare(int maxdegree){
  while(binary.back().deg()<=maxdegree/2)binary.push_back(binary.back()*binary.back());
  reciprocal_length=maxdegree+1;FP rb=rev(f,f.deg()+1),g(rb[0].inverse());
  for(int len=1;len<reciprocal_length;){int m=std::min(2*len,reciprocal_length);g=trunc(g*(FP(2)-trunc(trunc(rb,m)*g,m)),m);len=m;}
  reciprocal={g};while(reciprocal.size()<binary.size())reciprocal.push_back(trunc(reciprocal.back()*reciprocal.back(),reciprocal_length));
 }
 std::pair<FP,FP> divide_power(const FP&a,int j){
  const FP&b=binary[j];int n=a.deg()-b.deg()+1;if(n<=32||b.deg()<32||j>=(int)reciprocal.size()||n>reciprocal_length)return fast_divide(a,b);
  FP q=rev(trunc(trunc(rev(a,a.deg()+1),n)*trunc(reciprocal[j],n),n),n),r=a-b*q;
  if(r.deg()>=b.deg())throw std::runtime_error("cached reciprocal division identity failed");return {q,r};
 }
 // Return exact f-order and quotient. Infinity is represented by 10^8 for zero.
 std::pair<int,FP> remove(FP a){
  if(!a)return {100000000,a};int limit=a.deg()/f.deg();if(limit==0)return {0,a};
  if(a.mod(f))return {0,a};
  int high=0;while((uint64_t(1)<<(high+1))<=uint64_t(limit))high++;
  while((int)binary.size()<=high)binary.push_back(binary.back()*binary.back());
  int v=0;for(int j=high;j>=0;j--)if(a.deg()>=binary[j].deg()){
   auto[q,r]=divide_power(a,j);if(!r){a=std::move(q);v+=1<<j;}
  }
  return {v,a};
 }
 int order(FP a){return remove(std::move(a)).first;}
};
// Integer Hungarian algorithm. Forbidden entries use +/-INF according to sense.
inline long long assignment_min(const std::vector<std::vector<long long>>&a,std::vector<long long>*rows=nullptr,std::vector<long long>*cols=nullptr){
 int n=a.size();const long long INF=1LL<<55;std::vector<long long>u(n+1),v(n+1);std::vector<int>p(n+1),way(n+1);
 for(int i=1;i<=n;i++){
  p[0]=i;int j0=0;std::vector<long long>minv(n+1,INF);std::vector<char>used(n+1,false);
  do{
   used[j0]=true;int i0=p[j0],j1=0;long long delta=INF;
   for(int j=1;j<=n;j++)if(!used[j]){long long cur=a[i0-1][j-1]-u[i0]-v[j];if(cur<minv[j]){minv[j]=cur;way[j]=j0;}if(minv[j]<delta){delta=minv[j];j1=j;}}
   if(delta>=INF/4)throw std::runtime_error("no finite determinant matching");
   for(int j=0;j<=n;j++)if(used[j]){u[p[j]]+=delta;v[j]-=delta;}else minv[j]-=delta;
   j0=j1;
  }while(p[j0]);
  do{int j1=way[j0];p[j0]=p[j1];j0=j1;}while(j0);
 }
 long long dual=0,primal=0;for(int i=1;i<=n;i++)dual+=u[i]+v[i];
 for(int j=1;j<=n;j++)primal+=a[p[j]-1][j-1];
 for(int i=1;i<=n;i++)for(int j=1;j<=n;j++)if(u[i]+v[j]>a[i-1][j-1])throw std::runtime_error("infeasible Sylvester valuation dual");
 if(primal!=dual||dual!=-v[0])throw std::runtime_error("Sylvester valuation primal/dual mismatch");
 if(rows)*rows=std::vector<long long>(u.begin()+1,u.end());if(cols)*cols=std::vector<long long>(v.begin()+1,v.end());
 return dual;
}
inline long long resultant_lower_valuation(const std::vector<int>&f,const std::vector<int>&g,std::vector<long long>*rows=nullptr,std::vector<long long>*cols=nullptr){
 int m=f.size()-1,n=g.size()-1;const long long INF=1LL<<54;std::vector<std::vector<long long>>a(m+n,std::vector<long long>(m+n,INF));
 for(int i=0;i<n;i++)for(int j=0;j<=m;j++)if(f[j]<100000000)a[i][i+m-j]=f[j];
 for(int i=0;i<m;i++)for(int j=0;j<=n;j++)if(g[j]<100000000)a[n+i][i+n-j]=g[j];
 return assignment_min(a,rows,cols);
}
}
#endif
