#pragma once
#include "laurent.hpp"
inline PSource load_chart(){std::ifstream in("evidence/chart.txt");if(!in)throw std::runtime_error("missing chart");PSource ps;for(auto&c:ps)for(auto&p:c){size_t n;in>>n;p.resize(n);for(auto&v:p){size_t m;in>>m;for(size_t i=0;i<m;i++){int h,w;F a;in>>h>>w>>a;v=v+lm(h,w,0,0,a);}}}return ps;}
inline Curve ctimes(const Curve&a,const Poly&p){return a*Curve(p);}
inline Source barred(const Source&G){Source g;g[0]=div_y(G[0],2);g[1]=div_y(G[1]-ctimes(scale(G[0],3),B0),3);g[2]=div_y(G[2]-ctimes(scale(G[1],2),B0)+ctimes(scale(G[0],3),power(B0,2)),4);g[3]=div_y(G[3]-ctimes(G[2],B0)+ctimes(G[1],power(B0,2))-ctimes(G[0],power(B0,3)),5);return g;}
inline std::array<Curve,3> universal_resultant(const Curve&a,const Curve&b,const Curve&c,const Curve&d,const Curve&q,const Curve&C){
Curve a2=power(a,2),a3=a2*a,a4=a2*a2,a5=a4*a,b2=power(b,2),b3=b2*b,b4=b2*b2,b5=b4*b,c2=power(c,2),c3=c2*c,c4=c2*c2,c5=c4*c;
Curve E=a*d-b*c,Delta=b2+a*c,T0=c5-q*b5+power(q,2)*a5,U0=scale(q*a5,2)-b5;
Curve V0=-(d*b5)-scale(c2*b4,2)-scale(a*b2*c3,3)-scale(a2*c4,2)+q*(scale(a5*d,2)-a4*b*c+a3*b3);
Curve W0=a2*power(d,2)-a*b*c*d+scale(b2*c2,2)+b3*d+a*c3;
Curve M0=U0*(scale(a*E,2)+b*Delta)-a2*V0;
return {a3*(T0*W0+C*M0)+power(C,2)*power(a,10),T0*V0+C*(power(U0,2)-scale(a5*T0,2)),power(T0,2)};
}
// Polynomial in lambda whose coefficients are polynomials in x.
using BiPoly=std::vector<Poly>;
inline BiPoly badd(const BiPoly&a,const BiPoly&b){BiPoly c(std::max(a.size(),b.size()));for(size_t i=0;i<c.size();i++)c[i]=(i<a.size()?a[i]:Poly{})+(i<b.size()?b[i]:Poly{});return c;}
inline BiPoly bscale(BiPoly a,F b){for(auto&p:a)p=scale(p,b);return a;}
inline BiPoly bxmul(BiPoly a,const Poly&b){for(auto&p:a)p=p*b;return a;}
inline BiPoly bmul(const BiPoly&a,const BiPoly&b){BiPoly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=c[i+j]+a[i]*b[j];return c;}
inline BiPoly bpow(BiPoly a,unsigned n){BiPoly b{Poly{1}};while(n){if(n&1)b=bmul(b,a);n>>=1;if(n)a=bmul(a,a);}return b;}
inline BiPoly residual_all_scales(const Source&G){auto g=barred(G);Curve qb=cm(0,1)*Curve(exactdiv(Q-power(B0,5),power(P,2)));auto D=universal_resultant(scale(g[0],3),scale(g[1],2),g[2],g[3],qb,Curve(power(t,3)));
std::array<BiPoly,3> B;for(int j=0;j<3;j++)for(auto&d:D)B[j].push_back(d[j]);
BiPoly R=badd(badd(bpow(B[0],3),bxmul(bpow(B[1],3),P)),badd(bxmul(bpow(B[2],3),power(P,2)),bscale(bxmul(bmul(bmul(B[0],B[1]),B[2]),P),2)));
Poly t15=power(t,15);for(auto&r:R)r=exactdiv(r,t15);return R;}
inline Poly specialize_scale(const BiPoly&R,F l){Poly r;for(int j=int(R.size())-1;j>=0;j--)r=scale(r,l)+R[j];return r;}
inline std::tuple<Poly,Poly,Poly> xgcd(Poly a,Poly b){Poly u{1},v{},s{},z{1};while(!b.empty()){auto[q,r]=divrem(a,b);a=b;b=r;auto uu=u-q*s,vv=v-q*z;u=s;v=z;s=uu;z=vv;}if(a.empty())return {a,u,v};F iv=FF::inv(a.back());return {scale(a,iv),scale(u,iv),scale(v,iv)};}
inline F expected_lead(F h,F w){F eps=FF::add(24,FF::add(FF::mul(4,25),FF::mul(23,FF::pow(25,3))));F q=FF::pow(w,3),H=FF::mul(h,w);Poly a0{89654,311173,214299,163299,315361,33043,356725,245794};F psi=FF::add(eval(a0,q),FF::mul(H,FF::mul(q,FF::add(299833,FF::mul(232505,q)))));F f6=FF::div(psi,FF::mul(q,FF::pow(299619,2)));return FF::pow(FF::mul(3,FF::mul(FF::pow(h,3),FF::mul(FF::pow(eps,8),f6))),3);}
inline bool allowed(F h,F w){F q=FF::pow(w,3);return h&&w&&q!=1&&q!=15383&&expected_lead(h,w);}
inline F det(std::vector<std::vector<F>>a){F d=1;for(size_t i=0;i<a.size();i++){size_t j=i;while(j<a.size()&&!a[j][i])j++;if(j==a.size())return 0;if(j!=i){std::swap(a[j],a[i]);d=FF::neg(d);}F p=a[i][i];d=FF::mul(d,p);F iv=FF::inv(p);for(size_t j=i+1;j<a.size();j++){F m=FF::mul(a[j][i],iv);for(size_t k=i;k<a.size();k++)a[j][k]=FF::sub(a[j][k],FF::mul(m,a[i][k]));}}return d;}
inline F fixed_resultant(const Poly&f,const Poly&g,int m,int n){if(f.deg()>m||g.deg()>n)throw std::runtime_error("wrong fixed resultant degrees");std::vector<std::vector<F>>a(m+n,std::vector<F>(m+n));for(int i=0;i<n;i++)for(int j=0;j<=m;j++)a[i][i+j]=f.coef(m-j);for(int i=0;i<m;i++)for(int j=0;j<=n;j++)a[n+i][i+j]=g.coef(n-j);return det(a);}
inline F eval_curve(const Curve&a,F x,F y){return FF::add(eval(a[0],x),FF::add(FF::mul(y,eval(a[1],x)),FF::mul(FF::pow(y,2),eval(a[2],x))));}
