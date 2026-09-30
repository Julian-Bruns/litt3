#include "ff.hpp"
#include <algorithm>
#include <array>
#include <map>
#include <chrono>
#include <cstring>
#include <iomanip>
#include <limits>

using ff::E; using Key=int64_t;
struct Term{Key m;E c;};
using Poly=std::vector<Term>; using Curve=std::array<Poly,3>;
const Key SX=1,SH=1024,SM=65536,SQ=524288;
inline int X(Key k){return int(k&1023);} inline int H(Key k){return int((k>>10)&63);} inline int M(Key k){return int((k>>16)&7);} inline int Qexp(Key k){return int(k>>19);}
inline Key key(int x,int h,int mu,int q){return Key(x)+SH*h+SM*mu+SQ*q;}
Poly plus(const Poly&a,const Poly&b){Poly r;r.reserve(a.size()+b.size());size_t i=0,j=0;while(i<a.size()||j<b.size()){if(j==b.size()||(i<a.size()&&a[i].m<b[j].m))r.push_back(a[i++]);else if(i==a.size()||b[j].m<a[i].m)r.push_back(b[j++]);else{E c=ff::add(a[i].c,b[j].c);if(c)r.push_back({a[i].m,c});i++;j++;}}return r;}
Poly scale(Poly a,E c){if(!c)return {};for(auto&t:a)t.c=ff::mul(t.c,c);return a;}
Poly minus(const Poly&a,const Poly&b){return plus(a,scale(b,4));}
Poly shift(Poly a,Key k){for(auto&t:a)t.m+=k;return a;}
Poly one(E c=1){return c?Poly{{0,c}}:Poly{};}
struct Bounds{int x=0,h=0,m=0,q0=0,q1=0;};
Bounds bounds(const Poly&a){Bounds b;if(!a.empty())b.q0=b.q1=Qexp(a[0].m);for(auto&t:a){b.x=std::max(b.x,X(t.m));b.h=std::max(b.h,H(t.m));b.m=std::max(b.m,M(t.m));b.q0=std::min(b.q0,Qexp(t.m));b.q1=std::max(b.q1,Qexp(t.m));}return b;}

uint64_t products=0,multiplications=0;
Poly times(const Poly&a,const Poly&b){
 if(a.empty()||b.empty())return {};
 if(a.size()==1)return shift(scale(b,a[0].c),a[0].m);
 if(b.size()==1)return shift(scale(a,b[0].c),b[0].m);
 Bounds A=bounds(a),B=bounds(b);int nx=A.x+B.x+1,nh=A.h+B.h+1,nm=A.m+B.m+1,nq=A.q1+B.q1-A.q0-B.q0+1;
 if(nx>1024||nh>64||nm>8)throw std::runtime_error("packed exponent overflow");
 size_t sh=nx,sm=sh*nh,sq=sm*nm,N=sq*nq;
 if(N>200000000)throw std::runtime_error("dense temporary exceeds 800MB limit");
 std::vector<E> out(N,0);struct T{size_t i;E l;};std::vector<T>aa,bb;aa.reserve(a.size());bb.reserve(b.size());
 for(auto&t:a)aa.push_back({X(t.m)+sh*H(t.m)+sm*M(t.m)+sq*(Qexp(t.m)-A.q0),ff::logs[t.c]});
 for(auto&t:b)bb.push_back({X(t.m)+sh*H(t.m)+sm*M(t.m)+sq*(Qexp(t.m)-B.q0),ff::logs[t.c]});
 uint64_t work=uint64_t(a.size())*b.size();products+=work;multiplications++;
 for(auto&u:aa){E* base=out.data()+u.i;const E* ex=ff::exps+u.l;for(auto&v:bb){E&z=base[v.i];z=ff::add(z,ex[v.l]);}}
 Poly r;r.reserve(std::min(N,a.size()+b.size()));for(int q=0;q<nq;q++)for(int m=0;m<nm;m++)for(int h=0;h<nh;h++)for(int x=0;x<nx;x++){E c=out[x+sh*h+sm*m+sq*q];if(c)r.push_back({key(x,h,m,q+A.q0+B.q0),c});}
 return r;
}
Poly powp(Poly a,int n){if(n==5){for(auto&t:a){t.m*=5;t.c=ff::pow(t.c,5);}return a;}Poly r=one();while(n){if(n&1)r=times(r,a);n>>=1;if(n)a=times(a,a);}return r;}
Curve cplus(const Curve&a,const Curve&b){return {plus(a[0],b[0]),plus(a[1],b[1]),plus(a[2],b[2])};}
Curve cscale(Curve a,E c){for(auto&p:a)p=scale(p,c);return a;}
Curve cminus(const Curve&a,const Curve&b){return cplus(a,cscale(b,4));}
Curve cshift(Curve a,Key k){for(auto&p:a)p=shift(p,k);return a;}
Curve cone(E c=1){return {one(c),{}, {}};}
Poly Ppoly,Dpoly; // D=P/q
Curve ctimes(const Curve&a,const Curve&b){Curve r;for(int i=0;i<3;i++)for(int j=0;j<3;j++){Poly p=times(a[i],b[j]);if(i+j>=3)p=times(p,Dpoly);r[(i+j)%3]=plus(r[(i+j)%3],p);}return r;}
Curve cpow(Curve a,int n){
 if(n==5){return {powp(a[0],5),times(powp(a[2],5),powp(Dpoly,3)),times(powp(a[1],5),Dpoly)};}
 Curve r=cone();while(n){if(n&1)r=ctimes(r,a);n>>=1;if(n)a=ctimes(a,a);}return r;
}
void stats(const std::string&s,const Poly&a){auto b=bounds(a);std::cout<<s<<" terms="<<a.size()<<" degH="<<b.h<<" degMu="<<b.m<<" degX="<<b.x<<" q=["<<b.q0<<","<<b.q1<<"] products="<<products<<std::endl;}
void stats(const std::string&s,const Curve&a){for(int i=0;i<3;i++)stats(s+"["+std::to_string(i)+"]",a[i]);}
Curve critical(const Curve&a,const Curve&b,const Curve&c,const Curve&d,const Curve&Qc,const Curve&C){
 Curve a2=cpow(a,2),a3=ctimes(a2,a),a4=ctimes(a3,a),a5=cpow(a,5),a10=ctimes(a5,a5);
 Curve b2=cpow(b,2),b3=ctimes(b2,b),b4=ctimes(b3,b),b5=cpow(b,5);
 Curve c2=cpow(c,2),c3=ctimes(c2,c),c4=ctimes(c3,c),c5=cpow(c,5);
 Curve ee=cminus(ctimes(a,d),ctimes(b,c)),delta=cplus(b2,ctimes(a,c));
 Curve T=cplus(cminus(c5,ctimes(Qc,b5)),ctimes(cpow(Qc,2),a5));stats("T",T);
 Curve U=cminus(cscale(ctimes(Qc,a5),2),b5);
 Curve V=cminus(cminus(cminus(cscale(ctimes(d,b5),4),cscale(ctimes(c2,b4),2)),cscale(ctimes(ctimes(a,b2),c3),3)),cscale(ctimes(a2,c4),2));
 V=cplus(V,ctimes(Qc,cplus(cminus(cscale(ctimes(a5,d),2),ctimes(ctimes(a4,b),c)),ctimes(a3,b3))));stats("V",V);
 Curve W=cplus(cplus(cplus(cminus(ctimes(a2,cpow(d,2)),ctimes(ctimes(ctimes(a,b),c),d)),cscale(ctimes(b2,c2),2)),ctimes(b3,d)),ctimes(a,c3));stats("W",W);
 Curve MM=cminus(ctimes(U,cplus(cscale(ctimes(a,ee),2),ctimes(b,delta))),ctimes(a2,V));
 Curve term2=cshift(cpow(T,2),2*SM);
 Curve term1=cshift(cplus(ctimes(T,V),ctimes(C,cminus(cpow(U,2),cscale(ctimes(a5,T),2)))),SM);
 Curve term0=cplus(ctimes(a3,cplus(ctimes(T,W),ctimes(C,MM))),ctimes(cpow(C,2),a10));
 Curve r=cplus(cplus(term2,term1),term0);stats("resultant",r);return r;
}
Poly norm(const Curve&a){Poly r=minus(plus(plus(powp(a[0],3),times(powp(a[1],3),Dpoly)),times(powp(a[2],3),powp(Dpoly,2))),scale(times(times(times(a[0],a[1]),a[2]),Dpoly),3));stats("norm",r);return r;}
Poly exact_div_x(const Poly&a,const std::vector<E>&b){
 if(b.empty()||!b.back())throw std::runtime_error("zero divisor");
 E ib=ff::inv(b.back());Poly r;size_t i=0;while(i<a.size()){Key base=a[i].m-X(a[i].m);size_t j=i;int n=0;while(j<a.size()&&a[j].m-X(a[j].m)==base){n=std::max(n,X(a[j].m)+1);j++;}std::vector<E> v(n,0),quo(std::max(0,n-int(b.size())+1),0);for(size_t k=i;k<j;k++)v[X(a[k].m)]=a[k].c;
 for(int k=n-int(b.size());k>=0;k--){E c=ff::mul(v[k+b.size()-1],ib);quo[k]=c;if(c)for(size_t l=0;l<b.size();l++)v[k+l]=ff::sub(v[k+l],ff::mul(c,b[l]));}
 if(std::any_of(v.begin(),v.end(),[](E c){return c!=0;}))throw std::runtime_error("nonexact x-division");for(size_t k=0;k<quo.size();k++)if(quo[k])r.push_back({base+Key(k),quo[k]});i=j;}
 return r;
}
void save(const std::string&fn,const Poly&p){std::ofstream o(fn,std::ios::binary);uint64_t n=p.size();o.write((char*)&n,8);for(auto&t:p){o.write((char*)&t.m,8);o.write((char*)&t.c,4);}}
Poly readpoly(const std::string&fn){std::ifstream f(fn,std::ios::binary);if(!f)throw std::runtime_error("missing polynomial checkpoint");uint64_t n;f.read((char*)&n,8);Poly p(n);for(auto&t:p){f.read((char*)&t.m,8);f.read((char*)&t.c,4);}return p;}
E evalpoly(const Poly&p,E Hh,E qq,E mm,E xx){E r=0;for(auto&t:p){E c=t.c;c=ff::mul(c,ff::pow(Hh,H(t.m)));int q=Qexp(t.m);c=ff::mul(c,q>=0?ff::pow(qq,q):ff::pow(ff::inv(qq),-q));c=ff::mul(c,ff::pow(mm,M(t.m)));c=ff::mul(c,ff::pow(xx,X(t.m)));r=ff::add(r,c);}return r;}
int main(int argc,char**argv){try{
 auto start=std::chrono::steady_clock::now();ff::init();
 if(argc<2)throw std::runtime_error("usage: expand ROOT [resume]");std::string root=argv[1];std::ifstream input(root+"/evidence/normalized_sources.dat");if(!input)throw std::runtime_error("missing normalized sources");
 std::array<Curve,6>src;for(auto&g:src){int n;input>>n;for(int i=0;i<n;i++){int h,q,y,x;E c;input>>h>>q>>y>>x>>c;g[y].push_back({key(x,h,0,q),c});}for(auto&p:g)std::sort(p.begin(),p.end(),[](auto&a,auto&b){return a.m<b.m;});}
 E pc[]={11,22,18,5,19,20,15,16,9,22,1};for(int i=0;i<11;i++)if(pc[i])Ppoly.push_back({i,pc[i]});Dpoly=shift(Ppoly,-SQ);
 Curve res;
 if(argc>2&&std::string(argv[2])=="resume")for(int i=0;i<3;i++)res[i]=readpoly(root+"/build/resbar_"+std::to_string(i)+".bin");
 else {res=critical(cscale(src[0],3),cscale(src[1],2),src[2],src[3],src[4],src[5]);for(int i=0;i<3;i++)save(root+"/build/resbar_"+std::to_string(i)+".bin",res[i]);}
 if(argc>2&&std::string(argv[2])=="resultant-only"){std::cout<<"PASS: global resultant-only checkpoint completed."<<std::endl;return 0;}
 Poly N=norm(res);save(root+"/build/norm.bin",N);
 // C=q^3*t^3, so t^15=(C/q^3)^5.
 Poly td=powp(shift(src[5][0],-3*SQ),5);std::vector<E>dv(bounds(td).x+1,0);for(auto&t:td){if(H(t.m)||M(t.m)||Qexp(t.m))throw std::runtime_error("bad t polynomial");dv[X(t.m)]=t.c;}
 Poly R=shift(exact_div_x(N,dv),-15*SQ);stats("Rcal",R);save(root+"/build/Rcal.bin",R);
 std::ofstream eval(root+"/evidence/global_expansion_evaluations.json");eval<<"[\n";E test[][4]={{2,3,3,0},{1,2,2,1},{150,3,ff::div(25,6),25},{325683,173602,ff::div(13579,67890),54321}};for(int i=0;i<4;i++){auto&t=test[i];eval<<"  {\"H\":"<<t[0]<<",\"q\":"<<t[1]<<",\"mu\":"<<t[2]<<",\"x\":"<<t[3]<<",\"Rcal\":"<<evalpoly(R,t[0],t[1],t[2],t[3])<<"}"<<(i==3?"\n":",\n");}eval<<"]\n";
 std::cout<<"completed seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<" pair_products="<<products<<" multiplications="<<multiplications<<std::endl;
 }catch(const std::exception&e){std::cerr<<"ERROR: "<<e.what()<<std::endl;return 1;}return 0;}
