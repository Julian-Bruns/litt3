#pragma once
#include "source.hpp"
// Laurent polynomials in H,w. H exponent first; w exponents may be negative.
struct LW {
 std::map<std::pair<int,int>,F> c;
 LW()=default;LW(int n):LW(F(n)){}LW(F a){if(a)c[{0,0}]=a;}
 static LW mon(int h,int w,F a=F(1)){LW p;if(a)p.c[{h,w}]=a;return p;}
 explicit operator bool()const{return !c.empty();}
 bool operator==(const LW& b)const{return c==b.c;}
 bool operator!=(const LW& b)const{return c!=b.c;}
 void put(std::pair<int,int> e,F a){if(!a)return;auto it=c.find(e);if(it==c.end())c[e]=a;else{it->second+=a;if(!it->second)c.erase(it);}}
 LW operator-()const{LW p;for(auto [e,a]:c)p.c[e]=-a;return p;}
 LW operator+(const LW& b)const{LW p=*this;for(auto [e,a]:b.c)p.put(e,a);return p;}
 LW operator-(const LW& b)const{return *this+-b;}
 LW operator*(F b)const{LW p;if(b)for(auto [e,a]:c)p.c[e]=a*b;return p;}
 LW operator/(F b)const{return *this*b.inv();}
 LW operator*(const LW& b)const{LW p;for(auto [e,a]:c)for(auto [f,v]:b.c)p.put({e.first+f.first,e.second+f.second},a*v);return p;}
 LW& operator+=(const LW& b){for(auto [e,a]:b.c)put(e,a);return *this;}
 LW& operator-=(const LW& b){return *this+=-b;}
 LW& operator*=(const LW& b){return *this=*this*b;}
 LW pow(int n)const{LW a=*this,b(1);while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
 LW frob(int p)const{LW out;for(auto [e,a]:c)out.c[{e.first*p,e.second*p}]=a.pow(p);return out;}
 LW shift(int h,int w)const{LW p;for(auto [e,a]:c)p.c[{e.first+h,e.second+w}]=a;return p;}
 F eval(F h,F w)const{F a;for(auto [e,c0]:c)a+=c0*h.pow(e.first)*w.pow(e.second);return a;}
 LW as_q(int weight=0)const{LW out;for(auto [e,a]:c){if((e.second-weight)%3)throw std::runtime_error("non-cube-invariant source term");out.c[{e.first,(e.second-weight)/3}]=a;}return out;}
 int degH()const{int d=-1;for(auto [e,a]:c)d=std::max(d,e.first);return d;}
 std::pair<int,int> rangeW()const{int lo=INT_MAX,hi=INT_MIN;for(auto [e,a]:c){lo=std::min(lo,e.second);hi=std::max(hi,e.second);}return {lo,hi};}
};
inline LW operator*(F a,const LW& b){return b*a;}
inline void write_lw(std::ostream& out,const LW& p){out<<"[";bool first=true;for(auto [e,a]:p.c){if(!first)out<<",";first=false;out<<"["<<e.first<<","<<e.second<<","<<a<<"]";}out<<"]";}
using Jet=std::vector<LW>;
inline int JET_N=7;
inline Jet jconstant(LW a){Jet out(JET_N);out[0]=a;return out;}
inline Jet jadd(Jet a,const Jet& b){for(int j=0;j<JET_N;j++)a[j]+=b[j];return a;}
inline Jet jscale(Jet a,F c){for(auto &p:a)p=p*c;return a;}
inline Jet jmul(const Jet& a,const Jet& b){Jet out(JET_N);for(int i=0;i<JET_N;i++)for(int j=0;i+j<JET_N;j++)out[i+j]+=a[i]*b[j];return out;}
inline Jet jshift(const Jet& a,int n){Jet out(JET_N);for(int i=0;i+n<JET_N;i++)out[i+n]=a[i];return out;}
inline Jet jpow(Jet a,int n){Jet out=jconstant(LW(1));while(n){if(n&1)out=jmul(out,a);a=jmul(a,a);n>>=1;}return out;}
inline Jet j5(const Jet& a){Jet out(JET_N);for(int i=0;5*i<JET_N;i++)out[5*i]=a[i].frob(5);return out;}
inline std::vector<F> makeY(){
 std::vector<F> y(JET_N);y[0]=F(1);
 auto coeff3=[&](int n){F c;for(int i=0;i<=n;i++)for(int j=0;i+j<=n;j++)c+=y[i]*y[j]*y[n-i-j];return c;};
 for(int n=1;n<JET_N;n++){F target=n%3?F():P[10-n/3];y[n]=(target-coeff3(n))/F(3);}
 for(int n=0;n<JET_N;n++)if(coeff3(n)!=(n%3?F():P[10-n/3]))throw std::runtime_error("Y cube check");return y;
}
inline std::array<Jet,4> source_jets(const std::vector<LW>& coeff){
 auto yy=makeY();std::vector<std::vector<F>> yp(11,std::vector<F>(JET_N));yp[0][0]=F(1);
 for(int j=1;j<=10;j++)for(int a=0;a<JET_N;a++)for(int b=0;a+b<JET_N;b++)yp[j][a+b]+=yp[j-1][a]*yy[b];
 std::array<Jet,4> out;for(auto &a:out)a.resize(JET_N);auto cc=coordinates();int shift[4]={35,46,57,70};
 for(size_t k=0;k<cc.size();k++){
  auto [n,i,j]=cc[k];if(n==0)j+=2;int start=shift[n]-3*i-10*j;
  if(start<0)throw std::runtime_error("source pole exceeds jet shift");
  for(int m=0;start+m<JET_N;m++)out[n][start+m]+=coeff[k]*yp[j][m];
 }
 out[0]=jscale(out[0],F(3));out[1]=jscale(out[1],F(2));return out;
}
inline Jet F_jets(const std::vector<LW>& coeff){
 auto sj=source_jets(coeff);auto as=sj[0],bs=sj[1],cs=sj[2];
 if(as[0]||bs[0]!=LW(F(2)*input::eps))throw std::runtime_error("nonunit/incorrect quadratic jet");
 Jet rho(JET_N);rho[0]=-(cs[0]/(F(2)*input::eps));
 for(int n=1;n<JET_N;n++){
  auto equation=jadd(jadd(jmul(as,jmul(rho,rho)),jmul(bs,rho)),cs);
  rho[n]=-equation[n]/(F(2)*input::eps);
 }
 auto eq=jadd(jadd(jmul(as,jmul(rho,rho)),jmul(bs,rho)),cs);for(auto a:eq)if(a)throw std::runtime_error("rho jet check");
 Jet qs(JET_N);for(int i=0;i<=input::Q.deg();i++){int m=57-3*i;if(m<JET_N)qs[m]=LW(input::Q[i]);}
 auto left=jadd(qs,jshift(j5(rho),2));
 auto right=jadd(sj[3],jshift(jadd(jmul(as,jpow(rho,3)),jscale(jmul(bs,jpow(rho,2)),F(2))),2));
 Jet out=jmul(left,right);
 auto yy=makeY();Jet yj(JET_N);for(int i=0;i<JET_N;i++)yj[i]=LW(yy[i]);auto y10=jpow(yj,10);
 Poly tp=input::t.pow(3);for(int i=0;i<=tp.deg();i++){int start=27-3*i;for(int m=0;m+start<JET_N;m++)out[m+start]+=y10[m]*tp[i];}
 return out;
}
struct TopAtlas{std::vector<F> base;std::array<std::vector<F>,4> top;std::array<std::vector<F>,2> kernel;};
inline TopAtlas top_atlas(const AffineSpace& sp){
 int n=sp.particular.size();std::vector<std::vector<F>> mat(4,std::vector<F>(6));
 for(int j=0;j<6;j++){auto v=top_coordinates(sp.dirs[j]);for(int i=0;i<4;i++)mat[i][j]=v[i];}
 auto rr=rref(mat,6);if(rr.free.size()!=2)throw std::runtime_error("wrong top kernel dimension");
 auto v0=top_coordinates(sp.base);
 auto solve=[&](std::vector<F> target,bool affine){
  auto aug=mat;for(int i=0;i<4;i++)aug[i].push_back(target[i]-(affine?v0[i]:F()));auto R=rref(aug,6);
  std::vector<F> coeff(6);for(int i=0;i<4;i++)coeff[R.piv[i]]=R.rows[i][6];
  auto v=affine?sp.particular:std::vector<F>(n);for(int j=0;j<6;j++)for(int k=0;k<n;k++)v[k]+=coeff[j]*sp.basis[j][k];return v;
 };
 TopAtlas a;a.base=solve(std::vector<F>(4),true);
 for(int i=0;i<4;i++){std::vector<F> tar(4);tar[i]=F(1);a.top[i]=solve(tar,false);}
 for(int i=0;i<2;i++){
  std::vector<F> coeff(6);coeff[rr.free[i]]=F(1);for(int j=0;j<4;j++)coeff[rr.piv[j]]=-rr.rows[j][rr.free[i]];
  a.kernel[i].resize(n);for(int j=0;j<6;j++)for(int k=0;k<n;k++)a.kernel[i][k]+=coeff[j]*sp.basis[j][k];
 }
 return a;
}
struct Cramer{
 int r;TopAtlas atlas;std::vector<LW> graph,num;LW determinant;F det_scalar;int det_w;
 std::array<LW,2> kernel_num;
 LW d;F pivot;
};
inline Cramer cramer(const AffineSpace& sp){
 using namespace input;Cramer c;c.r=sp.r.v;c.atlas=top_atlas(sp);auto &a=c.atlas;
 LW H=LW::mon(1,0),w=LW::mon(0,1),h=H*w,z=w*(F(2)/eps),cc=h*Ca+w*Cd;
 LW e=-(cc*z)-LW::mon(0,-1,eta*eps/(F(2)*F::code(24)));
 LW f=-(w.pow(2)/eps)-z.frob(5)*(F::code(8)/F::code(24));
 std::array<LW,4> tops={h,w,e,f};int n=a.base.size();c.graph.resize(n);
 for(int k=0;k<n;k++){c.graph[k]=LW(a.base[k]);for(int i=0;i<4;i++)c.graph[k]+=tops[i]*a.top[i][k];}
 auto F0=F_jets(c.graph);for(int i=0;i<4;i++)if(F0[i])throw std::runtime_error("graph F0..F3 not zero");
 std::array<Jet,2> delta;
 for(int j=0;j<2;j++){auto coeff=c.graph;for(int k=0;k<n;k++)coeff[k]+=LW(a.kernel[j][k]);auto Fj=F_jets(coeff);delta[j]=jadd(Fj,jscale(F0,F(-1)));}
 c.determinant=delta[0][4]*delta[1][5]-delta[1][4]*delta[0][5];
 c.kernel_num[0]=-F0[4]*delta[1][5]+F0[5]*delta[1][4];
 c.kernel_num[1]=-F0[5]*delta[0][4]+F0[4]*delta[0][5];
 if(c.determinant.c.size()!=2||c.determinant.degH()!=0)throw std::runtime_error("Cramer determinant shape");
 auto [lo,hi]=c.determinant.rangeW();if(hi-lo!=3)throw std::runtime_error("Cramer determinant exponents");
 c.det_w=lo;c.det_scalar=c.determinant.c.at({0,hi});
 c.pivot=-c.determinant.c.at({0,lo})/c.det_scalar;c.d=LW::mon(0,3)-LW(c.pivot);
 c.num.resize(n);
 for(int k=0;k<n;k++)c.num[k]=(c.graph[k]*c.determinant+c.kernel_num[0]*a.kernel[0][k]+c.kernel_num[1]*a.kernel[1][k]).shift(0,-lo)/c.det_scalar;
 // c.num / (w^3 - pivot) is the exact source vector.
 return c;
}
