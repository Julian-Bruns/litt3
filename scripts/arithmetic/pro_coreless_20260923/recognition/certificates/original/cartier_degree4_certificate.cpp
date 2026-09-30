/*
Exact degree-four obstruction certificate for the Cartier-line problem.

Build and run (assertions must remain enabled):
    g++ -O3 -std=c++17 cartier_degree4_certificate.cpp -o certificate
    ./certificate

All integer field codes in the input use a^2 = a + 3 over F_5.
No numerical approximations are used. The fixed-seed polynomial splitting
routine is Las Vegas: every factorization is verified by exact arithmetic;
a failure to split causes an exception, not an accepted result.

Mathematical reduction verified by this file:
  L(v) = (v^4 + 3 v^2 + 3)/(3 v^3).
  r(z) = c + m L(t/(1-z)),
  c=(alpha+beta)/2, m=(beta-alpha)/2,
  {alpha,beta} any two distinct roots of P,
  rho any root of A,
  t any root of t^4 - 3*((rho-c)/m)*t^3 + 3*t^2 + 3.
There are exactly 45*4*4 = 720 geometric candidates.
For each candidate form the monic polynomial proportional to
  N_r(z) = (1-z)^4 A(r(z))/z  (degree 15).
Check that no N_r is proportional to z^15 N_s(1/z).

The quartic defining t has discriminant 2*(s^2-1)^2, a nonzero square
in K=F_(25^4). Hence its Frobenius permutation is even, and every root
lies in K, its quadratic extension, or its cubic extension. The common
subfield of the latter two is K. Polynomial keys explicitly identify
coefficients in that common subfield. This is an exhaustive geometric
check, not a bounded search over an arbitrary field.

K = F_25[b]/(b^4+[7]b^3+[6]b^2+[2]b+[5]).
An element of K is encoded in base 25, with the original F_25 code for
each digit. The two larger fields are K[c]/(c^2-b) and K[c]/(c^3-a).
The irreducibility and splitting assertions needed below are checked.
*/

#ifdef NDEBUG
#error "Build with assertions enabled: do not define NDEBUG."
#endif

#include <bits/stdc++.h>
using namespace std;
using ull=unsigned long long;
const int q=390625;
int ad[25][25],mu[25][25],ng[25];
void init25(){for(int a=0;a<25;a++)for(int b=0;b<25;b++){
 ad[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
 mu[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
 } for(int a=0;a<25;a++)ng[a]=(5-a%5)%5+5*((5-a/5)%5);}
int ba(int a,int b){int r=0,w=1;for(int i=0;i<4;i++){r+=w*ad[a%25][b%25];a/=25;b/=25;w*=25;}return r;}
int bn(int a){int r=0,w=1;for(int i=0;i<4;i++){r+=w*ng[a%25];a/=25;w*=25;}return r;}
int bm(int a,int b){int aa[4],bb[4],c[7]={};for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=ad[c[i+j]][mu[aa[i]][bb[j]]];int co[4]={ng[5],ng[2],ng[6],ng[7]};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=ad[c[i-4+j]][mu[c[i]][co[j]]];int r=0;for(int i=3;i>=0;i--)r=25*r+c[i];return r;}
int bp(int a,ull n){int v=1;while(n){if(n&1)v=bm(v,a);a=bm(a,a);n>>=1;}return v;}

// Independent polynomial arithmetic over the 25-element coefficient field.
using SmallPolynomial = vector<int>;
void small_trim(SmallPolynomial &p) {
    while (!p.empty() && p.back() == 0) p.pop_back();
}
int small_power(int x, unsigned long long n) {
    int r = 1;
    while (n) {
        if (n & 1) r = mu[r][x];
        x = mu[x][x];
        n >>= 1;
    }
    return r;
}
SmallPolynomial small_subtract(SmallPolynomial a, const SmallPolynomial &b) {
    a.resize(max(a.size(), b.size()));
    for (size_t i = 0; i < b.size(); ++i) a[i] = ad[a[i]][ng[b[i]]];
    small_trim(a);
    return a;
}
SmallPolynomial small_remainder(SmallPolynomial a, const SmallPolynomial &b) {
    assert(!b.empty());
    const int inverse = small_power(b.back(), 23);
    while (a.size() >= b.size()) {
        const size_t shift = a.size() - b.size();
        const int c = mu[a.back()][inverse];
        for (size_t i = 0; i < b.size(); ++i)
            a[i + shift] = ad[a[i + shift]][ng[mu[c][b[i]]]];
        small_trim(a);
    }
    return a;
}
SmallPolynomial small_multiply(const SmallPolynomial &a, const SmallPolynomial &b) {
    if (a.empty() || b.empty()) return {};
    SmallPolynomial r(a.size() + b.size() - 1);
    for (size_t i = 0; i < a.size(); ++i)
        for (size_t j = 0; j < b.size(); ++j)
            r[i+j] = ad[r[i+j]][mu[a[i]][b[j]]];
    small_trim(r);
    return r;
}
SmallPolynomial small_power_mod(SmallPolynomial a, unsigned long long n,
                                const SmallPolynomial &modulus) {
    SmallPolynomial r{1};
    while (n) {
        if (n & 1) r = small_remainder(small_multiply(r, a), modulus);
        a = small_remainder(small_multiply(a, a), modulus);
        n >>= 1;
    }
    return r;
}
SmallPolynomial small_gcd(SmallPolynomial a, SmallPolynomial b) {
    while (!b.empty()) {
        auto r = small_remainder(a, b);
        a = b;
        b = r;
    }
    const int inverse = small_power(a.back(), 23);
    for (auto &v : a) v = mu[v][inverse];
    return a;
}
void validate_base_field() {
    // For a degree-four polynomial, these two Frobenius tests prove
    // irreducibility over F_25 (the only prime divisor of 4 is 2).
    SmallPolynomial H{5, 2, 6, 7, 1}, X{0, 1};
    assert(small_gcd(H, small_subtract(small_power_mod(X, 625, H), X))
           == SmallPolynomial{1});
    assert(small_power_mod(X, q, H) == X);
    assert(bp(2, (q-1)/2) == 1); // The quartic discriminant is a square.
    cout << "base_field_irreducibility=verified\n";
}

// Extension arithmetic and exact polynomial factorization.
mt19937_64 rng(7823793);
template<int D> struct F {
 array<int,D>a{};static inline int nu=1;static inline ull Q=1;
 F(int v=0){a[0]=v;}
 bool operator==(const F&b)const{return a==b.a;} bool operator!=(const F&b)const{return !(*this==b);} bool zero()const{for(int v:a)if(v)return false;return true;}
 F operator+(const F&b)const{F c;for(int i=0;i<D;i++)c.a[i]=ba(a[i],b.a[i]);return c;}
 F operator-()const{F c;for(int i=0;i<D;i++)c.a[i]=bn(a[i]);return c;}
 F operator-(const F&b)const{return *this+(-b);}
 F operator*(const F&b)const{array<int,2*D-1>c{};for(int i=0;i<D;i++)for(int j=0;j<D;j++)c[i+j]=ba(c[i+j],bm(a[i],b.a[j]));for(int i=2*D-2;i>=D;i--)c[i-D]=ba(c[i-D],bm(c[i],nu));F v;for(int i=0;i<D;i++)v.a[i]=c[i];return v;}
 F pow(ull n)const{F u=*this,v(1);while(n){if(n&1)v=v*u;u=u*u;n>>=1;}return v;}
 F inv()const{assert(!zero());return pow(Q-2);}
 F operator/(const F&b)const{return *this*b.inv();}
 static F random(){F x;for(auto &v:x.a)v=rng()%q;return x;}
 static void setup(){Q=1;for(int i=0;i<D;i++)Q*=q;if constexpr(D>1){for(nu=2;nu<q;nu++)if(bp(nu,(q-1)/D)!=1)break;}cerr<<"field D="<<D<<" Q="<<Q<<" nu="<<nu<<"\n";}
};
template<int D> using Pol=vector<F<D>>;
template<int D> void trim(Pol<D>&p){while(!p.empty()&&p.back().zero())p.pop_back();}
template<int D> Pol<D> plusp(Pol<D>a,const Pol<D>&b){a.resize(max(a.size(),b.size()));for(int i=0;i<(int)b.size();i++)a[i]=a[i]+b[i];trim(a);return a;}
template<int D> Pol<D> negp(Pol<D>a){for(auto &x:a)x=-x;return a;}
template<int D> Pol<D> scale(Pol<D>a,F<D>c){for(auto &x:a)x=x*c;trim(a);return a;}
template<int D> Pol<D> mult(const Pol<D>&a,const Pol<D>&b){if(a.empty()||b.empty())return {};Pol<D>c(a.size()+b.size()-1);for(int i=0;i<(int)a.size();i++)for(int j=0;j<(int)b.size();j++)c[i+j]=c[i+j]+a[i]*b[j];trim(c);return c;}
template<int D> Pol<D> monic(Pol<D>a){if(a.empty())return a;return scale(a,a.back().inv());}
template<int D> pair<Pol<D>,Pol<D>> divp(Pol<D>a,const Pol<D>&b){assert(!b.empty());Pol<D>quo(max(0,(int)a.size()-(int)b.size()+1));F<D>bi=b.back()==F<D>(1)?F<D>(1):b.back().inv();while(a.size()>=b.size()){int r=a.size()-b.size();F<D>c=a.back()*bi;quo[r]=c;for(int i=0;i<(int)b.size();i++)a[i+r]=a[i+r]-c*b[i];trim(a);}trim(quo);return {quo,a};}
template<int D> Pol<D> rem(Pol<D>a,const Pol<D>&b){return divp(a,b).second;}
template<int D> Pol<D> gc(Pol<D>a,Pol<D>b){while(!b.empty()){auto c=rem(a,b);a=b;b=c;}return monic(a);}
template<int D> Pol<D> powp(Pol<D>a,ull n,const Pol<D>&m){Pol<D>v{F<D>(1)};while(n){if(n&1)v=rem(mult(v,a),m);a=rem(mult(a,a),m);n>>=1;}return v;}
template<int D> void splitlinear(Pol<D>p,vector<F<D>>&out){p=monic(p);int deg=p.size()-1;if(deg<1)return;if(deg==1){out.push_back(-p[0]);return;}for(int tries=0;tries<1000;tries++){
 Pol<D>a(deg);for(auto &x:a)x=F<D>::random();auto b=powp(a,(F<D>::Q-1)/2,p);b=plusp(b,Pol<D>{F<D>(4)});auto g=gc(p,b);int gd=g.size()-1;if(gd>0&&gd<deg){splitlinear(g,out);splitlinear(divp(p,g).first,out);return;}}
 throw runtime_error("split failed");}
template<int D> vector<F<D>> roots(Pol<D>p){Pol<D>x{F<D>(0),F<D>(1)};auto g=gc(p,plusp(powp(x,F<D>::Q,p),negp(x)));vector<F<D>>out;splitlinear(g,out);return out;}
struct Meta {int D,ia,ib,ir; vector<int>t;};
map<string,vector<Meta>> allN; vector<pair<string,Meta>> revkeys;
template<int D> string key(const Pol<D>&v){bool base=true;for(auto&x:v)for(int j=1;j<D;j++)if(x.a[j])base=false;int d=base?1:D;string s;s.push_back((char)d);for(auto&x:v)for(int j=0;j<d;j++){uint32_t u=x.a[j];s.append((char*)&u,4);}return s;}
int ev(const vector<int>&p,int x){int y=0;for(int i=p.size()-1;i>=0;i--)y=ba(bm(y,x),p[i]);return y;}
vector<int>PR,AR;
template<int D> void run(){using E=F<D>;using V=Pol<D>;E::setup();int cnt=0,desc=0;
 const vector<int>A={1,21,14,22,13};V S={E(1),E(4)};auto S2=mult(S,S),S4=mult(S2,S2);
 for(int ia=0;ia<10;ia++)for(int ib=ia+1;ib<10;ib++){
 E m(bm(ba(PR[ib],bn(PR[ia])),3)); // divide by 2 = multiply by 3
 E c(bm(ba(PR[ib],PR[ia]),3));
 for(int ir=0;ir<4;ir++){
 E sv=(E(AR[ir])-c)/m;
 assert(sv != E(1) && sv != E(4));
 V pol={E(3),E(0),E(3),-E(3)*sv,E(1)};
 auto rt=roots(pol);
 for(E t:rt){assert(!t.zero());
 E check;for(int j=4;j>=0;j--)check=check*t+pol[j];assert(check.zero());E t2=t*t,t3=t2*t,t4=t2*t2;
 V den=scale(S,E(3)*t3);
 V uu=plusp(plusp(V{t4},scale(S2,E(3)*t2)),scale(S4,E(3)));
 V num=plusp(scale(uu,m),scale(den,c));
 V hh={E(A[4])},dp={E(1)};
 for(int j=3;j>=0;j--){dp=mult(dp,den);hh=plusp(mult(hh,num),scale(dp,E(A[j])));}
 assert(hh.size()==17);assert(hh[0].zero());assert(!hh[1].zero());
 V nn(hh.begin()+1,hh.end());nn=monic(nn);auto rv=nn;reverse(rv.begin(),rv.end());rv=monic(rv);
 Meta meta{D,ia,ib,ir,vector<int>(t.a.begin(),t.a.end())};string kn=key(nn),kr=key(rv);if(kn[0]==1)desc++;
 allN[kn].push_back(meta);revkeys.push_back({kr,meta});cnt++;
 }
 }}
 cout<<"D="<<D<<" candidates="<<cnt<<" normalized_polynomials_over_base="<<desc<<"\n";
}
int main(){init25();validate_base_field();vector<int>P={11,22,18,5,19,20,15,16,9,22,1};
 for(int x=0;x<q;x++)if(ev(P,x)==0)PR.push_back(x);
 int a=25;for(int i=0;i<4;i++){AR.push_back(a);a=bp(a,25);}sort(AR.begin(),AR.end());
 cerr<<"P roots=";for(auto a:PR)cerr<<a<<",";cerr<<"\nA roots=";for(auto a:AR)cerr<<a<<",";cerr<<"\n";assert(PR.size()==10);assert(set<int>(AR.begin(),AR.end()).size()==4);for(int a:AR)assert(ev({1,21,14,22,13},a)==0);
 run<1>();run<2>();run<3>();
 int matches=0;for(auto &[k,me]:revkeys){auto it=allN.find(k);if(it!=allN.end()){for(auto &o:it->second){matches++;cout<<"MATCH D="<<me.D<<" params "<<me.ia<<","<<me.ib<<","<<me.ir<<" vs D="<<o.D<<" params "<<o.ia<<","<<o.ib<<","<<o.ir<<"\n";}}}
 cout<<"distinct_N="<<allN.size()<<" total_candidates_with_repetitions="<<revkeys.size()<<" matches="<<matches<<"\n";
 assert(allN.size()==720);assert(revkeys.size()==1024);assert(matches==0);
 cout<<"degree_four_obstruction=verified\n";
}
