#!/usr/bin/env sage
"""Exact degree-377 critical-resultant interpolation on a 416-point coset."""
from sage.all import *
import argparse,time
from itertools import permutations
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
ap.add_argument('--root',type=int,default=145049);ap.add_argument('--interpolate-only',action='store_true')
args=ap.parse_args();start=time.time()
data=args.work/'data';source=load(str(data/f'concentrated_d0_critical_setup_{args.root}.sobj'))
E=source['E'];V=PolynomialRing(E,'X');X=V.gen();P=V(source['P'](X,0));t=V(source['t'](X,0))
zero=[V.zero()]*3
def add(a,b):return [a[i]+b[i] for i in range(3)]
def neg(a):return [-v for v in a]
def sub(a,b):return add(a,neg(b))
def scale(a,c):return [v*c for v in a]
def mul(a,b):
    out=[V.zero()]*5
    for i in range(3):
        for j in range(3):out[i+j]+=a[i]*b[j]
    return [out[0]+P*out[3],out[1]+P*out[4],out[2]]
def power(a,n):
    out=[V.one(),V.zero(),V.zero()]
    while n:
        if n%2:out=mul(out,a)
        a=mul(a,a);n//=2
    return out
def norm(a):return a[0]**3+P*a[1]**3+P**2*a[2]**3-3*P*a[0]*a[1]*a[2]
def divide(a,b):
    adj=[b[0]**2-P*b[1]*b[2],P*b[2]**2-b[0]*b[1],b[1]**2-b[0]*b[2]]
    numerator=mul(a,adj);den=norm(b);out=[]
    for component in numerator:
        q,r=component.quo_rem(den);assert not r;out.append(q)
    return out
def resultant(F,D):
    a=D[3];assert a!=zero;rem=F[:]
    for degree in range(10,2,-1):
        lead=rem[degree];rem=[mul(a,f) for f in rem]
        for j in range(4):rem[degree-3+j]=sub(rem[degree-3+j],mul(lead,D[j]))
        assert rem[degree]==zero
    g0,g1,g2=rem[:3];a2=power(a,2);d0,d1,d2=D[:3]
    M=[
        [mul(a2,g0),neg(mul(mul(a,d0),g2)),add(neg(mul(mul(a,d0),g1)),mul(mul(d2,d0),g2))],
        [mul(a2,g1),sub(mul(a2,g0),mul(mul(a,d1),g2)),add(neg(mul(mul(a,d1),g1)),mul(sub(mul(d2,d1),mul(a,d0)),g2))],
        [mul(a2,g2),sub(mul(a2,g1),mul(mul(a,d2),g2)),add(sub(mul(a2,g0),mul(mul(a,d2),g1)),mul(sub(power(d2,2),mul(a,d1)),g2))],
    ]
    det=zero[:]
    for perm in permutations(range(3)):
        sign=(-1)**sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))
        det=add(det,scale(mul(mul(M[0][perm[0]],M[1][perm[1]]),M[2][perm[2]]),sign))
    for j in range(20):det=divide(det,a)
    return det
alpha=source['alpha'];zeta=alpha**(390624//416)
assert zeta**416==1 and zeta**208!=1 and zeta**32!=1
R=source['R'];x,eta=R.gens();unit=source['H']*source['source_nums'][13]*source['source_nums'][4]
coset=None
for j in range(75):
    candidate=alpha**j
    if all(unit(0,candidate*zeta**i) for i in range(416)):
        coset=candidate;break
assert coset is not None
assert max(f.degree(eta) for row in source['Fhat']+source['Dhat'] for f in row)<=29
def compile_component(f):
    out=[V.zero() for _ in range(max(0,int(f.degree(eta)))+1)]
    for (dx,de),c in f.dict().items():out[de]+=c*X**dx
    return out
Fcoeff=[[compile_component(f) for f in row] for row in source['Fhat']]
Dcoeff=[[compile_component(f) for f in row] for row in source['Dhat']]
def evaluate_component(coefficients,value):
    out=V.zero()
    for coefficient in reversed(coefficients):out=out*value+coefficient
    return out
checkpoint=data/f'concentrated_d0_critical_samples_{args.root}.sobj'
if checkpoint.exists():
    old=load(str(checkpoint));assert old['coset']==coset and old['zeta']==zeta;samples=old['samples']
else:samples=[]
for i in range(len(samples),416):
    value=coset*zeta**i
    F=[[evaluate_component(f,value) for f in row] for row in Fcoeff]
    D=[[evaluate_component(f,value) for f in row] for row in Dcoeff]
    samples.append(resultant(F,D))
    if i in (0,1,15,63,127,255,415):
        W=PolynomialRing(E,'W');w=W.gen()
        for xx in (E.one(),alpha):
            yy=(w**3-P(xx)).roots(multiplicities=False)[0]
            def evaluate(f):return sum((f[j](xx)*yy**j for j in range(3)),E.zero())
            ff=W([evaluate(f) for f in F]);dd=W([evaluate(f) for f in D])
            assert dd.degree()==3 and ff.degree()==10
            assert ff.resultant(dd)==evaluate(samples[-1])
    if (i+1)%16==0:
        save({'coset':coset,'zeta':zeta,'samples':samples,'source':source},str(checkpoint))
        print('SAMPLES',i+1,'SECONDS',time.time()-start,flush=True)
def fft(values,root):
    n=len(values)
    if n==1:return values
    r=2 if n%2==0 else 13;m=n//r
    blocks=[fft(values[j::r],root**r) for j in range(r)]
    powers=[root**i for i in range(n)];out=[]
    for k in range(n):
        total=zero[:]
        for j in range(r):total=add(total,scale(blocks[j][k%m],powers[(j*k)%n]))
        out.append(total)
    return out
coeff=fft(samples,zeta**(-1));inverse=E(416)**(-1)
coeff=[scale(f,inverse*coset**(-j)) for j,f in enumerate(coeff)]
assert all(f==zero for f in coeff[378:])
print('INVERSE_FOURIER_SECONDS',time.time()-start,flush=True)
# Forward Fourier replay verifies the complete interpolation sample table.
replay=fft([scale(f,coset**j) for j,f in enumerate(coeff)],zeta)
assert replay==samples
print('FOURIER_REPLAY_SECONDS',time.time()-start,flush=True)
Delta=[{} for _ in range(3)]
for j,row in enumerate(coeff[:378]):
    for char,component in enumerate(row):
        for i,c in enumerate(component):
            if c:Delta[char][(i,j)]=c
Delta=[R(f) for f in Delta]
C=[]
for component in Delta:
    q,r=component.quo_rem(source['t']**5);assert not r;C.append(q)
source.update(Delta_hat=Delta,C_hat=C,interpolation_coset=coset,
              interpolation_root=zeta,interpolation_length=416,
              interpolation_parameter_degree_bound=377)
save(source,str(data/f'concentrated_d0_critical_interpolated_{args.root}.sobj'))
print('INTERPOLATED_SECONDS',time.time()-start,flush=True)
if args.interpolate_only:raise SystemExit(0)
Pc=source['P'];nc=C[0]**3+Pc*C[1]**3+Pc**2*C[2]**3-3*Pc*C[0]*C[1]*C[2]
root_value=sum((E((args.root//25**i)%25%5)+E(((args.root//25**i)%25)//5)*source['beta'])*alpha**i for i in range(4))
remaining,r=nc.quo_rem((x-root_value)**20);assert not r
source.update(Delta_hat=Delta,C_hat=C,norm_C_hat=nc,reduced_norm_C_hat=remaining,
              interpolation_coset=coset,interpolation_root=zeta,interpolation_length=416,
              interpolation_parameter_degree_bound=377)
save(source,str(data/f'concentrated_d0_critical_norm_{args.root}_symbolic.sobj'))
print('COMPLETE_SECONDS',time.time()-start,'NORM_X_DEGREE',nc.degree(x),
      'REDUCED_NORM_X_DEGREE',remaining.degree(x),'NORM_ETA_DEGREE',nc.degree(eta),flush=True)
