"""Three short equations for simultaneous quintic leading degeneration.

Separate the three x-endpoints by their Vandermonde matrix.  This
avoids expanding the product of three fourth-power content norms.
No zero-locus decision is made by this construction alone.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
small=load(str(root/'endpoint_small_top_symbolic.sobj'))
B=small['ring'];HH,q=B.gens();K=B.base_ring();alpha=K.gen();BF=B.fraction_field()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
R=PolynomialRing(K,names=('H','w'));H,w=R.gens();A=R.fraction_field()
def dec(n):
    v=K.zero()
    for i in range(4):
        c=n%25;n//=25;v+=(K(c%5)+(c//5)*beta)*alpha^i
    return v
N=12;S=LaurentSeriesRing(A,'z',default_prec=N);z=S.gen()
P=[11,22,18,5,19,20,15,16,9,22,1]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
pbar=sum((dec(c)*z^(30-3*i) for i,c in enumerate(P)),S.zero()).add_bigoh(N)
Y=S.one().add_bigoh(N)
for _ in range(5):Y=(Y-(Y^3-pbar)/(3*Y^2)).add_bigoh(N)
y=z^-10*Y
it=iter((root/'family.txt').read_text().split());gs=[]
for k in range(4):
    terms=[tuple(int(next(it)) for j in range(5)) for i in range(int(next(it)))]
    lo=min(-3*i-10*j for i,j,hh,ww,c in terms);value=S.zero()
    for i,j,hh,ww,c in terms:
        if -3*i-10*j>=lo+N:continue
        value+=A(dec(c))*H^hh*w^(ww-hh)*z^(-3*i-10*j)*Y^j
    gs.append(value.add_bigoh(lo+N))
aa=3*gs[0]*z^35;bb=2*gs[1]*z^46;cc=gs[2]*z^57
rho=S(-cc[0]/bb[0]).add_bigoh(N)
for _ in range(5):rho=(rho-(aa*rho^2+bb*rho+cc)/(2*aa*rho+bb)).add_bigoh(N)
smallZ=z^-11*rho;largeZ=gs[1]/gs[0]-smallZ
qpoly=sum((dec(c)*z^(-3*i) for i,c in enumerate(Q)),S.zero())
KX=PolynomialRing(K,'x');x=KX.gen()
tx=KX(sum(dec(c)*x^i for i,c in enumerate([1,21,14,22,13]))/(x-alpha)/dec(13))
tt=sum((tx[i]*z^(-3*i) for i in range(4)),S.zero())^3;df=-z^-16*Y^2
values=[A.zero()]*3
for name,Z in [('O4',largeZ),('O7',smallZ)]:
    phi=(Z^5+qpoly)/y^5
    ss=(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3])/y^5
    eta=(3*gs[1]-gs[0]*Z)/(2*y^3)
    lam=-(ss/phi+tt/phi^2)
    base=eta*df*lam.derivative()^2/phi
    v5=base.valuation()-6*lam.valuation();needed=6-v5
    form=base.add_bigoh(base.valuation()+needed)/lam.add_bigoh(lam.valuation()+needed)^6
    assert form.precision_absolute()>=6
    for j in range(3):values[j]-=form[3*j-1]
    print(name,'seconds',time.time()-start,flush=True)
assert values[0]==0
def convert(v):
    if not v:return BF.zero()
    num,den=v.numerator(),v.denominator()
    nr={int(e[1])%3 for e in num.exponents()};dr={int(e[1])%3 for e in den.exponents()}
    assert len(nr)==len(dr)==1 and nr==dr
    residue=next(iter(nr))
    def ch(f):return B({(int(e[0]),int(e[1]-residue)//3):c for e,c in f.dict().items()})
    return BF(ch(num))/ch(den)
infinity=vector(BF,[convert(v*w^5) for v in values])
roots=[r['root'] for r in small['records']]
vand=matrix(K,[[r^j for r in roots] for j in range(3)])
targets=-vand.inverse()*infinity
equations=[]
for i,record in enumerate(small['records']):
    n,d=record['Q_degree5_normalized'];target=targets[i]
    equation=n*target.denominator()-d*target.numerator()
    equations.append(equation)
    print('equation',i,'degrees',equation.degrees(),'terms',len(equation.dict()),flush=True)
fixtures=json.loads((root/'reciprocal_quintic_top.json').read_text())['rows']
for fixture in fixtures:
    h0,w0=dec(fixture['h']),dec(fixture['w']);H0=h0*w0;q0=w0^3
    end=[]
    for record in small['records']:
        n,d=record['Q_degree5_normalized'];end.append(n(H0,q0)/d(H0,q0))
    total=vand*vector(K,end)+vector(K,[v.numerator()(H0,q0)/v.denominator()(H0,q0) for v in infinity])
    for j in range(3):assert total[j]==dec(fixture['coeff'][j][2])*w0^5
save({'ring':B,'roots':roots,'infinity':infinity,'targets':targets,
      'equations':equations,'endpoint_coefficients':small['records']},
     str(root/'quintic_leading_equations'))
report={'scope':'three equations for simultaneous leading degeneration, not a decision',
        'new_fixture_comparisons':int(27),'seconds':time.time()-start,
        'equations':[{'degrees':list(map(int,f.degrees())),'terms':len(f.dict())} for f in equations]}
(root/'quintic_leading_equations.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
