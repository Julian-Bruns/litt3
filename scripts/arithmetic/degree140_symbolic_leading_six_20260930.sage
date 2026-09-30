"""Exact short infinity jets for the two reciprocal degree-six coefficients.

ROOT. This is a new calculation, not a replay of the global trace grid.
For f=x^3 or y, finite points contribute only through degree five.
Retain both infinity branches, including all normalization parameters.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]); started=time.time()
old=load(str(root/'trace_leading_bezout.sobj'))
K=old['target'].parent().base_ring()
R=PolynomialRing(K,names=('H','w'));H,w=R.gens();A=R.fraction_field()
alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
assert beta^2-beta-3==0
def decode(n):
    z=K.zero(); aa=alpha; bb=beta
    for i in range(4):
        c=n%25;n//=25
        z+=K((c%5)+(c//5)*bb)*aa^i
    return z

N=12; S=LaurentSeriesRing(A,'z',default_prec=N);z=S.gen()
P=[11,22,18,5,19,20,15,16,9,22,1]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
pbar=sum((decode(c)*z^(30-3*i) for i,c in enumerate(P)),S.zero()).add_bigoh(N)
Y=S.one().add_bigoh(N)
for _ in range(5):Y=(Y-(Y^3-pbar)/(3*Y^2)).add_bigoh(N)
y=z^-10*Y

it=iter((root/'family.txt').read_text().split());gs=[]
for k in range(4):
    terms=[tuple(int(next(it)) for j in range(5)) for i in range(int(next(it)))]
    lo=min(-3*i-10*j for i,j,hh,ww,c in terms)
    value=S.zero()
    for i,j,hh,ww,c in terms:
        if -3*i-10*j>=lo+N:continue
        value+=A(decode(c))*H^hh*w^(ww-hh)*z^(-3*i-10*j)*Y^j
    value=value.add_bigoh(lo+N);gs.append(value)
    print('input',k,'valuation',value.valuation(),'precision',value.precision_absolute(),flush=True)

aa=3*gs[0]*z^35;bb=2*gs[1]*z^46;cc=gs[2]*z^57
rho=S(-cc[0]/bb[0]).add_bigoh(N)
for _ in range(5):rho=(rho-(aa*rho^2+bb*rho+cc)/(2*aa*rho+bb)).add_bigoh(N)
small=z^-11*rho;large=gs[1]/gs[0]-small
qpoly=sum((decode(c)*z^(-3*i) for i,c in enumerate(Q)),S.zero())
# t=(A(x)/(x-alpha))/[13], represented without any parameter denominator.
KX=PolynomialRing(K,'x');x=KX.gen()
tx=sum(decode(c)*x^i for i,c in enumerate([1,21,14,22,13]))/(x-K.gen())/decode(13)
tx=KX(tx)
tt=sum((tx[i]*z^(-3*i) for i in range(4)),S.zero())^3
df=-z^-16*Y^2
answer=[A.zero(),A.zero()];parts=[]
for name,Z in [('O4',large),('O7',small)]:
    phi=(Z^5+qpoly)/y^5
    ss=(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3])/y^5
    eta=(3*gs[1]-gs[0]*Z)/(2*y^3)
    lam=-(ss/phi+tt/phi^2)
    expected=-4 if name=='O4' else -7
    assert lam.valuation()==expected,(name,lam.valuation())
    omega=eta*df*lam.derivative()^2/phi/lam^7
    vals=[]
    for i,f in enumerate([z^-9,y]):
        form=omega*f
        assert form.precision_absolute()>-1,(name,i,form.precision_absolute())
        value=-form[-1];answer[i]+=value;vals.append(value)
    parts.append((name,vals))
    print(name,'done seconds',time.time()-started,flush=True)

save({'ring':R,'values':answer,'parts':parts},str(root/'reciprocal_degree6_symbolic'))
Qring=PolynomialRing(K,names=('H','q'));HH,q=Qring.gens()
def invariant(value):
    num,den=value.numerator(),value.denominator()
    nr={int(e[1])%3 for e in num.exponents()};dr={int(e[1])%3 for e in den.exponents()}
    assert len(nr)==len(dr)==1 and nr==dr,(nr,dr)
    residue=next(iter(nr))
    def change(poly):
        return Qring({(int(e[0]),(int(e[1])-residue)//3):c for e,c in poly.dict().items()})
    return change(num),change(den)
converted=[invariant(answer[0]*w^6),invariant(answer[1]*w^5)]
save({'ring':Qring,'values':converted},str(root/'reciprocal_degree6_invariant'))
report={'scope':'exact two-infinity leading coefficients; not a common-zero decision',
        'seconds':time.time()-started,'coefficients':[]}
for n,d in converted:
    report['coefficients'].append({'numerator_terms':len(n.dict()),'denominator_terms':len(d.dict()),
          'numerator_H_degree':int(n.degree(HH)),'numerator_q_degree':int(n.degree(q)),
          'denominator_H_degree':int(d.degree(HH)),'denominator_q_degree':int(d.degree(q))})
(root/'reciprocal_degree6_symbolic.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
