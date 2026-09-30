#pragma once
#include "io_dft.hpp"
#include <thread>
#include <mutex>
#include <atomic>
// Mixed-radix DFT. Rader's cyclic convolution handles the prime 313 factor.
inline Rows fdft(const Rows&,F,int=1);
struct RaderKernel{std::vector<int> gp,gi;std::vector<F> bhat;F gamma;};
inline RaderKernel make_rader(F root){
 constexpr int p=313,n=312;int g=2;
 auto powm=[](int a,int b){int z=1;while(b){if(b&1)z=z*a%313;a=a*a%313;b>>=1;}return z;};
 while(powm(g,n/2)==1||powm(g,n/3)==1||powm(g,n/13)==1)g++;
 RaderKernel r;r.gp.resize(n);r.gi.resize(n);r.gp[0]=1;
 for(int i=1;i<n;i++)r.gp[i]=r.gp[i-1]*g%p;
 for(int i=0;i<n;i++)r.gi[i]=r.gp[(n-i)%n];
 r.gamma=F::code(kfield::primitive).pow(kfield::N/n);Rows b(n,std::vector<F>(1));
 for(int i=0;i<n;i++)b[i][0]=root.pow(r.gp[i]);auto bh=fdft(b,r.gamma);r.bhat.resize(n);for(int i=0;i<n;i++)r.bhat[i]=bh[i][0];return r;
}
inline const RaderKernel& rkernel(F root){static std::map<int,RaderKernel> cache;static std::mutex mx;std::lock_guard<std::mutex> l(mx);auto it=cache.find(root.v);if(it==cache.end())it=cache.emplace(root.v,make_rader(root)).first;return it->second;}
inline Rows fdft(const Rows& in,F root,int threads){
 int n=in.size(),nc=in[0].size();if(n==1)return in;Rows out(n,std::vector<F>(nc));
 if(n==313){const auto& r=rkernel(root);Rows a(312,std::vector<F>(nc));
  for(int i=0;i<312;i++)a[i]=in[r.gi[i]];a=fdft(a,r.gamma);
  for(int i=0;i<312;i++)for(int c=0;c<nc;c++)a[i][c]*=r.bhat[i];a=fdft(a,r.gamma.inv());
  F iv=F(312).inv();for(int c=0;c<nc;c++){F z;for(auto &row:in)z+=row[c];out[0][c]=z;}
  for(int i=0;i<312;i++)for(int c=0;c<nc;c++)out[r.gp[i]][c]=in[0][c]+a[i][c]*iv;return out;
 }
 int a=n%8==0?8:2;if(n%8)while(n%a)a++;int b=n/a;
 if(b==1){F rk(1);for(int k=0;k<n;k++){F z(1);for(int j=0;j<n;j++){if(z==F(1)){for(int c=0;c<nc;c++)out[k][c]+=in[j][c];}else for(int c=0;c<nc;c++)out[k][c]+=in[j][c]*z;z*=rk;}rk*=root;}return out;}
 std::vector<Rows> part(a);std::atomic<int> next(0);auto worker=[&]{for(;;){int r=next++;if(r>=a)break;Rows sub(b);for(int j=0;j<b;j++)sub[j]=in[a*j+r];part[r]=fdft(sub,root.pow(a));}};
 if(threads>1&&n>=10000){std::vector<std::thread> pool;for(int t=0;t<std::min(a,threads);t++)pool.emplace_back(worker);for(auto &t:pool)t.join();}else worker();
 std::atomic<int> nextk(0);auto combine=[&]{for(;;){int lo=nextk.fetch_add(128);if(lo>=n)break;int hi=std::min(n,lo+128);F rk=root.pow(lo);
  for(int k=lo;k<hi;k++){out[k]=part[0][k%b];F z=rk;for(int r=1;r<a;r++){if(z==F(1)){for(int c=0;c<nc;c++)out[k][c]+=part[r][k%b][c];}else for(int c=0;c<nc;c++)out[k][c]+=part[r][k%b][c]*z;z*=rk;}rk*=root;}
 }};
 if(threads>1&&n>=10000){std::vector<std::thread> pool;for(int t=0;t<threads;t++)pool.emplace_back(combine);for(auto &t:pool)t.join();}else combine();return out;
}
