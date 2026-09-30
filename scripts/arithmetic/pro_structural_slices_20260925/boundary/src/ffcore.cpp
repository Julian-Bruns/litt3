// Exact arithmetic in F_25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]).
// Field encodings: sum c_i*25^i, 0<=c_i<25; c_i=a+5*b means a+b*beta.
// beta^2=beta+3. All polynomial coefficient arrays are ascending.
#include <algorithm>
#include <stdexcept>
#include <vector>
#include <cstdint>
using std::vector;
static constexpr int q=390625, order=q-1;
static int plus625[625*625], plus25[25*25], mul25[25*25], negs[q], logs[q], exps[2*order];
static bool ready=false;
static int add0(int a,int b){return plus625[(a%625)*625+(b%625)]+625*plus625[(a/625)*625+(b/625)];}
static int direct(int a,int b){
 int ac[4],bc[4],c[7]={0};
 for(int i=0;i<4;i++){ac[i]=a%25;bc[i]=b%25;a/=25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++) c[i+j]=plus25[c[i+j]*25+mul25[ac[i]*25+bc[j]]];
 int mod[4]={5,2,6,7};
 for(int i=6;i>=4;i--) if(c[i])for(int j=0;j<4;j++){
   int v=mul25[c[i]*25+mod[j]]; int nv=(5-v%5)%5+5*((5-v/5)%5);
   c[i-4+j]=plus25[c[i-4+j]*25+nv];
 }
 return c[0]+25*c[1]+625*c[2]+15625*c[3];
}
static int direct_pow(int a,int64_t n){int r=1;while(n){if(n&1)r=direct(r,a);a=direct(a,a);n>>=1;}return r;}
static inline int mul0(int a,int b){return (!a||!b)?0:exps[logs[a]+logs[b]];}
static inline int inv0(int a){return a?exps[order-logs[a]]:0;}
static inline int sub0(int a,int b){return add0(a,negs[b]);}
using Poly=vector<int>;
static void trim(Poly& a){while(!a.empty()&&!a.back())a.pop_back();}
static Poly p_add(const Poly&a,const Poly&b,bool minus=false){Poly c(std::max(a.size(),b.size()));for(size_t i=0;i<c.size();i++){int ai=i<a.size()?a[i]:0,bi=i<b.size()?b[i]:0;c[i]=minus?sub0(ai,bi):add0(ai,bi);}trim(c);return c;}
static Poly p_mul(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=add0(c[i+j],mul0(a[i],b[j]));trim(c);return c;}
static std::pair<Poly,Poly> p_div(Poly a,const Poly&b){if(b.empty())throw std::runtime_error("zero divisor");Poly out(a.size()>=b.size()?a.size()-b.size()+1:0);int iv=inv0(b.back());while(a.size()>=b.size()){int d=a.size()-b.size(),c=mul0(a.back(),iv);out[d]=c;for(size_t j=0;j<b.size();j++)a[d+j]=sub0(a[d+j],mul0(c,b[j]));trim(a);}trim(out);return {out,a};}
static Poly p_mod(const Poly&a,const Poly&m){return p_div(a,m).second;}
static Poly p_powmod(Poly a,int64_t e,const Poly&m){Poly r={1};while(e){if(e&1)r=p_mod(p_mul(r,a),m);e>>=1;if(e)a=p_mod(p_mul(a,a),m);}return r;}
extern "C" {
int ff_init(){if(ready)return 0;
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
  plus25[a*25+b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  int u=a%5,v=a/5,s=b%5,t=b/5;
  mul25[a*25+b]=(u*s+3*v*t)%5+5*((u*t+v*s+v*t)%5);
 }
 for(int a=0;a<625;a++)for(int b=0;b<625;b++)plus625[a*625+b]=plus25[(a%25)*25+b%25]+25*plus25[(a/25)*25+b/25];
 for(int a=0;a<q;a++){int n=a,out=0,p=1;for(int i=0;i<8;i++){out+=((5-n%5)%5)*p;p*=5;n/=5;}negs[a]=out;logs[a]=-1;}
 // Prime factors of 5^8-1: 2, 3, 13, 313.
 int gen=2;
 for(;;gen++){bool good=true;for(int p:{2,3,13,313})if(direct_pow(gen,order/p)==1){good=false;break;}if(good)break;if(gen>=q)return -1;}
 int a=1;for(int i=0;i<order;i++){if(logs[a]!=-1)return -2;logs[a]=i;exps[i]=a;a=direct(a,gen);}if(a!=1)return -3;
 for(int i=0;i<order;i++)exps[i+order]=exps[i];
 ready=true;return gen;
}
int ff_add(int a,int b){return add0(a,b);} int ff_sub(int a,int b){return sub0(a,b);} int ff_neg(int a){return negs[a];}
int ff_mul(int a,int b){return mul0(a,b);} int ff_inv(int a){return inv0(a);} int ff_pow(int a,int64_t n){if(!a)return n==0?1:0;int64_t e=(int64_t)logs[a]*(n%order)%order;if(e<0)e+=order;return exps[e];}
int ff_log(int a){return logs[a];} int ff_exp(int n){n%=order;if(n<0)n+=order;return exps[n];}
int poly_op(int op,const int*ap,int na,const int*bp,int nb,int*out){Poly a(ap,ap+na),b(bp,bp+nb),c;
 if(op==0)c=p_add(a,b);else if(op==1)c=p_add(a,b,true);else if(op==2)c=p_mul(a,b);else if(op==3)c=p_div(a,b).first;else if(op==4)c=p_div(a,b).second;else if(op==5){while(!b.empty()){Poly c=p_mod(a,b);a=b;b=c;}c=a;if(!c.empty()){int iv=inv0(c.back());for(int&x:c)x=mul0(x,iv);}}else return -1;
 for(size_t i=0;i<c.size();i++)out[i]=c[i];return c.size();}
int poly_powmod(const int*ap,int na,int64_t e,const int*mp,int nm,int*out){Poly a(ap,ap+na),m(mp,mp+nm);Poly c=p_powmod(a,e,m);for(size_t i=0;i<c.size();i++)out[i]=c[i];return c.size();}
int poly_eval(const int*ap,int na,int x){int r=0;for(int i=na-1;i>=0;i--)r=add0(mul0(r,x),ap[i]);return r;}
int matrix_rref(int*a,int nr,int nc,int*piv){int row=0;for(int col=0;col<nc&&row<nr;col++){int s=row;while(s<nr&&!a[s*nc+col])s++;if(s==nr)continue;for(int j=0;j<nc;j++)std::swap(a[s*nc+j],a[row*nc+j]);int iv=inv0(a[row*nc+col]);for(int j=col;j<nc;j++)a[row*nc+j]=mul0(a[row*nc+j],iv);for(int i=0;i<nr;i++)if(i!=row&&a[i*nc+col]){int c=a[i*nc+col];for(int j=col;j<nc;j++)a[i*nc+j]=sub0(a[i*nc+j],mul0(c,a[row*nc+j]));}piv[row]=col;row++;}return row;}
}

// Polynomial algebra over a finite F_(5^8)-algebra F_(5^8)[s]/(g).
// All inversions below verify that the input is a unit; irreducibility is not assumed.
static Poly emod;
static int em=0;
using Elem=Poly;
static Elem ezero(){return Elem(em,0);}
static Elem eone(){Elem a(em,0);a[0]=1;return a;}
static bool eiszero(const Elem&a){for(int x:a)if(x)return false;return true;}
static Elem eadd(const Elem&a,const Elem&b){Elem c(em);for(int i=0;i<em;i++)c[i]=add0(a[i],b[i]);return c;}
static Elem esub(const Elem&a,const Elem&b){Elem c(em);for(int i=0;i<em;i++)c[i]=sub0(a[i],b[i]);return c;}
static Elem emul(const Elem&a,const Elem&b){Elem c(2*em-1);for(int i=0;i<em;i++)if(a[i])for(int j=0;j<em;j++)if(b[j])c[i+j]=add0(c[i+j],mul0(a[i],b[j]));for(int i=2*em-2;i>=em;i--)if(c[i])for(int j=0;j<em;j++)if(emod[j])c[i-em+j]=sub0(c[i-em+j],mul0(c[i],emod[j]));c.resize(em);return c;}
static Elem einv(const Elem&a){Poly r0=emod,r1=a,s0={},s1={1};trim(r1);while(!r1.empty()){auto dr=p_div(r0,r1);Poly ns=p_add(s0,p_mul(dr.first,s1),true);r0=r1;r1=dr.second;s0=s1;s1=ns;}if(r0.size()!=1)throw std::runtime_error("nonunit extension coefficient");int iv=inv0(r0[0]);for(int&x:s0)x=mul0(x,iv);s0=p_mod(s0,emod);s0.resize(em);return s0;}
static Elem epower(Elem a,int64_t n){if(n<0){a=einv(a);n=-n;}Elem r=eone();while(n){if(n&1)r=emul(r,a);n>>=1;if(n)a=emul(a,a);}return r;}
using EPoly=vector<Elem>;
static void etrim(EPoly&a){while(!a.empty()&&eiszero(a.back()))a.pop_back();}
static EPoly epadd(const EPoly&a,const EPoly&b,bool minus=false){EPoly c(std::max(a.size(),b.size()),ezero());for(size_t i=0;i<c.size();i++){Elem av=i<a.size()?a[i]:ezero(),bv=i<b.size()?b[i]:ezero();c[i]=minus?esub(av,bv):eadd(av,bv);}etrim(c);return c;}
static EPoly epmul(const EPoly&a,const EPoly&b){
 if(a.empty()||b.empty())return {};
 // Accumulate the convolution before reducing in s. This avoids one reduction per product.
 int nx=a.size()+b.size()-1,ns=2*em-1;vector<int> raw(nx*ns,0);
 for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++){
  int*o=&raw[(i+j)*ns];
  for(int u=0;u<em;u++)if(a[i][u])for(int v=0;v<em;v++)if(b[j][v])o[u+v]=add0(o[u+v],mul0(a[i][u],b[j][v]));
 }
 EPoly out(nx,ezero());
 for(int k=0;k<nx;k++){
  int*o=&raw[k*ns];
  for(int i=ns-1;i>=em;i--)if(o[i])for(int j=0;j<em;j++)if(emod[j])o[i-em+j]=sub0(o[i-em+j],mul0(o[i],emod[j]));
  for(int j=0;j<em;j++)out[k][j]=o[j];
 }
 etrim(out);return out;
}
static std::pair<EPoly,EPoly> epdiv(EPoly a,const EPoly&b){if(b.empty())throw std::runtime_error("zero divisor");EPoly out(a.size()>=b.size()?a.size()-b.size()+1:0,ezero());Elem iv=einv(b.back());while(a.size()>=b.size()){int d=a.size()-b.size();Elem c=emul(a.back(),iv);out[d]=c;for(size_t j=0;j<b.size();j++)a[d+j]=esub(a[d+j],emul(c,b[j]));etrim(a);}etrim(out);return {out,a};}
static EPoly epread(const int*a,int n){EPoly b(n,ezero());for(int i=0;i<n;i++)for(int j=0;j<em;j++)b[i][j]=a[i*em+j];etrim(b);return b;}
static int epwrite(const EPoly&a,int*out){for(size_t i=0;i<a.size();i++)for(int j=0;j<em;j++)out[i*em+j]=a[i][j];return a.size();}
extern "C" {
int ext_init(const int*mod,int n){if(n<2||mod[n-1]!=1)return -1;em=n-1;emod=Poly(mod,mod+n);return em;}
int ext_op(int op,const int*a,const int*b,int*out){try{Elem aa(a,a+em),bb(b,b+em),c;if(op==0)c=eadd(aa,bb);else if(op==1)c=esub(aa,bb);else if(op==2)c=emul(aa,bb);else if(op==3)c=einv(aa);else return -1;for(int i=0;i<em;i++)out[i]=c[i];return 0;}catch(...){return -999;}}
int ext_pow(const int*a,int64_t n,int*out){try{Elem c=epower(Elem(a,a+em),n);for(int i=0;i<em;i++)out[i]=c[i];return 0;}catch(...){return -999;}}
int ep_op(int op,const int*ap,int na,const int*bp,int nb,int*out){try{EPoly a=epread(ap,na),b=epread(bp,nb),c;if(op==0)c=epadd(a,b);else if(op==1)c=epadd(a,b,true);else if(op==2)c=epmul(a,b);else if(op==3)c=epdiv(a,b).first;else if(op==4)c=epdiv(a,b).second;else if(op==5){while(!b.empty()){EPoly rr=epdiv(a,b).second;a=b;b=rr;}c=a;if(!c.empty()){Elem iv=einv(c.back());for(Elem&x:c)x=emul(x,iv);}}else return -1;return epwrite(c,out);}catch(...){return -999;}}
}
