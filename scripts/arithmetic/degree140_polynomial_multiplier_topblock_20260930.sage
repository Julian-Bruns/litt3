"""Infinity-only coefficients for Tr(x^j*t*v/phi), 0<=j<=3.

All coefficients of scale degree >=5 have no finite endpoint residue.
Use constant linear combinations, with no scale shifts that could move
uncomputed endpoint coefficients into this block.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
old=load(str(root/'trace_leading_bezout.sobj'))
K=old['target'].parent().base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
R=PolynomialRing(K,names=('H','w'));H,w=R.gens();A=R.fraction_field()
def dec(n):
    value=K.zero()
    for i in range(4):
        c=n%25;n//=25;value+=(K(c%5)+(c//5)*beta)*alpha^i
    return value
N=26;S=LaurentSeriesRing(A,'z',default_prec=N);z=S.gen()
P=[11,22,18,5,19,20,15,16,9,22,1]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
pbar=sum((dec(c)*z^(30-3*i) for i,c in enumerate(P)),S.zero()).add_bigoh(N)
Y=S.one().add_bigoh(N)
for _ in range(6):Y=(Y-(Y^3-pbar)/(3*Y^2)).add_bigoh(N)
y=z^-10*Y
it=iter((root/'family.txt').read_text().split());gs=[]
for k in range(4):
    terms=[tuple(int(next(it)) for j in range(5)) for i in range(int(next(it)))]
    lo=min(-3*i-10*j for i,j,hh,ww,c in terms);value=S.zero()
    for i,j,hh,ww,c in terms:
        if -3*i-10*j>=lo+N:continue
        value+=A(dec(c))*H^hh*w^(ww-hh)*z^(-3*i-10*j)*Y^j
    gs.append(value.add_bigoh(lo+N))
    print('input',k,'seconds',time.time()-start,flush=True)
aa=3*gs[0]*z^35;bb=2*gs[1]*z^46;cc=gs[2]*z^57
rho=S(-cc[0]/bb[0]).add_bigoh(N)
for _ in range(6):rho=(rho-(aa*rho^2+bb*rho+cc)/(2*aa*rho+bb)).add_bigoh(N)
small=z^-11*rho;large=gs[1]/gs[0]-small
qpoly=sum((dec(c)*z^(-3*i) for i,c in enumerate(Q)),S.zero())
KX=PolynomialRing(K,'x');x=KX.gen()
tx=KX(sum(dec(c)*x^i for i,c in enumerate([1,21,14,22,13]))/(x-alpha)/dec(13))
tt=sum((tx[i]*z^(-3*i) for i in range(4)),S.zero())
df=-z^-16*Y^2
out={(n,j):A.zero() for n in range(5,9) for j in range(4)}
for name,Z in [('O4',large),('O7',small)]:
    phi=(Z^5+qpoly)/y^5
    ss=(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3])/y^5
    eta=(3*gs[1]-gs[0]*Z)/(2*y^3)
    lam=-(ss/phi+tt^3/phi^2)
    assert lam.valuation()==(-4 if name=='O4' else -7)
    base=eta*df*lam.derivative()^2/phi*tt
    for n in range(5,9):
        form=base/lam^(n+1)
        for j in range(4):
            value=form*z^(-3*j)
            assert value.precision_absolute()>-1,(name,n,j,value.precision_absolute())
            out[(n,j)]-=value[-1]
        print(name,n,'seconds',time.time()-start,flush=True)
save({'ring':R,'coefficients':out},str(root/'polynomial_multiplier_topblock_raw'))
B=PolynomialRing(K,names=('H','q'));HH,q=B.gens();BF=B.fraction_field()
def convert(value):
    if not value:return BF.zero()
    num,den=value.numerator(),value.denominator()
    nr={int(e[1])%3 for e in num.exponents()};dr={int(e[1])%3 for e in den.exponents()}
    assert len(nr)==len(dr)==1 and nr==dr
    residue=next(iter(nr))
    def change(f):return B({(int(e[0]),(int(e[1])-residue)//3):c for e,c in f.dict().items()})
    return BF(change(num))/change(den)
matrix6=matrix(BF,[[convert(out[(n,j)]*w^n) for j in range(4)] for n in range(5,9)])
determinant=matrix6.det()
save({'ring':B,'matrix':matrix6,'determinant':determinant},str(root/'polynomial_multiplier_topblock'))
report={'scope':'infinity coefficient block, not an actual-cover decision',
        'det_zero':bool(determinant==0),'seconds':time.time()-start}
if determinant:
    report['det_numerator_degrees']=list(map(int,determinant.numerator().degrees()))
    report['det_numerator_terms']=len(determinant.numerator().dict())
    report['det_factor_degrees']=[(list(map(int,f.degrees())),int(e),len(f.dict())) for f,e in determinant.numerator().factor()]
(root/'polynomial_multiplier_topblock.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
