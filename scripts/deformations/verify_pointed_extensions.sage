#!/usr/bin/env sage
"""Verify second-Frobenius semistability of every pointed extension on C_a.

Here a^3+a+1=0 over F5. Rebuild all16 two-torsion cohomology matrices,
retain both parity blocks, and verify Busé's determinantal resultant as
a square coefficient matrix. No projective chart search is needed.
See Proofs/deformations/pointed_extensions_frobenius.md.
"""
import argparse
import itertools
import json
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--verbose', action='store_true')
args = parser.parse_args()
started = time.monotonic()

report_context={}
def report(**kw):
    kw={**report_context, **kw}
    kw['seconds'] = float(round(time.monotonic()-started, 4))
    if args.verbose:
        print(json.dumps(kw, default=int), flush=True)

P = 25
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
            blocks.append(dict(matrices=[A.matrix_from_rows_and_columns(rr,cols) for A in matrices],
                               weights=[weights[j] for j in cols], exponents=[rows[i] for i in rr]))
    return blocks

def verify_block(block):
    B0,B1,B2 = block['matrices']
    n = B0.ncols()
    assert B0.nrows() == n+2
    A = PolynomialRing(k,2,names=('x1','x2'))
    x1,x2 = A.gens()
    # Setting x0=1 identifies homogeneous degree-n forms with
    # polynomials of total degree<=n. Thus sigma_n remains square.
    phi = B0.change_ring(A)+x1*B1.change_ring(A)+x2*B2.change_ring(A)
    monomials = [x1**i*x2**j for i in range(n+1) for j in range(n+1-i)]
    coefficients = []
    for omit in itertools.combinations(range(n+2),2):
        minor = phi.matrix_from_rows([i for i in range(n+2) if i not in omit]).det()
        coefficients.append([minor.monomial_coefficient(m) for m in monomials])
    sigma = matrix(k,coefficients)
    q = binomial(n+2,2)
    assert sigma.nrows() == sigma.ncols() == q
    determinant = sigma.det()
    assert determinant != 0, 'A projective extension parameter drops rank.'
    # Sum the already proved jet coefficient weights across this determinant.
    weighted = q*sum(block['weights'])+binomial(n+1,2)*sum(block['exponents'])+P*n*q
    assert weighted % 2 == 0
    return dict(columns=n,coefficient_size=q,determinant=str(determinant),
                source_weight_sum=sum(block['weights']),
                target_exponent_sum=sum(block['exponents']),
                parameter_degree_bound=weighted//2)


results = []
expected = {0:[(13,156,165,32760),(10,140,156,17160)],
            1:[(12,144,154,26208),(11,154,169,22308)],
            2:[(12,156,168,27300),(11,143,156,21450)]}
for torsion in range(16):
    block_results = []
    for index,block in enumerate(build_blocks(torsion)):
        result = verify_block(block)
        block_results.append(result)
        report(torsion=torsion,block=index,**result)
    data = [(r['columns'],r['source_weight_sum'],r['target_exponent_sum'],
             r['parameter_degree_bound']) for r in block_results]
    assert sorted(data) == sorted(expected[twists[torsion].degree()])
    results.extend(block_results)
assert len(results) == 32
assert max(r['parameter_degree_bound'] for r in results) == 32760
print('PASS: all32 coefficient determinants nonzero; parameter degree bound32760 (%.2fs)'
      % (time.monotonic()-started))
