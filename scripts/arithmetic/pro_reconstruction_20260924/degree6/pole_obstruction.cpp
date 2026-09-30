#include <array>
#include <vector>
#include <set>
#include <map>
#include <algorithm>
#include <iostream>
#include <fstream>
#include <cassert>
#include <cstdint>
#include <string>
#ifdef NDEBUG
#error "Compile this certificate with assertions enabled (do not use -DNDEBUG)."
#endif
using namespace std;

// F_5[z]/(M), M = 1+2z+4z^2+4z^4+4z^5+3z^6+z^7+
//                    3z^8+4z^9+4z^10+4z^12+2z^13+z^14.
const int N=14;
const int MOD[N]={1,2,4,0,4,4,3,1,3,4,4,0,4,2};
const uint64_t CARD=6103515625ULL;
struct K {
 array<uint8_t,N> c{};
 K()=default;
 K(int x) {x%=5; if(x<0)x+=5; c[0]=x;}
 bool zero()const {for(auto a:c)if(a)return false;return true;}
 uint64_t code()const {uint64_t x=0;for(int i=N-1;i>=0;--i)x=5*x+c[i];return x;}
 friend bool operator==(const K&a,const K&b){return a.c==b.c;}
 friend bool operator!=(const K&a,const K&b){return !(a==b);}
 friend K operator+(const K&a,const K&b){K r;for(int i=0;i<N;i++)r.c[i]=(a.c[i]+b.c[i])%5;return r;}
 friend K operator-(const K&a,const K&b){K r;for(int i=0;i<N;i++)r.c[i]=(a.c[i]+5-b.c[i])%5;return r;}
 K operator-()const {return K(0)-*this;}
 friend K operator*(const K&a,const K&b){
  int t[2*N-1]={0};
  for(int i=0;i<N;i++)if(a.c[i])for(int j=0;j<N;j++)t[i+j]+=a.c[i]*b.c[j];
  for(int i=2*N-2;i>=N;--i){int z=t[i]%5;if(z)for(int j=0;j<N;j++)t[i-N+j]+=z*(5-MOD[j]);}
  K r;for(int i=0;i<N;i++)r.c[i]=t[i]%5;return r;
 }
 K pow(uint64_t n)const {K a=*this,r(1);while(n){if(n&1)r=r*a;a=a*a;n>>=1;}return r;}
 K inv()const{assert(!zero());K r=pow(CARD-2);assert(r*(*this)==K(1));return r;}
 friend K operator/(const K&a,const K&b){return a*b.inv();}
};
using Vec=vector<K>;using Mat=vector<Vec>;using Poly=Vec;
vector<Vec> nullspace(Mat a,int nc){
 int nr=a.size(),r=0;vector<int> piv;
 for(int j=0;j<nc&&r<nr;j++){
  int k=r;while(k<nr&&a[k][j].zero())k++;if(k==nr)continue;
  swap(a[k],a[r]);K u=a[r][j].inv();for(int h=j;h<nc;h++)a[r][h]=a[r][h]*u;
  for(int i=0;i<nr;i++)if(i!=r){K t=a[i][j];for(int h=j;h<nc;h++)a[i][h]=a[i][h]-t*a[r][h];}
  piv.push_back(j);r++;
 }
 vector<Vec> out;
 for(int j=0;j<nc;j++)if(find(piv.begin(),piv.end(),j)==piv.end()){
  Vec v(nc);v[j]=K(1);for(int i=0;i<r;i++)v[piv[i]]=-a[i][j];out.push_back(v);
 }
 return out;
}
K eval(const Poly&p,K x){K r;for(int j=(int)p.size()-1;j>=0;j--)r=r*x+p[j];return r;}
Poly deriv(const Poly&p){Poly r(max(0,(int)p.size()-1));for(int j=1;j<(int)p.size();j++)r[j-1]=p[j]*K(j);return r;}
Poly add(Poly a,const Poly&b){a.resize(max(a.size(),b.size()));for(int j=0;j<(int)b.size();j++)a[j]=a[j]+b[j];return a;}
Poly scale(Poly a,K x){for(auto &v:a)v=v*x;return a;}
Poly mul(const Poly&a,const Poly&b){Poly r(a.size()+b.size()-1);for(int i=0;i<(int)a.size();i++)for(int j=0;j<(int)b.size();j++)r[i+j]=r[i+j]+a[i]*b[j];return r;}
Poly lincomb(const vector<Vec>&basis,K a,K b){return add(scale(basis[0],a),scale(basis[1],b));}
void trim(Poly &p){while(!p.empty()&&p.back().zero())p.pop_back();}
bool pzero(Poly p){trim(p);return p.empty();}
Poly sub(Poly a,const Poly&b){return add(a,scale(b,K(-1)));}
Poly shift(Poly a,int n){a.insert(a.begin(),n,K(0));return a;}
Poly divexact(Poly a,Poly b){
 trim(a);trim(b);assert(!b.empty());Poly r(max(0,int(a.size())-int(b.size())+1));K inv=b.back().inv();
 while(a.size()>=b.size()){
  int j=a.size()-b.size();K t=a.back()*inv;r[j]=t;
  for(int h=0;h<int(b.size());h++) { a[h+j]=a[h+j]-t*b[h]; }
  trim(a);
 }
 assert(a.empty());return r;
}
Poly rem(Poly a,Poly b){
 trim(a);trim(b);assert(!b.empty());K inv=b.back().inv();
 while(a.size()>=b.size()){
  int j=a.size()-b.size();K t=a.back()*inv;
  for(int h=0;h<int(b.size());h++) { a[h+j]=a[h+j]-t*b[h]; }
  trim(a);
 }
 return a;
}
Poly ppow(Poly p,int n){Poly r={K(1)};while(n){if(n&1)r=mul(r,p);p=mul(p,p);n>>=1;}return r;}
K det3(Mat a){assert(a.size()==3&&a[0].size()==3);return
 a[0][0]*(a[1][1]*a[2][2]-a[1][2]*a[2][1])
 -a[0][1]*(a[1][0]*a[2][2]-a[1][2]*a[2][0])
 +a[0][2]*(a[1][0]*a[2][1]-a[1][1]*a[2][0]);}
void printvec(ofstream &out, const Vec &p) {out<<"[";for(int i=0;i<int(p.size());i++){if(i)out<<",";out<<p[i].code();}out<<"]";}


int main(int argc,char**argv){
 string path=argc>1?argv[1]:"pole_cases.csv";ofstream out(path);
 out<<"e0,e1,e2,j1,j2,dimension,status,obstruction,c1,c2,determinant\n";
 ofstream cert("exact_certificate.jsonl");
 if(!out || !cert) { cerr<<"Cannot open certificate output files.\n"; return 2; }
 K z;z.c[1]=1;assert(z.pow(29)==K(1));assert(z!=K(1));
 // M divides Phi_29, and ord_29(5)=14, so this quotient is a field.
 K geom(0);for(int i=0;i<29;i++)geom=geom+z.pow(i);assert(geom.zero());
 int ord=1,pp=5;while(pp!=1){pp=(5*pp)%29;ord++;}assert(ord==14);

 K g;
 for(int i=1;i<5;i++){g=(z+K(i)).pow((CARD-1)/8);if(g.pow(4)==K(-1))break;}
 assert(g.pow(8)==K(1)&&g.pow(4)==K(-1));
 cerr<<"z code "<<z.code()<<", mu8 generator code "<<g.code()<<"\n";
 vector<K> qs(29),roots8(8);for(int i=0;i<29;i++)qs[i]=z.pow(i);for(int i=0;i<8;i++)roots8[i]=g.pow(i);
 set<array<int,3>> layouts;
 for(int a=0;a<29;a++)for(int b=a+1;b<29;b++)for(int c=b+1;c<29;c++){
  array<int,3> ar={a,b,c},best={29,29,29};
  for(int sg:{-1,1})for(int h=0;h<29;h++){
   array<int,3> t;for(int i=0;i<3;i++)t[i]=((sg*ar[i]+h)%29+29)%29;sort(t.begin(),t.end());best=min(best,t);
  }layouts.insert(best);
 }
 assert(layouts.size()==70);map<string,int> counts;int candidates=0;
 for(auto es:layouts){
  array<K,3> q={qs[es[0]],qs[es[1]],qs[es[2]]};Poly D={K(1)};for(K x:q)D=mul(D,Poly{-x,K(1)});
  Poly Dp=deriv(D),Dpp=deriv(Dp);array<K,3> dp,dpp;
  Mat M1(3,Vec(5)),M2(3,Vec(5));
  for(int i=0;i<3;i++){
   dp[i]=eval(Dp,q[i]);dpp[i]=eval(Dpp,q[i]);
   for(int j=0;j<5;j++){
    K qj=q[i].pow(j),diff=j?K(j)*q[i].pow(j-1):K(0);
    M1[i][j]=K(2)*dp[i]*diff-dpp[i]*qj;
    M2[i][j]=K(2)*q[i]*dp[i]*diff-(K(4)*dp[i]+q[i]*dpp[i])*qj;
   }
  }
  auto U=nullspace(M1,5),V=nullspace(M2,5);assert(U.size()==2&&V.size()==2);
  array<array<K,2>,3> ue,ve;
  array<array<K,3>,3> invdiff;
  for(int i=0;i<3;i++){for(int j=0;j<2;j++){ue[i][j]=eval(U[j],q[i]);ve[i][j]=eval(V[j],q[i]);}for(int j=0;j<3;j++)if(i!=j)invdiff[i][j]=(q[i]-q[j]).inv();}
  for(int j1=0;j1<8;j1++)for(int j2=0;j2<8;j2++){
   array<K,3> xi={K(1),roots8[j1],roots8[j2]};Mat H(3,Vec(4));
   for(int i=0;i<3;i++){K w=q[i].pow(4)*xi[i];for(int j=0;j<2;j++){H[i][j]=-w*ue[i][j];H[i][2+j]=ve[i][j];}}
   auto W=nullspace(H,4);string status;K obstruction,c1,c2,determinant;
   if(W.size()!=1){status="rank_degenerate";}
   else {
    auto w=W[0];Poly B1=lincomb(U,w[0],w[1]),B2=lincomb(V,w[2],w[3]);
    array<K,3> u,v,l,a,b,h1,h2;
    bool polezero=false;
    for(int i=0;i<3;i++){
     K e1=eval(B1,q[i]),e2=eval(B2,q[i]);assert(e2==q[i].pow(4)*xi[i]*e1);if(e1.zero())polezero=true;
     u[i]=e1/dp[i];v[i]=e2/(q[i].pow(2)*dp[i]);l[i]=q[i].pow(4)*xi[i].pow(2);a[i]=-u[i]*u[i];b[i]=-v[i]*v[i];assert(b[i]==l[i]*a[i]);
    }
    if(polezero)status="zero_at_D";
    else if(B1[4].zero()||B2[4].zero())status="degree_drop";
    else if(B1[0].zero()||B2[0].zero())status="zero_at_0";
    else{
     // Polynomial part of B1/D = lead*s + next + simple poles.
     K aa=B1[4],bb=B1[3]-aa*D[2],sumu=u[0]+u[1]+u[2];
     Poly pol1={K(0),bb*bb+K(2)*aa*sumu,aa*bb,aa*aa/K(3)};
     K vm2=B2[0]/D[0],vm1=B2[1]/D[0]-B2[0]*D[1]/(D[0]*D[0]);
     K w0;for(int i=0;i<3;i++)w0=w0-v[i]/q[i];
     array<K,4> pole0={K(0),-(vm1*vm1+K(2)*vm2*w0),-vm2*vm1,-vm2*vm2/K(3)};
     for(int i=0;i<3;i++){
      h1[i]=eval(pol1,q[i]);
      for(int d=1;d<=3;d++)h2[i]=h2[i]+pole0[d]/q[i].pow(d);
      for(int j=0;j<3;j++)if(i!=j){h1[i]=h1[i]+a[j]*invdiff[i][j];h2[i]=h2[i]+b[j]*invdiff[i][j];}
     }
     array<K,3> rhs;
     for(int i=0;i<3;i++)rhs[i]=l[i]*h1[i]-h2[i]-K(2)*l[i]*a[i]/q[i];
     assert(l[0]!=l[1]&&l[0]!=l[2]&&l[1]!=l[2]);
     c1=(rhs[1]-rhs[0])/(l[0]-l[1]);c2=rhs[0]+l[0]*c1;
     obstruction=c2-l[2]*c1-rhs[2];
     
     // Independent polynomial check of both integrations, followed by a
     // direct D^2-congruence obstruction (no Laurent-series calculation).
     Poly N1=mul(pol1,D),N2(1);
     for(int d=1;d<=3;d++)N2=add(N2,scale(shift(D,3-d),pole0[d]));
     for(int i=0;i<3;i++){
      Poly Di=divexact(D,Poly{-q[i],K(1)});
      N1=add(N1,scale(Di,a[i]));N2=add(N2,scale(shift(Di,3),b[i]));
     }
     trim(N1);trim(N2);
     assert(pzero(sub(sub(mul(deriv(N1),D),mul(N1,Dp)),mul(B1,B1))));
     assert(pzero(sub(sub(shift(mul(D,deriv(N2)),1),mul(add(scale(D,K(3)),shift(Dp,1)),N2)),mul(B2,B2))));
     Poly T0=sub(shift(ppow(N2,4),1),ppow(N1,4));
     Poly E0=rem(divexact(T0,D),D);
     Poly E1=rem(scale(ppow(N1,3),K(-4)),D);
     Poly E2=rem(scale(shift(ppow(N2,3),4),K(4)),D);
     E0.resize(3);E1.resize(3);E2.resize(3);
     Mat EM(3,Vec(3));for(int i=0;i<3;i++){EM[i][0]=E1[i];EM[i][1]=E2[i];EM[i][2]=E0[i];}
     determinant=det3(EM);
     assert(determinant.zero()==obstruction.zero());
     assert(!determinant.zero());
     Vec witness={E1[1]*E2[2]-E1[2]*E2[1], E1[2]*E2[0]-E1[0]*E2[2], E1[0]*E2[1]-E1[1]*E2[0]};
     witness=scale(witness,determinant.inv());
     K w0test,w1test,w2test;
     for(int i=0;i<3;i++){w0test=w0test+witness[i]*E0[i];w1test=w1test+witness[i]*E1[i];w2test=w2test+witness[i]*E2[i];}
     assert(w0test==K(1)&&w1test.zero()&&w2test.zero());
     cert<<"{\"layout\":["<<es[0]<<","<<es[1]<<","<<es[2]<<"],\"xi_exponents\":[0,"<<j1<<","<<j2<<"],\"B1\":";
     printvec(cert,B1);cert<<",\"B2\":";printvec(cert,B2);
     cert<<",\"N1\":";printvec(cert,N1);cert<<",\"N2\":";printvec(cert,N2);
     cert<<",\"E0\":";printvec(cert,E0);cert<<",\"E1\":";printvec(cert,E1);cert<<",\"E2\":";printvec(cert,E2);
     cert<<",\"determinant\":"<<determinant.code()<<",\"unit_witness\":";printvec(cert,witness);cert<<"}\n";
     status=obstruction.zero()?"survivor":"pole3_obstruction";

     if(status=="survivor"){
      cerr<<"SURVIVOR "<<es[0]<<","<<es[1]<<","<<es[2]<<" xi "<<j1<<","<<j2<<"\n";
      ofstream sx("survivor_"+to_string(es[1])+"_"+to_string(es[2])+"_"+to_string(j1)+"_"+to_string(j2)+".txt");
      for(auto bp:{B1,B2}){for(K v:bp)sx<<v.code()<<",";sx<<"\n";}
      sx<<c1.code()<<","<<c2.code()<<","<<determinant.code()<<"\n";
     }
    }
   }
   out<<es[0]<<","<<es[1]<<","<<es[2]<<","<<j1<<","<<j2<<","<<W.size()<<","<<status<<","<<obstruction.code()<<","<<c1.code()<<","<<c2.code()<<","<<determinant.code()<<"\n";
   counts[status]++;candidates++;
  }
 }
 cerr<<"TOTAL "<<candidates<<"\n";for(auto p:counts)cerr<<p.first<<" "<<p.second<<"\n";
 assert(candidates==4480);assert(counts.size()==1&&counts["pole3_obstruction"]==4480);
 cerr<<"All exact integral identities and 4480 nonzero D^2-obstruction determinants verified.\n";

 return 0;
}
