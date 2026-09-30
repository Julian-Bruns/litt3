// Exact residual interpolation on each full irreducible incidence factor.
#define FINITE_ALGEBRA_NO_MAIN
#include "finite_algebra.cpp"
#include "kpoly.hpp"
#include <filesystem>
using E=KP;
static KP MOD;static int ND;static vector<KP> FROB;
static int XV,PV;
int fp(int a,int n){if(n==0)return 1;if(!a)return 0;long long z=(long long)LG[a]*n%MM;if(z<0)z+=MM;return EX[z];}
E ea(E a,const E&b){return pa(a,b);} E en(E a){return pn(a);} E es(E a,const E&b){return ps(a,b);}
E ec(E a,int c){return sc(a,c);}
E em(const E&a,const E&b){if(a.empty()||b.empty())return {};if(a.size()==1)return sc(b,a[0]);if(b.size()==1)return sc(a,b[0]);return md(pm(a,b),MOD);}
E ep(E a,int n){E b={1};while(n){if(n&1)b=em(b,a);n>>=1;if(n)a=em(a,a);}return b;}
E eqshift(E a,int k){
 a.resize(ND);
 if(k>=0)for(int j=0;j<k;j++){
  int c=a[ND-1];for(int i=ND-1;i>=1;i--)a[i]=sub(a[i-1],mul(c,MOD[i]));a[0]=neg(mul(c,MOD[0]));
 }
 else for(int j=0;j<-k;j++){
  int c=mul(a[0],inv(MOD[0]));for(int i=0;i<ND-1;i++)a[i]=sub(a[i+1],mul(c,MOD[i+1]));a[ND-1]=neg(c);
 }
 trim(a);return a;
}
E ef(E a){E out(ND);for(int i=0;i<(int)a.size();i++)if(a[i]){int c=fp(a[i],5);for(int j=0;j<(int)FROB[i].size();j++)out[j]=add(out[j],mul(c,FROB[i][j]));}trim(out);return out;}
struct C{array<E,3> v;};
C ca(C a,const C&b){for(int j=0;j<3;j++)a.v[j]=ea(a.v[j],b.v[j]);return a;}
C cn(C a){for(auto&v:a.v)v=en(v);return a;}
C cs(C a,int c){for(auto&v:a.v)v=ec(v,c);return a;}
C cm(const C&a,const C&b){
 array<E,5> z;for(int i=0;i<3;i++)for(int j=0;j<3;j++)z[i+j]=ea(z[i+j],em(a.v[i],b.v[j]));
 C c;c.v={ea(z[0],ec(eqshift(z[3],-1),PV)),ea(z[1],ec(eqshift(z[4],-1),PV)),z[2]};return c;
}
C cf(const C&a){C b;for(int j=0;j<3;j++){int e=5*j;b.v[e%3]=ec(eqshift(ef(a.v[j]),-(e/3)),fp(PV,e/3));}return b;}
C cp(C a,int n){C b;b.v[0]={1};while(n){if(n&1)b=cm(b,a);n>>=1;if(n)a=cm(a,a);}return b;}
C operator+(C a,const C&b){return ca(a,b);}C operator-(C a,const C&b){return ca(a,cn(b));}C operator-(C a){return cn(a);}C operator*(const C&a,const C&b){return cm(a,b);}C operator*(C a,int n){return cs(a,n);}C operator*(int n,C a){return cs(a,n);}
using EP=vector<E>;
EP epa(EP a,const EP&b){a.resize(max(a.size(),b.size()));for(int i=0;i<(int)b.size();i++)a[i]=ea(a[i],b[i]);return a;}
EP epn(EP a){for(auto&v:a)v=en(v);return a;}
EP epm(const EP&a,const EP&b){EP c(a.size()+b.size()-1);for(int i=0;i<(int)a.size();i++)for(int j=0;j<(int)b.size();j++)c[i+j]=ea(c[i+j],em(a[i],b[j]));return c;}
EP eps(EP a,int k,int c){for(auto&v:a)v=ec(eqshift(v,k),c);return a;}
EP norm(const array<C,3>&D){
 EP a(3),b(3),c(3);for(int i=0;i<3;i++){a[i]=D[i].v[0];b[i]=D[i].v[1];c[i]=D[i].v[2];}
 EP out=epm(epm(a,a),a);out=epa(out,eps(epm(epm(b,b),b),-1,PV));out=epa(out,eps(epm(epm(c,c),c),-2,mul(PV,PV)));out=epa(out,eps(epm(epm(a,b),c),-1,mul(2,PV)));return out;
}
struct Term{int c,h,q,x;};
using Fun=vector<Term>;
map<string,Fun> funs;
map<string,vector<E>> specialized;
E HH;
void specialize(){
 specialized.clear();
 for(auto [name,terms]:funs){
  int degree=0;for(auto t:terms)degree=max(degree,t.x);vector<E> row(degree+1);
  for(auto t:terms){E v=t.h?ep(HH,t.h):E{1};v=ec(eqshift(v,t.q),t.c);row[t.x]=ea(row[t.x],v);}
  specialized[name]=row;
 }
}
E eval(const string&name,int x){E out;auto&row=specialized[name];for(int i=row.size()-1;i>=0;i--)out=ea(ec(out,x),row[i]);return out;}
array<C,3> resultant(int x){
 XV=x;E pp=eval("P",x);if(pp.size()>1)abort();PV=pp.empty()?0:pp[0];
 E tt=eval("t",x);if(tt.size()>1)abort();
 C a,b,c,d,QQ,TT;
 a.v[0]=ec(eval("Z",x),3);a.v[1]=ec(eqshift(E{3794},2),3);
 b.v[0]=ec(eqshift(eval("A3",x),1),2);b.v[1]=ec(eqshift(eval("B3",x),1),2);b.v[2]=ec(eval("C3",x),2);
 c.v[0]=eval("B4",x);c.v[1]=eqshift(eval("C4",x),-1);c.v[2]=eqshift(eval("A4",x),1);
 d.v[0]=eqshift(eval("C5",x),-2);d.v[1]=eval("A5",x);d.v[2]=eval("B5",x);
 QQ.v[1]=eqshift(eval("C0",x),-3);TT.v[0]=eqshift(E{fp(tt.empty()?0:tt[0],3)},-4);
 C a2=a*a,a3=a2*a,b2=b*b,b3=b2*b,c2=c*c,c3=c2*c;
 C a5=cf(a),b5=cf(b),c5=cf(c);
 C delta=b2+a*c;
 C J=b3-a*b*c+2*(a2*d);
 C AA=c5-b5*QQ+a5*(QQ*QQ);
 C KK=a3*QQ*J-d*b5-2*(c2*(delta*delta))+a*b2*c3;
 C SS=2*(b2*c2)+a*c3+d*J-a2*(d*d);
 C EE=-b5+2*(a5*QQ);
 C D2=AA*AA;
 C D1=AA*KK+TT*(EE*EE-2*(a5*AA));
 C D0=a3*(AA*SS+TT*(EE*J-a2*KK))+(a5*a5)*(TT*TT);
 return {D0,D1,D2};
}

#ifndef RESIDUAL_NO_MAIN
int main(int argc,char**argv){
 if(argc<5){cerr<<"usage residual field.bin factors.txt data_directory out_directory [only_factor_index]\n";return 2;}
 initfield(argv[1]);string dir=argv[3],outdir=argv[4];filesystem::create_directories(outdir);
 ifstream f(argv[2]);int nf;f>>nf;vector<KP> facs;for(int i=0;i<nf;i++){int n;f>>n;KP v(n);for(int&c:v)f>>c;facs.push_back(v);}
 ifstream hfile(dir+"/shape_H.txt");int ns;hfile>>ns;KP h(ns);for(int&c:h)hfile>>c;
 ifstream funcs(dir+"/residual_functions.txt");int nfun;funcs>>nfun;for(int i=0;i<nfun;i++){string name;int n;funcs>>name>>n;Fun ff(n);for(auto&t:ff)funcs>>t.c>>t.h>>t.q>>t.x;funs[name]=ff;}
 auto start=chrono::steady_clock::now();
 const int NPTS=156;int rho=fp(25,MM/NPTS);if(fp(rho,NPTS)!=1)abort();
 for(int k=0;k<nf;k++){
  if(argc>=6&&k!=stoi(argv[5]))continue;
  MOD=facs[k];ND=MOD.size()-1;HH=md(h,MOD);FROB.clear();E z={1};for(int j=0;j<ND;j++){FROB.push_back(z);z=eqshift(z,5);}specialize();
  int gamma=1;
  for(;;){bool ok=true;int x=gamma;for(int i=0;i<NPTS;i++){if(eval("t",x).empty()){ok=false;break;}x=mul(x,rho);}if(ok)break;gamma=mul(gamma,25);}
  cerr<<"factor="<<k<<" degree="<<ND<<" grid_size="<<NPTS<<" gamma="<<gamma<<endl;
  vector<EP> values;int x=gamma;
  for(int i=0;i<NPTS;i++){
   auto D=resultant(x);EP rr=norm(D);E tt=eval("t",x);int it=inv(fp(tt[0],15));for(E&v:rr)v=ec(v,it);values.push_back(rr);x=mul(x,rho);
   if(i%26==25)cerr<<"factor="<<k<<" evaluated="<<i+1<<" seconds="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
  }
  vector<vector<E>> coeff(7,vector<E>(NPTS));
  for(int j=0;j<NPTS;j++){
   int r=fp(rho,-j),fac=1;for(int i=0;i<NPTS;i++){for(int l=0;l<7;l++)coeff[l][j]=ea(coeff[l][j],ec(values[i][l],fac));fac=mul(fac,r);}
   // 156 equals 1 in characteristic five, hence no additional DFT scalar.
   int sca=fp(gamma,-j);for(int l=0;l<7;l++)coeff[l][j]=ec(coeff[l][j],sca);
  }
  for(int l=0;l<7;l++)for(int j=141;j<NPTS;j++)if(!coeff[l][j].empty()){cerr<<"DEGREE_FAILURE l="<<l<<" j="<<j<<endl;return 8;}
  for(int l=1;l<7;l++)if(!coeff[l][140].empty())abort();
  E ao;KP a0={89654,311173,214299,163299,315361,33043,356725,245794};for(int j=a0.size()-1;j>=0;j--)ao=ea(eqshift(ao,1),E{a0[j]});
  E a1=ea(eqshift(E{299833},1),eqshift(E{232505},2));E psi=ea(ao,em(a1,HH));
  int eps=add(add(24,mul(4,25)),mul(23,fp(25,3)));int lc=mul(2,mul(fp(eps,24),fp(299619,-6)));
  E expected=ec(eqshift(em(ep(HH,9),ep(psi,3)),10),lc);
  if(coeff[0][140]!=expected){cerr<<"LEADING_FAILURE\n";return 9;}
  cerr<<"factor="<<k<<" leading coefficient verified; x-degrees:";
  for(int l=0;l<7;l++){int d=140;while(d>=0&&coeff[l][d].empty())d--;cerr<<" "<<d;}cerr<<endl;
  ofstream out(outdir+"/residual_"+to_string(k)+".txt");out<<ND<<" 7 141\n";for(int l=0;l<7;l++)for(int j=0;j<141;j++){E v=coeff[l][j];v.resize(ND);for(int c:v)out<<c<<" ";out<<"\n";}
 }
 cerr<<"RESIDUALS_VERIFIED seconds="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
}

#endif
