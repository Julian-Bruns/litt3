"""The infinity block using a formal inverse of its ONE nonmonomial unit.

All coefficient denominators are monomials in H,w,Psi.  Keep s=Psi^-1
formal during Laurent-series convolution; perform rational reduction
only on the30 extracted residues.  This avoids thousands of unrelated
multivariate gcd computations.  Valuation bounds precede the introduction
of s and all precision assertions are retained.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
old=load(str(root/'trace_leading_bezout.sobj'))
K=old['target'].parent().base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    v=K.zero()
    for i in range(4):
        c=n%25;n//=25;v+=(K(c%5)+(c//5)*beta)*alpha^i
    return v
R=PolynomialRing(K,names=('H','w'));HR,wR=R.gens();A=R.fraction_field()
Psi=sum(dec(c)*wR^(3*i) for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))+HR*wR^3*(dec(299833)+dec(232505)*wR^3)
C=LaurentPolynomialRing(K,names=('H','w','s'));H,w,s=C.gens()
N=26;cutoff=12;S=LaurentSeriesRing(C,'z',default_prec=N);z=S.gen()
def frobenius(v):
    """Exact fifth power, without forming cancelling cross products."""
    if not v:return S.zero().add_bigoh(5*v.precision_absolute())
    lo=int(v.valuation())
    d={(lo+i)*5:C({tuple(5*int(e0) for e0 in e):c^5
                   for e,c in coefficient.dict().items()})
       for i,coefficient in enumerate(v.list()) if coefficient}
    answer=S(d)
    return answer if v.precision_absolute()==infinity else answer.add_bigoh(5*v.precision_absolute())
def invert_unit(c):
    d=c.dict();assert d
    assert all(e[2]==0 for e in d), 'no nested formal-unit inversion is needed'
    hm=min(int(e[0]) for e in d);wm=min(int(e[1]) for e in d)
    p=R({(int(e[0])-hm,int(e[1])-wm):v for e,v in d.items()})
    count=0
    while not p.is_constant():
        q0,rem=p.quo_rem(Psi)
        assert not rem,('unexpected leading denominator',p)
        p=q0;count+=1
    assert p
    return C(1/p.constant_coefficient())*H^-hm*w^-wm*s^count
def inverse(b):
    v=int(b.valuation());p=b.precision_absolute()
    m=N if p==infinity else min(N,int(p)-v)
    assert m>0
    lead=invert_unit(b[v]);co=[lead]
    for i in range(1,m):
        co.append(-lead*sum((b[v+j]*co[i-j] for j in range(1,i+1)),C.zero()))
    return (sum((co[i]*z^(i-v) for i in range(m)),S.zero())).add_bigoh(m-v)
def div(a,b):return a*inverse(b)
P=[11,22,18,5,19,20,15,16,9,22,1]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
pbar=sum((C(dec(c))*z^(30-3*i) for i,c in enumerate(P)),S.zero()).add_bigoh(N)
Y=S.one().add_bigoh(N)
for _ in range(6):Y=(Y-div(Y^3-pbar,3*Y^2)).add_bigoh(N)
y=z^-10*Y
it=iter((root/'family.txt').read_text().split());gs=[]
for k in range(4):
    terms=[tuple(int(next(it)) for j in range(5)) for i in range(int(next(it)))]
    lo=min(-3*i-10*j for i,j,hh,ww,c in terms);value=S.zero()
    for i,j,hh,ww,c in terms:
        if -3*i-10*j>=lo+N:continue
        value+=C(dec(c))*H^hh*w^(ww-hh)*z^(-3*i-10*j)*Y^j
    gs.append(value.add_bigoh(lo+N))
aa=3*gs[0]*z^35;bb=2*gs[1]*z^46;cc=gs[2]*z^57
rho=S(-cc[0]*invert_unit(bb[0])).add_bigoh(N)
for _ in range(6):rho=(rho-div(aa*rho^2+bb*rho+cc,2*aa*rho+bb)).add_bigoh(N)
small=z^-11*rho;large=div(gs[1],gs[0])-small
qpoly=sum((C(dec(c))*z^(-3*i) for i,c in enumerate(Q)),S.zero())
KX=PolynomialRing(K,'x');x=KX.gen()
tx=KX(sum(dec(c)*x^i for i,c in enumerate([1,21,14,22,13]))/(x-alpha)/dec(13))
tt=sum((C(tx[i])*z^(-3*i) for i in range(4)),S.zero());df=-z^-16*Y^2
print('source and critical roots ready','seconds',time.time()-start,flush=True)
def project(c):
    if not c:return A.zero()
    d=c.dict();hm=min(int(e[0]) for e in d);wm=min(int(e[1]) for e in d)
    sm=max(int(e[2]) for e in d);assert all(e[2]>=0 for e in d)
    levels={}
    for e,v in d.items():levels.setdefault(sm-int(e[2]),{})[(int(e[0])-hm,int(e[1])-wm)]=v
    num=sum((R(dd)*Psi^i for i,dd in levels.items()),R.zero())
    return A(num)*A(HR)^hm*A(wR)^wm/A(Psi)^sm
out={(n,j):A.zero() for n in range(5,10) for j in range(6)};parts=[]
checkpoint=root/'polynomial_multiplier_extended_partial.sobj'
if checkpoint.exists():
    previous=load(str(checkpoint));parts=previous['parts'];out=previous['coefficients']
    print('reuse completed branches',[name for name,values in parts],flush=True)
for name,Z in [('O4',large),('O7',small)]:
    if name in [label for label,values in parts]:continue
    phi=div(frobenius(Z)+qpoly,frobenius(y))
    ss=div(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3],frobenius(y))
    eta=div(3*gs[1]-gs[0]*Z,2*y^3)
    lam=-(div(ss,phi)+div(tt^3,phi^2))
    assert lam.valuation()==(-4 if name=='O4' else -7)
    assert all(all(e[2]==0 for e in co.dict()) for co in lam.list())
    print(name,'Lambda ready','seconds',time.time()-start,flush=True)
    relative=20 if name=='O7' else 19
    def short(v):return v.add_bigoh(v.valuation()+relative)
    base=div(short(eta)*short(df)*short(lam.derivative())^2,short(phi))*short(tt)
    print(name,'base ready','seconds',time.time()-start,flush=True)
    # Every inverse coefficient has its KNOWN denominator c0^(j+1).
    # Keeping that grading avoids expanding independent formal s-levels.
    bv=int(base.valuation());lv=int(lam.valuation())
    maximum=max(-1,11-(bv-6*lv))
    assert base.precision_absolute()>bv+maximum
    assert lam.precision_absolute()>lv+maximum
    assert all(all(e[2]==0 for e in c.dict()) for c in base.list())
    c0=lam[lv];cp=[C.one()]
    for j in range(maximum+10):cp.append(cp[-1]*c0)
    ee=[C.one()]
    for j in range(1,maximum+1):
        ee.append(-sum((lam[lv+i]*ee[j-i]*cp[i-1]
                        for i in range(1,j+1)),C.zero()))
    def fifth_coefficient(c):
        return C({tuple(5*int(e0) for e0 in e):v^5 for e,v in c.dict().items()})
    pp={6:[sum((fifth_coefficient(ee[a])*ee[j-5*a]
                 for a in range(j//5+1)),C.zero())
            for j in range(maximum+1)]}
    for exponent in range(7,11):
        bound=11-(bv-exponent*lv)
        pp[exponent]=[sum((pp[exponent-1][i]*ee[j-i]
                           for i in range(j+1)),C.zero())
                       for j in range(max(0,bound+1))]
    print(name,'graded inverse numerators ready','seconds',time.time()-start,flush=True)
    def extract(exponent,target,series=base):
        k=target-(bv-exponent*lv)
        if k<0:return A.zero()
        assert series.precision_absolute()>bv+k
        numerator=sum((series[bv+i]*pp[exponent][k-i]*cp[i]
                       for i in range(k+1)),C.zero())
        return project(numerator)/project(cp[exponent+k])
    local={}
    for n in range(5,10):
        vals=[-extract(n+1,3*j-1) for j in range(5)]
        vals.append(-extract(n+1,9,base*Y))
        for j,value in enumerate(vals):
            out[(n,j)]+=value;local[(n,j)]=value
        print(name,n,'seconds',time.time()-start,flush=True)
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
mat=matrix(BF,[[convert(out[(n,j)]*wR^(n-(j==5))) for j in range(6)] for n in range(5,10)])
save({'ring':B,'matrix':mat},str(root/'polynomial_multiplier_extended'))
report={'scope':'exact high coefficient block; no actual-cover decision',
        'shape':[int(5),int(6)],'previous_coefficients_agree':True,'seconds':time.time()-start,
        'algorithm':'graded known denominators and sparse coefficient Frobenius'}
(root/'polynomial_multiplier_extended.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
