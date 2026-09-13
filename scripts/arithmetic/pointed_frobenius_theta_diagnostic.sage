#!/usr/bin/env sage
"""Exact low-height theta-plane diagnostic; NOT a common-cover checker.

On the small genus-two family specialization, test whether a nonsplit
extension O -> E -> omega can destabilize at the given Frobenius height.
Output distinguishes an exact minor-ideal unit from an unfinished ideal.
Use --all to cover all16 two-torsion labels and all3 projective charts.
The geometric dictionary and degree-bound transfer are in
Proofs/deformations/pointed_frobenius_dormant_model.md.
"""
import argparse
import itertools
import json
import time

parser = argparse.ArgumentParser()
parser.add_argument('--height', type=int, default=2)
parser.add_argument('--minor-limit', type=int, default=200)
parser.add_argument('--chart', type=int, choices=[0,1,2], default=0)
parser.add_argument('--torsion', type=int, choices=range(16), default=0)
parser.add_argument('--verbose', action='store_true')
parser.add_argument('--all', action='store_true', help='Check all16 torsion labels and all3 charts in one Sage process.')
args = parser.parse_args()
started = time.monotonic()

report_context={}
def report(**kw):
    kw={**report_context, **kw}
    kw['seconds'] = float(round(time.monotonic()-started, 4))
    print(json.dumps(kw, default=int), flush=True)

if not 1 <= args.height <= 3:
    raise ValueError('This diagnostic permits heights1--3 only.')
P = 5**args.height
k = GF(125, name='a', modulus=GF(5)['T']('T^3+T+1'))
a = k.gen()
R = PolynomialRing(k, 'u'); u = R.gen()
F = u*(u-1)*(u-2)*(u-3)*(u-a)
precision = 6*P+30
S = LaurentSeriesRing(k, 't', default_prec=precision)
t = S.gen()
Ft = list(reversed(F.list()))

def eval_poly(cs, z):
    ans = S(0)
    for c in reversed(cs):
        ans = ans*z+c
    return ans

# t=u^2/v, z=1/u: z=t^2 Ftilde(z). Newton doubles precision.
z = t**2 + O(t**precision)
for _ in range(12):
    error = z-t**2*eval_poly(Ft,z)
    z -= error/(1-t**2*eval_poly([i*Ft[i] for i in range(1,len(Ft))],z))
    if error.valuation() >= precision-4:
        break
assert (z-t**2*eval_poly(Ft,z)).valuation() >= precision-4
x = 1/z
y = x**2/t
assert (y*y-eval_poly(F.list(),x)).valuation() >= precision-20
branch=[k(0),k(1),k(2),k(3),a]
twists=[R(1)]+[u-c for c in branch]+[(u-c)*(u-d) for c,d in itertools.combinations(branch,2)]
def build_blocks(torsion):
    Rtwist=twists[torsion]
    d=Rtwist.degree()
    unit=t**(2*d)*eval_poly(Rtwist.list(),x)
    kapunit=S(1)+O(t**precision)
    for _ in range(12):
        error=kapunit**2-unit
        if error.valuation() >= precision-8:
            break
        kapunit=(kapunit+unit/kapunit)/2
    kap=kapunit/t**d
    assert (kap**2-eval_poly(Rtwist.list(),x)).valuation() >= precision-20
    assert (kapunit**2-unit).valuation() >= precision-8
    
    def pole_monomial(w):
        if w >= d and (w-d) % 2 == 0:
            return kap*x**((w-d)//2)
        if w >= 5-d and (w-(5-d)) % 2 == 0:
            return (y/kap)*x**((w-(5-d))//2)
        return None
    
    maxpole = 4*P-1
    mono = {w:pole_monomial(w) for w in range(maxpole+1)}
    weights = [w for w in range(P) if mono[w] is not None]
    rows = sorted([-w for w in range(5) if mono[w] is None])+list(range(1,P+1))
    
    def reduce_cohom(q):
        # H1(O(-(P+1)O)) = Laurent/(A+t^(P+1)R).
        assert q.precision_absolute() > P
        for w in range(maxpole,-1,-1):
            if mono[w] is not None:
                c = q[-w]
                if c:
                    q -= c*mono[w]
        assert q.precision_absolute() > P
        return vector(k,[q[i] for i in rows])
    
    matrices = []
    for e in [-3*P,-P,P]:
        columns = [reduce_cohom(t**e*mono[w]) for w in weights]
        matrices.append(matrix(k,columns).transpose())
    assert len(weights)==P-2 and len(rows)==P+2
    # u is even and v is odd in t. The map changes parity: keep both blocks.
    blocks=[]
    for parity in [0,1]:
        cols=[j for j,w in enumerate(weights) if w%2==parity]
        rr=[i for i,e in enumerate(rows) if e%2!=(parity%2)]
        if cols:
            for A in matrices:
                assert all(A[i,j]==0 for i in range(len(rows)) if i not in rr for j in cols)
            blocks.append([A.matrix_from_rows_and_columns(rr,cols) for A in matrices])
    report(stage='matrix', height=args.height, field=125, torsion=torsion, R=str(Rtwist),
           shape=[len(rows),len(weights)], blocks=[[B[0].nrows(),B[0].ncols()] for B in blocks])
    return blocks

def verify_chart(blocks, chart):
    # Disjoint projective charts [1:z:w], [0:1:z], [0:0:1].
    nvars=2-chart
    if nvars:
        A = PolynomialRing(k, names=['z','w'][:nvars], order='degrevlex')
        variables=list(A.gens())
        lambdas=[A(0)]*chart+[A(1)]+variables
    else:
        A=k; lambdas=[k(0),k(0),k(1)]
    
    all_good=True
    for block, Bs in enumerate(blocks):
        M=sum((lambdas[j]*Bs[j].change_ring(A) for j in range(3)),
              matrix(A,Bs[0].nrows(),Bs[0].ncols(),0))
        nr,nc=M.nrows(),M.ncols()
        if not nvars:
            rank=M.rank()
            report(stage='point', block=block, rank=rank, columns=nc, excluded=(rank==nc))
            all_good = all_good and rank==nc
            continue
        generators=[]
        block_good=False
        # In an (nc+2)-by-nc block, a minor is determined by two omitted rows.
        for ix,omit in enumerate(itertools.combinations(range(nr),nr-nc)):
            if ix >= args.minor_limit:
                break
            determinant=M.matrix_from_rows([i for i in range(nr) if i not in omit]).det()
            if determinant:
                generators.append(determinant)
            if args.verbose:
                report(stage='minor', block=block, number=ix+1, terms=len(determinant.monomials()) if determinant else 0,
                       degree=int(determinant.total_degree()) if determinant else -1)
            if generators and (ix<4 or (ix+1)%5==0):
                I=A.ideal(generators)
                gb=I.groebner_basis()
                excluded=(len(gb)==1 and gb[0]==1)
                if args.verbose or excluded:
                    report(stage='ideal', block=block, minors=len(generators), basis_size=len(gb), excluded=excluded)
                if excluded:
                    # Replay the ideal membership with a lift against original minors.
                    if nvars==1:
                        # Univariate finite-field polynomials do not expose lift().
                        # Accumulate an exact Bezout witness by the Euclidean algorithm.
                        gcd=A(0); witness=[]
                        for polynomial in generators:
                            gcd,left,right=gcd.xgcd(polynomial)
                            witness=[left*c for c in witness]+[right]
                        assert gcd==1
                    else:
                        witness=A(1).lift(generators)
                    assert sum(c*g for c,g in zip(witness,generators))==1
                    report(stage='verified_unit', block=block, chart=chart, minors=len(generators))
                    block_good=True
                    break
        else:
            gb=A.ideal(generators).groebner_basis()
            report(stage='all_minors_finished', block=block, basis=[str(g) for g in gb], dimension=A.ideal(gb).dimension())
        if not block_good:
            report(stage='inconclusive', block=block, minors=len(generators))
        all_good = all_good and block_good
    return all_good

labels=range(16) if args.all else [args.torsion]
charts=range(3) if args.all else [args.chart]
verified_cases=0
for torsion in labels:
    report_context={'torsion':torsion}
    blocks=build_blocks(torsion)
    for chart in charts:
        report_context={'torsion':torsion,'chart':chart}
        good=verify_chart(blocks,chart)
        verified_cases+=int(good)
        report(stage='chart_finished', excluded=good)
report_context={}
expected_cases=len(labels)*len(charts)
report(stage='done', height=args.height, verified_cases=verified_cases,
       expected_cases=expected_cases, excluded=(verified_cases==expected_cases),
       scope='these torsion labels and projective charts ONLY')
if verified_cases!=expected_cases:
    raise SystemExit(2)
