#pragma once
#include "fast_univariate.hpp"
using BP=UP;
static BP VF;
static BP VF_cache_modulus,VF_cache_inverse;
static BP br(const BP&a){if(a.size()<VF.size())return a;int n=a.size()-VF.size()+1;if(n<48||VF.size()<48)return udslow(a,VF).second;
 if(VF_cache_modulus!=VF){VF_cache_modulus=VF;VF_cache_inverse={};}if(int(VF_cache_inverse.size())<n){BP rev=VF;std::reverse(rev.begin(),rev.end());VF_cache_inverse=uinvseries(rev,std::max(n,int(VF.size())));VF_cache_inverse.resize(std::max(n,int(VF.size())));}
 BP ar=a;std::reverse(ar.begin(),ar.end());ar=utrunc(ar,n);BP q=utrunc(um(ar,utrunc(VF_cache_inverse,n)),n);q.resize(n);std::reverse(q.begin(),q.end());trim(q);BP rem=us(a,um(q,VF));if(rem.size()>=VF.size())throw std::runtime_error("cached finite reduction degree failure");return rem;}
static BP ba(const BP&a,const BP&b){return ua(a,b);}
static BP bn(const BP&a){return un(a);}
static BP bscl(const BP&a,U c){return uc(a,c);}
static BP bm(const BP&a,const BP&b){return br(um(a,b));}
static BP bi(const BP&a){if(a.empty())throw std::runtime_error("zero base inverse");auto z=VF.size()>128?uxgfast(a,VF):uxg(a,VF);if(z[0]!=UP{1})throw std::runtime_error("base modulus is not a field for this pivot");return br(z[1]);}
using SPoly=std::vector<BP>;
static void st(SPoly&a){while(!a.empty()&&a.back().empty())a.pop_back();}
static SPoly sa(SPoly a,const SPoly&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=ba(a[i],b[i]);st(a);return a;}
static SPoly sn(SPoly a){for(auto&x:a)x=bn(x);return a;}
static SPoly ss(SPoly a,const SPoly&b){return sa(a,sn(b));}
static SPoly sc(SPoly a,const BP&b){for(auto&x:a)x=bm(x,b);st(a);return a;}
static SPoly sm(const SPoly&a,const SPoly&b){if(a.empty()||b.empty())return{};SPoly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(!a[i].empty())for(size_t j=0;j<b.size();j++)if(!b[j].empty())c[i+j]=ba(c[i+j],bm(a[i],b[j]));st(c);return c;}
static std::pair<SPoly,SPoly> sd(SPoly a,const SPoly&b){if(b.empty())throw std::runtime_error("zero S divisor");st(a);SPoly q(a.size()>=b.size()?a.size()-b.size()+1:0);BP ib=b.back()==BP{1}?BP{1}:bi(b.back());while(a.size()>=b.size()){int sh=a.size()-b.size();BP c=bm(a.back(),ib);q[sh]=c;for(size_t j=0;j<b.size();j++)a[j+sh]=ba(a[j+sh],bn(bm(c,b[j])));st(a);}st(q);return{q,a};}
static SPoly sr(const SPoly&a,const SPoly&b){return sd(a,b).second;}
static SPoly sx(const SPoly&a,const SPoly&b){auto[q,r]=sd(a,b);if(!r.empty())throw std::runtime_error("nonexact S division");return q;}
static SPoly sg(SPoly a,SPoly b){while(!b.empty()){SPoly r=sr(a,b);a=std::move(b);b=std::move(r);}return a.empty()?a:sc(a,bi(a.back()));}
static std::array<SPoly,3> sxg(SPoly a,SPoly b){SPoly u={{1}},v={},s={},t={{1}};while(!b.empty()){auto[q,r]=sd(a,b);a=std::move(b);b=std::move(r);SPoly w=ss(u,sm(q,s));u=std::move(s);s=std::move(w);w=ss(v,sm(q,t));v=std::move(t);t=std::move(w);}if(a.empty())return{a,u,v};BP iv=bi(a.back());return{sc(a,iv),sc(u,iv),sc(v,iv)};}
static SPoly spmod(SPoly a,int n,const SPoly&f){SPoly b={{1}};while(n){if(n&1)b=sr(sm(a,b),f);n>>=1;if(n)a=sr(sm(a,a),f);}return b;}
static SPoly SF;
struct EA {SPoly n;EA(){}EA(U c){if(c)n={{c}};}explicit EA(BP p){p=br(p);if(!p.empty())n={p};}explicit EA(SPoly a):n(sr(a,SF)){}bool zero()const{return n.empty();}};
static EA operator+(EA a,const EA&b){a.n=sa(a.n,b.n);return a;}
static EA operator-(EA a,const EA&b){a.n=ss(a.n,b.n);return a;}
static EA operator*(const EA&a,const EA&b){return EA(sm(a.n,b.n));}
static EA scale(EA a,U c){for(auto&p:a.n)p=uc(p,c);st(a.n);return a;}
static EA powe(EA a,int n){EA b(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
static EA einverse(const EA&a){auto z=sxg(a.n,SF);if(z[0]!=SPoly{{1}})throw std::runtime_error("nonunit in finite curve algebra");EA b(z[1]);if(!(a*b-EA(1)).zero())throw std::runtime_error("finite inverse product failed");return b;}
static std::array<EA,2> unit_tails(const EA&a,const EA&b){auto z=sxg(a.n,SF);auto w=sxg(z[0],b.n);if(w[0]!=SPoly{{1}})throw std::runtime_error("square tails have a nontrivial common zero");EA u(sm(w[1],z[1])),v(w[2]);if(!(a*u+b*v-EA(1)).zero())throw std::runtime_error("tail Bezout mismatch");return{u,v};}
static constexpr int FP=73;
using ES=std::vector<EA>;
static ES esmul(const ES&a,const ES&b){ES c(FP);for(int i=0;i<int(a.size());i++)if(!a[i].zero())for(int j=0;i+j<FP&&j<int(b.size());j++)if(!b[j].zero())c[i+j]=c[i+j]+a[i]*b[j];return c;}
static ES essq(const ES&a){ES c(FP);for(int i=0;i<int(a.size());i++)if(!a[i].zero()){if(2*i<FP)c[2*i]=c[2*i]+a[i]*a[i];for(int j=i+1;i+j<FP&&j<int(a.size());j++)if(!a[j].zero())c[i+j]=c[i+j]+scale(a[i]*a[j],2);}return c;}
static ES esa(ES a,const ES&b){for(int i=0;i<FP;i++)a[i]=a[i]+b[i];return a;}
static ES esc(ES a,U c){for(auto&x:a)x=scale(x,c);return a;}
static ES esh(const ES&a,int n){ES b(FP);for(int i=0;i+n<FP;i++)b[i+n]=a[i];return b;}
static ES esp(const ES&a,const UP&p,const EA&c){ES b(FP);for(int i=0;i<FP;i++){EA t;for(int j=0;j<=i&&j<int(p.size());j++)t=t+scale(a[i-j],p[j]);b[i]=t*c;}return b;}
static ES esf(const ES&a,int n){ES b(FP);for(int i=0;i*n<FP&&i<int(a.size());i++)b[i*n]=powe(a[i],n);return b;}
static ES sqrt_rec(const ES&u){ES r(FP);r[0]=EA(1);for(int n=1;n<FP;n++){EA t;for(int i=1;2*i<n;i++)t=t+scale(r[i]*r[n-i],2);if(n%2==0)t=t+r[n/2]*r[n/2];r[n]=scale(u[n]-t,3);}return r;}
static void outup(std::ostream&o,const UP&p){o<<p.size();for(U c:p)o<<" "<<c;o<<"\n";}
static UP inup(std::istream&i){int n;i>>n;UP p(n);for(U&c:p)i>>c;if(!i)throw std::runtime_error("bad polynomial input");return p;}
static void outsp(std::ostream&o,const std::string&name,const SPoly&p){o<<name<<" "<<p.size()<<"\n";for(auto&x:p)outup(o,x);}
static SPoly insp(std::istream&i,std::string&name){int n;i>>name>>n;SPoly a(n);for(auto&p:a)p=inup(i);return a;}
