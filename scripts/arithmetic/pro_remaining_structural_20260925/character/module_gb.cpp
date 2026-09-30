// Exact certificate-producing module Buchberger algorithm over F25.
// Order: term-over-position, graded reverse lexicographic in the variables.
// Pair selection and chain criterion parallel SymPy sdm_groebner.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;
const int MAXV=12;int nv,nc;
uint8_t ad[25][25],mu[25][25],ng[25],iv[25];
struct Mon {array<uint16_t,MAXV> e{};uint16_t comp=0,deg=0;};
bool eq(const Mon&a,const Mon&b){return a.comp==b.comp&&a.e==b.e;}
int cmp(const Mon&a,const Mon&b){if(a.deg!=b.deg)return a.deg>b.deg?1:-1;for(int k=nv-1;k>=0;--k)if(a.e[k]!=b.e[k])return a.e[k]<b.e[k]?1:-1;if(a.comp!=b.comp)return a.comp<b.comp?1:-1;return 0;}
bool monDiv(const Mon&a,const Mon&b){if(a.comp!=b.comp)return false;for(int k=0;k<nv;++k)if(a.e[k]>b.e[k])return false;return true;}
Mon lcmM(const Mon&a,const Mon&b){Mon r;r.comp=a.comp;for(int k=0;k<nv;++k){r.e[k]=max(a.e[k],b.e[k]);r.deg+=r.e[k];}return r;}
Mon diffM(const Mon&a,const Mon&b){Mon r;for(int k=0;k<nv;++k){r.e[k]=a.e[k]-b.e[k];r.deg+=r.e[k];}return r;}
Mon shiftM(Mon a,const Mon&b){for(int k=0;k<nv;++k)a.e[k]+=b.e[k];a.deg+=b.deg;return a;}
struct Term{Mon m;uint8_t c;};using Poly=vector<Term>;
Poly combine(const Poly&a,size_t begin,const Poly&b,const Mon&s,uint8_t cf){
 Poly out;out.reserve(a.size()-begin+b.size());size_t i=begin,j=0;
 while(i<a.size()||j<b.size()){
  if(j==b.size()){out.insert(out.end(),a.begin()+i,a.end());break;}
  Mon bm=shiftM(b[j].m,s);uint8_t bc=ng[mu[cf][b[j].c]];
  if(i==a.size()){out.push_back({bm,bc});++j;continue;}
  int k=cmp(a[i].m,bm);
  if(k>0)out.push_back(a[i++]);else if(k<0){out.push_back({bm,bc});++j;}
  else{uint8_t v=ad[a[i].c][bc];if(v)out.push_back({bm,v});++i;++j;}
 }
 return out;
}
vector<Poly> G;vector<int>sugar;vector<vector<int>>bycomp;
struct Red{int i;Mon s;uint8_t c;};
Poly nf(Poly f,vector<Red>&rs){
 Poly rem;size_t start=0;
 while(start<f.size()){
  Term lead=f[start];int gi=-1;
  for(int i:bycomp[lead.m.comp])if(monDiv(G[i][0].m,lead.m)){gi=i;break;}
  if(gi<0){rem.push_back(lead);++start;continue;}
  Mon s=diffM(lead.m,G[gi][0].m);uint8_t c=mu[lead.c][iv[G[gi][0].c]];
  rs.push_back({gi,s,c});f=combine(f,start,G[gi],s,c);start=0;
 }
 return rem;
}
struct Pair{int i,j,s;Mon lm;};vector<Pair>pairs;
int psugar(int i,int j,const Mon&lm){return max(sugar[i]-int(G[i][0].m.deg),sugar[j]-int(G[j][0].m.deg))+lm.deg;}
bool pairLess(const Pair&a,const Pair&b){if(a.s!=b.s)return a.s<b.s;int c=cmp(a.lm,b.lm);if(c)return c<0;return a.j<b.j;}
void addG(Poly f,int sg){
 int k=G.size();G.push_back(move(f));sugar.push_back(sg);Mon lm=G[k][0].m;
 vector<Pair>keep;keep.reserve(pairs.size());
 for(auto&p:pairs){bool erase=false;if(lm.comp==p.lm.comp){Mon a=lcmM(lm,G[p.i][0].m),b=lcmM(lm,G[p.j][0].m);erase=!eq(a,p.lm)&&!eq(b,p.lm)&&monDiv(a,p.lm)&&monDiv(b,p.lm);}if(!erase)keep.push_back(p);}
 vector<Pair>np;
 for(int i:bycomp[lm.comp]){Mon l=lcmM(lm,G[i][0].m);np.push_back({i,k,psugar(i,k,l),l});}
 sort(np.begin(),np.end(),pairLess);vector<bool>rm(np.size());
 for(size_t i=0;i<np.size();++i)for(size_t j=i+1;j<np.size();++j)if(monDiv(np[i].lm,np[j].lm))rm[j]=true;
 for(size_t i=0;i<np.size();++i)if(!rm[i])keep.push_back(np[i]);
 pairs.swap(keep);bycomp[lm.comp].push_back(k);
}
int constant_rank(){
 vector<vector<uint8_t>>A;for(auto&g:G)if(g[0].m.deg==0){vector<uint8_t>r(nc);for(auto&t:g)r[t.m.comp]=t.c;A.push_back(r);}
 int r=0;for(int j=0;j<nc&&r<(int)A.size();++j){int q=r;while(q<(int)A.size()&&!A[q][j])++q;if(q==(int)A.size())continue;swap(A[q],A[r]);uint8_t s=iv[A[r][j]];for(auto&x:A[r])x=mu[s][x];for(int i=r+1;i<(int)A.size();++i)if(A[i][j]){s=A[i][j];for(int k=j;k<nc;++k)A[i][k]=ad[A[i][k]][ng[mu[s][A[r][k]]]];}++r;}return r;
}
void writepoly(ostream&os,const Poly&g){for(auto&t:g){os<<"T "<<t.m.comp;for(int k=0;k<nv;++k)os<<' '<<t.m.e[k];os<<' '<<int(t.c)<<'\n';}}
int main(int argc,char**argv){
 if(argc<4){cerr<<"Usage: module_gb INPUT CERTIFICATE SECONDS\n";return 2;}
 for(int a=0;a<25;++a){ng[a]=(-a%5+5)%5+5*((-(a/5)+5)%5);for(int b=0;b<25;++b){ad[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);mu[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
 for(int a=1;a<25;++a)for(int b=1;b<25;++b)if(mu[a][b]==1)iv[a]=b;
 ifstream in(argv[1]);if(!in)throw runtime_error("Cannot read input");int ns;in>>nv>>nc>>ns;if(nv>MAXV)throw runtime_error("Too many variables");bycomp.resize(nc);
 ofstream cert(argv[2]);cert<<"MODULE_DAG_V1 "<<nv<<' '<<nc<<' '<<ns<<'\n';
 for(int i=0;i<ns;++i){int nt;in>>nt;Poly p;for(int j=0;j<nt;++j){Term t;int cc;in>>t.m.comp;for(int k=0;k<nv;++k){in>>t.m.e[k];t.m.deg+=t.m.e[k];}in>>cc;t.c=cc;p.push_back(t);}sort(p.begin(),p.end(),[](const Term&a,const Term&b){return cmp(a.m,b.m)>0;});if(p.empty())throw runtime_error("Zero generator");uint8_t v=iv[p[0].c];for(auto&t:p)t.c=mu[v][t.c];cert<<"INIT "<<i<<' '<<p.size()<<'\n';writepoly(cert,p);int dg=p[0].m.deg;addG(move(p),dg);}
 auto start=chrono::steady_clock::now();double limit=stod(argv[3]),last=0;long steps=0;int cr=constant_rank();
 while(!pairs.empty()&&cr<nc){
  auto it=min_element(pairs.begin(),pairs.end(),pairLess);Pair p=*it;pairs.erase(it);++steps;
  Mon si=diffM(p.lm,G[p.i][0].m),sj=diffM(p.lm,G[p.j][0].m);Poly a=G[p.i];for(auto&t:a)t.m=shiftM(t.m,si);Poly sp=combine(a,0,G[p.j],sj,1);vector<Red>rs;Poly h=nf(move(sp),rs);
  if(!h.empty()){uint8_t v=iv[h[0].c];for(auto&t:h)t.c=mu[v][t.c];int idx=G.size();cert<<"ADD "<<idx<<' '<<p.i<<' '<<p.j<<' '<<int(v)<<' '<<h.size()<<' '<<rs.size()<<'\n';writepoly(cert,h);for(auto&r:rs){cert<<"R "<<r.i;for(int k=0;k<nv;++k)cert<<' '<<r.s.e[k];cert<<' '<<int(r.c)<<'\n';}int dg=h[0].m.deg;addG(move(h),p.s);if(dg==0)cr=constant_rank();}
  double elapsed=chrono::duration<double>(chrono::steady_clock::now()-start).count();
  if(elapsed-last>5){cout<<"progress seconds="<<elapsed<<" processed="<<steps<<" basis="<<G.size()<<" pending="<<pairs.size()<<" sugar="<<p.s<<" constants="<<cr<<endl;last=elapsed;cert.flush();}
  if(elapsed>limit){cout<<"BOUNDED_STOP seconds="<<elapsed<<" basis="<<G.size()<<" constants="<<cr<<endl;cert<<"STOP\n";return 3;}
 }
 cout<<"DONE processed="<<steps<<" basis="<<G.size()<<" constants="<<cr<<" seconds="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;cert<<"END "<<cr<<'\n';return cr==nc?0:1;
}
