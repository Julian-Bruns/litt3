#pragma once
// Exact cubic extension K[q]/(q^3+f2*q^2+f1*q+f0), with q one root of a0.
#include "../../src/exact.hpp"
#include <filesystem>
#include <omp.h>
namespace KF {
inline std::vector<F> ad,ng;
inline F add(F a,F b){return ad[(a%625)*625+b%625]+625*ad[(a/625)*625+b/625];}
inline F neg(F a){return ng[a];}
inline F sub(F a,F b){return add(a,ng[b]);}
inline F mul(F a,F b){return a&&b?FF::ex[FF::lg[a]+FF::lg[b]]:0;}
inline void init(){init_curve();ad.resize(625*625);for(F a=0;a<625;a++)for(F b=0;b<625;b++)ad[a*625+b]=FF::add(a,b);ng.resize(FF::N);for(F a=0;a<FF::N;a++)ng[a]=FF::neg(a);}
}
struct E {
 F c[3]; E(F a=0,F b=0,F d=0):c{a,b,d}{}
 explicit operator bool()const{return c[0]||c[1]||c[2];}
 bool operator==(const E&b)const{return c[0]==b.c[0]&&c[1]==b.c[1]&&c[2]==b.c[2];}
 bool operator!=(const E&b)const{return !(*this==b);}
};
static_assert(sizeof(E)==12);
namespace EF {
inline const std::array<std::array<F,3>,2> factors{{{{219733,262411,63559}},{{288706,229183,188479}}}};
inline std::array<F,3> mod,rr,ss;
inline std::array<std::vector<F>,6> tab;
inline int factor_index=-1;
inline E add(const E&a,const E&b){return {KF::add(a.c[0],b.c[0]),KF::add(a.c[1],b.c[1]),KF::add(a.c[2],b.c[2])};}
inline E neg(const E&a){return {KF::neg(a.c[0]),KF::neg(a.c[1]),KF::neg(a.c[2])};}
inline E sub(const E&a,const E&b){return {KF::sub(a.c[0],b.c[0]),KF::sub(a.c[1],b.c[1]),KF::sub(a.c[2],b.c[2])};}
inline E scale(const E&a,F b){return {KF::mul(a.c[0],b),KF::mul(a.c[1],b),KF::mul(a.c[2],b)};}
inline E mul(const E&a,const E&b){
 F p0=KF::mul(a.c[0],b.c[0]),p1=KF::mul(a.c[1],b.c[1]),p2=KF::mul(a.c[2],b.c[2]);
 F p01=KF::sub(KF::sub(KF::mul(KF::add(a.c[0],a.c[1]),KF::add(b.c[0],b.c[1])),p0),p1);
 F p02=KF::sub(KF::sub(KF::mul(KF::add(a.c[0],a.c[2]),KF::add(b.c[0],b.c[2])),p0),p2);
 F p12=KF::sub(KF::sub(KF::mul(KF::add(a.c[1],a.c[2]),KF::add(b.c[1],b.c[2])),p1),p2);
 return {KF::add(p0,KF::add(tab[0][p12],tab[3][p2])),KF::add(p01,KF::add(tab[1][p12],tab[4][p2])),KF::add(KF::add(p02,p1),KF::add(tab[2][p12],tab[5][p2]))};
}
inline E times_q(const E&a){return {tab[0][a.c[2]],KF::add(a.c[0],tab[1][a.c[2]]),KF::add(a.c[1],tab[2][a.c[2]])};}
inline E inv(const E&a){if(!a)throw std::runtime_error("zero in cubic extension");E b=times_q(a),d=times_q(b);F u=KF::sub(KF::mul(b.c[1],d.c[2]),KF::mul(b.c[2],d.c[1]));F v=KF::sub(KF::mul(a.c[2],d.c[1]),KF::mul(a.c[1],d.c[2]));F z=KF::sub(KF::mul(a.c[1],b.c[2]),KF::mul(a.c[2],b.c[1]));F det=KF::add(KF::mul(a.c[0],u),KF::add(KF::mul(b.c[0],v),KF::mul(d.c[0],z)));return scale(E{u,v,z},FF::inv(det));}
inline E div(const E&a,const E&b){return mul(a,inv(b));}
inline E pow(E a,uint64_t n){E b{1};while(n){if(n&1)b=mul(b,a);n>>=1;if(n)a=mul(a,a);}return b;}
inline E rawmul(const E&a,const E&b){F c[5]{};for(int i=0;i<3;i++)for(int j=0;j<3;j++)c[i+j]=FF::add(c[i+j],FF::rawmul(a.c[i],b.c[j]));for(int i=4;i>=3;i--)for(int j=0;j<3;j++)c[i-3+j]=FF::sub(c[i-3+j],FF::rawmul(c[i],mod[j]));return E(c[0],c[1],c[2]);}
inline void init(int which){if(which<0||which>1)throw std::runtime_error("cubic factor index must be 0 or 1");KF::init();factor_index=which;mod=factors[which];for(int i=0;i<3;i++)rr[i]=KF::neg(mod[i]);ss[0]=KF::mul(rr[2],rr[0]);ss[1]=KF::add(rr[0],KF::mul(rr[2],rr[1]));ss[2]=KF::add(rr[1],KF::mul(rr[2],rr[2]));for(int i=0;i<6;i++){tab[i].resize(FF::N);F a=i<3?rr[i]:ss[i-3];for(F b=0;b<FF::N;b++)tab[i][b]=KF::mul(a,b);}}
inline void check(){E q(0,1);E v=add(pow(q,3),add(scale(pow(q,2),mod[2]),add(scale(q,mod[1]),E(mod[0]))));if(v)throw std::runtime_error("modulus check");E qn=pow(q,FF::N);if(qn==q||pow(q,uint64_t(FF::N)*FF::N*FF::N)!=q)throw std::runtime_error("cubic irreducibility/Frobenius check");std::mt19937 rng(92817+factor_index);for(int i=0;i<1500;i++){E a(rng()%FF::N,rng()%FF::N,rng()%FF::N),b(rng()%FF::N,rng()%FF::N,rng()%FF::N);if(mul(a,b)!=rawmul(a,b)||mul(a,inv(a))!=E(1))throw std::runtime_error("extension arithmetic comparison");}std::cout<<"PASS: cubic field/Frobenius and 1500 direct-reduction multiplication/inversion checks; factor="<<factor_index<<"\n"<<std::flush;}
inline void json(std::ostream&o,const E&a){o<<"["<<a.c[0]<<","<<a.c[1]<<","<<a.c[2]<<"]";}
}
// Multiplication by a fixed extension element, amortized over a polynomial row.
struct EMultiplier {
 F logs[3][3]; bool scalar; F slog;
 explicit EMultiplier(E a){scalar=!(a.c[1]||a.c[2]);slog=FF::lg[a.c[0]];E b=EF::times_q(a),d=EF::times_q(b);for(int i=0;i<3;i++){logs[i][0]=FF::lg[a.c[i]];logs[i][1]=FF::lg[b.c[i]];logs[i][2]=FF::lg[d.c[i]];}}
 E operator()(const E&b)const{F l[3]={FF::lg[b.c[0]],FF::lg[b.c[1]],FF::lg[b.c[2]]};E c;if(scalar){for(int i=0;i<3;i++)c.c[i]=(slog!=FF::M&&l[i]!=FF::M)?FF::ex[slog+l[i]]:0;return c;}for(int i=0;i<3;i++){F z[3];for(int j=0;j<3;j++)z[j]=(logs[i][j]!=FF::M&&l[j]!=FF::M)?FF::ex[logs[i][j]+l[j]]:0;c.c[i]=KF::add(z[0],KF::add(z[1],z[2]));}return c;}
};
inline E operator+(const E&a,const E&b){return EF::add(a,b);}inline E operator-(const E&a,const E&b){return EF::sub(a,b);}inline E operator-(const E&a){return EF::neg(a);}inline E operator*(const E&a,const E&b){return EF::mul(a,b);}
struct EP:std::vector<E>{using std::vector<E>::vector;EP(){};void trim(){while(!empty()&&!back())pop_back();}int deg()const{return int(size())-1;}E coef(int i)const{return i>=0&&i<int(size())?(*this)[i]:E();}};
inline EP pcon(E a){return a?EP{a}:EP{};}
inline EP operator+(const EP&a,const EP&b){EP c(std::max(a.size(),b.size()));for(int i=0;i<int(c.size());i++)c[i]=a.coef(i)+b.coef(i);c.trim();return c;}
inline EP operator-(const EP&a,const EP&b){EP c(std::max(a.size(),b.size()));for(int i=0;i<int(c.size());i++)c[i]=a.coef(i)-b.coef(i);c.trim();return c;}
inline EP escale(EP a,E b){for(auto&c:a)c=c*b;a.trim();return a;}
inline EP kscale(EP a,F b){for(auto&c:a)c=EF::scale(c,b);a.trim();return a;}
inline EP operator*(const EP&a,const EP&b){if(a.empty()||b.empty())return {};EP c(a.size()+b.size()-1);for(int i=0;i<int(a.size());i++)if(a[i]){EMultiplier times(a[i]);for(int j=0;j<int(b.size());j++)if(b[j])c[i+j]=c[i+j]+times(b[j]);}c.trim();return c;}
inline EP epower(EP a,unsigned n){EP b{E(1)};while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
inline E eeval(const EP&a,E x){E b;for(int i=a.deg();i>=0;i--)b=b*x+a[i];return b;}
inline E keval(const EP&a,F x){E b;for(int i=a.deg();i>=0;i--)b=EF::scale(b,x)+a[i];return b;}
inline std::pair<EP,EP> epdiv(EP a,const EP&b){if(b.empty())throw std::runtime_error("polynomial division by zero");EP q(std::max(0,a.deg()-b.deg()+1));E iv=EF::inv(b.back());for(int i=a.deg()-b.deg();i>=0;i--){E v=a[i+b.deg()]*iv;q[i]=v;if(v){EMultiplier times(v);for(int j=0;j<=b.deg();j++)a[i+j]=a[i+j]-times(b[j]);}}a.resize(std::min(a.size(),b.size()-1));a.trim();q.trim();return {q,a};}
inline EP erem(EP a,const EP&b){return epdiv(a,b).second;}
inline void json_ep(std::ostream&o,const EP&a){o<<"[";for(int i=0;i<int(a.size());i++){if(i)o<<",";EF::json(o,a[i]);}o<<"]";}
inline void write_ep(const std::string&path,const EP&a){std::ofstream o(path,std::ios::binary);o.write((const char*)a.data(),a.size()*sizeof(E));if(!o)throw std::runtime_error("write polynomial failed");}
inline EP read_ep(const std::string&path){size_t n=std::filesystem::file_size(path);if(n%sizeof(E))throw std::runtime_error("bad extension polynomial binary");EP p(n/sizeof(E));std::ifstream f(path,std::ios::binary);f.read((char*)p.data(),n);if(!f)throw std::runtime_error("read extension polynomial failed");p.trim();return p;}
