#pragma once
#include "field.cpp"
#include <unordered_map>
#include <map>
#include <string>
#include <fstream>
#include <iostream>
#include <chrono>
#include <stdexcept>
#include <array>
using Key=uint64_t;
static constexpr Key OFF=Key(4096)<<32;
static Key key(int x,int y,int h,int q,int mu=0){assert(x>=0&&x<4096&&y>=0&&y<16&&h>=0&&h<4096&&q>=-4096&&q<1044480&&mu>=0&&mu<16);return Key(x)|(Key(y)<<12)|(Key(h)<<16)|(Key(mu)<<28)|(Key(q+4096)<<32);}
static int kx(Key a){return a&4095;}static int ky(Key a){return(a>>12)&15;}static int kh(Key a){return(a>>16)&4095;}static int kmu(Key a){return(a>>28)&15;}static int kq(Key a){return int(a>>32)-4096;}
struct Poly {
 std::unordered_map<Key,U> t;
 Poly(){}explicit Poly(U c){if(c)t[OFF]=c;}
 static Poly mon(int x,int y,int h,int q,U c=1,int mu=0){Poly p;if(c)p.t[key(x,y,h,q,mu)]=c;return p;}
 void put(Key m,U c){if(!c)return;auto it=t.find(m);if(it==t.end()){t.emplace(m,c);return;}U u=kadd(it->second,c);if(u)it->second=u;else t.erase(it);}
 Poly& operator+=(const Poly&b){for(auto [m,c]:b.t)put(m,c);return *this;}
 Poly scale(U c)const{Poly r;if(c){r.t.reserve(t.size());for(auto [m,d]:t)r.t[m]=kmul(c,d);}return r;}
 Poly shift(int x=0,int y=0,int h=0,int q=0,int mu=0)const{Poly r;r.t.reserve(t.size());for(auto [m,c]:t)r.t[key(kx(m)+x,ky(m)+y,kh(m)+h,kq(m)+q,kmu(m)+mu)]=c;return r;}
 size_t size()const{return t.size();}bool zero()const{return t.empty();}
};
static Poly operator+(Poly a,const Poly&b){a+=b;return a;}static Poly operator-(Poly a,const Poly&b){for(auto [m,c]:b.t)a.put(m,kneg(c));return a;}
static std::vector<std::vector<U>> PP;
static std::vector<U> umul(const std::vector<U>&a,const std::vector<U>&b){if(a.empty()||b.empty())return {};std::vector<U>c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=kadd(c[i+j],kmul(a[i],b[j]));return c;}
static Poly reduce(const Poly&a){Poly r;r.t.reserve(a.size()*2+1);for(auto [m,c]:a.t){int j=ky(m);if(j<3){r.put(m,c);continue;}int s=j/3;assert(s<int(PP.size()));for(int i=0;i<int(PP[s].size());i++)if(PP[s][i])r.put(key(kx(m)+i,j%3,kh(m),kq(m)-s,kmu(m)),kmul(c,PP[s][i]));}return r;}
static Poly rawmul(const Poly&a,const Poly&b){Poly r;if(a.zero()||b.zero())return r;r.t.reserve(std::min(size_t(1000000),a.size()*b.size()+1));for(auto [m,c]:a.t)for(auto [n,d]:b.t)r.put(m+n-OFF,kmul(c,d));return r;}
static Poly operator*(const Poly&a,const Poly&b){return reduce(rawmul(a,b));}
static Poly pow5(const Poly&a){Poly r;for(auto [m,c]:a.t){int j=5*ky(m),s=j/3;assert(s<int(PP.size()));U cc=kpow(c,5);for(int i=0;i<int(PP[s].size());i++)if(PP[s][i])r.put(key(5*kx(m)+i,j%3,5*kh(m),5*kq(m)-s,5*kmu(m)),kmul(cc,PP[s][i]));}return r;}
static Poly powp(Poly a,int n){if(n==0)return Poly(1);if(n%5==0)return powp(pow5(a),n/5);Poly r(1);while(n){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
static Poly divx(const Poly&a,const std::vector<U>&b){assert(!b.empty()&&b.back());int d=b.size()-1;std::unordered_map<Key,std::vector<U>>blocks;for(auto [m,c]:a.t){Key k=m-Key(kx(m));auto&v=blocks[k];if(v.size()<=size_t(kx(m)))v.resize(kx(m)+1);v[kx(m)]=c;}Poly r;U ib=kinv(b.back());for(auto& [m,v]:blocks){for(int i=int(v.size())-1;i>=d;i--)if(v[i]){U c=kmul(v[i],ib);r.t[m+Key(i-d)]=c;for(int j=0;j<=d;j++)v[i-d+j]=kadd(v[i-d+j],kneg(kmul(c,b[j])));}for(int i=0;i<d&&i<int(v.size());i++)if(v[i]){std::cerr<<"nonexact division x="<<i<<" y="<<ky(m)<<" H="<<kh(m)<<" q="<<kq(m)<<"\n";throw std::runtime_error("nonexact division");}}return r;}
static void write_poly(std::ostream&out,const std::string&name,const Poly&p){std::map<Key,U>sorted(p.t.begin(),p.t.end());out<<name<<" "<<p.size()<<"\n";for(auto [m,c]:sorted)out<<kx(m)<<" "<<ky(m)<<" "<<kh(m)<<" "<<kq(m)<<" "<<kmu(m)<<" "<<c<<"\n";}
static Poly read_poly(std::istream&in,std::string&name){size_t n;in>>name>>n;if(!in)throw std::runtime_error("reading polynomial header");Poly r;for(size_t i=0;i<n;i++){int x,y,h,q,mu;U c;in>>x>>y>>h>>q>>mu>>c;assert(in);r.put(key(x,y,h,q,mu),c);}return r;}
static void stats(const std::string&name,const Poly&p){int deg[5]={-10000,-10000,-10000,-10000,-10000},mins[5]={10000,10000,10000,10000,10000};for(auto [m,c]:p.t){int d[5]={kx(m),ky(m),kh(m),kq(m),kmu(m)};for(int i=0;i<5;i++){deg[i]=std::max(deg[i],d[i]);mins[i]=std::min(mins[i],d[i]);}}std::cout<<name<<" terms="<<p.size()<<" degrees=(";for(int i=0;i<5;i++)std::cout<<(i?",":"")<<mins[i]<<":"<<deg[i];std::cout<<")"<<std::endl;}
static void initP(const std::vector<U>&P){PP={{1}};for(int i=1;i<=5;i++)PP.push_back(umul(PP.back(),P));}
