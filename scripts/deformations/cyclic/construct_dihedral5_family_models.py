#!/usr/bin/env sage-python
"""Actual degree-five D10 quotients and oper inputs for all fifteen resolvents.

This constructs separable Verschiebung pullbacks, not arbitrary genus-six
equations. Each rational map is checked against the original genus-two
equation. The output supplies characteristic-five inputs for a separate
higher-Witt computation; it makes no fourth-lift assertion.
"""
import argparse
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, EllipticCurve, matrix, prod


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    start = time.monotonic()
    pr = PolynomialRing(GF(5), 'T'); T = pr.gen()
    k = GF(625, 't', modulus=T**4+4*T**3+T**2+4*T+3); t = k.gen()
    ring = PolynomialRing(k, 's'); s = ring.gen()
    frac = ring.fraction_field()
    roots = [k(0), k(1), k(2), k(3), t]
    F = prod(s-r for r in roots)
    mu, h0 = 4+4*t, 4*t+3
    PC = 2*s**3+(2*t+3)*s**2+(3*t**2+3)*s+2*t**3+4*t**2+4*t+4
    enc = lambda a: [int(k(a).polynomial()[i]) for i in range(4)]
    penc = lambda p: [enc(a) for a in ring(p)]
    renc = lambda r: dict(numerator=penc(frac(r).numerator()),
                          denominator=penc(frac(r).denominator()))
    directory = Path(args.output); directory.mkdir(parents=True, exist_ok=True)
    rows = []

    def verschiebung(E):
        mult = E.multiplication_by_m(5, x_only=True)
        def fifth_root_variable(poly):
            assert all(int(i) % 5 == 0 for i in poly.dict())
            return ring({int(i)//5: c for i,c in poly.dict().items()})
        q = fifth_root_variable(mult.numerator())/fifth_root_variable(mult.denominator())
        assert max(q.numerator().degree(),q.denominator().degree()) == 5
        assert q.derivative() != 0, 'Prym is not ordinary'
        return q

    pairs = [(i,5) for i in range(5)] + [(i,j) for i in range(5) for j in range(i+1,5)]
    for index,(i,j) in enumerate(pairs):
        branch = [roots[i]] + ([] if j==5 else [roots[j]])
        R = prod(s-r for r in branch); S = F//R
        if S.degree()==3:
            E = EllipticCurve(k,[0,S[2],0,S[1],S[0]])
            q = verschiebung(E)
            elliptic_change = dict(kind='cubic', original_u='elliptic_x')
        else:
            # A branch of the quartic gives an actual Weierstrass origin.
            b = next(r for r in roots if r not in branch and r != t)
            cubic = ring(s**4*S(b+1/s))
            assert cubic.degree()==3
            A,B,C,D = [cubic[i] for i in (3,2,1,0)]
            E = EllipticCurve(k,[0,B,0,A*C,A**2*D])
            qE = verschiebung(E)
            q = frac(b+A/qE)
            elliptic_change = dict(kind='quartic_to_cubic', branch=enc(b), scale=enc(A),
                                   formula='u=branch+scale/x_E')

        N,Den = q.numerator(),q.denominator()
        Fq = frac(F(q)); fn,fd = Fq.numerator().factor(),Fq.denominator().factor()
        G = ring(fn.unit()/fd.unit())
        yfac = frac(1)
        for f,e in fn:
            if e%2: G *= f
            yfac *= f**(e//2)
        for f,e in fd:
            if e%2: G *= f
            yfac /= f**((e+1)//2)

        # Preserve the exact already audited origin for the regression row.
        baseline = (i,j)==(0,1)
        if baseline:
            old = json.loads(Path('Research/computations/neutral5_hyperelliptic_model.json').read_text())
            dp = lambda key: ring([k(c) for c in old[key]])
            assert q==dp('numerator')/dp('denominator')
            N,Den=dp('numerator'),dp('denominator')
            G=dp('hyperelliptic_polynomial')
            yfac=dp('elliptic_y_numerator')/dp('denominator_square_root')**5
        assert yfac**2*G == Fq
        assert G.degree()==13 and G.gcd(G.derivative())==1
        eta = q.derivative()/yfac
        AT = ring(eta**4*(q-t)*(q-h0)**2/mu)
        PT = ring(eta**2*PC(q)
                  -(G*eta.derivative(2)+G.derivative()*eta.derivative()/2)/(2*eta)
                  +3*G*eta.derivative()**2/(4*eta**2))
        fac=AT.factor(); L0=ring(1); K=ring(1)
        for f,e in fac:
            if e%2: L0*=f
            K*=f**(e//2)
        assert L0.is_monic() and K.is_monic()
        scale=G.leading_coefficient()**L0.degree()
        L0*=scale; muT=scale/fac.unit()
        if baseline:
            L0=s-t**5
            nt=N-t*Den
            square=ring(nt/(nt.leading_coefficient()*L0))
            flag,B2=square.is_square(root=True); assert flag
            B2=B2.monic()
            K=dp('denominator_square_root')*B2*(N-h0*Den)
            muT=mu/(nt.leading_coefficient()*(t**2+2)**4)
        assert L0*K**2/muT == AT
        Sco,rem=G.quo_rem(L0); assert rem==0
        Bpoly=L0*K.derivative()+L0.derivative()*K/2
        assert Sco*Bpoly.derivative()+Sco.derivative()*Bpoly/2 == PT*K
        assert (L0*K**2).gcd(Sco*Bpoly**2).degree()==0
        assert PT.degree()<=10

        def coeff(p,j): return p[j] if j>=0 else k(0)
        plus=matrix(k,11,11,lambda a,b:coeff(AT*G**2,5*(b+1)-(a+1)))
        minus=matrix(k,4,4,lambda a,b:coeff(AT,5*(b+1)-(a+1)))
        full=matrix.block_diagonal([plus,minus]); defect=15-full.rank()
        neutral=R != s-t
        assert defect==(1 if neutral else 4)
        if neutral:
            assert plus.rank()==10 and minus.rank()==4
            kernel=plus.right_kernel().basis()[0].apply_map(lambda a:a**125)
            dual=plus.left_kernel().basis()[0]
            assert plus*kernel.apply_map(lambda a:a**5)==0
        else:
            kernel=[]; dual=[]
        iterate=matrix.identity(k,15); ranks=[15]
        for step in range(1,9):
            iterate=iterate*full.apply_map(lambda a:a**(5**(step-1)))
            ranks.append(int(iterate.rank()))
        if neutral: assert ranks==[15,14,13,12,11,10,9,9,9]
        label=f'pair_{i}_{j}'
        data=dict(status='PASS actual characteristic-five model and oper', label=label,
                  field_modulus=[int(a) for a in k.modulus()], branch_pair=[i,j],
                  resolvent_polynomial=penc(R), elliptic_change=elliptic_change,
                  numerator=penc(N),denominator=penc(Den), y_multiplier=renc(yfac),
                  eta_multiplier=renc(eta),hyperelliptic_polynomial=penc(G),
                  hodge_multiplier=penc(AT),potential=penc(PT),
                  double_polynomial=penc(L0),double_section=penc(K),
                  double_derivative=penc(Bpoly),mu=enc(muT),
                  kernel=[enc(a) for a in kernel],obstruction_dual=[enc(a) for a in dual],
                  hodge_matrix=[[enc(a) for a in row] for row in full],
                  neutral=neutral,defect=int(defect),semilinear_ranks=ranks,
                  genus=6,degree_to_original_curve=5,
                  scope='Actual separable Verschiebung pullback of the original C; no W4 conclusion.')
        (directory/f'{label}.json').write_text(json.dumps(data,indent=2)+'\n')
        row=dict(label=label,branch_pair=[i,j],neutral=neutral,defect=int(defect),
                 double_degree=int(L0.degree()),section_degree=int(K.degree()),
                 potential_degree=int(PT.degree()),hodge_degree=int(AT.degree()))
        rows.append(row);print(json.dumps(row),flush=True)
    assert sum(r['neutral'] for r in rows)==14
    (directory/'summary.json').write_text(json.dumps(dict(status='PASS',rows=rows,
                  seconds=time.monotonic()-start),indent=2)+'\n')


if __name__=='__main__':main()
