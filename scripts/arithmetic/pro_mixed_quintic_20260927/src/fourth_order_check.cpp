// Exact geometric certificate for REPORT Section 19.
// This regenerates the resultant identity and checks the finite-field
// obstruction on every irreducible component. It is not a curve search.
// Compile with C++17 and assertions enabled (do NOT use -DNDEBUG).
#include <algorithm>
#include <cassert>
#include <iostream>
#include <utility>
#include <vector>

using E = unsigned;
using Poly = std::vector<E>;

// F25[z]/(z^3+z+1). Code a0+25*a1+625*a2, each ai an F25 code.
// F25 uses iota^2=iota+3 exactly as in the problem. The auxiliary cubic
// modulus is independently checked by the Python generator.
struct Field {
    E at[25][25]{}, mt[25][25]{}, nt[25]{};
    std::vector<E> inv;
    Field() : inv(15625) {
        for (E a=0; a<25; ++a) {
            nt[a]=(5-a%5)%5+5*((5-a/5)%5);
            for (E b=0; b<25; ++b) {
                at[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
                mt[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5
                    +5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
            }
        }
        for (E a=1; a<15625; ++a) inv[a]=power(a,15623);
    }
    E add(E a,E b) const {
        return at[a%25][b%25]+25*at[(a/25)%25][(b/25)%25]
            +625*at[a/625][b/625];
    }
    E neg(E a) const { return nt[a%25]+25*nt[(a/25)%25]+625*nt[a/625]; }
    E sub(E a,E b) const { return add(a,neg(b)); }
    E mul(E a,E b) const {
        E aa[3]={a%25,(a/25)%25,a/625};
        E bb[3]={b%25,(b/25)%25,b/625};
        E v[5]={};
        for (int i=0; i<3; ++i)
            for (int j=0; j<3; ++j)
                v[i+j]=at[v[i+j]][mt[aa[i]][bb[j]]];
        // z^3=-z-1 and z^4=-z^2-z.
        v[2]=at[v[2]][nt[v[4]]]; v[1]=at[v[1]][nt[v[4]]];
        v[1]=at[v[1]][nt[v[3]]]; v[0]=at[v[0]][nt[v[3]]];
        return v[0]+25*v[1]+625*v[2];
    }
    E power(E a,unsigned n) const {
        E r=1;
        while (n) { if (n&1) r=mul(r,a); a=mul(a,a); n>>=1; }
        return r;
    }
} K;

void trim(Poly& a) { while (!a.empty() && !a.back()) a.pop_back(); }
Poly psub(Poly a,const Poly& b) {
    if (a.size()<b.size()) a.resize(b.size());
    for (size_t i=0; i<b.size(); ++i) a[i]=K.sub(a[i],b[i]);
    trim(a); return a;
}
Poly pscale(Poly a,E c) { for (auto& x:a) x=K.mul(x,c); trim(a); return a; }
Poly pmul(const Poly& a,const Poly& b) {
    if (a.empty() || b.empty()) return {};
    Poly out(a.size()+b.size()-1);
    for (size_t i=0; i<a.size(); ++i)
        for (size_t j=0; j<b.size(); ++j)
            out[i+j]=K.add(out[i+j],K.mul(a[i],b[j]));
    trim(out); return out;
}
std::pair<Poly,Poly> pdivmod(Poly a,const Poly& b) {
    assert(!b.empty());
    Poly q(a.size()>=b.size() ? a.size()-b.size()+1 : 0);
    while (a.size()>=b.size()) {
        const size_t j=a.size()-b.size();
        const E z=K.mul(a.back(),K.inv[b.back()]);
        q[j]=z;
        for (size_t i=0; i<b.size(); ++i) a[i+j]=K.sub(a[i+j],K.mul(z,b[i]));
        trim(a);
    }
    trim(q); return {q,a};
}
Poly rem(const Poly& a,const Poly& b) { return pdivmod(a,b).second; }
Poly pgcd(Poly a,Poly b) {
    while (!b.empty()) { auto r=rem(a,b); a=b; b=r; }
    return a.empty() ? a : pscale(a,K.inv[a.back()]);
}
Poly ppow(Poly a,unsigned n) {
    Poly r={1};
    while (n) { if (n&1) r=pmul(r,a); a=pmul(a,a); n>>=1; }
    return r;
}
Poly power_mod(Poly a,unsigned n,const Poly& f) {
    Poly r={1}; a=rem(a,f);
    while (n) { if (n&1) r=rem(pmul(r,a),f); a=rem(pmul(a,a),f); n>>=1; }
    return r;
}
Poly deriv(const Poly& a) {
    if (a.size()<2) return {};
    Poly b(a.size()-1);
    for (size_t i=1; i<a.size(); ++i) b[i-1]=K.mul(i%5,a[i]);
    trim(b); return b;
}
Poly inverse_mod(const Poly& a,const Poly& f) {
    Poly old=f, r=rem(a,f), old_s={}, ss={1};
    while (!r.empty()) {
        auto qr=pdivmod(old,r);
        auto next_s=psub(old_s,pmul(qr.first,ss));
        old=r; r=qr.second; old_s=ss; ss=next_s;
    }
    assert(old.size()==1);
    return rem(pscale(old_s,K.inv[old[0]]),f);
}
E eval(const Poly& a,E x) {
    E out=0;
    for (auto it=a.rbegin(); it!=a.rend(); ++it) out=K.add(K.mul(out,x),*it);
    return out;
}
Poly peval(const Poly& h,const Poly& x,const Poly& f) {
    Poly out;
    for (auto it=h.rbegin(); it!=h.rend(); ++it) {
        out=rem(pmul(out,x),f);
        if (out.empty()) out.resize(1);
        out[0]=K.add(out[0],*it); trim(out);
    }
    return out;
}
Poly frob(Poly a,unsigned times,const Poly& f) {
    for (unsigned i=0; i<times; ++i) a=power_mod(a,25,f);
    return a;
}

E resultant(Poly a,Poly b) {
    if (a.empty() || b.empty()) return 0;
    E out=1;
    while (b.size()>1) {
        const unsigned m=a.size()-1, n=b.size()-1;
        auto rr=rem(a,b);
        if (rr.empty()) return 0;
        const unsigned s=rr.size()-1;
        out=K.mul(out,K.power(b.back(),m-s));
        if ((m*n)%2) out=K.neg(out);
        a=b; b=rr;
    }
    return K.mul(out,K.power(b[0],a.size()-1));
}
// Specialization of the fixed-(m,n) Sylvester determinant, not a resultant
// with the specialized degrees. Both and one-sided degree drops are retained.
E fixed_resultant(const Poly& a,const Poly& b,unsigned m,unsigned n) {
    if (a.empty() || b.empty()) return 0;
    assert(a.size()<=m+1 && b.size()<=n+1);
    const unsigned da=m+1-a.size(), db=n+1-b.size();
    if (da && db) return 0;
    E r=resultant(a,b);
    if (da) { r=K.mul(r,K.power(b.back(),da)); if ((n*da)%2) r=K.neg(r); }
    if (db) r=K.mul(r,K.power(a.back(),db));
    return r;
}
// Delta_f(X,Y)=(p(X)q(Y)-q(X)p(Y))/(Y-X), specialized at X=x.
Poly divided_difference(const Poly& num,const Poly& den,E x) {
    const E n=eval(num,x), d=eval(den,x);
    Poly p(std::max(num.size(),den.size()));
    for (size_t j=0; j<p.size(); ++j)
        p[j]=K.sub(j<den.size() ? K.mul(n,den[j]) : 0,
                   j<num.size() ? K.mul(d,num[j]) : 0);
    trim(p);
    if (p.size()<2) { assert(p.empty()); return {}; }
    Poly q(p.size()-1); q.back()=p.back();
    for (int j=int(q.size())-2; j>=0; --j) q[j]=K.add(p[j+1],K.mul(x,q[j+1]));
    assert(K.add(p[0],K.mul(x,q[0]))==0);
    trim(q); return q;
}
void irreducible(const Poly& f) {
    const unsigned d=f.size()-1;
    assert(d>1 && f.back()==1 && pgcd(f,deriv(f))==Poly({1}));
    std::vector<unsigned> tests;
    unsigned m=d;
    for (unsigned q=2; q*q<=m; ++q) if (m%q==0) {
        tests.push_back(d/q); while (m%q==0) m/=q;
    }
    if (m>1) tests.push_back(d/m);
    Poly x={0,1}, h=x;
    for (unsigned j=1; j<=d; ++j) {
        h=power_mod(h,25,f);
        if (std::find(tests.begin(),tests.end(),j)!=tests.end())
            assert(pgcd(psub(h,x),f)==Poly({1}));
    }
    assert(h==x); // Exact Rabin irreducibility criterion over F25.
}

#include "fourth_order_data.h"

E specialization(E x) {
    return fixed_resultant(divided_difference(I2_numerator,I2_denominator,x),
                           divided_difference(I3_numerator,I3_denominator,x),15,28);
}
int main() {
    for (E a=1; a<15625; ++a) assert(K.mul(a,K.inv[a])==1);
    for (auto xv:independent_sylvester) assert(specialization(xv.first)==xv.second);
    // The proved bidegrees (15,15),(28,28) give degree <=840 in X.
    // Interpolating 841 distinct auxiliary-field points certifies an identity.
    Poly out, basis={1};
    constexpr unsigned bound=840;
    for (E x=0; x<=bound; ++x) {
        const E denominator=eval(basis,x);
        assert(denominator!=0);
        const E c=K.mul(K.sub(specialization(x),eval(out,x)),K.inv[denominator]);
        if (out.size()<basis.size()) out.resize(basis.size());
        for (size_t j=0; j<basis.size(); ++j) out[j]=K.add(out[j],K.mul(c,basis[j]));
        trim(out);
        basis=pmul(basis,Poly({K.neg(x),1}));
    }
    for (E x=bound+1; x<=bound+20; ++x) assert(eval(out,x)==specialization(x));
    for (E c:out) assert(c<25);
    assert(out.size()==841);

    Poly residual={1};
    for (const auto& f:factors) {
        irreducible(f);
        assert(pgcd(residual,f)==Poly({1}));
        residual=pmul(residual,f);
    }
    assert(residual.size()==313 && pgcd(residual,deriv(residual))==Poly({1}));
    assert(pgcd(residual,pmul(pmul(A,D),P))==Poly({1}));
    auto factorization=pscale(pmul(pmul(pmul(ppow(Amonic,9),ppow(D,44)),
                                       ppow(P,36)),residual),2);
    assert(out==factorization);
    std::cout << "PASS fixed-degree resultant: degree 840; exact boundary degree 528; squarefree residual degree 312.\n";
    std::cout << "PASS interpolation: 841 distinct points, 20 extra points, nine independent direct Sylvester checks.\n";

    for (size_t index=0; index<factors.size(); ++index) {
        const auto& f=factors[index];
        const unsigned d=f.size()-1;
        const Poly a={0,1}, b=frob(a,d/2,f);
        assert(b==expected_partner[index]);
        assert(pgcd(psub(b,a),f)==Poly({1}) && frob(b,d/2,f)==a);
        for (int which:{2,3}) {
            const Poly& num=which==2 ? I2_numerator : I3_numerator;
            const Poly& den=which==2 ? I2_denominator : I3_denominator;
            assert(pgcd(den,f)==Poly({1}));
            assert(rem(pmul(peval(num,a,f),peval(den,b,f)),f)
                ==rem(pmul(peval(num,b,f),peval(den,a,f)),f));
        }
        auto Wa=rem(pmul(power_mod(deriv(A),39,f),power_mod(P,26,f)),f);
        Wa=rem(pmul(Wa,inverse_mod(power_mod(A,87,f),f)),f);
        const auto ratio=rem(pmul(frob(Wa,d/2,f),inverse_mod(Wa,f)),f);
        const auto difference=psub(frob(ratio,28,f),ratio);
        assert(ratio==expected_epsilon29[index]);
        assert(difference==expected_F25_28_difference[index]);
        assert(!difference.empty() && pgcd(difference,f)==Poly({1}));
        std::cout << "PASS irreducible component degree " << d
                  << ": Frobenius partner and scalar-field exclusion.\n";
    }
    std::cout << "ALL FOURTH-ORDER CERTIFICATES PASS. FULL MIXED-PHASE EXISTENCE REMAINS UNRESOLVED.\n";
}
