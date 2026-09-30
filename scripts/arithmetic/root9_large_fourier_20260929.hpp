// Exact multiplicative DFT in F_(5^8). Rader's reduction of the prime313
// stage uses a length312 cyclic convolution; no numerical approximation.
#ifndef ROOT9_LARGE_FOURIER_HPP
#define ROOT9_LARGE_FOURIER_HPP
#include <map>
std::vector<F> large_dft(const std::vector<F>&a,F root);
std::vector<F> rader313(const std::vector<F>&a,F root){
 assert(a.size()==313);
 struct Kernel{std::vector<int> powers;std::vector<F> hat;F rt;};
 static thread_local std::map<unsigned,Kernel> cache;
 auto it=cache.find(root.v);
 if(it==cache.end()){
  int g=2;
  auto mp=[](int x,int n){int z=1;while(n){if(n&1)z=z*x%313;x=x*x%313;n>>=1;}return z;};
  while(mp(g,156)==1||mp(g,104)==1||mp(g,24)==1)g++;
  Kernel k;k.rt=F(25).pow(F::NN/312);k.powers.resize(312);
  int t=1;std::vector<F>v(312);
  for(int j=0;j<312;j++){k.powers[j]=t;v[j]=root.pow(t);t=t*g%313;}assert(t==1);
  k.hat=large_dft(v,k.rt);it=cache.emplace(root.v,std::move(k)).first;
 }
 const auto&k=it->second;std::vector<F>u(312),b(313);
 for(int j=0;j<312;j++)u[j]=a[k.powers[(312-j)%312]];
 u=large_dft(u,k.rt);for(int j=0;j<312;j++)u[j]*=k.hat[j];
 u=large_dft(u,k.rt.inverse());F ni=F(312%5).inverse();
 for(auto v:a)b[0]+=v;
 for(int j=0;j<312;j++)b[k.powers[j]]=a[0]+u[j]*ni;
 return b;
}
std::vector<F> large_dft(const std::vector<F>&a,F root){
 int n=a.size();if(n==1)return a;if(n==313)return rader313(a,root);
 int r=0;for(int p:{2,3,13})if(n%p==0){r=p;break;}
 if(!r)throw std::runtime_error("unimplemented exact DFT radix");
 int m=n/r;std::vector<std::vector<F>>p(r);
 for(int j=0;j<r;j++){std::vector<F>x(m);for(int i=0;i<m;i++)x[i]=a[j+r*i];p[j]=large_dft(x,root.pow(r));}
 std::vector<F>b(n);F w(1);
 for(int k=0;k<n;k++){F t(1);for(int j=0;j<r;j++){b[k]+=p[j][k%m]*t;t*=w;}w*=root;}
 return b;
}
void large_dft_controls(){
 for(int n:{13,312,313,3756,15024}){
  F rt=F(25).pow(F::NN/n);std::vector<F>a(n);
  for(int i=0;i<n;i++)if(i%7==0||i==n-1)a[i]=F(25).pow(13*i+5);
  auto b=large_dft(a,rt);FP p(a);
  for(int i:{0,1,2,17,n-1})assert(b[i%n]==p.eval(rt.pow(i%n)));
  auto c=large_dft(b,rt.inverse());F ni=F(n%5).inverse();
  for(int i=0;i<n;i++)assert(c[i]*ni==a[i]);
 }
 std::cout<<"LARGE_DFT_RADER_CONTROLS_PASS"<<std::endl;
}
#endif
