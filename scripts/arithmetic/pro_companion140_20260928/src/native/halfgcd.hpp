#ifndef COMPANION_HALFGCD_HPP
#define COMPANION_HALFGCD_HPP
#include "polynomial_tools.hpp"
namespace comp {
inline FP high_part(const FP&a,int k){assert(k>=0);if(k>a.deg())return FP();return FP(std::vector<F>(a.c.begin()+k,a.c.end()));}
struct PMat {
 FP a{1},b,c,d{1};
 PMat()=default;
 PMat(FP aa,FP bb,FP cc,FP dd):a(std::move(aa)),b(std::move(bb)),c(std::move(cc)),d(std::move(dd)){}
 std::pair<FP,FP> apply(const FP&x,const FP&y)const{
 FP xx,yy;
 #pragma omp parallel sections if(std::max(x.deg(),y.deg())>=4096)
 {
 #pragma omp section
 xx=a*x+b*y;
 #pragma omp section
 yy=c*x+d*y;
 }
 return {xx,yy};
 }
 friend PMat operator*(const PMat&A,const PMat&B){
 FP a,b,c,d;
 #pragma omp parallel sections if(std::max(A.a.deg(),B.a.deg())>=2048)
 {
 #pragma omp section
 a=A.a*B.a+A.b*B.c;
 #pragma omp section
 b=A.a*B.b+A.b*B.d;
 #pragma omp section
 c=A.c*B.a+A.d*B.c;
 #pragma omp section
 d=A.c*B.b+A.d*B.d;
 }
 return PMat(std::move(a),std::move(b),std::move(c),std::move(d));
 }
 void step(const FP&q){FP aa=c,bb=d,cc=a-q*c,dd=b-q*d;a=std::move(aa);b=std::move(bb);c=std::move(cc);d=std::move(dd);}
};
inline uint64_t hgcd_calls=0,hgcd_fallbacks=0;
inline PMat halfgcd(const FP&a,const FP&b){
 hgcd_calls++;assert(a.deg()>b.deg());int n=a.deg(),m=(n+1)/2;if(!b||b.deg()<m)return PMat();
 if(n<=48){FP c=a,d=b;PMat R;while(d&&d.deg()>=m){auto[q,e]=fast_divide(c,d);R.step(q);c=std::move(d);d=std::move(e);}return R;}
 PMat R=halfgcd(high_part(a,m),high_part(b,m));auto[c,d]=R.apply(a,b);
 if(!d||d.deg()<m)return R;
 if(c.deg()<=d.deg()||c.deg()>a.deg())throw std::runtime_error("half-gcd high-half reduction invariant failed");
 auto[q,e]=fast_divide(c,d);R.step(q);if(!e||e.deg()<m)return R;
 int k=2*m-d.deg();if(k<0)throw std::runtime_error("negative half-gcd second truncation");
 PMat S=halfgcd(high_part(d,k),high_part(e,k));R=S*R;
 return R;
}
inline std::tuple<FP,FP,FP> xgcd_half(FP a,FP b,bool progress=false){
 FP original_a=a,original_b=b;std::vector<PMat>steps;
 if(a.deg()<b.deg()){std::swap(a,b);steps.emplace_back(FP(),FP(1),FP(1),FP());}
 if(a&&b&&a.deg()==b.deg()){auto[q,r]=fast_divide(a,b);PMat M;M.step(q);steps.push_back(std::move(M));a=std::move(b);b=std::move(r);}
 while(b){
  if(progress)std::cout<<"{\"half_gcd_degrees\":["<<a.deg()<<','<<b.deg()<<"]}"<<std::endl;
  int old=a.deg();PMat M=halfgcd(a,b);auto[c,d]=M.apply(a,b);if(c.deg()>old||d.deg()>=(old+1)/2)throw std::runtime_error("half-gcd failed target degree bound");
  if(d){auto[q,e]=fast_divide(c,d);M.step(q);c=std::move(d);d=std::move(e);}
  steps.push_back(std::move(M));a=std::move(c);b=std::move(d);
 }
 if(!a)return {a,FP(),FP()};F inv=a.c.back().inverse();FP u(inv),v;
 for(int i=int(steps.size())-1;i>=0;i--){FP uu=u*steps[i].a+v*steps[i].c,vv=u*steps[i].b+v*steps[i].d;u=std::move(uu);v=std::move(vv);}
 a=a.scale(inv);
 if(u*original_a+v*original_b!=a)throw std::runtime_error("large polynomial Bezout identity failed");
 if(mod_fast(original_a,a)||mod_fast(original_b,a))throw std::runtime_error("large polynomial gcd divisibility failed");
 return {a,u,v};
}
// Exact division by f(q)^(5^j), exploiting its sparse support in characteristic 5.
inline std::pair<FP,FP> frobenius_divide(const FP&a,const FP&f,int power){
 assert(power>=1);int degree=f.deg()*power;FP r=a,q;if(r.deg()<degree)return {q,r};
 q.c.resize(r.deg()-degree+1);std::vector<F>coeff=f.c;for(auto&x:coeff)x=x.pow(power);F inv=coeff.back().inverse();
 while(r&&r.deg()>=degree){int off=r.deg()-degree;F v=r.c.back()*inv;q.c[off]=v;for(int j=0;j<=f.deg();j++)r.c[off+j*power]-=v*coeff[j];r.trim();}
 q.trim();return {q,r};
}
inline std::pair<int,FP> remove_frobenius(FP a,const FP&f){
 if(!a)throw std::runtime_error("valuation of zero projected polynomial");if(f.deg()<1)throw std::runtime_error("constant valuation factor");
 if(frobenius_divide(a,f,1).second)return {0,std::move(a)};
 int high=1;while(high<=a.deg()/f.deg()/5)high*=5;int v=0;
 for(int p=high;p>=1;p/=5){for(int j=0;j<4&&a.deg()>=f.deg()*p;j++){auto[q,r]=frobenius_divide(a,f,p);if(r)break;a=std::move(q);v+=p;}}
 return {v,a};
}
}
#endif
