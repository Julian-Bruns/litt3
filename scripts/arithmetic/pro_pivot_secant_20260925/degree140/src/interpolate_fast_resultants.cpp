#include "fast_exact.cpp"
#include "additive_fft.hpp"
#include <chrono>
#include <random>
using Clock=chrono::steady_clock;
double sec(Clock::time_point t){return chrono::duration<double>(Clock::now()-t).count();}
using Bi=vector<Poly>;
int eval(const Poly&p,int h){int z=0;for(int i=int(p.size())-1;i>=0;i--)z=ff::add(ff::mul(z,h),p[i]);return z;}
Bi readbi(istream &in){int terms,dh,dm;in>>terms>>dh>>dm;Bi a(dm+1,Poly(dh+1));for(int i=0;i<terms;i++){int h,m,c;in>>h>>m>>c;a[m][h]=c;}for(auto&p:a)trim(p);return a;}
void save(const string&file,const Poly&p){ofstream out(file);out<<p.size()<<'\n';for(auto c:p)out<<c<<' ';out<<'\n';}
int main(int argc,char**argv){if(argc<5){cerr<<"tables input output-prefix [compute|test]\n";return 2;}ff::init(argv[1]);AddFFT fft;auto t=Clock::now();
 if(string(argv[4])=="test"){mt19937 gen(149140);for(int s=0;s<=8;s++){for(int it=0;it<4;it++){int n=fft.p5[s],deg=(it==0?n-1:gen()%n);Poly p(deg+1);for(auto&c:p)c=gen()%ff::N;trim(p);auto vals=fft.evaluate(p,s);for(int k=0;k<min(n,40);k++){int h=gen()%n;if(eval(p,h)!=vals[h])throw runtime_error("additive eval mismatch");}if(fft.interpolate(vals,s)!=p)throw runtime_error("additive interpolation mismatch");}cerr<<"Additive level "<<s<<" passed\n";}return 0;}
 ifstream in(argv[2]);int dmin,dmax,md,nd;in>>dmin>>dmax>>md>>nd;auto a=readbi(in),b=readbi(in);int nf=0;in>>nf;vector<pair<int,Poly>> factors;for(int k=0;k<nf;k++){int e,n;in>>e>>n;Poly f(n);for(auto&c:f)in>>c;factors.push_back({e,f});}int degree=dmax-dmin;for(auto [e,f]:factors)degree-=e*(int(f.size())-1);
 int s=0;while(fft.p5[s]<=degree+1+nf){s++;if(s>8)throw runtime_error("interpolation needs larger coefficient field");}int N=fft.p5[s];vector<int>bad;for(int h=0;h<N;h++){bool nope=(h==0);for(auto &[e,f]:factors)if(e&&eval(f,h)==0)nope=true;if(nope)bad.push_back(h);}Poly erasure{1};for(int h:bad)erasure=mul(erasure,Poly{ff::neg(h),1});if(degree+(int)bad.size()>=N)throw runtime_error("erasure degree bound failed");
 cerr<<"declared degrees "<<md<<","<<nd<<"; quotient H-degree bound "<<degree<<"; additive grid "<<N<<"; erased "<<bad.size()<<"\n";
 vector<int>va((md+1)*N),vb((nd+1)*N);for(int j=0;j<=md;j++){auto vals=fft.evaluate(a[j],s);for(int h=0;h<N;h++)va[h*(md+1)+j]=vals[h];}cerr<<"first polynomial all evaluated "<<sec(t)<<" sec\n";
 for(int j=0;j<=nd;j++){auto vals=fft.evaluate(b[j],s);for(int h=0;h<N;h++)vb[h*(nd+1)+j]=vals[h];}cerr<<"both evaluated "<<sec(t)<<" sec\n";
 vector<int>values(N);int bi=0;for(int h=0;h<N;h++){if(bi<(int)bad.size()&&bad[bi]==h){bi++;continue;}Poly af(va.begin()+h*(md+1),va.begin()+(h+1)*(md+1)),bf(vb.begin()+h*(nd+1),vb.begin()+(h+1)*(nd+1));trim(af);trim(bf);int den=ff::pow(h,dmin);for(auto &[e,f]:factors)den=ff::mul(den,ff::pow(eval(f,h),e));values[h]=ff::mul(ff::mul(resultant(af,bf,md,nd),ff::inv(den)),eval(erasure,h));if(h%10000==0)cerr<<"resultant value "<<h<<" elapsed "<<sec(t)<<" sec\n";}
 cerr<<"all resultant values ready "<<sec(t)<<" sec\n";auto kpoly=fft.interpolate(values,s);auto p=exactdiv(kpoly,erasure);if((int)p.size()>degree+1)throw runtime_error("interpolation degree exceeded");string pre=argv[3];save(pre+".poly",p);save(pre+".erasure",erasure);save(pre+".grid_values",values);cerr<<"quotient degree "<<p.size()-1<<"; complete grid interpolation "<<sec(t)<<" sec\n";
 for(int h:vector<int>{100001,99999,200000,100000,150000}){bool skip=false;int den=ff::pow(h,dmin);for(auto &[e,f]:factors){int v=eval(f,h);if(!v)skip=true;den=ff::mul(den,ff::pow(v,e));}if(skip)continue;Poly af,bf;for(auto&f:a)af.push_back(eval(f,h));for(auto&f:b)bf.push_back(eval(f,h));trim(af);trim(bf);int want=ff::mul(resultant(af,bf,md,nd),ff::inv(den));if(eval(p,h)!=want)throw runtime_error("extra resultant value mismatch");}cerr<<"extra determinant evaluations agree. Interpolation identity exact by degree bound.\n";
}
