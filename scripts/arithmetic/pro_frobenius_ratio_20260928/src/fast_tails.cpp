// Exact first-tail and fixed-degree resultant evaluator over the entire
// quadratic ratio algebra. No finite-field point search is a proof here.
#include "field.cpp"
#include <stdexcept>
#include <array>
#include <memory>
#include <chrono>
static inline F fpow(F a,uint64_t n){return n?(!a?0:exps[(uint64_t(logs[a])*(n%ORD))%ORD]):1;}
struct QE{F a=0,b=0; QE(){} QE(F a_):a(a_){} QE(F a_,F b_):a(a_),b(b_){} };
static F qz0,qz1;
static inline bool qzero(QE x){return !x.a&&!x.b;}
static inline QE qa(QE x,QE y){return QE(add(x.a,y.a),add(x.b,y.b));}
static inline QE qn(QE x){return QE(neg(x.a),neg(x.b));}
static inline QE qs(QE x,F t){return QE(mul(x.a,t),mul(x.b,t));}
static inline QE qm(QE x,QE y){
 F aa=mul(x.a,y.a),bb=mul(x.b,y.b);
 return QE(add(aa,mul(bb,qz0)),add(add(mul(x.a,y.b),mul(x.b,y.a)),mul(bb,qz1)));
}
static inline F qnorm(QE x){return add(add(mul(x.a,x.a),mul(qz1,mul(x.a,x.b))),neg(mul(qz0,mul(x.b,x.b))));}
static inline QE qi(QE x){F nn=qnorm(x);if(!nn)throw std::runtime_error("nonunit quadratic pivot");return qs(QE(add(x.a,mul(qz1,x.b)),neg(x.b)),inv(nn));}
static QE qp(QE x,unsigned n){QE r(1);for(;n;n>>=1,x=qm(x,x))if(n&1)r=qm(r,x);return r;}
static QE qf(QE x,unsigned n,QE zn){return qa(QE(fpow(x.a,n)),qs(zn,fpow(x.b,n)));}
static F evalp(const F*p,int n,F x){F r=0;for(int i=n-1;i>=0;--i)r=add(mul(r,x),p[i]);return r;}
static F rb[]={90885,339126,362701,194731,371097,144818};
static F rc[]={56518,278019,104390,351083,235630,246647,217983};
static F re[]={0,324104,260238,219737,136154,199269,240524,27757,108951,319279};
static void ratio_context(F q){F b=evalp(rb,6,q),c=evalp(rc,7,q),e=evalp(re,10,q);qz0=mul(2,mul(b,e));qz1=mul(3,c);}
static std::vector<F> interp_matrix(int n){
 std::vector<F> mat(n*n,0);
 for(int i=0;i<n;++i){std::vector<F> p(1,1);F d=1;
  for(int j=0;j<n;++j)if(j!=i){std::vector<F> pp(p.size()+1,0);for(size_t k=0;k<p.size();++k){pp[k]=add(pp[k],neg(mul(j,p[k])));pp[k+1]=add(pp[k+1],p[k]);}p.swap(pp);d=mul(d,add(i,neg(j)));}
  F id=inv(d);for(int k=0;k<n;++k)mat[k*n+i]=mul(p[k],id);
 }return mat;
}
static std::vector<F> im13,im19;
static void tails_init(){ff_init();if(im13.empty()){im13=interp_matrix(13);im19=interp_matrix(19);}}
using Small=std::array<QE,19>;
static std::vector<std::vector<QE>> first_tails(const std::vector<std::array<QE,7>>& A,int last=74){
 int N=last+1;std::vector<Small> a2(N),a3(N);std::vector<std::array<QE,19>> values2(N),values3(N);
 // Evaluation/interpolation in scale lowers the exact convolution count.
 for(int v=0;v<19;++v){std::vector<QE> av(N),v2(N),v3(N);
  for(int n=0;n<N;++n){QE val;for(int s=6;s>=0;--s)val=qa(qs(val,v),A[n][s]);av[n]=val;}
  for(int n=0;n<N;++n){QE val;for(int i=0;i<=n/2;++i){QE t=qm(av[i],av[n-i]);val=qa(val,i*2==n?t:qs(t,2));}v2[n]=val;if(v<13)values2[n][v]=val;}
  for(int n=0;n<N;++n){int rr=n%5;bool needed=false;for(int j=71;j<=last;++j)if(rr==j%5)needed=true;if(!needed)continue;
   QE val;for(int i=0;i<=n;++i)val=qa(val,qm(av[i],v2[n-i]));values3[n][v]=val;}
 }
 for(int n=0;n<N;++n){for(int s=0;s<13;++s){QE v;for(int i=0;i<13;++i)v=qa(v,qs(values2[n][i],im13[s*13+i]));a2[n][s]=v;}
  int rr=n%5;bool needed=false;for(int j=71;j<=last;++j)if(rr==j%5)needed=true;if(!needed)continue;
  for(int s=0;s<19;++s){QE v;for(int i=0;i<19;++i)v=qa(v,qs(values3[n][i],im19[s*19+i]));a3[n][s]=v;}
 }
 QE z5=qp(QE(0,1),5),z25=qp(QE(0,1),25);
 std::vector<Small> p5(last/5+1),p25(last/25+1);
 for(int i=0;i<=last/5;++i)for(int s=0;s<13;++s)p5[i][s]=qf(a2[i][s],5,z5);
 for(int i=0;i<=last/25;++i)for(int s=0;s<13;++s)p25[i][s]=qf(a2[i][s],25,z25);
 std::vector<std::vector<QE>> out;
 for(int n=71;n<=last;++n){int dm=3*n/4;std::vector<QE> val(dm+1);
  for(int j=0;j<=n/25;++j){std::vector<QE> inner(dm+1);
   for(int i=0;i<=(n-25*j)/5;++i){int at=n-25*j-5*i;
    for(int s=0;s<13;++s)if(!qzero(p5[i][s]))for(int t=0;t<19 && t+5*s<=dm;++t)if(!qzero(a3[at][t]))inner[t+5*s]=qa(inner[t+5*s],qm(a3[at][t],p5[i][s]));
   }
   for(int s=0;s<13;++s)if(!qzero(p25[j][s]))for(int t=0;t+25*s<=dm;++t)if(!qzero(inner[t]))val[t+25*s]=qa(val[t+25*s],qm(inner[t],p25[j][s]));
  }out.push_back(val);
 }return out;
}
static std::vector<std::array<QE,7>> model_eval(const F*G,int nq,F q,int N){
 std::vector<std::array<QE,7>> A(N); // G layout [2][141][7][nq]
 for(int n=0;n<N;++n)for(int s=0;s<7;++s){QE e;
  e.a=evalp(G+((0*141+n)*7+s)*nq,nq,q);e.b=evalp(G+((1*141+n)*7+s)*nq,nq,q);A[n][s]=e;}
 QE il=qi(A[0][0]);for(auto&row:A)for(auto &x:row)x=qm(x,il);
 return A;
}
static void qtrim(std::vector<QE>&a){while(!a.empty()&&qzero(a.back()))a.pop_back();}
static QE qres(std::vector<QE> a,std::vector<QE>b,int da,int db){
 qtrim(a);qtrim(b);if(a.empty()||b.empty())return QE();int n=a.size()-1,m=b.size()-1;QE res(1);
 if(n<da&&m<db)return QE();
 if(n<da){res=qp(b.back(),da-n);if(((da-n)*db)%2)res=qn(res);}
 if(m<db)res=qm(res,qp(a.back(),db-m));
 while(!b.empty()){
  n=a.size()-1;m=b.size()-1;
  if(!m)return qm(res,qp(b[0],n));
  if(n<m){a.swap(b);if((n*m)%2)res=qn(res);continue;}
  QE ib=qi(b.back());std::vector<QE> r=a;
  for(int i=n-m;i>=0;--i){QE t=qm(r[i+m],ib);if(!qzero(t))for(int j=0;j<=m;++j)r[i+j]=qa(r[i+j],qn(qm(t,b[j])));}
  qtrim(r);if(r.empty())return QE();int k=r.size()-1;
  res=qm(res,qp(b.back(),n-k));if((n*m)%2)res=qn(res);a.swap(b);b.swap(r);
 }return QE();
}
extern "C" {
int ft_tails_at_q(const F*G,int nq,F q,F*out,int last){
 try{tails_init();ratio_context(q);auto A=model_eval(G,nq,q,last+1);auto tt=first_tails(A,last);std::fill(out,out+(last-70)*56*2,0);
 for(int i=0;i<int(tt.size());++i)for(int j=0;j<int(tt[i].size());++j){out[(i*56+j)*2]=tt[i][j].a;out[(i*56+j)*2+1]=tt[i][j].b;}return 1;
 }catch(...){return 0;}
}
int ft_resultants_at_q(const F*G,int nq,F q,F*out,int last){
 try{tails_init();ratio_context(q);auto A=model_eval(G,nq,q,last+1);auto tt=first_tails(A,last);
  F c=evalp(rc,7,q);F disc=add(mul(c,c),qz0); // (z+c)^2 = c^2+2be
  if(disc && logs[disc]%2==0){F sq=exps[logs[disc]/2],z1=add(sq,neg(c)),z2=add(neg(sq),neg(c));
   for(int i=1;i<int(tt.size());++i){QE prod(1);for(F z:{z1,z2}){std::vector<QE> aa=tt[0],bb=tt[i];for(auto &x:aa)x=QE(add(x.a,mul(x.b,z)));for(auto &x:bb)x=QE(add(x.a,mul(x.b,z)));prod=qm(prod,qres(aa,bb,53,3*(71+i)/4));}out[i-1]=prod.a;}
  }else{for(int i=1;i<int(tt.size());++i)out[i-1]=qnorm(qres(tt[0],tt[i],53,3*(71+i)/4));}
  return 1;
 }catch(...){return 0;}
}
}

extern "C" int ft_profile(const F*G,int nq,F q,double*times){
using clk=std::chrono::steady_clock;auto t0=clk::now();tails_init();ratio_context(q);auto t1=clk::now();auto A=model_eval(G,nq,q,75);auto t2=clk::now();auto tt=first_tails(A,74);auto t3=clk::now();try{for(int i=1;i<4;++i)qres(tt[0],tt[i],53,3*(71+i)/4);}catch(...){}auto t4=clk::now();times[0]=std::chrono::duration<double>(t1-t0).count();times[1]=std::chrono::duration<double>(t2-t1).count();times[2]=std::chrono::duration<double>(t3-t2).count();times[3]=std::chrono::duration<double>(t4-t3).count();return 1;}

struct QD{QE v,d;QD(){} QD(QE a):v(a){} QD(QE a,QE b):v(a),d(b){} };
static inline QD da(QD a,QD b){return QD(qa(a.v,b.v),qa(a.d,b.d));}
static inline QD dn(QD a){return QD(qn(a.v),qn(a.d));}
static inline QD dm(QD a,QD b){return QD(qm(a.v,b.v),qa(qm(a.d,b.v),qm(a.v,b.d)));}
static QD di(QD a){QE iv=qi(a.v);return QD(iv,qn(qm(qm(iv,iv),a.d)));}
static QD dp(QD a,unsigned n){QE p=qp(a.v,n);if(!n)return QD(QE(1));return QD(p,qs(qm(qp(a.v,n-1),a.d),n%5));}
static bool dzero(QD a){return qzero(a.v)&&qzero(a.d);}
static void dtrim(std::vector<QD>&a){while(!a.empty()&&dzero(a.back()))a.pop_back();if(!a.empty()&&qzero(a.back().v))throw std::runtime_error("dual leading drop");}
static QD dres_euclid(std::vector<QD>a,std::vector<QD>b,int da0,int db0){
 if(a.size()!=size_t(da0+1)||b.size()!=size_t(db0+1)||qzero(a.back().v)||qzero(b.back().v))throw std::runtime_error("dual original leading drop");
 QD res(QE(1));
 while(!b.empty()){
  int n=a.size()-1,m=b.size()-1;if(!m)return dm(res,dp(b[0],n));
  if(n<m){a.swap(b);if(n*m%2)res=dn(res);continue;}
  QD ib=di(b.back());std::vector<QD>r=a;
  for(int i=n-m;i>=0;--i){QD t=dm(r[i+m],ib);if(!dzero(t))for(int j=0;j<=m;++j)r[i+j]=da(r[i+j],dn(dm(t,b[j])));}
  dtrim(r);if(r.empty())return QD();int k=r.size()-1;
  res=dm(res,dp(b.back(),n-k));if(n*m%2)res=dn(res);a.swap(b);b.swap(r);
 }return QD();
}
static QD dres_matrix(const std::vector<QD>&a,const std::vector<QD>&b,int n,int m){
 int N=n+m;std::vector<QD>M(N*N);for(int i=0;i<m;++i)for(int j=0;j<=n;++j)M[i*N+i+j]=a[j];
 for(int i=0;i<n;++i)for(int j=0;j<=m;++j)M[(i+m)*N+i+j]=b[j];QD det(QE(1));
 // Rows use ascending coefficients; compared with the usual resultant this
 // determinant has (-1)^(n*m); apply the conversion once at the end.
 for(int k=0;k<N;++k){int pi=-1,pj=-1;
  for(int i=k;i<N&&pi<0;++i)for(int j=k;j<N;++j)if(!qzero(M[i*N+j].v)){pi=i;pj=j;break;}
  if(pi<0){QD r=(k==N-1)?dm(det,M[k*N+k]):QD();return n*m%2?dn(r):r;}
  if(pi!=k){for(int j=0;j<N;++j)std::swap(M[pi*N+j],M[k*N+j]);det=dn(det);}
  if(pj!=k){for(int i=0;i<N;++i)std::swap(M[i*N+pj],M[i*N+k]);det=dn(det);}
  QD pivot=M[k*N+k],iv=di(pivot);det=dm(det,pivot);
  for(int i=k+1;i<N;++i){QD t=dm(M[i*N+k],iv);if(!dzero(t))for(int j=k+1;j<N;++j)M[i*N+j]=da(M[i*N+j],dn(dm(t,M[k*N+j])));M[i*N+k]=QD();}
 }return n*m%2?dn(det):det;
}
static QD dres(std::vector<QD>a,std::vector<QD>b,int n,int m){try{return dres_euclid(a,b,n,m);}catch(...){return dres_matrix(a,b,n,m);}}

static std::pair<std::vector<std::vector<QE>>,std::vector<std::vector<QE>>> first_tails_dual(
 const std::vector<std::array<QE,7>>& A,const std::vector<std::array<QE,7>>& AD,int last){
 int N=last+1;std::vector<Small>a2(N),a3(N),a3d(N);std::vector<Small>values2(N),values3(N),values3d(N);
 for(int v=0;v<19;++v){std::vector<QE>av(N),adv(N),v2(N);
  for(int n=0;n<N;++n){QE x,y;for(int s=6;s>=0;--s){x=qa(qs(x,v),A[n][s]);y=qa(qs(y,v),AD[n][s]);}av[n]=x;adv[n]=y;}
  for(int n=0;n<N;++n){QE x;for(int i=0;i<=n/2;++i){QE t=qm(av[i],av[n-i]);x=qa(x,i*2==n?t:qs(t,2));}v2[n]=x;if(v<13)values2[n][v]=x;}
  for(int n=0;n<N;++n){bool needed=false;for(int j=71;j<=last;++j)if(n%5==j%5)needed=true;if(!needed)continue;QE x,y;
   for(int i=0;i<=n;++i){x=qa(x,qm(av[i],v2[n-i]));y=qa(y,qm(adv[i],v2[n-i]));}values3[n][v]=x;values3d[n][v]=qs(y,3);}
 }
 for(int n=0;n<N;++n){for(int s=0;s<13;++s){QE x;for(int i=0;i<13;++i)x=qa(x,qs(values2[n][i],im13[s*13+i]));a2[n][s]=x;}
  bool needed=false;for(int j=71;j<=last;++j)if(n%5==j%5)needed=true;if(!needed)continue;
  for(int s=0;s<19;++s){QE x,y;for(int i=0;i<19;++i){x=qa(x,qs(values3[n][i],im19[s*19+i]));y=qa(y,qs(values3d[n][i],im19[s*19+i]));}a3[n][s]=x;a3d[n][s]=y;}
 }
 QE z5=qp(QE(0,1),5),z25=qp(QE(0,1),25);std::vector<Small>p5(last/5+1),p25(last/25+1);
 for(int i=0;i<=last/5;++i)for(int s=0;s<13;++s)p5[i][s]=qf(a2[i][s],5,z5);
 for(int i=0;i<=last/25;++i)for(int s=0;s<13;++s)p25[i][s]=qf(a2[i][s],25,z25);
 std::vector<std::vector<QE>>out,od;
 for(int n=71;n<=last;++n){int d=3*n/4;std::vector<QE>x(d+1),y(d+1);
  for(int j=0;j<=n/25;++j){std::vector<QE>in(d+1),ind(d+1);
   for(int i=0;i<=(n-25*j)/5;++i){int at=n-25*j-5*i;
    for(int s=0;s<13;++s)if(!qzero(p5[i][s]))for(int t=0;t<19&&t+5*s<=d;++t){in[t+5*s]=qa(in[t+5*s],qm(a3[at][t],p5[i][s]));ind[t+5*s]=qa(ind[t+5*s],qm(a3d[at][t],p5[i][s]));}}
   for(int s=0;s<13;++s)if(!qzero(p25[j][s]))for(int t=0;t+25*s<=d;++t){x[t+25*s]=qa(x[t+25*s],qm(in[t],p25[j][s]));y[t+25*s]=qa(y[t+25*s],qm(ind[t],p25[j][s]));}
  }out.push_back(x);od.push_back(y);
 }return {out,od};
}
static QE conjugate(QE x){return QE(add(x.a,mul(qz1,x.b)),neg(x.b));}
static F derivative_eval(const F*p,int n,F x){F v=0;for(int i=n-1;i>=1;--i)v=add(mul(v,x),mul(i%5,p[i]));return v;}
static void normalized_dual_input(const F*vals,const F*ders,F q,int N,
 std::vector<std::array<QE,7>>&A,std::vector<std::array<QE,7>>&AD){
 F b=evalp(rb,6,q),c=evalp(rc,7,q),e=evalp(re,10,q),bd=derivative_eval(rb,6,q),cd=derivative_eval(rc,7,q),ed=derivative_eval(re,10,q);
 F z0d=mul(2,add(mul(bd,e),mul(b,ed))),z1d=mul(3,cd);
 QE zp=qm(QE(z0d,z1d),qi(QE(neg(qz1),2)));A.resize(N);AD.resize(N);
 for(int n=0;n<N;++n)for(int s=0;s<7;++s){int ia=n*7+s,ib=(N+n)*7+s;A[n][s]=QE(vals[ia],vals[ib]);AD[n][s]=qa(QE(ders[ia],ders[ib]),qs(zp,vals[ib]));}
 QE invl=qi(A[0][0]),ld=AD[0][0];for(int n=0;n<N;++n)for(int s=0;s<7;++s){A[n][s]=qm(A[n][s],invl);AD[n][s]=qm(qa(AD[n][s],qn(qm(A[n][s],ld))),invl);}
}
static void norms_dual_from_values(const F*vals,const F*ders,F q,F*out,int last){
 ratio_context(q);std::vector<std::array<QE,7>>A,AD;normalized_dual_input(vals,ders,q,last+1,A,AD);auto both=first_tails_dual(A,AD,last);auto &tt=both.first;auto& td=both.second;
 F c=evalp(rc,7,q),disc=add(mul(c,c),qz0);bool split=disc&&logs[disc]%2==0;F sq=split?exps[logs[disc]/2]:0;
 for(int i=1;i<int(tt.size());++i){std::vector<QD>aa,bb;for(int j=0;j<int(tt[0].size());++j)aa.push_back(QD(tt[0][j],td[0][j]));for(int j=0;j<int(tt[i].size());++j)bb.push_back(QD(tt[i][j],td[i][j]));
  if(split){QD norm(QE(1));for(F root:{add(sq,neg(c)),add(neg(sq),neg(c))}){auto a=aa,bv=bb;for(auto&x:a)x=QD(QE(add(x.v.a,mul(x.v.b,root))),QE(add(x.d.a,mul(x.d.b,root))));for(auto&x:bv)x=QD(QE(add(x.v.a,mul(x.v.b,root))),QE(add(x.d.a,mul(x.d.b,root))));norm=dm(norm,dres(a,bv,53,3*(71+i)/4));}out[2*(i-1)]=norm.v.a;out[2*(i-1)+1]=norm.d.a;}
  else{QD rr=dres(aa,bb,53,3*(71+i)/4);out[2*(i-1)]=qnorm(rr.v);QE tr=qm(rr.d,conjugate(rr.v));out[2*(i-1)+1]=add(mul(2,tr.a),mul(qz1,tr.b));}
 }
}
extern "C" int ft_dual_at_q(const F*G,int nq,F q,F*out,int last){try{tails_init();int N=last+1,W=2*N*7;std::vector<F>vs(W),ds(W);for(int j=0;j<2;++j)for(int n=0;n<N;++n)for(int s=0;s<7;++s){int at=(j*N+n)*7+s;const F* p=G+((j*141+n)*7+s)*nq;vs[at]=evalp(p,nq,q);ds[at]=derivative_eval(p,nq,q);}norms_dual_from_values(vs.data(),ds.data(),q,out,last);return 1;}catch(...){return 0;}}

// Complete 625-node coset evaluation. Taylor translation uses Lucas'
// digitwise binomial identity; the DFT is a mixed-radix exact transform.
struct DFTPlan{int N,r,m;F root;std::vector<F> tw;std::unique_ptr<DFTPlan>child;
 DFTPlan(int n,F rt):N(n),root(rt){if(n==1){r=m=1;return;}r=(n%13==0?13:(n%3==0?3:(n%4==0?4:(n%2==0?2:n))));m=n/r;child.reset(new DFTPlan(m,fpow(rt,r)));tw.resize(n*r);
  for(int k=0;k<n;++k)for(int j=0;j<r;++j)tw[k*r+j]=fpow(rt,(uint64_t)k*j);}
};
static std::unique_ptr<DFTPlan> plan624;
static void dft_run(const F*in,int stride,const DFTPlan&p,F*out,int width){
 if(p.N==1){std::copy(in,in+width,out);return;}
 std::vector<F>tmp((size_t)p.N*width);
 for(int j=0;j<p.r;++j)dft_run(in+(size_t)j*stride*width,stride*p.r,*p.child,tmp.data()+(size_t)j*p.m*width,width);
 std::fill(out,out+(size_t)p.N*width,0);
 for(int k=0;k<p.N;++k){int ki=k%p.m;F*dst=out+(size_t)k*width;
  for(int j=0;j<p.r;++j){F w=p.tw[k*p.r+j];const F*src=tmp.data()+((size_t)j*p.m+ki)*width;
   if(w==1){for(int h=0;h<width;++h)dst[h]=add(dst[h],src[h]);}
   else for(int h=0;h<width;++h)dst[h]=add(dst[h],mul(src[h],w));
  }
 }
}
static void translate625(std::vector<F>&a,int width,F off){
 static const F binom[5][5]={{1,0,0,0,0},{1,1,0,0,0},{1,2,1,0,0},{1,3,3,1,0},{1,4,1,4,1}};
 for(int stride=1;stride<625;stride*=5){F w=fpow(off,stride),pw[5]={1,w,0,0,0};for(int i=2;i<5;++i)pw[i]=mul(pw[i-1],w);F mat[5][5]={};for(int k=0;k<5;++k)for(int j=k+1;j<5;++j)mat[k][j]=mul(binom[j][k],pw[j-k]);
  for(int block=0;block<625;block+=5*stride)for(int lo=0;lo<stride;++lo)for(int k=0;k<4;++k){F*dst=a.data()+((size_t)block+lo+k*stride)*width;
   for(int j=k+1;j<5;++j){F wj=mat[k][j];if(!wj)continue;const F*src=a.data()+((size_t)block+lo+j*stride)*width;
    for(int h=0;h<width;++h)dst[h]=add(dst[h],mul(src[h],wj));
   }
  }
 }
}
static void model_coset(const F*coeff,int W,F offset,std::vector<F>&values,std::vector<F>&derivs,std::vector<F>&nodes){
 tails_init();F root=fpow(generator,626);if(!plan624)plan624.reset(new DFTPlan(624,root));
 std::vector<F>shifted(coeff,coeff+(size_t)625*W);translate625(shifted,W,offset);
 std::vector<F>data((size_t)624*2*W),out(data.size());
 for(int i=0;i<624;++i)for(int h=0;h<W;++h){F c=shifted[(size_t)i*W+h];data[(size_t)i*2*W+h]=(i?c:add(c,shifted[(size_t)624*W+h]));data[(size_t)i*2*W+W+h]=(i?mul(i%5,c):mul(4,shifted[(size_t)624*W+h]));}
 dft_run(data.data(),1,*plan624,out.data(),2*W);
 values.resize((size_t)625*W);derivs.resize((size_t)625*W);nodes.resize(625);nodes[0]=offset;
 std::copy(shifted.data(),shifted.data()+W,values.data());std::copy(shifted.data()+W,shifted.data()+2*W,derivs.data());F alpha=1;
 for(int i=1;i<=624;++i){nodes[i]=add(offset,alpha);F ia=inv(alpha);const F*src=out.data()+(size_t)(i-1)*2*W;
  for(int h=0;h<W;++h){values[(size_t)i*W+h]=src[h];derivs[(size_t)i*W+h]=mul(src[W+h],ia);}alpha=mul(alpha,root);}
}
static std::vector<std::vector<F>>nfactors;
static std::vector<std::vector<int>>nexps;
static std::vector<F>nholes;
extern "C" int ft_set_normalization(const F*coeff,const int*lengths,int nf,const int*exps,int nr){try{tails_init();nfactors.clear();nexps.clear();nholes.clear();size_t at=0;for(int i=0;i<nf;++i){nfactors.emplace_back(coeff+at,coeff+at+lengths[i]);at+=lengths[i];if(lengths[i]==2&&nfactors.back()[1]==1)nholes.push_back(neg(nfactors.back()[0]));}for(int r=0;r<nr;++r)nexps.emplace_back(exps+r*nf,exps+(r+1)*nf);return 1;}catch(...){return 0;}}
static bool is_hole(F q){return std::find(nholes.begin(),nholes.end(),q)!=nholes.end();}
static void normalize_resultants(F q,F*out,int nr){std::vector<F>fv,fd;for(auto&f:nfactors){F v=evalp(f.data(),f.size(),q);if(!v)throw std::runtime_error("normalization zero off holes");fv.push_back(v);fd.push_back(mul(derivative_eval(f.data(),f.size(),q),inv(v)));}
 for(int r=0;r<nr;++r){F mult=1,ld=0;for(size_t i=0;i<nfactors.size();++i){int p=nexps[r][i];if(p<0)throw std::runtime_error("negative normalization power");if(p){mult=mul(mult,fpow(fv[i],p));ld=add(ld,mul(p%5,fd[i]));}}F v=out[2*r],dv=out[2*r+1];out[2*r]=mul(mult,v);out[2*r+1]=mul(mult,add(dv,mul(v,ld)));}
}
extern "C" int ft_coset_resultants(const F*coeff,F offset,F*out,int last){try{
 int W=2*(last+1)*7,nr=last-71;std::vector<F>vs,ds,nodes;model_coset(coeff,W,offset,vs,ds,nodes);
 for(int i=0;i<625;++i){F*dst=out+i*nr*2;if(is_hole(nodes[i]))std::fill(dst,dst+2*nr,0);else{norms_dual_from_values(vs.data()+(size_t)i*W,ds.data()+(size_t)i*W,nodes[i],dst,last);normalize_resultants(nodes[i],dst,nr);}}
 return 1;}catch(...){return 0;}}
extern "C" int ft_coset_model(const F*coeff,int W,F off,F*vs,F*ds,F*ns){try{std::vector<F>v,d,n;model_coset(coeff,W,off,v,d,n);std::copy(v.begin(),v.end(),vs);std::copy(d.begin(),d.end(),ds);std::copy(n.begin(),n.end(),ns);return 1;}catch(...){return 0;}}

// Exact interpolation on all of K, with values indexed by original K-code.
static std::unique_ptr<DFTPlan> field_fwd,field_inv;
static void field_interpolate(const F*values,int W,F*coeff){
 tails_init();if(!field_inv)field_inv.reset(new DFTPlan(ORD,inv(generator)));
 std::vector<F>in((size_t)ORD*W),out(in.size());
 for(int i=0;i<ORD;++i)std::copy(values+(size_t)exps[i]*W,values+(size_t)exps[i]*W+W,in.data()+(size_t)i*W);
 dft_run(in.data(),1,*field_inv,out.data(),W);F scale=inv(ORD%5);
 for(int j=0;j<ORD;++j)for(int h=0;h<W;++h)coeff[(size_t)j*W+h]=mul(scale,out[(size_t)j*W+h]);
 for(int h=0;h<W;++h){coeff[(size_t)ORD*W+h]=add(coeff[h],neg(values[h]));coeff[h]=values[h];}
}
static void field_evaluate(const F*coeff,int W,F*values){
 tails_init();if(!field_fwd)field_fwd.reset(new DFTPlan(ORD,generator));
 std::vector<F>in(coeff,coeff+(size_t)ORD*W),out(in.size());for(int h=0;h<W;++h)in[h]=add(in[h],coeff[(size_t)ORD*W+h]);
 dft_run(in.data(),1,*field_fwd,out.data(),W);
 std::copy(coeff,coeff+W,values);for(int i=0;i<ORD;++i)std::copy(out.data()+(size_t)i*W,out.data()+(size_t)(i+1)*W,values+(size_t)exps[i]*W);
}
extern "C" int ft_field_interpolate(const F*values,int W,F*coeff){try{field_interpolate(values,W,coeff);return 1;}catch(...){return 0;}}
extern "C" int ft_field_evaluate(const F*coeff,int W,F*values){try{field_evaluate(coeff,W,values);return 1;}catch(...){return 0;}}
extern "C" int ft_field_hermite(const F*values,const F*derivs,int W,F*coeff){try{
 std::vector<F>A((size_t)Q*W),AD(A.size(),0),vd(A.size()),B(A.size());field_interpolate(values,W,A.data());
 for(int j=1;j<Q;++j)for(int h=0;h<W;++h)AD[(size_t)(j-1)*W+h]=mul(j%5,A[(size_t)j*W+h]);
 field_evaluate(AD.data(),W,vd.data());for(size_t i=0;i<vd.size();++i)vd[i]=add(vd[i],neg(derivs[i]));field_interpolate(vd.data(),W,B.data());
 std::fill(coeff,coeff+(size_t)2*Q*W,0);std::copy(A.begin(),A.end(),coeff);
 for(int j=0;j<Q;++j)for(int h=0;h<W;++h){F v=B[(size_t)j*W+h];size_t lo=(size_t)(j+1)*W+h,hi=(size_t)(j+Q)*W+h;coeff[lo]=add(coeff[lo],neg(v));coeff[hi]=add(coeff[hi],v);}
 return 1;}catch(...){return 0;}}
// Small independent regression entry point for every fixed-degree drop type.
extern "C" int ft_scalar_dual_resultant(const F*ap,const F*bp,int n,int m,F*out){try{
 tails_init();qz0=2;qz1=3;std::vector<QD>a(n+1),b(m+1);
 for(int i=0;i<=n;++i)a[i]=QD(QE(ap[2*i]),QE(ap[2*i+1]));for(int i=0;i<=m;++i)b[i]=QD(QE(bp[2*i]),QE(bp[2*i+1]));
 QD r=dres(a,b,n,m);out[0]=r.v.a;out[1]=r.d.a;return 1;}catch(...){return 0;}}
