#!/usr/bin/env python3
"""Exact geometric pole13 norm test; Sage generator with Bezout evidence.

Every candidate has g=U(x)+(x+b)y after scalar normalization. Its cubic
norm is a supported monic polynomial of degree13. Generic b and the
unique vanishing-leading-coefficient boundary are checked separately.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

ap = argparse.ArgumentParser()
ap.add_argument('output', type=Path)
args = ap.parse_args()
started = time.monotonic()
F5 = GF(5)
R0 = PolynomialRing(F5, 'beta0'); beta0 = R0.gen()
F = GF(25, 'beta', modulus=beta0**2-beta0-3)
beta = F.gen()
dec = lambda c: F(c%5)+F(c//5)*beta
R = PolynomialRing(F, 'w'); w = R.gen()
E = F.extension(w**4+dec(7)*w**3+dec(6)*w**2+dec(2)*w+dec(5), 'alpha')
alpha = E.gen()
B = PolynomialRing(E, 'b'); b = B.gen()
Frac = B.fraction_field()
RX = PolynomialRing(Frac, 'x'); x = RX.gen()
P = RX([dec(c) for c in (11,22,18,5,19,20,15,16,9,22,1)])
A = RX([dec(c) for c in (1,21,14,22,13)])
roots = [alpha**(25**i) for i in range(4)]
assert len(set(roots)) == 4 and all(A(r)==0 and P(r)!=0 for r in roots)

def code(c):
    cs = list(E(c).lift())+[F(0)]*4
    def c25(v):
        v = list(F(v).polynomial())+[F5(0)]*2
        return int(v[0])+5*int(v[1])
    return sum(c25(cs[i])*25**i for i in range(4))

def portable(p): return [code(c) for c in B(p).list()]
def weights(total, count):
    if count == 1:
        yield (total,); return
    for j in range(total+1):
        for tail in weights(total-j, count-1): yield (j,)+tail

records=[]; survivors=[]
for wt in weights(13,4):
    S=RX.one()
    for r,n in zip(roots,wt): S *= (x-r)**n
    G=S-P*(x+b)**3
    lead=B(G[12]); assert lead.degree()==1
    # A geometric cube root of lead is allowed; normalize its x^4 term.
    norm=G/lead; U=x**4
    for j in range(3,-1,-1): U += (norm-U**3)[8+j]/E(3)*x**j
    residual=norm-U**3
    numerators=[B(c.numerator()) for c in residual.list()]
    # Incremental exact Bezout identity for the nonzero residuals.
    gcd=B.zero(); combination=[]; active=[]
    for j,h in enumerate(numerators):
        if not h: continue
        d,s,t=gcd.xgcd(h)
        combination=[c*s for c in combination]+[t]
        active.append(j);gcd=d
        if gcd == 1: break
    assert sum(c*numerators[j] for c,j in zip(combination,active))==gcd
    # The unique b where the degree12 coefficient vanishes.
    b0=-lead[0]/lead[1]
    boundary=RX([Frac(c(b0)) for c in [B(v) for v in G.list()]])
    bd=int(boundary.degree()) if boundary else -1
    obstruction=None
    if boundary and bd%3==0:
        m=bd//3; Z=x**m; normalized=boundary/boundary[bd]
        for j in range(m-1,-1,-1): Z+=(normalized-Z**3)[2*m+j]/E(3)*x**j
        err=normalized-Z**3
        if err: obstruction=dict(degree=int(err.degree()),coefficient=code(err.leading_coefficient()))
    elif boundary: obstruction=dict(noncube_degree=bd)
    if gcd!=1 or obstruction is None:
        survivors.append(dict(weights=wt,generic_gcd=str(gcd),boundary_degree=bd))
    records.append(dict(weights=wt,active_indices=active,
        residual_numerators=[portable(numerators[j]) for j in active],
        bezout=[portable(c) for c in combination],gcd=portable(gcd),
        boundary_parameter=code(b0),boundary_degree=bd,boundary_obstruction=obstruction))
    if len(records)%40==0: print(len(records), 'patterns; survivors',len(survivors), 'seconds',round(time.monotonic()-started,2),flush=True)

result=dict(scope='all geometric pole13 supported functions U+(x+b)y; not a common-cover decision',
            field='F25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5])',
            patterns=len(records),survivors=survivors,records=records,
            elapsed_seconds=time.monotonic()-started)
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
print('Completed',len(records),'patterns; survivors',survivors,flush=True)
