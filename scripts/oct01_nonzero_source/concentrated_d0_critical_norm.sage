#!/usr/bin/env sage
"""Critical resultant norm for the concentrated d0 one-parameter family."""
from sage.all import *
import argparse,json,time
from math import comb
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
ap.add_argument('--root',type=int,default=145049);ap.add_argument('--eta',type=int,default=1)
ap.add_argument('--symbolic',action='store_true');ap.add_argument('--setup-only',action='store_true')
args=ap.parse_args();start=time.time()
E=GF(5**24,'z');EE=PolynomialRing(E,'Z');Z=EE.gen()
beta=(Z**2-Z-3).roots(multiplicities=False)[0]
def code25(c):return E(c%5)+E(c//5)*beta
alpha=sum((code25(c)*Z**i for i,c in enumerate([5,2,6,7,1])),EE.zero()).roots(multiplicities=False)[0]
rho=(Z**3-code25(6)).roots(multiplicities=False)[0]
cache={}
def decode(code):
    code=int(code)
    if code not in cache:
        n=code;v=E.zero()
        for j in range(3):
            b=n%390625;n//=390625;s=E.zero()
            for i in range(4):s+=code25(b%25)*alpha**i;b//=25
            v+=s*rho**j
        cache[code]=v
    return cache[code]
if args.symbolic:
    R=PolynomialRing(E,('x','eta'),order='degrevlex');x,eta=R.gens()
else:
    R=PolynomialRing(E,'x');x=R.gen();eta=decode(args.eta)
P=sum((code25(c)*x**i for i,c in enumerate([11,22,18,5,19,20,15,16,9,22,1])),R.zero())
zero=[R.zero()]*3
def add(a,b):return [a[i]+b[i] for i in range(3)]
def neg(a):return [-v for v in a]
def sub(a,b):return add(a,neg(b))
def scale(a,c):return [v*c for v in a]
def mul(a,b):
    out=[R.zero()]*5
    for i in range(3):
        for j in range(3):out[i+j]+=a[i]*b[j]
    return [out[0]+P*out[3],out[1]+P*out[4],out[2]]
def power(a,n):
    out=[R.one(),R.zero(),R.zero()]
    while n:
        if n%2:out=mul(out,a)
        a=mul(a,a);n//=2
    return out
def norm(a):return a[0]**3+P*a[1]**3+P**2*a[2]**3-3*P*a[0]*a[1]*a[2]
def divide(a,b):
    adj=[b[0]**2-P*b[1]*b[2],P*b[2]**2-b[0]*b[1],b[1]**2-b[0]*b[2]]
    assert mul(b,adj)==[norm(b),R.zero(),R.zero()]
    numerator=mul(a,adj);den=norm(b);out=[]
    for component in numerator:
        q,r=component.quo_rem(den);assert not r;out.append(q)
    return out
data=args.work/'data';family=json.loads((data/'concentrated_d0_source_family.json').read_text())
source=next(r for r in family['records'] if r['root_K_code']==args.root)
def ep(poly):return sum((decode(c)*eta**i for i,c in enumerate(poly)),R.zero())
nums=[ep(poly) for poly in source['source_numerators']];H=ep(source['common_denominator'])
point=next(r for r in json.loads((data/'shifted_concentrated_projection.json').read_text())['records'] if r['root_K_code']==args.root)
y0=decode(point['y0_extension_code']);characters=[1,1,1,1,1,2,0,0,2,2,2,2,2,0,0,0,0,1]
nums=[n*y0**(1-e) for n,e in zip(nums,characters)]
adapted=json.loads((data/'adapted_family.json').read_text())
N=[zero[:] for _ in range(6)]
columns=[adapted['origin']]+adapted['directions'][5:]
for scalar,column in zip(nums[:13],columns):
    for tag,c in zip(adapted['labels'],column):
        if tag[0]=='kappa' or not c:continue
        degree,b,char=tag;N[degree][char]+=scalar*decode(c)*x**b
Q=sum((code25(c)*x**i for i,c in enumerate([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])),R.zero())
B=[sum((code25(c)*x**i for i,c in enumerate([8,14,19,2,10,19,3,24,18,16])),R.zero()),R.zero(),R.zero()]
v=nums[13];N[0]=[v,R.zero(),R.zero()];N[5]=add(N[5],[v*Q,R.zero(),R.zero()])
def divide_y(f,n):
    out=zero[:]
    for char,component in enumerate(f):
        exponent,target=divmod(char-n,3)
        if exponent<0:
            quotient,remainder=component.quo_rem(P**(-exponent));assert not remainder
            out[target]=quotient
        else:out[target]=component*P**exponent
    return out
bp=[power(B,i) for i in range(6)]
S=[]
for j in range(5):
    total=zero[:]
    for i in range(6):
        degree=5-i
        if degree>=j:total=add(total,scale(mul(N[i],bp[degree-j]),comb(degree,j)*(-1)**(degree-j)))
    S.append(divide_y(total,5-j))
q=divide_y(sub([Q,R.zero(),R.zero()],bp[5]),5);S[0]=sub(S[0],scale(q,v))
t=sum((decode(c)*x**i for i,c in enumerate(adapted['t'])),R.zero())
F=[add(add(scale(power(q,2),v),mul(q,S[0])),[H*t**3,R.zero(),R.zero()])]
F.extend(mul(q,S[j]) for j in range(1,5));F.append(add(S[0],scale(q,2*v)))
F.extend(S[1:]);F.append([v,R.zero(),R.zero()]);D=[scale(S[j],j) for j in range(1,5)]
print('SOURCE_SECONDS',time.time()-start,flush=True)
if args.setup_only:
    assert args.symbolic
    save({'E':E,'beta':beta,'alpha':alpha,'rho':rho,'R':R,'x':x,'eta':eta,
          'source_nums':nums,'H':H,'root':args.root,'P':P,'Fhat':F,'Dhat':D,
          't':t,'parameter_degree_bound':377},str(data/f'concentrated_d0_critical_setup_{args.root}.sobj'))
    raise SystemExit(0)
a=D[3];rem=F[:]
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
from itertools import permutations
for perm in permutations(range(3)):
    sign=(-1)**sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))
    det=add(det,scale(mul(mul(M[0][perm[0]],M[1][perm[1]]),M[2][perm[2]]),sign))
print('DETERMINANT_SECONDS',time.time()-start,flush=True)
Delta=det
for j in range(20):
    Delta=divide(Delta,a)
    if args.symbolic:print('DIVISION',j+1,'SECONDS',time.time()-start,flush=True)
C=[]
for component in Delta:
    quotient,remainder=component.quo_rem(t**5);assert not remainder;C.append(quotient)
nc=norm(C);factor=(x-decode(args.root))**20
remaining,remainder=nc.quo_rem(factor);assert not remainder
report={'E':E,'beta':beta,'alpha':alpha,'rho':rho,'R':R,'x':x,'eta':eta,
        'source_nums':nums,'H':H,'root':args.root,'P':P,'Fhat':F,'Dhat':D,
        'Delta_hat':Delta,'C_hat':C,'norm_C_hat':nc,'reduced_norm_C_hat':remaining}
suffix='symbolic' if args.symbolic else 'eta'+str(args.eta)
save(report,str(data/f'concentrated_d0_critical_norm_{args.root}_{suffix}.sobj'))
print('COMPLETE_SECONDS',time.time()-start,'NORM_X_DEGREE',nc.degree(x) if args.symbolic else nc.degree(),
      'REDUCED_NORM_X_DEGREE',remaining.degree(x) if args.symbolic else remaining.degree(),flush=True)
if not args.symbolic:
    square=remaining.is_square();print('SQUARE',square,flush=True)
    factors=remaining.factor();print('ODD_FACTOR_DEGREES',[f.degree() for f,k in factors if k%2],flush=True)
