#!/usr/bin/env sage
"""Fixed-oper sections and residue coordinates for the remaining exact certificates.

These are shared constructors, without the superseded sampled direct/136-row/
64-row comparisons. Settled original receipts are preserved externally.
"""
import json, random, time
from pathlib import Path
started=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
R=PolynomialRing(k,'x'); x=R.gen()
F=R([2*a+1,4*a+2,3*a+3,a,3*a+4,4*a,3*a,3*a+1,a+4,4*a+2,1])
Fp=F.derivative()
def basis(n):
    return sorted([(i,j) for j in range(3) for i in range(n//3+1) if 3*i+10*j<=n],key=lambda ij:3*ij[0]+10*ij[1])
def delta(v):
    ans=[R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        ans[(j+2)%3]+=f.derivative()*F**((j+2)//3)
        if j: ans[j-1]+=2*j*f*Fp
    return tuple(ans)
def mul(v,w):
    ans=[R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        for h,g in enumerate(w): ans[(j+h)%3]+=f*g*F**((j+h)//3)
    return tuple(ans)
def sub(v,w): return tuple(f-g for f,g in zip(v,w))
def poly(v,mons):
    ans=[R.zero() for _ in range(3)]
    for c,(i,j) in zip(v,mons): ans[j]+=c*x**i
    return tuple(ans)
def coeff(v,mons): return vector(k,[v[j][i] for i,j in mons])
def eqmat(images):
    deg=max(f.degree() for v in images for f in v)
    return matrix(k,[[v[j][i] for v in images] for j in range(3) for i in range(deg+1)])
cert=json.loads(Path('../litt3-computation-data/legacy_workspace_computations/normalized_oper_algebra_certificate.json').read_text())
alpha=4*a+2
ev=lambda v:R(v)(alpha)
assert ev(cert['P'])==0 and ev(cert['lambda'])==2
co={name:ev(v) for name,v in cert['coordinates'].items()}
assert co['zeta']==a
A=9*R([co['a%s'%i] for i in range(10)]+[1])
C=3*R([co['c%s'%i] for i in range(4)]+[1])
B=R([ev(v) for v in cert['B']]); P=(A,B+2*x**8,C)
monsU=basis(112); monsT=basis(197)
def kernel(mons):
    images=[sub(delta(delta(poly(vector(k,[int(h==q) for h in range(len(mons))]),mons))),mul(P,poly(vector(k,[int(h==q) for h in range(len(mons))]),mons))) for q in range(len(mons))]
    M=eqmat(images); K=M.right_kernel().basis_matrix(); assert M*K.transpose()==0
    return K
KU=kernel(monsU); KT=kernel(monsT)
print('kernel dimensions',KU.nrows(),KT.nrows(),flush=True)
assert (KU.nrows(),KT.nrows())==(32,66)
Tb=[poly(row,monsT) for row in KT.rows()]
precision=800
PS=PowerSeriesRing(k,'t',default_prec=precision); t=PS.gen()
Ft=R(list(reversed(F.list()))); z=t**3+O(t**precision)
for _ in range(11): z-=(z-t**3*Ft(z))/(1-t**3*Ft.derivative()(z))
assert (z-t**3*Ft(z)).valuation()>=precision
LS=LaurentSeriesRing(k,'t',default_prec=precision); tt=LS.gen()
xx=1/LS(z); yy=xx**3/tt
expansions={(i,j):xx**i*yy**j for i,j in monsT}
reducers={3*i+10*j:v for (i,j),v in expansions.items()}
delta_t=yy**2/xx.derivative()
gaps=[1,2,4,5,7,8,11,14,17]
domain=[-g for g in gaps]+list(range(1,32)); target=[-g for g in gaps]+list(range(1,48))
def rho(s,exps):
    assert s.precision_absolute()>max(exps) and s.valuation()>=-197, (s.precision_absolute(),s.valuation(),max(exps))
    for pole in sorted(reducers,reverse=True):
        c=s[-pole]
        if c: s-=c*reducers[pole]
    return vector(k,[s[e] for e in exps])
def laurent(v,mons): return sum((c*expansions[ij] for c,ij in zip(v,mons)),LS.zero())
def frob(s):
    # Sage's generic power propagation loses valid characteristic-five precision.
    p=s.precision_absolute()
    return sum((s[e]**5*tt**(5*e) for e in range(int(s.valuation()),int(p)) if s[e]),LS.zero()).add_bigoh(5*p)
def enc(v): return [str(c) for c in v]
saved=json.loads(Path('../litt3-computation-data/legacy_workspace_computations/direct_wronskian_samples.json').read_text())
parse=lambda v:vector(k,[sage_eval(c,locals={'a':a}) for c in v])
target128=[-g for g in gaps]+list(range(1,128))
assert len(target128)==136 and len(target)==56
pole_to_index={3*i+10*j:h for h,(i,j) in enumerate(monsT)}
def split_aff(s):
    assert s.valuation()>=-197 and s.precision_absolute()>132
    v=vector(k,len(monsT))
    for pole in sorted(reducers,reverse=True):
        c=s[-pole]
        if c:
            s-=c*reducers[pole]
            v[pole_to_index[pole]]+=c
    return v,s
def monseries(v,exps): return sum((c*tt**e for c,e in zip(v,exps)),LS.zero())
def fifthvector(v): return vector(k,[c**5 for c in v])
# Columns of D give -rho32(delta eta), before Frobenius.
D=matrix(k,[-rho(delta_t*(tt**e).derivative(),domain) for e in target]).transpose()
