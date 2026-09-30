#pragma once
// Exact compatible presentation: kplus=F5[t]/(4+4t+2t^2+3t^3+3t^4+2t^5+2t^6+t^7),
// K=kplus[beta]/(beta^2-beta-3), F=K[theta]/(theta^4-[20]), theta=c-hat_2.
// Fast arithmetic uses verified discrete-log tables for kplus; no randomness.
#include <array>
#include <vector>
#include <cstdint>
#include <stdexcept>
#include <algorithm>
#include <iostream>
namespace exact {
constexpr int q=78125, qm=q-1;
inline std::vector<uint32_t> add3,add4,negv,lg,ex,scale;
inline int primitive=0;
inline int raw_add(int a,int b) {
 int c=0,p=1; for(int i=0;i<7;++i){c+=((a%5+b%5)%5)*p;a/=5;b/=5;p*=5;}return c;
}
inline int raw_mul(int a,int b) {
 int aa[7],bb[7],v[13]={};for(int i=0;i<7;++i){aa[i]=a%5;a/=5;bb[i]=b%5;b/=5;}
 for(int i=0;i<7;++i)for(int j=0;j<7;++j)v[i+j]+=aa[i]*bb[j];
 const int m[7]={4,4,2,3,3,2,2};
 for(int i=12;i>=7;--i){int c=(v[i]%5+5)%5;for(int j=0;j<7;++j)v[i-7+j]-=c*m[j];}
 int c=0,p=1;for(int i=0;i<7;++i){c+=((v[i]%5+5)%5)*p;p*=5;}return c;
}
inline int raw_pow(int a,int n){int r=1;while(n){if(n&1)r=raw_mul(r,a);a=raw_mul(a,a);n>>=1;}return r;}
inline int add(int a,int b){return add3[(a%125)*125+b%125]+125*add4[(a/125)*625+b/125];}
inline int neg(int a){return negv[a];}
inline int sub(int a,int b){return add(a,neg(b));}
inline int mul(int a,int b){return (!a||!b)?0:ex[lg[a]+lg[b]];}
inline int inv(int a){if(!a)throw std::runtime_error("division by zero");return ex[qm-lg[a]];}
inline int divi(int a,int b){return mul(a,inv(b));}
inline int smul(int a,int s){return scale[(s%5)*q+a];}
inline int power(int a,uint64_t n){if(!a)return n?0:1;return ex[(uint64_t(lg[a])*(n%qm))%qm];}
inline void init() {
 add3.resize(125*125);add4.resize(625*625);negv.resize(q);scale.resize(5*q);
 for(int a=0;a<125;++a)for(int b=0;b<125;++b)add3[a*125+b]=raw_add(a,b);
 for(int a=0;a<625;++a)for(int b=0;b<625;++b)add4[a*625+b]=raw_add(a,b);
 for(int a=0;a<q;++a){negv[a]=raw_mul(a,4);for(int s=0;s<5;++s)scale[s*q+a]=raw_mul(a,s);}
 for(int g=2;g<q;++g)if(raw_pow(g,qm/2)!=1&&raw_pow(g,qm/19531)!=1){primitive=g;break;}
 if(!primitive)throw std::runtime_error("No primitive element");
 lg.assign(q,qm+1);ex.resize(2*qm+1);int a=1;
 for(int i=0;i<qm;++i){if(lg[a]!=qm+1)throw std::runtime_error("Early cycle");lg[a]=i;ex[i]=a;a=raw_mul(a,primitive);}
 if(a!=1)throw std::runtime_error("Incomplete multiplicative cycle");
 for(int i=qm;i<=2*qm;++i)ex[i]=ex[i-qm];
}
struct K {
 int a=0,b=0;
 K()=default; K(int x):a((x%5+5)%5),b(0){} K(int aa,int bb):a(aa),b(bb){}
 static K code(int c){return K(c%5,c/5);}
 bool zero()const{return !a&&!b;}
 bool operator==(const K&o)const{return a==o.a&&b==o.b;}
 bool operator!=(const K&o)const{return !(*this==o);}
 K operator+(const K&o)const{return K(add(a,o.a),add(b,o.b));}
 K operator-()const{return K(neg(a),neg(b));}
 K operator-(const K&o)const{return *this+(-o);}
 K operator*(const K&o)const{
  int bb=mul(b,o.b);return K(add(mul(a,o.a),smul(bb,3)),add(add(mul(a,o.b),mul(b,o.a)),bb));
 }
 K bar()const{return K(add(a,b),neg(b));}
 int norm()const{return add(add(mul(a,a),mul(a,b)),smul(mul(b,b),2));}
 K inverse()const{int v=inv(norm());K c=bar();return K(mul(c.a,v),mul(c.b,v));}
 K operator/(const K&o)const{return *this*o.inverse();}
 K times(int n)const{return K(smul(a,n),smul(b,n));}
 K pow(uint64_t n)const{K s(1),v=*this;while(n){if(n&1)s=s*v;v=v*v;n>>=1;}return s;}
 K frob(int n)const{
  n=(n%14+14)%14; uint64_t p=1;for(int i=0;i<n%7;++i)p*=5;
  K r(power(a,p),power(b,p));return (n%2)?r.bar():r;
 }
 uint64_t pack()const{return uint64_t(a)+uint64_t(q)*b;}
};
inline int row7(std::initializer_list<int> cs){int r=0,p=1;for(auto v:cs){r+=v*p;p*=5;}return r;}
inline K zeta(){return K(row7({2,2,3,2,1,0,2}),row7({1,2,4,1,3,0,1}));}
struct F {
 std::array<K,4> c{};
 F()=default;F(int n){c[0]=K(n);}explicit F(K a){c[0]=a;}
 bool zero()const{for(auto a:c)if(!a.zero())return false;return true;}
 bool operator==(const F&o)const{return c==o.c;}
 bool operator!=(const F&o)const{return !(*this==o);}
 F operator+(const F&o)const{F r;for(int i=0;i<4;++i)r.c[i]=c[i]+o.c[i];return r;}
 F operator-()const{F r;for(int i=0;i<4;++i)r.c[i]=-c[i];return r;}
 F operator-(const F&o)const{return *this+(-o);}
 F times(K a)const{F r;for(int i=0;i<4;++i)r.c[i]=c[i]*a;return r;}
 F operator*(const F&o)const{
  F r;K d=K::code(20);
  for(int i=0;i<4;++i)for(int j=0;j<4;++j){K a=c[i]*o.c[j];if(i+j>=4)a=a*d;r.c[(i+j)%4]=r.c[(i+j)%4]+a;}
  return r;
 }
 F pow(uint64_t n)const{F r(1),v=*this;while(n){if(n&1)r=r*v;v=v*v;n>>=1;}return r;}
 F sigma()const{F r;int w=1;for(int i=0;i<4;++i){r.c[i]=c[i].times(w);w=(2*w)%5;}return r;}
 F inverse()const{
  F s1=sigma(),s2=s1.sigma(),s3=s2.sigma();F adj=s1*s2*s3;F n=(*this)*adj;
  for(int i=1;i<4;++i)if(!n.c[i].zero())throw std::runtime_error("Norm not scalar");
  return adj.times(n.c[0].inverse());
 }
 F operator/(const F&o)const{return *this*o.inverse();}
 F frob(int n)const{F r=*this;for(int i=0;i<n%56;++i)r=r.pow(5);return r;}
};
inline std::array<std::array<F,4>,116> labels;
inline void init_labels(){
 const int cs[4][4]={{20,1,7,19},{8,1,15,0},{12,18,8,6},{4,17,2,0}};
 const int es[4]={5,8,17,4};
 K z=zeta();if(z.pow(29)!=K(1)||z==K(1))throw std::runtime_error("zeta order error");
 std::array<K,29> zp;zp[0]=K(1);for(int j=1;j<29;++j)zp[j]=zp[j-1]*z;
 for(int j=0;j<29;++j)for(int i=0;i<4;++i)for(int h=0;h<4;++h){
  int w=1,tw=1;for(int k=0;k<i;++k)tw=(tw*2)%5;
  for(int k=0;k<4;++k){labels[4*j+i][h].c[k]=K::code(cs[h][k])*zp[(es[h]*j)%29].times(w);w=(w*tw)%5;}
 }
}
inline std::array<F,4> endpoint(const std::array<int,4>&ix){
 std::array<F,4> r{};for(int h=0;h<4;++h)for(int j:ix)r[h]=r[h]+labels[j][h];return r;
}
inline bool admissible(const std::array<int,4>&ix){
 if(ix[0]/4==ix[3]/4)return false;
 auto im=ix;for(int &v:im)v=4*(v/4)+(v%4+2)%4;std::sort(im.begin(),im.end());return im!=ix;
}
inline void print_ix(const std::array<int,4>& ix,std::ostream &o){o<<'[';for(int k=0;k<4;++k){if(k)o<<',';o<<'['<<ix[k]%4<<','<<ix[k]/4<<']';}o<<']';}
}
