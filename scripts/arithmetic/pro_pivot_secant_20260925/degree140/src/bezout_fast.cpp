#include "fast_exact.cpp"
#include "additive_fft.hpp"
#include <chrono>
using Clock=chrono::steady_clock;
double seconds(Clock::time_point t){return chrono::duration<double>(Clock::now()-t).count();}
Poly readp(const string&file){ifstream in(file);int n;in>>n;if(!in)throw runtime_error("file read");Poly p(n);for(auto&c:p)in>>c;return p;}
void writep(const string&file,const Poly&p){ofstream out(file);out<<p.size()<<'\n';for(auto c:p)out<<c<<' ';out<<'\n';}
using Mat=array<Poly,4>;
Mat matmul(const Mat&B,const Mat&A,const AddFFT&fft){int na=0,nb=0;for(auto&p:A)na=max(na,int(p.size()));for(auto&p:B)nb=max(nb,int(p.size()));Mat C;
 if(na+nb<150){for(int i=0;i<2;i++)for(int j=0;j<2;j++)C[2*i+j]=add(mul(B[2*i],A[j]),mul(B[2*i+1],A[2+j]));return C;}
 int s=0;while(fft.p5[s]<na+nb-1){if(++s>8)throw runtime_error("matrix product degree exceeds field grid");}int n=fft.p5[s];array<vector<int>,4>ea,eb;for(int i=0;i<4;i++){ea[i]=fft.evaluate(A[i],s);eb[i]=fft.evaluate(B[i],s);}for(int i=0;i<2;i++)for(int j=0;j<2;j++){vector<int>v(n);for(int h=0;h<n;h++)v[h]=ff::add(ff::mul(eb[2*i][h],ea[j][h]),ff::mul(eb[2*i+1][h],ea[2+j][h]));C[2*i+j]=fft.interpolate(v,s);}return C;}
Mat matrix_product(const vector<Poly>&q,int l,int r,const AddFFT&fft){if(r-l<=32){Mat M{Poly{1},Poly{},Poly{},Poly{1}};for(int k=l;k<r;k++){Mat N;N[0]=M[2];N[1]=M[3];N[2]=sub(M[0],mul(q[k],M[2]));N[3]=sub(M[1],mul(q[k],M[3]));M=move(N);}return M;}int mid=(l+r)/2;auto A=matrix_product(q,l,mid,fft),B=matrix_product(q,mid,r,fft);return matmul(B,A,fft);}
void verify(const Poly&a,const Poly&b,const Poly&s,const Poly&t,const Poly&g,const AddFFT&fft){int deg=max(int(a.size()+s.size())-2,int(b.size()+t.size())-2);deg=max(deg,int(g.size())-1);int level=0;while(fft.p5[level]<=deg)level++;if(level>8)throw runtime_error("verification grid too small");auto va=fft.evaluate(a,level),vb=fft.evaluate(b,level),vs=fft.evaluate(s,level),vt=fft.evaluate(t,level),vg=fft.evaluate(g,level);for(int h=0;h<fft.p5[level];h++)if(ff::add(ff::mul(va[h],vs[h]),ff::mul(vb[h],vt[h]))!=vg[h])throw runtime_error("polynomial Bezout identity failed");cerr<<"Bezout identity verified at "<<fft.p5[level]<<" distinct field points, exceeding degree "<<deg<<".\n";}
int main(int argc,char**argv){if(argc<5)return 2;ff::init(argv[1]);AddFFT fft;auto aa=readp(argv[2]),bb=readp(argv[3]);auto t=Clock::now();string pre=argv[4];
 if(argc>5&&string(argv[5])=="verify"){verify(aa,bb,readp(pre+".a"),readp(pre+".b"),readp(pre+".gcd"),fft);cerr<<"Certificate verified in "<<seconds(t)<<" seconds.\n";return 0;}
 auto a=aa,b=bb;vector<Poly>qs;int steps=0;while(b.size()){auto qr=divmod(a,b);a=move(b);b=move(qr.second);qs.push_back(move(qr.first));steps++;if(steps%10000==0)cerr<<"Euclidean step "<<steps<<" remainder degree "<<b.size()-1<<" seconds "<<seconds(t)<<endl;}
 cerr<<"Euclidean gcd degree "<<a.size()-1<<"; steps "<<steps<<"; seconds "<<seconds(t)<<endl;auto M=matrix_product(qs,0,qs.size(),fft);int iv=ff::inv(a.back());auto g=sc(a,iv),s=sc(M[0],iv),tt=sc(M[1],iv);writep(pre+".gcd",g);writep(pre+".a",s);writep(pre+".b",tt);cerr<<"Bezout multipliers of degrees "<<s.size()-1<<","<<tt.size()-1<<" constructed in "<<seconds(t)<<" seconds.\n";verify(aa,bb,s,tt,g,fft);cerr<<"All exact checks passed in "<<seconds(t)<<" seconds.\n";}
