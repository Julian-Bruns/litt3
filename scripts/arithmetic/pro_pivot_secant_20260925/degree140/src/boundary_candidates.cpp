#include "fast_exact.cpp"
#include <sstream>
struct Split {Poly factor;};
using LP=vector<Poly>; // polynomial in mu, coefficients in K[H]/M
Poly MOD;
Poly er(const Poly&a){return divmod(a,MOD).second;}
Poly ea(const Poly&a,const Poly&b){return add(a,b);}
Poly em(const Poly&a,const Poly&b){return er(mul(a,b));}
Poly ei(Poly a){Poly b=MOD,s{1},t{};while(b.size()){auto qr=divmod(a,b);auto z=sub(s,mul(qr.first,t));a=move(b);b=move(qr.second);s=move(t);t=move(z);}if(a.size()!=1)throw Split{sc(a,ff::inv(a.back()))};return er(sc(s,ff::inv(a[0])));}
void lt(LP&p){while(p.size()&&p.back().empty())p.pop_back();}
LP la(const LP&a,const LP&b){LP c(max(a.size(),b.size()));for(size_t i=0;i<c.size();i++)c[i]=add(i<a.size()?a[i]:Poly{},i<b.size()?b[i]:Poly{});lt(c);return c;}
LP ln(LP a){for(auto&c:a)c=neg(c);return a;}
LP ls(const LP&a,const LP&b){return la(a,ln(b));}
LP lm2(const LP&a,const LP&b){if(a.empty()||b.empty())return {};LP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=add(c[i+j],em(a[i],b[j]));lt(c);return c;}
LP lsc(LP a,const Poly&v){for(auto&c:a)c=em(c,v);lt(a);return a;}
LP reduce(LP a){for(auto&c:a)c=er(c);lt(a);return a;}
pair<LP,LP> ld(LP a,const LP&b){if(b.empty())throw runtime_error("mu divide by zero");if(a.size()<b.size())return {{},a};LP q(a.size()-b.size()+1);auto iv=ei(b.back());for(int i=int(q.size())-1;i>=0;i--){auto c=q[i]=em(a[i+b.size()-1],iv);for(size_t j=0;j<b.size();j++)a[i+j]=sub(a[i+j],em(c,b[j]));}a.resize(b.size()-1);lt(a);lt(q);return {q,a};}
array<LP,3> lx(LP a,LP b){LP s{Poly{1}},t{},u{},v{Poly{1}};while(b.size()){auto qr=ld(a,b);auto ns=ls(s,lm2(qr.first,u)),nt=ls(t,lm2(qr.first,v));a=move(b);b=move(qr.second);s=move(u);u=move(ns);t=move(v);v=move(nt);}if(a.empty())return {a,s,t};auto iv=ei(a.back());return {lsc(a,iv),lsc(s,iv),lsc(t,iv)};}
Poly deriv(const Poly&p){Poly d;for(size_t i=1;i<p.size();i++)d.push_back(ff::mul(p[i],i%5));trim(d);return d;}
Poly rad(Poly p){if(p.size()<2)return {1};p=sc(p,ff::inv(p.back()));auto d=deriv(p);if(d.empty()){Poly a((p.size()-1)/5+1);for(size_t i=0;i<p.size();i++)if(p[i]){if(i%5)throw runtime_error("bad fifth power");a[i/5]=ff::pow(p[i],78125);}return rad(a);}auto g=gcd(p,d),r=exactdiv(p,g),s=rad(g);return exactdiv(mul(r,s),gcd(r,s));}
Poly readp(istream&in){int n;in>>n;if(!in)throw runtime_error("read failed");Poly p(n);for(int&c:p)in>>c;trim(p);return p;}
void wp(ostream&out,const Poly&p){out<<p.size();for(int c:p)out<<' '<<c;out<<'\n';}
void wl(ostream&out,const LP&p){out<<p.size()<<'\n';for(auto&c:p)wp(out,c);}
vector<LP> originals;vector<Poly> pieces;string prefix;int partcount=0;
void solve(const Poly&m){MOD=m;try{vector<LP> fs;for(auto f:originals)fs.push_back(reduce(f));LP g;vector<LP>comb(fs.size());for(size_t i=0;i<fs.size();i++){auto z=lx(g,fs[i]);for(auto&c:comb)c=lm2(z[1],c);comb[i]=la(comb[i],z[2]);g=z[0];cerr<<"modulus degree "<<m.size()-1<<" after formal index "<<71+i<<" gcd mu-degree "<<int(g.size())-1<<'\n';if(g.size()==1)break;}
 LP sum;for(size_t i=0;i<fs.size();i++)sum=la(sum,lm2(comb[i],fs[i]));if(sum!=g)throw runtime_error("quotient Bezout identity failed");int nz=0,exp=-1;for(size_t i=0;i<g.size();i++)if(g[i].size()){nz++;exp=i;}bool excluded=nz==1&&g[exp]==Poly{1};int id=partcount++;ofstream out(prefix+".part"+to_string(id));wp(out,m);wl(out,g);out<<comb.size()<<'\n';for(auto&c:comb)wl(out,c);out<<excluded<<' '<<exp<<'\n';cerr<<"PART "<<id<<" dimension "<<m.size()-1<<" excluded "<<excluded<<" mu exponent "<<exp<<'\n';pieces.push_back(m);
 }catch(Split&s){auto g=gcd(m,s.factor);if(g.size()<2||g.size()==m.size())throw runtime_error("invalid coefficient split");cerr<<"SPLIT modulus "<<m.size()-1<<" into "<<g.size()-1<<" and "<<m.size()-g.size()<<'\n';solve(g);solve(exactdiv(m,g));}}
int main(int argc,char**argv){if(argc<5)return 2;ff::init(argv[1]);ifstream gi(argv[2]),in(argv[3]);auto G=readp(gi);auto C=rad(G);if(gcd(C,deriv(C)).size()!=1)throw runtime_error("radical not squarefree");if(exactdiv(power(C,int(G.size())),G).empty())throw runtime_error("bad radical certificate");prefix=argv[4];ofstream radout(prefix+".radical");wp(radout,C);int n;in>>n;for(int i=0;i<n;i++){int k;in>>k;LP p;for(int j=0;j<k;j++)p.push_back(readp(in));originals.push_back(p);}cerr<<"resultant gcd degree "<<G.size()-1<<"; radical degree "<<C.size()-1<<'\n';solve(C);Poly product{1};for(auto&p:pieces)product=mul(product,p);if(product!=C)throw runtime_error("pieces do not cover radical");ofstream out(prefix+".cover");out<<pieces.size()<<'\n';for(auto&p:pieces)wp(out,p);cerr<<"All quotient identities and complete radical cover verified.\n";}
