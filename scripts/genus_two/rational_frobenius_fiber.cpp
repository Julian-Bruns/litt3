// Check a reconstructed fiber and count its points over the coefficient field.
// Uses the exact arithmetic from the preserved returned certificate.
#include "common.hpp"
#include "univar.hpp"
#include "rur.hpp"

void require(bool b, const string& s) { if (!b) throw runtime_error(s); }
U eval_poly(const P& p, const vector<U>& X, const U& H) {
    vector<vector<U>> pw(3, vector<U>(6));
    for (int i=0;i<3;i++) {
        pw[i][0]={1};
        for (int j=1;j<=5;j++) pw[i][j]=umodmul(pw[i][j-1],X[i],H);
    }
    U a;
    for (auto [m,c]:p) {
        U t=umodmul(umodmul(pw[0][mx(m)],pw[1][my(m)],H),pw[2][mz(m)],H);
        a=uadd(a,t,c);
    }
    return a;
}
void linear_roots(const U& f, vector<F>& roots, mt19937_64& random) {
    if (ud(f)==0) return;
    if (ud(f)==1) { roots.push_back(mul(neg(f[0]),inv(f[1]))); return; }
    for (int trial=0;trial<10000;trial++) {
        int coefficients[5]; for (int& c:coefficients) c=random()%125;
        U a{pack(coefficients),1};
        U part=ugcd(f,a);
        if (ud(part)==0 || ud(part)==ud(f))
            part=ugcd(f,uadd(upow(a,(FSIZE-1)/2,f),U{1},4));
        if (ud(part)>0 && ud(part)<ud(f)) {
            linear_roots(part,roots,random);
            linear_roots(exactdiv(f,part),roots,random);
            return;
        }
    }
    throw runtime_error("bounded root search failed");
}
int main() { try {
    initfield(); inputs(3);
    U H; for (uint64_t c:HCODE) H.push_back(decode(c));
    vector<U> X(3);
    for (int i=0;i<3;i++) for (uint64_t c:XCODE[i]) X[i].push_back(decode(c));
    require(ud(H)==125 && H.back()==1,"wrong degree");
    require(ud(ugcd(H,uderiv(H)))==0,"nonreduced fiber");
    U separator=uadd(uadd(X[0],X[1],128),X[2],power(128,2));
    require(rem(uadd(separator,U{0,1},4),H).empty(),"separator identity");
    U q[4]; for (int j=0;j<4;j++) q[j]=eval_poly(Q[j],X,H);
    for (int j=0;j<3;j++)
        require(uadd(q[j],q[3],neg(B[j])).empty(),"fiber equation");
    U base=ugcd(H,q[3]), remaining=exactdiv(H,base);
    U kum=ugcd(remaining,eval_poly(G,X,H));
    U good=exactdiv(remaining,kum);
    U rational=ugcd(good,uadd(upow(U{0,1},FSIZE,good),U{0,1},4));
    cerr<<"Certified: full reduced fiber 125; base "<<ud(base)
        <<"; Kummer "<<ud(kum)<<"; good "<<ud(good)
        <<"; coefficient-field rational "<<ud(rational)<<"\n";
    ofstream out("rational_fiber.json");
    out<<"{\"raw_degree\":125,\"base_degree\":"<<ud(base)
       <<",\"kummer_degree\":"<<ud(kum)<<",\"good_degree\":"<<ud(good)
       <<",\"rational_count\":"<<ud(rational)<<",\"rational_polynomial\":";
    writevec(out,rational);
    out<<",\"good_polynomial\":"; writevec(out,good);
    vector<F> roots; mt19937_64 random(20260920);
    linear_roots(rational,roots,random);
    sort(roots.begin(),roots.end());
    require(int(roots.size())==ud(rational),"root count");
    require(adjacent_find(roots.begin(),roots.end())==roots.end(),"repeated root");
    out<<",\"rational_points\":[";
    for (int r=0;r<int(roots.size());r++) {
        F h=roots[r], value=0;
        for (int j=ud(rational);j>=0;j--) value=add(mul(value,h),rational[j]);
        require(value==0,"incorrect linear root");
        vector<F> z;
        for (int i=0;i<3;i++) {
            F a=0; for (int j=ud(X[i]);j>=0;j--) a=add(mul(a,h),X[i][j]);
            z.push_back(a); cerr<<"point "<<r<<" z"<<i<<" = "<<fstr(a)<<"\n";
        }
        z.push_back(1); if(r) out<<","; writevec(out,z);
    }
    out<<"]}\n";
} catch (const exception& e) { cerr<<"ERROR: "<<e.what()<<"\n"; return 1; } }
