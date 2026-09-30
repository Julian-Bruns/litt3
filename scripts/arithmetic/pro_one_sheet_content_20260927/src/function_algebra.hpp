#pragma once
#include "field.cpp"
#include <array>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <chrono>
#include <atomic>
using UP=std::vector<U>;
static void trim(UP&a){while(!a.empty()&&!a.back())a.pop_back();}
static UP cn(U c){return c?UP{c}:UP{};}
static UP ua(UP a,const UP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=kadd(a[i],b[i]);trim(a);return a;}
static UP un(UP a){for(U&c:a)c=kneg(c);return a;}
static UP us(UP a,const UP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=kadd(a[i],kneg(b[i]));trim(a);return a;}
static UP uc(UP a,U c){if(!c)return{};if(c==1)return a;for(U&v:a)v=kmul(v,c);trim(a);return a;}
static UP ush(const UP&a,int n){if(a.empty())return{};assert(n>=0);UP b(n);b.insert(b.end(),a.begin(),a.end());return b;}
static UP ucut(const UP&a,int lo,int hi){hi=std::min(hi,int(a.size()));if(lo>=hi)return{};UP b(a.begin()+lo,a.begin()+hi);trim(b);return b;}
static void accum(UP&a,const UP&b,int sh=0,bool minus=false){a.resize(std::max(a.size(),b.size()+sh));for(size_t i=0;i<b.size();i++)a[i+sh]=kadd(a[i+sh],minus?kneg(b[i]):b[i]);}

#ifdef USE_GMP_PACKING
#include <gmp.h>
#include <mutex>
// Exact Kronecker convolution in the tower basis. The spacing 21 separates
// polynomial coefficients; base slots exceed 128*min(lengths), so no carry
// crosses a slot. All positive integer coefficients are then reduced mod 5.
static UP packed_mul_tower(const UP&a,const UP&b){
 size_t bound=128*std::min(a.size(),b.size());unsigned bits=0;for(size_t z=bound;z;z>>=1)bits++;
 auto encode=[&](mpz_t z,const UP&p){size_t nbits=21*p.size()*bits;std::vector<uint64_t>w((nbits+63)/64+1);for(size_t i=0;i<p.size();i++){U co=p[i];for(int j=0;j<4;j++){U digit=co%25;co/=25;for(int k=0;k<2;k++){uint64_t d=k?digit/5:digit%5;size_t bit=(21*i+3*j+k)*bits;size_t n=bit/64;unsigned off=bit%64;w[n]|=d<<off;if(off+3>64)w[n+1]|=d>>(64-off);}}}mpz_import(z,w.size(),-1,8,0,0,w.data());};
 mpz_t aa,bb,cc;mpz_inits(aa,bb,cc,nullptr);encode(aa,a);encode(bb,b);mpz_mul(cc,aa,bb);
 size_t len=a.size()+b.size()-1,nbits=21*len*bits;std::vector<uint64_t>w((nbits+63)/64+2);size_t count;mpz_export(w.data(),&count,-1,8,0,0,cc);mpz_clears(aa,bb,cc,nullptr);
 uint64_t mask=(uint64_t(1)<<bits)-1;UP out(len);const U mod[4]={5,2,6,7};
 for(size_t i=0;i<len;i++){U rr[21];for(int j=0;j<21;j++){size_t bit=(21*i+j)*bits,n=bit/64;unsigned off=bit%64;uint64_t t=w[n]>>off;if(off+bits>64)t|=w[n+1]<<(64-off);rr[j]=(t&mask)%5;}
  U c[7];for(int j=0;j<7;j++)c[j]=(rr[3*j]+3*rr[3*j+2])%5+5*((rr[3*j+1]+rr[3*j+2])%5);
  for(int j=6;j>=4;j--)for(int k=0;k<4;k++)c[j-4+k]=ad25[c[j-4+k]][mu25[c[j]][mu25[4][mod[k]]]];
  out[i]=c[0]+25*c[1]+625*c[2]+15625*c[3];
 }trim(out);return out;
}
// An exact primitive-element basis reduces the Kronecker stride from 21 to 15.
// Conversion tables are field-linear bijections, verified while constructed.
static std::vector<U> prime_to_code,code_to_prime,prime_high;
static std::once_flag prime_basis_once;
static void initialize_prime_basis(){std::call_once(prime_basis_once,[]{
 prime_to_code.assign(QQ,0);U g=ex.at(1);size_t stride=1;
 for(int j=0;j<8;j++){U gj=kpow(g,j);for(U d=1;d<5;d++){U c=kmul(gj,d);for(size_t i=0;i<stride;i++)prime_to_code[i+d*stride]=kadd(prime_to_code[i],c);}stride*=5;}
 code_to_prime.assign(QQ,QQ);for(U i=0;i<QQ;i++){U c=prime_to_code[i];if(code_to_prime[c]!=QQ)throw std::runtime_error("primitive basis is not bijective");code_to_prime[c]=i;}
 prime_high.resize(78125);U g8=kpow(g,8);for(U i=0;i<78125;i++)prime_high[i]=kmul(prime_to_code[i],g8);
 });}
static UP packed_mul_prime(const UP&a,const UP&b){initialize_prime_basis();size_t bound=128*std::min(a.size(),b.size());unsigned bits=0;for(size_t z=bound;z;z>>=1)bits++;if(bits>=63)throw std::runtime_error("packing coefficient bound exceeds implementation width");
 auto encode=[&](mpz_t z,const UP&p){size_t nbits=15*p.size()*bits;std::vector<uint64_t>w((nbits+63)/64+1);for(size_t i=0;i<p.size();i++){U co=code_to_prime[p[i]];for(int j=0;j<8;j++){uint64_t d=co%5;co/=5;size_t bit=(15*i+j)*bits,n=bit/64;unsigned off=bit%64;w[n]|=d<<off;if(off+3>64)w[n+1]|=d>>(64-off);}}mpz_import(z,w.size(),-1,8,0,0,w.data());};
 mpz_t aa,bb,cc;mpz_inits(aa,bb,cc,nullptr);encode(aa,a);encode(bb,b);mpz_mul(cc,aa,bb);size_t len=a.size()+b.size()-1,nbits=15*len*bits;std::vector<uint64_t>w((nbits+63)/64+2);size_t count;mpz_export(w.data(),&count,-1,8,0,0,cc);mpz_clears(aa,bb,cc,nullptr);
 uint64_t mask=(uint64_t(1)<<bits)-1;UP out(len);for(size_t i=0;i<len;i++){U low=0,high=0,place=1;for(int j=0;j<15;j++){size_t bit=(15*i+j)*bits,n=bit/64;unsigned off=bit%64;uint64_t t=w[n]>>off;if(off+bits>64)t|=w[n+1]<<(64-off);U digit=(t&mask)%5;if(j==8)place=1;if(j<8)low+=digit*place;else high+=digit*place;place*=5;}out[i]=kadd(prime_to_code[low],prime_high[high]);}trim(out);return out;
}
static UP packed_mul(const UP&a,const UP&b){
#ifdef USE_TOWER_PACKING
 return packed_mul_tower(a,b);
#else
 return packed_mul_prime(a,b);
#endif
}

#endif
static UP um(const UP&a,const UP&b){if(a.empty()||b.empty())return{};if(a.size()==1)return uc(b,a[0]);if(b.size()==1)return uc(a,b[0]);
#ifdef USE_GMP_PACKING
if(std::min(a.size(),b.size())>=96)return packed_mul(a,b);
#endif
if(std::min(a.size(),b.size())<28){UP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=kadd(c[i+j],kmul(a[i],b[j]));trim(c);return c;}
 int m=(std::max(a.size(),b.size())+1)/2;UP a0=ucut(a,0,m),a1=ucut(a,m,a.size()),b0=ucut(b,0,m),b1=ucut(b,m,b.size());UP c0=um(a0,b0),c2=um(a1,b1),c1=us(us(um(ua(a0,a1),ua(b0,b1)),c0),c2);UP c;accum(c,c0);accum(c,c1,m);accum(c,c2,2*m);trim(c);return c;}
static UP up(UP a,int n){UP b={1};while(n){if(n&1)b=um(a,b);n>>=1;if(n)a=um(a,a);}return b;}
static UP uf(const UP&a,int n){UP b(a.empty()?0:(a.size()-1)*n+1);for(size_t i=0;i<a.size();i++)b[i*n]=kpow(a[i],n);return b;}
static std::pair<UP,UP> udslow(UP a,const UP&b){assert(!b.empty());trim(a);UP q(a.size()>=b.size()?a.size()-b.size()+1:0);U iv=kinv(b.back());while(a.size()>=b.size()){int sh=a.size()-b.size();U c=kmul(a.back(),iv);q[sh]=c;for(size_t j=0;j<b.size();j++)a[j+sh]=kadd(a[j+sh],kneg(kmul(c,b[j])));trim(a);}trim(q);return {q,a};}
static UP utrunc(UP a,int n){if(a.size()>size_t(n))a.resize(n);trim(a);return a;}
static UP uinvseries(const UP&a,int n){assert(!a.empty()&&a[0]);UP g={kinv(a[0])};for(int k=1;k<n;k*=2){int t=std::min(2*k,n);UP z=utrunc(um(utrunc(a,t),g),t);z=un(z);if(z.empty())z.resize(1);z[0]=kadd(z[0],2);g=utrunc(um(g,z),t);}return g;}
// Block long division avoids a huge reciprocal when the divisor is small.
static std::pair<UP,UP> udblock(const UP&a,const UP&b){int d=b.size()-1;assert(d>0);UP rev=b;std::reverse(rev.begin(),rev.end());UP ri=uinvseries(rev,d);ri.resize(d);UP q(a.size()>=b.size()?a.size()-b.size()+1:0),r;for(int k=(int(a.size())-1)/d;k>=0;k--){UP c=ucut(a,k*d,(k+1)*d);c.resize(d);c.insert(c.end(),r.begin(),r.end());trim(c);if(c.size()<b.size()){r=std::move(c);continue;}int n=c.size()-b.size()+1;UP ar=c;std::reverse(ar.begin(),ar.end());ar=utrunc(ar,n);UP qq=utrunc(um(ar,utrunc(ri,n)),n);qq.resize(n);std::reverse(qq.begin(),qq.end());trim(qq);r=us(c,um(qq,b));if(r.size()>=b.size())throw std::runtime_error("block division degree failure");for(int i=0;i<int(qq.size());i++)q.at(k*d+i)=qq[i];}trim(q);return{q,r};}
static std::pair<UP,UP> ud(UP a,const UP&b){assert(!b.empty());trim(a);if(a.size()<b.size())return{{},a};int n=a.size()-b.size()+1;if(n<48||b.size()<48)return udslow(a,b);if(n>4*int(b.size()))return udblock(a,b);UP ar=a,br=b;std::reverse(ar.begin(),ar.end());std::reverse(br.begin(),br.end());ar=utrunc(ar,n);UP qr=utrunc(um(ar,uinvseries(br,n)),n);qr.resize(n);std::reverse(qr.begin(),qr.end());trim(qr);UP r=us(a,um(qr,b));if(r.size()>=b.size())throw std::runtime_error("fast division remainder degree");return{qr,r};}
static UP ux(const UP&a,const UP&b){auto[q,r]=ud(a,b);if(!r.empty())throw std::runtime_error("nonexact polynomial quotient");return q;}
// Half-gcd is used only to construct certificates. Every returned Bezout
// identity and divisibility is checked exactly, independently of degree bounds.
struct UM {std::array<UP,4>a; UM():a{UP{1},UP{},UP{},UP{1}}{};};
static UM mmul(const UM&A,const UM&B){UM C;for(int i=0;i<2;i++)for(int j=0;j<2;j++)C.a[2*i+j]=ua(um(A.a[2*i],B.a[j]),um(A.a[2*i+1],B.a[2+j]));return C;}
static std::pair<UP,UP> mapply(const UM&M,const UP&a,const UP&b){return{ua(um(M.a[0],a),um(M.a[1],b)),ua(um(M.a[2],a),um(M.a[3],b))};}
static UM mstep(const UP&q,const UM&R){UM S;S.a[0]=R.a[2];S.a[1]=R.a[3];S.a[2]=us(R.a[0],um(q,R.a[2]));S.a[3]=us(R.a[1],um(q,R.a[3]));return S;}
static UM uhgcd(const UP&a,const UP&b){int n=int(a.size())-1,m=(n+1)/2;UM I;if(b.empty()||int(b.size())-1<m)return I;
 if(n<128){UP c=a,d=b;UM R;while(!d.empty()&&int(d.size())-1>=m){auto[q,e]=ud(c,d);R=mstep(q,R);c=std::move(d);d=std::move(e);}return R;}
 UM R=uhgcd(ucut(a,m,a.size()),ucut(b,m,b.size()));auto[c,d]=mapply(R,a,b);if(d.empty()||int(d.size())-1<m)return R;auto[q,e]=ud(c,d);UM Q=mstep(q,R);int k=2*m-(int(d.size())-1);if(k<0)throw std::runtime_error("half-gcd negative shift");UM S=uhgcd(ucut(d,k,d.size()),ucut(e,k,e.size()));return mmul(S,Q);
}
static std::array<UP,3> uxgfast(UP a,UP b){UM M;UP oa=a,ob=b;if(a.size()<b.size()){std::swap(a,b);M=mstep({},M);}while(!b.empty()){
 if(a.size()<80){auto[q,r]=ud(a,b);M=mstep(q,M);a=std::move(b);b=std::move(r);continue;}
 UM R=uhgcd(a,b);auto[c,d]=mapply(R,a,b);M=mmul(R,M);if(d.empty()){a=std::move(c);b={};break;}auto[q,e]=ud(c,d);M=mstep(q,M);a=std::move(d);b=std::move(e);
 }if(a.empty())return{a,M.a[0],M.a[1]};U iv=kinv(a.back());a=uc(a,iv);UP u=uc(M.a[0],iv),v=uc(M.a[1],iv);if(ua(um(u,oa),um(v,ob))!=a)throw std::runtime_error("fast XGCD Bezout check failed");if(!ud(oa,a).second.empty()||!ud(ob,a).second.empty())throw std::runtime_error("fast XGCD divisibility check failed");return{a,u,v};}
static UP ugfast(UP a,UP b){if(a.size()<b.size())std::swap(a,b);while(!b.empty()){
 // A cheap exact Euclidean step handles the many nested denominators before
 // invoking half-gcd; this does not change the canonical monic answer.
 UP r=ud(a,b).second;a=std::move(b);b=std::move(r);if(b.empty())break;
 if(a.size()<1024||b.size()<512)continue;
 UM R=uhgcd(a,b);auto[c,d]=mapply(R,a,b);if(d.empty()){a=std::move(c);break;}UP e=ud(c,d).second;a=std::move(d);b=std::move(e);
 }return a.empty()?a:uc(a,kinv(a.back()));}

static UP ug(UP a,UP b){return ugfast(std::move(a),std::move(b));}
static std::array<UP,3> uxg(UP a,UP b){return uxgfast(std::move(a),std::move(b));}
static U ue(const UP&a,U v){U c=0;for(auto it=a.rbegin();it!=a.rend();++it)c=kadd(kmul(c,v),*it);return c;}

// Optional support accelerator: every denominator used while this is set must
// have all its irreducible factors in denominator_support. It does not invert
// anything new; it only avoids a large gcd when no common factor is possible.
static UP denominator_support;
static UP uradical(UP f){if(f.size()<=1)return{1};f=uc(f,kinv(f.back()));UP der(f.size()-1);for(size_t i=1;i<f.size();i++)der[i-1]=kmul(f[i],i%5);trim(der);UP g=ug(f,der),w=ux(f,g),res={1};while(w.size()>1){UP y=ug(w,g),z=ux(w,y);res=um(res,z);w=std::move(y);g=ux(g,w);}if(g.size()>1){UP r((g.size()-1)/5+1);for(size_t i=0;i<g.size();i++)if(g[i]){if(i%5)throw std::runtime_error("radical remainder is not a fifth power");r[i/5]=kpow(g[i],78125);}res=um(res,uradical(r));}return uc(res,kinv(res.back()));}
static std::atomic<long long> norm_calls{0},mul_calls{0};
static std::array<UP,6> F;
struct QA{std::array<UP,6>n;UP d={1};QA(){}QA(U c){n[0]=cn(c);}QA(UP a){n[0]=std::move(a);}bool zero()const{for(auto&a:n)if(!a.empty())return false;return true;}void normal(){norm_calls++;if(zero()){d={1};return;}UP g=d;
 if(!denominator_support.empty()){g=ug(denominator_support,d);for(auto&a:n){if(g.size()<=1)break;if(!a.empty())g=ug(g,a);}if(g.size()>1)g=d;}
 for(auto&a:n){if(g.size()<=1)break;if(!a.empty())g=ug(g,a);}if(g.size()>1){d=ux(d,g);for(auto&a:n)if(!a.empty())a=ux(a,g);}U iv=kinv(d.back());if(iv!=1){d=uc(d,iv);for(auto&a:n)a=uc(a,iv);}}};
static QA neg(QA a){for(auto&n:a.n)n=un(n);return a;}
static QA operator+(const QA&a,const QA&b){if(a.zero())return b;if(b.zero())return a;QA c;UP g=ug(a.d,b.d),da=ux(a.d,g),db=ux(b.d,g);for(int i=0;i<6;i++)c.n[i]=ua(um(a.n[i],db),um(b.n[i],da));c.d=um(a.d,db);c.normal();return c;}
static QA operator-(const QA&a,const QA&b){return a+neg(b);}
static QA qraw(const QA&a,const QA&b){mul_calls++;if(a.zero()||b.zero())return QA();QA c;std::array<UP,11>p;for(int i=0;i<6;i++)if(!a.n[i].empty())for(int j=0;j<6;j++)if(!b.n[j].empty())p[i+j]=ua(p[i+j],um(a.n[i],b.n[j]));for(int i=10;i>=6;i--)if(!p[i].empty())for(int j=0;j<6;j++)if(!F[j].empty())p[i-6+j]=us(p[i-6+j],um(p[i],F[j]));for(int i=0;i<6;i++)c.n[i]=std::move(p[i]);c.d=um(a.d,b.d);return c;}
static QA operator*(const QA&a,const QA&b){QA c=qraw(a,b);c.normal();return c;}
static QA scale(QA a,U c){if(!c)return QA();for(auto&n:a.n)n=uc(n,c);return a;}
static QA scalar(QA a,const UP&n,const UP&d={1}){for(auto&v:a.n)v=um(v,n);a.d=um(a.d,d);a.normal();return a;}
static QA powq(QA a,int n){QA b(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
static std::array<QA,126> SP;
static QA frob(const QA&a,int n){QA c;for(int i=0;i<6;i++)if(!a.n[i].empty())c=c+scalar(SP[i*n],uf(a.n[i],n));c.d=um(c.d,uf(a.d,n));c.normal();return c;}
static QA scalarinv(const QA&a){for(int i=1;i<6;i++)assert(a.n[i].empty());assert(!a.n[0].empty());QA b(a.d);b.d=a.n[0];b.normal();return b;}
// Inversion by Gaussian elimination over K(v), represented as scalar QA elements.
static QA inverse(const QA&a){std::array<std::array<QA,7>,6>M;for(int j=0;j<6;j++){QA p=a*SP[j];for(int i=0;i<6;i++){M[i][j]=QA(p.n[i]);M[i][j].d=p.d;M[i][j].normal();}}M[0][6]=QA(1);
 for(int j=0;j<6;j++){int p=j;while(p<6&&M[p][j].zero())p++;if(p==6)throw std::runtime_error("noninvertible generic algebra element");std::swap(M[j],M[p]);QA iv=scalarinv(M[j][j]);for(int k=j;k<7;k++)M[j][k]=M[j][k]*iv;for(int i=0;i<6;i++)if(i!=j&&!M[i][j].zero()){QA q=M[i][j];for(int k=j;k<7;k++)M[i][k]=M[i][k]-q*M[j][k];}}
 QA r;for(int j=0;j<6;j++)r=r+M[j][6]*SP[j];QA chk=a*r-QA(1);if(!chk.zero())throw std::runtime_error("inverse identity failure");return r;}
static int height(const QA&a){int h=a.d.size()-1;for(int i=0;i<6;i++)h=std::max(h,int(a.n[i].size())-1+6*i);return h;}
static void saveq(std::ostream&o,const QA&a){o<<a.d.size();for(U c:a.d)o<<" "<<c;o<<"\n";for(auto&p:a.n){o<<p.size();for(U c:p)o<<" "<<c;o<<"\n";}}
static QA loadq(std::istream&i){QA a;int n;i>>n;a.d.resize(n);for(U&c:a.d)i>>c;for(auto&p:a.n){i>>n;p.resize(n);for(U&c:p)i>>c;}if(!i)throw std::runtime_error("read QA");return a;}
