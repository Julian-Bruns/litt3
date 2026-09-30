"""Six endpoint-vanishing reciprocal traces, high coefficient block.

Multipliers are t,xt,x^2t,x^3t,x^4t,yt.  Only coefficients of
scale degree5..9 are used.  Finite endpoint contributions vanish in
these degrees.  Local valuation truncation is safe here: every later
division by Lambda increases the valuation; there are no scale shifts.
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
N=26;cutoff=12;S=LaurentSeriesRing(A,'z',default_prec=N);z=S.gen()
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
aa=3*gs[0]*z^35;bb=2*gs[1]*z^46;cc=gs[2]*z^57
rho=S(-cc[0]/bb[0]).add_bigoh(N)
for _ in range(6):rho=(rho-(aa*rho^2+bb*rho+cc)/(2*aa*rho+bb)).add_bigoh(N)
small=z^-11*rho;large=gs[1]/gs[0]-small
qpoly=sum((dec(c)*z^(-3*i) for i,c in enumerate(Q)),S.zero())
KX=PolynomialRing(K,'x');x=KX.gen()
tx=KX(sum(dec(c)*x^i for i,c in enumerate([1,21,14,22,13]))/(x-alpha)/dec(13))
tt=sum((tx[i]*z^(-3*i) for i in range(4)),S.zero());df=-z^-16*Y^2
out={(n,j):A.zero() for n in range(5,10) for j in range(6)}
parts=[]
checkpoint=root/'polynomial_multiplier_extended_partial.sobj'
if checkpoint.exists():
    previous=load(str(checkpoint))
    parts=previous['parts'];out=previous['coefficients']
    print('resume completed branches',[name for name,values in parts],flush=True)
for name,Z in [('O4',large),('O7',small)]:
    if name in [label for label,values in parts]:continue
    phi=(Z^5+qpoly)/y^5
    ss=(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3])/y^5
    eta=(3*gs[1]-gs[0]*Z)/(2*y^3)
    lam=-(ss/phi+tt^3/phi^2)
    assert lam.valuation()==(-4 if name=='O4' else -7)
    print(name,'Lambda formed','seconds',time.time()-start,flush=True)
    # For O7 the residue differential at degree5 starts at z^-8.
    # Exactly20 relative terms reach z^11.  Cut the factors BEFORE
    # their rational-series products; later positive-valuation factors
    # can never return a discarded coefficient to the residue range.
    relative=20 if name=='O7' else 19
    def short(v):return v.add_bigoh(v.valuation()+relative)
    base=short(eta)*short(df)*short(lam.derivative())^2/short(phi)*short(tt)
    print(name,'base formed','seconds',time.time()-start,flush=True)
    v5=base.valuation()-6*lam.valuation();needed=cutoff-v5
    bshort=base.add_bigoh(base.valuation()+needed)
    lshort=lam.add_bigoh(lam.valuation()+needed)
    invlam=1/lshort
    form=(bshort*invlam^6).add_bigoh(cutoff)
    assert form.precision_absolute()>=cutoff
    local={}
    for n in range(5,10):
        vals=[-form[3*j-1] for j in range(5)]
        vals.append(-(form*Y)[9])
        for j,val in enumerate(vals):out[(n,j)]+=val;local[(n,j)]=val
        print(name,n,'seconds',time.time()-start,flush=True)
        form=(form*invlam).add_bigoh(cutoff)
        assert form.precision_absolute()>=cutoff
    parts.append((name,local))
    save({'ring':R,'coefficients':out,'parts':parts},str(root/'polynomial_multiplier_extended_partial'))
previous=load(str(root/'polynomial_multiplier_topblock_raw.sobj'))['coefficients']
assert all(out[k]==v for k,v in previous.items())
save({'ring':R,'coefficients':out,'parts':parts},str(root/'polynomial_multiplier_extended_raw'))
B=PolynomialRing(K,names=('H','q'));HH,q=B.gens();BF=B.fraction_field()
def convert(value):
    if not value:return BF.zero()
    num,den=value.numerator(),value.denominator()
    nr={int(e[1])%3 for e in num.exponents()};dr={int(e[1])%3 for e in den.exponents()}
    assert len(nr)==len(dr)==1 and nr==dr,(nr,dr)
    residue=next(iter(nr))
    def change(f):return B({(int(e[0]),(int(e[1])-residue)//3):c for e,c in f.dict().items()})
    return BF(change(num))/change(den)
mat=matrix(BF,[[convert(out[(n,j)]*w^(n-(j==5))) for j in range(6)] for n in range(5,10)])
save({'ring':B,'matrix':mat},str(root/'polynomial_multiplier_extended'))
report={'scope':'exact high coefficient block; no actual-cover decision',
        'shape':[5,6],'previous_coefficients_agree':True,'seconds':time.time()-start}
(root/'polynomial_multiplier_extended.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
