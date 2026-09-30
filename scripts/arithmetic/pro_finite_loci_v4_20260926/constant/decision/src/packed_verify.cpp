// Independent polynomial-product verifier.  No discrete-log field arithmetic.
#include <algorithm>
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
#include <gmp.h>
using U=uint32_t;using Poly=std::vector<U>;
U a25(U a,U b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
U n25(U a){return (5-a%5)%5+5*((5-a/5)%5);}
U m25(U a,U b){return ((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}
U add(U a,U b){U c=0,p=1;for(int j=0;j<4;j++){c+=p*a25(a%25,b%25);a/=25;b/=25;p*=25;}return c;}
void pack(mpz_t z,const Poly&a,unsigned bits){size_t nbits=size_t(a.size())*21*bits;std::vector<uint64_t>w((nbits+63)/64+1);for(size_t i=0;i<a.size();i++){U c=a[i];for(unsigned j=0;j<4;j++){U d=c%25;c/=25;for(unsigned k=0;k<2;k++){U v=k?d/5:d%5;if(!v)continue;size_t bit=(21*i+3*j+k)*bits,idx=bit/64;unsigned sh=bit%64;w[idx]|=uint64_t(v)<<sh;if(sh+bits>64)w[idx+1]|=uint64_t(v)>>(64-sh);}}}mpz_import(z,w.size(),-1,sizeof(uint64_t),0,0,w.data());}
Poly prod(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};size_t n=a.size()+b.size()-1;uint64_t bound=128*std::min(a.size(),b.size());unsigned bits=1;while((uint64_t(1)<<bits)<=bound)bits++;mpz_t x,y,z;mpz_inits(x,y,z,nullptr);pack(x,a,bits);pack(y,b,bits);mpz_mul(z,x,y);size_t nw=(mpz_sizeinbase(z,2)+63)/64;std::vector<uint64_t>w(nw+2);size_t count=0;mpz_export(w.data(),&count,-1,sizeof(uint64_t),0,0,z);mpz_clears(x,y,z,nullptr);Poly out(n);uint64_t mask=(uint64_t(1)<<bits)-1;auto get=[&](size_t slot){size_t bit=slot*bits,idx=bit/64;unsigned sh=bit%64;if(idx>=w.size())return U(0);uint64_t v=w[idx]>>sh;if(sh+bits>64&&idx+1<w.size())v|=w[idx+1]<<(64-sh);return U((v&mask)%5);};for(size_t i=0;i<n;i++){U c[7]{};for(int j=0;j<7;j++){U v0=get(21*i+3*j),v1=get(21*i+3*j+1),v2=get(21*i+3*j+2);c[j]=(v0+3*v2)%5+5*((v1+v2)%5);}const U mod[]={5,2,6,7};for(int j=6;j>=4;j--)for(int k=0;k<4;k++)c[j-4+k]=a25(c[j-4+k],n25(m25(c[j],mod[k])));out[i]=c[0]+25*c[1]+625*c[2]+15625*c[3];}while(!out.empty()&&!out.back())out.pop_back();return out;}
Poly read(std::istream&in){size_t n;in>>n;Poly a(n);for(auto&c:a){in>>c;if(c>=390625)throw std::runtime_error("field code out of range");}if(!in)throw std::runtime_error("bad certificate input");return a;}
int main(int argc,char**argv){try{if(argc!=2)throw std::runtime_error("usage: packed_verify certificate.txt");std::ifstream in(argv[1]);auto a=read(in),b=read(in),u=read(in),v=read(in),g=read(in);auto p=prod(a,u),q=prod(b,v);p.resize(std::max(p.size(),q.size()));for(size_t i=0;i<q.size();i++)p[i]=add(p[i],q[i]);while(!p.empty()&&!p.back())p.pop_back();if(p!=g)throw std::runtime_error("full coefficient identity does not hold");std::cout<<"Independent packed-integer verification: all "<<std::max(a.size()+u.size(),b.size()+v.size())-1<<" coefficients checked; Bezout identity PASS. GMP "<<gmp_version<<"\n";return 0;}catch(const std::exception&e){std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}}
