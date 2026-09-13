#!/usr/bin/env sage
"""Exact deterministic scalar samples; no global atlas exclusion is claimed."""
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
cert=json.loads(Path('Research/computations/normalized_oper_algebra_certificate.json').read_text())
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
results={'scope':'Exact samples only; no global atlas exclusion','field':str(k.modulus()),'alpha':str(alpha),'c4':3,'A':enc(A.list()),'B':enc(B.list()),'C':enc(C.list()),'precision':precision,'sampling':'Python Random(seed), 32 independent randrange(5)+a*randrange(5) coefficients in Sage kernel basis. Last sample subtracts its pole112 component using first kernel row with nonzero leading coefficient.','reduction':'Subtract monomials of nongap pole order at most197 in descending order, including constant.','monomial_basis_U':monsU,'monomial_basis_T':monsT,'kernel_dimensions':[KU.nrows(),KT.nrows()],'domain_exponents':domain,'target_exponents':target,'samples':[]}
for seed in range(202609070,202609075):
    rng=random.Random(seed)
    uv=vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(KU.nrows())])*KU
    if seed==202609074:
        row=next(row for row in KU.rows() if row[-1])
        uv-=uv[-1]/row[-1]*row
    up=poly(uv,monsU); du=delta(up); U=laurent(uv,monsU)
    assert sub(delta(du),mul(P,up))==(R.zero(),)*3
    assert -U.valuation() in [111,112]
    images=[sub(mul(up,delta(v)),mul(v,du)) for v in Tb]
    W=eqmat(images); rhs=vector(k,W.nrows()); rhs[0]=1
    assert W.rank()==57 and W.ncols()-W.rank()==9
    tc=W.solve_right(rhs); tv=tc*KT; tp=poly(tv,monsT)
    assert sub(mul(up,delta(tp)),mul(tp,du))==(R.one(),R.zero(),R.zero())
    assert sub(delta(delta(tp)),mul(P,tp))==(R.zero(),)*3
    T=laurent(tv,monsT); H=T/U
    eta_prec=ceil(H.precision_absolute()/5)
    eta=sum((-H[e]**5*tt**(e//5) for e in range(int(H.valuation()),int(H.precision_absolute())) if e%5==0),LS.zero()).add_bigoh(eta_prec)
    V0=T+frob(eta)*U
    assert eta.valuation()>=-17 and V0.valuation()>=17-U.valuation()
    lv=-rho(delta_t*eta.derivative(),domain)
    lam=sum((c*tt**e for c,e in zip(lv,domain)),LS.zero())
    Aobs=rho(tt**(-85)*V0-U*lam**5,target); Bobs=rho(eta,target)
    residual=Aobs-Bobs
    item={'seed':seed,'U_coefficients':enc(uv),'T_coefficients':enc(tv),'U_pole':-U.valuation(),'wronskian_rank':W.rank(),'wronskian_nullity':W.ncols()-W.rank(),'polynomial_identities_verified':True,'H_precision':H.precision_absolute(),'eta_precision':eta.precision_absolute(),'eta_valuation':eta.valuation(),'V0_precision':V0.precision_absolute(),'V0_valuation':V0.valuation(),'lambda_coefficients':enc(lv),'Aobs':enc(Aobs),'Bobs':enc(Bobs),'residual':enc(residual),'observation_rank':matrix(k,[Aobs,Bobs]).rank(),'residual_zero':bool(residual==0)}
    results['samples'].append(item)
    print('seed',seed,'rank',item['wronskian_rank'],'nullity',item['wronskian_nullity'],'V0val',item['V0_valuation'],'obsrank',item['observation_rank'],'residualzero',item['residual_zero'],flush=True)
results['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/direct_wronskian_samples.json').write_text(json.dumps(results,indent=2,default=int)+'\n')
