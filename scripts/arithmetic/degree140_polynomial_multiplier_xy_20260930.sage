"""Add x*y*t without increasing the scale-degree-nine infinity bound.

Only one new residue coefficient per scale index is constructed. The
completed six-column block is reused, not replayed.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
source=Path(__file__).with_name('degree140_polynomial_multiplier_localized_20260930.sage').read_text()
source=source[:source.index('out={(n,j):')]
source=source.replace('N=26;cutoff=12;', 'N=27;cutoff=13;')
exec(preparse(source))
new={n:A.zero() for n in range(5,10)};parts=[]
checkpoint=root/'polynomial_multiplier_xy_partial.sobj'
if checkpoint.exists():
    previous=load(str(checkpoint));new=previous['coefficients'];parts=previous['parts']
for name,Z in [('O4',large),('O7',small)]:
    if name in [label for label,values in parts]:continue
    phi=div(frobenius(Z)+qpoly,frobenius(y))
    ss=div(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3],frobenius(y))
    eta=div(3*gs[1]-gs[0]*Z,2*y^3)
    lam=-(div(ss,phi)+div(tt^3,phi^2))
    assert lam.valuation()==(-4 if name=='O4' else -7)
    relative=21 if name=='O7' else 20
    def short(v):return v.add_bigoh(v.valuation()+relative)
    base=div(short(eta)*short(df)*short(lam.derivative())^2,short(phi))*short(tt)
    base=base*Y
    bv=int(base.valuation());lv=int(lam.valuation());maximum=12-(bv-6*lv)
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
        bound=12-(bv-exponent*lv)
        pp[exponent]=[sum((pp[exponent-1][i]*ee[j-i]
                           for i in range(j+1)),C.zero())
                       for j in range(max(0,bound+1))]
    print(name,'graded inverse numerators ready','seconds',time.time()-start,flush=True)
    local={}
    for n in range(5,10):
        exponent=n+1;k=12-(bv-exponent*lv)
        if k<0:value=A.zero()
        else:
            numerator=sum((base[bv+i]*pp[exponent][k-i]*cp[i]
                           for i in range(k+1)),C.zero())
            value=-project(numerator)/project(cp[exponent+k])
        new[n]+=value;local[n]=value
        print(name,n,'seconds',time.time()-start,flush=True)
    parts.append((name,local))
    save({'ring':R,'coefficients':new,'parts':parts},str(root/'polynomial_multiplier_xy_partial'))
previous=load(str(root/'polynomial_multiplier_extended.sobj'));B=previous['ring'];HH,q=B.gens();BF=B.fraction_field()
def convert(value):
    if not value:return BF.zero()
    num,den=value.numerator(),value.denominator()
    nr={int(e[1])%3 for e in num.exponents()};dr={int(e[1])%3 for e in den.exponents()}
    assert len(nr)==len(dr)==1 and nr==dr,(nr,dr)
    residue=next(iter(nr))
    def change(f):return B({(int(e[0]),(int(e[1])-residue)//3):c for e,c in f.dict().items()})
    return BF(change(num))/change(den)
column=vector(BF,[convert(new[n]*wR^(n-1)) for n in range(5,10)])
M=previous['matrix'].augment(matrix(BF,5,1,list(column)))
save({'ring':B,'matrix':M,'new_column':column,'raw':new},str(root/'polynomial_multiplier_extended7'))
report={'scope':'one new infinity trace column only','shape':[int(5),int(7)],
        'seconds':time.time()-start,'degree_bound':int(9),'existing_six_columns_reused':True}
(root/'polynomial_multiplier_extended7.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
