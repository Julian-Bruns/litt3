// Exact specialization checks for the globally proved monic scale equation.
// These are bounded checks, NOT a geometric decision or finite-field search.
#include "../src/source.hpp"
using XP = std::vector<Poly>; // x (or T) exponent, then mu exponent

XP addXP(const XP &a, const XP &b) {
    XP c(std::max(a.size(), b.size()));
    for (size_t i=0; i<c.size(); ++i)
        c[i]=(i<a.size()?a[i]:Poly())+(i<b.size()?b[i]:Poly());
    return c;
}
XP scaleXP(XP a, F s) { for (auto &p:a) p=scale(p,s); return a; }
XP mulXP(const XP &a, const XP &b, int limit) {
    if (a.empty() || b.empty()) return {};
    XP c(std::min(limit, int(a.size()+b.size()-1)));
    for(int i=0;i<int(a.size());++i)
        for(int j=0;j<int(b.size()) && i+j<limit;++j)
            c[i+j]=c[i+j]+a[i]*b[j];
    return c;
}
XP frobeniusXP(const XP &a, int p, int limit) {
    if(a.empty()) return {};
    XP c(std::min(limit,p*(int(a.size())-1)+1));
    for(int i=0;i<int(a.size()) && p*i<limit;++i) c[p*i]=frob(a[i],p);
    return c;
}
XP constantMu(const Poly &p) {
    XP a; for(F c:p.v) a.emplace_back(c); return a;
}
Poly atXP(const XP &a,int i) { return i>=0 && i<int(a.size())?a[i]:Poly(); }
std::vector<Poly> equations(const XP &W) {
    if(W.size()!=141 || W[140].deg()!=0 || !W[140].at(0))
        throw std::runtime_error("Expected degree 140 and unit scale-independent leading coefficient");
    XP A(141); for(int i=0;i<=140;++i) A[i]=W[140-i];
    XP A2=mulXP(A,A,125),A3=mulXP(A2,A,125);
    XP C=mulXP(mulXP(A3,frobeniusXP(A2,5,125),125),frobeniusXP(A2,25,125),125);
    XP B(C.begin(),C.begin()+71);
    XP late=addXP(mulXP(B,B,141),scaleXP(A,ff::neg(ff::pow(W[140].at(0),125))));
    std::vector<Poly> out;
    for(int i=71;i<=124;++i) out.push_back(atXP(C,i));
    for(int i=125;i<=140;++i) out.push_back(atXP(late,i));
    if(out.size()!=70) throw std::runtime_error("Incomplete equation list");
    return out;
}
struct Record {int j,h,q,m,x;F c;};
std::vector<Record> load(const std::string &path) {
    std::ifstream in(path); std::string magic;in>>magic;
    if(magic!="CONSTANT140_E_V1") throw std::runtime_error("Invalid E table");
    std::vector<Record> r;Record a;
    while(in>>a.j>>a.h>>a.q>>a.m>>a.x>>a.c)r.push_back(a);
    if(r.size()!=89481)throw std::runtime_error("Wrong E count");
    return r;
}
XP evaluateW(const std::vector<Record>&records,F H,F q) {
    std::array<XP,3>E;
    for(auto &e:E){e.resize(47);for(auto&p:e)p.v.resize(3);}
    std::array<F,13> hp;std::array<F,61>qp;hp[0]=qp[0]=1;
    for(int i=1;i<13;++i)hp[i]=ff::mul(hp[i-1],H);
    for(int i=1;i<61;++i)qp[i]=ff::mul(qp[i-1],q);
    for(auto r:records){F c=ff::mul(r.c,ff::mul(hp[r.h],qp[r.q]));
        E[r.j][r.x].v[r.m]=ff::add(E[r.j][r.x].v[r.m],c);}
    for(auto&e:E)for(auto&p:e)p.trim();
    XP W=scaleXP(mulXP(mulXP(E[0],E[0],141),E[0],141),ff::mul(q,q));
    W=addXP(W,scaleXP(mulXP(constantMu(P),mulXP(mulXP(E[1],E[1],141),E[1],141),141),q));
    W=addXP(W,mulXP(constantMu(P*P),mulXP(mulXP(E[2],E[2],141),E[2],141),141));
    W=addXP(W,scaleXP(mulXP(constantMu(P),mulXP(mulXP(E[0],E[1],141),E[2],141),141),ff::mul(2,q)));
    return W;
}
void fixture(const Poly &R,const std::string &name) {
    auto eq=equations(constantMu(R));
    for(int i=0;i<54;++i)if(!eq[i].zero())throw std::runtime_error("Fixture early equation failure");
    int n=0;for(int i=54;i<70;++i)if(!eq[i].zero())++n;
    if(!n)throw std::runtime_error("Nonsquare fixture not rejected by late equations");
    std::cout<<"synthetic_not_family "<<name<<" early54_vanish true late_nonzero "<<n<<"\n";
}
int main(int argc,char **argv) {try {
    ff::init();init_source();auto records=load(argc>1?argv[1]:"inputs/E_records.tsv");
    int count=0;
    for(auto [H,q]:std::vector<std::pair<F,F>>{{1,3},{5,15625},{31,48151},{2,17576},{625,14},{31,54853},{18,5},{50,26}}) {
        if(!allowed(H,q,1))throw std::runtime_error("Diagnostic ratio is outside the allowed chart");
        XP W=evaluateW(records,H,q);
        F psi=psieval(H,q),L=W[140].at(0);
        std::array<int,7>degrees;degrees.fill(-1);
        for(int x=0;x<=140;++x)for(int m=0;m<=6;++m)if(W[x].at(m))degrees[m]=x;
        std::array<int,7>bounds{140,138,137,136,133,131,129};
        for(int m=0;m<=6;++m)if(degrees[m]>bounds[m])throw std::runtime_error("Scale support exceeded");
        F c3=ff::mul(353570,ff::mul(ff::pow(q,46),ff::pow(psi,3)));
        F c6=ff::mul(242747,ff::pow(q,50));
        if(W[136].at(3)!=c3 || W[129].at(6)!=c6)throw std::runtime_error("W frontier coefficient mismatch");
        auto eq=equations(W);
        F top=ff::mul(295985,ff::mul(ff::pow(L,50),ff::mul(ff::pow(q,610),ff::pow(psi,30))));
        if(eq[2].deg()!=48 || eq[2].v.back()!=top)throw std::runtime_error("S73 monic leading certificate mismatch");
        if(eq[0].deg()>47 || eq[1].deg()>47 || eq[3].deg()>48)throw std::runtime_error("Early scale degrees exceeded");
        Poly monic=scale(eq[2],ff::inv(top)),gg=monic;
        int divisions=0,maxrem=-1;
        for(int i=0;i<70;++i)if(i!=2){auto qr=divmod(eq[i],monic);
            if(!(qr.first*monic+qr.second==eq[i]) || qr.second.deg()>=48)
                throw std::runtime_error("Exact quotient reduction failed");
            gg=gcd(gg,qr.second);maxrem=std::max(maxrem,qr.second.deg());++divisions;}
        std::cout<<"bounded_ratio H "<<H<<" q "<<q<<" S71_degree "<<eq[0].deg()
                 <<" S73_degree "<<eq[2].deg()<<" verified_leading_K_code "<<top
                 <<" exact_reductions "<<divisions<<" max_remainder_degree "<<maxrem
                 <<" specialized_all70_gcd_degree "<<gg.deg()<<"\n";
        ++count;
    }
    fixture(Poly::mon(140)+Poly(1),"x140_plus_1");
    Poly j7=Poly::mon(7)+Poly::mon(1,2)+Poly(1);
    Poly counterfeit=frob(Poly(std::vector<F>{4,1}),125)*Poly(std::vector<F>{3,1})*j7*j7;
    fixture(counterfeit,"multiplicity125_counterfeit");
    auto positive=equations(constantMu(ppow(Poly::mon(70)+Poly::mon(11,7)+Poly(2),2)));
    for(auto&p:positive)if(!p.zero())throw std::runtime_error("Synthetic square failed");
    std::cout<<"synthetic_square_not_family all70_vanish true\n";
    std::cout<<"CHECKS PASS: "<<count<<" bounded ratio checks, 69 exact remainders each, all70 retained.\n";
    std::cout<<"GLOBAL SQUARE LOCUS: UNRESOLVED.\n";
}catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}return 0;}
