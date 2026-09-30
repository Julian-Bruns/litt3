// Exact arithmetic in F25[X]/(N), with direct Bezout and primitive-element certificates.
#include <algorithm>
#include <cassert>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;using Poly=vector<int>;using YPoly=vector<Poly>;
int ad[25][25],mu[25][25],ng[25],iv[25];
void init(){for(int a=0;a<25;a++){ng[a]=(5-a%5)%5+5*((5-a/5)%5);for(int b=0;b<25;b++){ad[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);mu[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
 for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mu[a][b]==1)iv[a]=b;
}
void trim(Poly&a){while(!a.empty()&&!a.back())a.pop_back();}
Poly add(Poly a,const Poly&b){a.resize(max(a.size(),b.size()));for(int i=0;i<(int)b.size();i++)a[i]=ad[a[i]][b[i]];trim(a);return a;}
Poly neg(Poly a){for(int&v:a)v=ng[v];return a;}
Poly sub(const Poly&a,const Poly&b){return add(a,neg(b));}
Poly scale(Poly a,int s){for(int&v:a)v=mu[v][s];trim(a);return a;}
Poly mul(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(int i=0;i<(int)a.size();i++)if(a[i])for(int j=0;j<(int)b.size();j++)c[i+j]=ad[c[i+j]][mu[a[i]][b[j]]];trim(c);return c;}
pair<Poly,Poly> divrem(Poly a,const Poly&b){if(b.empty())throw runtime_error("polynomial divide by zero");Poly q(max(0,(int)a.size()-(int)b.size()+1));while(a.size()>=b.size()){
 int d=a.size()-b.size(),s=mu[a.back()][iv[b.back()]];q[d]=s;
 for(int i=0;i<(int)b.size();i++){a[i+d]=ad[a[i+d]][ng[mu[s][b[i]]]];}trim(a);
 }trim(q);return {q,a};}
Poly mod(const Poly&a,const Poly&b){return divrem(a,b).second;}
Poly monic(Poly a){return a.empty()?a:scale(a,iv[a.back()]);}
Poly gcd(Poly a,Poly b){while(!b.empty()){Poly r=mod(a,b);a=move(b);b=move(r);}return monic(a);}
Poly derivative(const Poly&a){Poly b(max(0,(int)a.size()-1));for(int i=1;i<(int)a.size();i++)b[i-1]=mu[i%5][a[i]];trim(b);return b;}
Poly modpoly;
Poly mm(const Poly&a,const Poly&b){return mod(mul(a,b),modpoly);}
Poly inverse(Poly a){Poly r0=modpoly,r1=mod(a,modpoly),s0={},s1={1};
 while(!r1.empty()){auto [q,r]=divrem(r0,r1);Poly s=sub(s0,mul(q,s1));r0=move(r1);r1=move(r);s0=move(s1);s1=move(s);}
 if(r0.size()!=1){throw runtime_error("nonunit inverse: gcd degree "+to_string((int)r0.size()-1));}return mod(scale(s0,iv[r0[0]]),modpoly);
}
Poly power(Poly a,int n){Poly z={1};while(n){if(n&1)z=mm(z,a);a=mm(a,a);n>>=1;}return z;}
Poly eval(const Poly&a,const Poly&x){Poly z;for(int i=(int)a.size()-1;i>=0;i--)z=add(mm(z,x),Poly{a[i]});return z;}
Poly readpoly(istream&in){
 int n;
 if(!(in>>n)||n< -1||n>1000000)throw runtime_error("invalid polynomial degree");
 Poly a(n+1);
 for(int &c:a){if(!(in>>c)||c<0||c>=25)throw runtime_error("invalid F25 coefficient");}
 trim(a);return a;
}
void writepoly(ostream&out,const Poly&a){out<<(int)a.size()-1<<'\n';for(int c:a)out<<c<<' ';out<<'\n';}
void ytrim(YPoly&a){while(!a.empty()&&a.back().empty())a.pop_back();}
YPoly pairpoly(const Poly&N,const Poly&D){
 Poly x={0,1},nx=mod(N,modpoly),dx=mod(D,modpoly);int n=max(N.size(),D.size())-1;YPoly h(n+1);
 for(int i=0;i<=n;i++)h[i]=sub(i<(int)D.size()?scale(nx,D[i]):Poly{},i<(int)N.size()?scale(dx,N[i]):Poly{});
 YPoly f(n);f[n-1]=h[n];for(int i=n-1;i>=1;i--)f[i-1]=add(h[i],mm(x,f[i]));assert(add(h[0],mm(x,f[0])).empty());ytrim(f);return f;
}
YPoly yadd(YPoly a,const YPoly&b){a.resize(max(a.size(),b.size()));for(int i=0;i<(int)b.size();i++)a[i]=add(a[i],b[i]);ytrim(a);return a;}
YPoly yneg(YPoly a){for(Poly&p:a)p=neg(p);return a;}
YPoly ysub(const YPoly&a,const YPoly&b){return yadd(a,yneg(b));}
YPoly ymul(const YPoly&a,const YPoly&b){if(a.empty()||b.empty())return {};YPoly c(a.size()+b.size()-1);for(int i=0;i<(int)a.size();i++)for(int j=0;j<(int)b.size();j++)c[i+j]=add(c[i+j],mm(a[i],b[j]));ytrim(c);return c;}
pair<YPoly,YPoly> ydivrem(YPoly a,const YPoly&b){Poly binv=inverse(b.back());YPoly out(max(0,(int)a.size()-(int)b.size()+1));while(a.size()>=b.size()){
 int d=a.size()-b.size();Poly q=mm(a.back(),binv);out[d]=q;
 for(int i=0;i<(int)b.size();i++){a[i+d]=sub(a[i+d],mm(q,b[i]));}ytrim(a);
 }ytrim(out);return {out,a};
}
YPoly bezout_f,bezout_g;
YPoly ygcd(YPoly a,YPoly b){YPoly original_a=a,original_b=b,s0={Poly{1}},s1={},t0={},t1={Poly{1}};while(!b.empty()){
 cerr<<"gcd y degrees "<<(int)a.size()-1<<','<<(int)b.size()-1<<'\n';
 auto [q,r]=ydivrem(a,b);YPoly sn=ysub(s0,ymul(q,s1)),tn=ysub(t0,ymul(q,t1));
 a=move(b);b=move(r);s0=move(s1);s1=move(sn);t0=move(t1);t1=move(tn);
 }Poly z=inverse(a.back());for(Poly&p:a)p=mm(p,z);for(Poly&p:s0)p=mm(p,z);for(Poly&p:t0)p=mm(p,z);
 bezout_f=s0;bezout_g=t0;assert(yadd(ymul(s0,original_a),ymul(t0,original_b))==a);
 cerr<<"Bezout identity certified; multiplier y-degrees "<<(int)s0.size()-1<<','<<(int)t0.size()-1<<'\n';return a;
}
void writeypoly(ostream&out,const YPoly&a){out<<(int)a.size()-1<<'\n';for(const Poly&p:a)writepoly(out,p);}
Poly yeval(const YPoly&a,const Poly&y){Poly z;for(int i=(int)a.size()-1;i>=0;i--)z=add(mm(z,y),a[i]);return z;}
Poly inverse_primitive;
Poly minpoly(const Poly&r){int d=modpoly.size()-1;
 vector<Poly> basis(d),comb(d);Poly w={1};
 for(int k=0;k<=d;k++){
  Poly v=w;v.resize(d);Poly c(k+1);c[k]=1;
  for(int i=0;i<d;i++)if(v[i]){
   if(basis[i].empty()){
    int s=iv[v[i]];for(int&b:v)b=mu[b][s];c=scale(c,s);basis[i]=v;comb[i]=c;goto independent;
   }
   int s=v[i];for(int j=i;j<d;j++)v[j]=ad[v[j]][ng[mu[s][basis[i][j]]]];
   c=sub(c,scale(comb[i],s));
  }
  {
  cerr<<"minimal polynomial degree="<<k<<" (algebra dimension "<<d<<")\n";
  if(k!=d)throw runtime_error("scalar does not generate full algebra");
  Poly target(d);target[1]=1;inverse_primitive.clear();
  for(int i=0;i<d;i++)if(target[i]){
   int s=target[i];if(basis[i].empty())throw runtime_error("missing pivot");
   for(int j=i;j<d;j++)target[j]=ad[target[j]][ng[mu[s][basis[i][j]]]];
   inverse_primitive=add(inverse_primitive,scale(comb[i],s));
  }
  trim(target);assert(target.empty());assert(eval(inverse_primitive,r)==Poly({0,1}));
  cerr<<"inverse primitive element certificate degree="<<inverse_primitive.size()-1<<" PASS\n";
  return monic(c);
  }
  independent: w=mm(w,r);
 }
 throw runtime_error("linear algebra did not terminate");
}
int main(int argc,char**argv){try{
 if(argc!=4){throw runtime_error("usage: quotient POLYS CLEAN_MODULUS OUTPUT");}init();ifstream f(argv[1]),g(argv[2]);
 Poly N=readpoly(f),D=readpoly(f),U=readpoly(f),V=readpoly(f);modpoly=readpoly(g);
 if(gcd(modpoly,derivative(modpoly))!=Poly{1})throw runtime_error("modpoly not squarefree");
 YPoly p=pairpoly(N,D),q=pairpoly(U,V),gcdpq=ygcd(p,q);
 if(gcdpq.size()!=2||gcdpq[1]!=Poly{1})throw runtime_error("not linear");
 Poly phi=neg(gcdpq[0]),x={0,1};assert(yeval(p,phi).empty()&&yeval(q,phi).empty());assert(eval(phi,phi)==x);inverse(sub(phi,x));
 Poly P={11,22,18,5,19,20,15,16,9,22,1},A={1,21,14,22,13},Ap=derivative(A);
 Poly r=mm(mm(power(mm(eval(P,phi),inverse(P)),26),power(mm(eval(Ap,phi),inverse(Ap)),39)),power(mm(A,inverse(eval(A,phi))),87));
 assert(mm(r,eval(r,phi))==Poly{1});
 Poly mp=minpoly(r);
 cerr<<"r-1 gcd degree="<<gcd(sub(r,Poly{1}),modpoly).size()-1<<'\n';
 cerr<<"r+1 gcd degree="<<gcd(add(r,Poly{1}),modpoly).size()-1<<'\n';
 cerr<<"r minpoly squarefree="<<(gcd(mp,derivative(mp))==Poly{1})<<'\n';
 ofstream out(argv[3]);writepoly(out,phi);writepoly(out,r);writepoly(out,mp);writepoly(out,inverse_primitive);
 ofstream bz(string(argv[3])+".bezout");writeypoly(bz,bezout_f);writeypoly(bz,bezout_g);
 assert(eval(mp,r).empty());cerr<<"PASS: partner substitution, involution, non-diagonal, reciprocal scalar, minimal polynomial\n";return 0;
 }catch(const exception&e){cerr<<"ERROR: "<<e.what()<<'\n';return 1;}}
