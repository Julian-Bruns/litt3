"""Infinity coefficients of the stronger ACTUAL-splitting traces.

Use delta(Lambda), without eta. Actual local splitting forces this to
vanish at every point of a finite nonzero critical fibre. Mere normalized
ramification does not. All finite-pole contributions have degree <=2.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
source=Path(__file__).with_name('degree140_polynomial_multiplier_localized_20260930.sage').read_text()
source=source[:source.index('out={(n,j):')]
exec(preparse(source))
out={(n,j):A.zero() for n in range(3,8) for j in range(5)};parts=[]
checkpoint=root/'actual_derivative_topblock_partial.sobj'
if checkpoint.exists():
    previous=load(str(checkpoint));out=previous['coefficients'];parts=previous['parts']
for name,Z in [('O4',large),('O7',small)]:
    if name in [label for label,values in parts]:continue
    phi=div(frobenius(Z)+qpoly,frobenius(y))
    ss=div(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3],frobenius(y))
    lam=-(div(ss,phi)+div(tt^3,phi^2))
    assert lam.valuation()==(-4 if name=='O4' else -7)
    base=df*lam.derivative()^2
    bv=int(base.valuation());lv=int(lam.valuation());maximum=9-(bv-4*lv)
    assert base.precision_absolute()>bv+maximum
    assert lam.precision_absolute()>lv+maximum
    assert all(all(e[2]==0 for e in coefficient.dict()) for coefficient in base.list())
    c0=lam[lv];cp=[C.one()]
    for j in range(maximum+10):cp.append(cp[-1]*c0)
    ee=[C.one()]
    for j in range(1,maximum+1):
        ee.append(-sum((lam[lv+i]*ee[j-i]*cp[i-1] for i in range(1,j+1)),C.zero()))
    def convolution(a,b,bound):
        return [sum((a[i]*b[j-i] for i in range(j+1)),C.zero()) for j in range(bound+1)]
    p2=convolution(ee,ee,maximum)
    p3=convolution(p2,ee,maximum)
    p4=convolution(p2,p2,maximum)
    def fifth(c):return C({tuple(5*int(e0) for e0 in e):v^5 for e,v in c.dict().items()})
    p5=[fifth(ee[j//5]) if j%5==0 else C.zero() for j in range(maximum+1)]
    powers={4:p4,5:p5}
    for a,p in [(6,ee),(7,p2),(8,p3)]:
        bound=max(-1,9-(bv-a*lv))
        powers[a]=convolution(p5,p,bound)
    def extract(n,target,v=base):
        a=n+1;k=target-(bv-a*lv)
        if k<0:return A.zero()
        assert v.precision_absolute()>bv+k
        numerator=sum((v[bv+i]*powers[a][k-i]*cp[i] for i in range(k+1)),C.zero())
        return -project(numerator)/project(cp[a+k])
    local={}
    for n in range(3,8):
        values=[extract(n,3*j-1) for j in range(4)]+[extract(n,9,base*Y)]
        for j,value in enumerate(values):out[n,j]+=value;local[n,j]=value
        print(name,n,'seconds',time.time()-start,flush=True)
    parts.append((name,local))
    save({'ring':R,'coefficients':out,'parts':parts},str(root/'actual_derivative_topblock_partial'))
M=matrix(A,[[out[n,j] for j in range(5)] for n in range(3,8)])
save({'ring':R,'matrix':M,'coefficients':out,'parts':parts},str(root/'actual_derivative_topblock'))
report={'scope':'new actual-splitting trace high coefficients only',
        'multipliers':['1','x','x^2','x^3','y'], 'indices':list(range(int(3),int(8))),
        'nonzero':[[bool(v) for v in row] for row in M.rows()],
        'numerator_degrees':[[list(map(int,v.numerator().degrees())) if v else None for v in row] for row in M.rows()],
        'seconds':time.time()-start}
(root/'actual_derivative_topblock.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
