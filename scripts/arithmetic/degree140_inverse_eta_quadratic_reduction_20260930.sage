"""Four unit leading pivots reduce seven actual traces to three quadratics.

No polynomial coefficient is truncated and no moving nonunit is inverted
except the already completely excluded leading-cubic H line. The four
original pivots and every exact row operation are retained.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_seven_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();Psi=d['Psi'];zero=R.zero();one=R.one()
aa=next(N for j,n,N,D in d['coefficients'] if j==0 and n==3)
aa=R({(e[0],0):c for e,c in aa.dict().items()});L=aa/aa.monomial_coefficient(H)
L=R(L);units=[H,q,Psi,L];powers=[{0:one} for _ in units]
def up(i,n):
    if n not in powers[i]:powers[i][n]=units[i]^n
    return powers[i][n]
def norm(v):
    N,D=v;D=list(D)
    if not N:return zero,(0,0,0,0)
    ee=N.exponents();x=min(e[0] for e in ee);y=min(e[1] for e in ee)
    if x or y:N=R({(e[0]-x,e[1]-y):c for e,c in N.dict().items()});D[0]-=x;D[1]-=y
    for i in [2,3]:
        while D[i]>0:
            z,r=N.quo_rem(units[i])
            if r:break
            N=z;D[i]-=1
    return N,tuple(D)
def add(a,b):
    if not a[0]:return b
    if not b[0]:return a
    D=tuple(max(a[1][i],b[1][i]) for i in range(4))
    def lift(v):return v[0]*prod(up(i,D[i]-v[1][i]) for i in range(4))
    return norm((lift(a)+lift(b),D))
def mul(a,b):return norm((a[0]*b[0],tuple(a[1][i]+b[1][i] for i in range(4))))
def neg(a):return(-a[0],a[1])
def invert(a):
    N,D=norm(a);D=list(D)
    for i in [2,3]:
        while not N.is_constant():
            z,r=N.quo_rem(units[i])
            if r:break
            N=z;D[i]-=1
    assert N.is_constant() and N,'nonunit pivot'
    return R(1/N.constant_coefficient()),tuple(-v for v in D)
original=[{int(n):(R(N),tuple(map(int,D))+(0,)) for j,n,N,D in d['coefficients'] if j==row and N} for row in range(7)]
rows=[dict(r) for r in original];operations=[]
for pivot,degree in [(4,6),(2,5),(1,4),(0,3)]:
    assert max(rows[pivot])==degree
    iv=invert(rows[pivot][degree])
    for i in [3,5,6]:
        if i==pivot or degree not in rows[i]:continue
        factor=mul(rows[i][degree],iv);operations.append((i,pivot,factor))
        for n,p in rows[pivot].items():
            z=add(rows[i].get(n,(zero,(0,0,0,0))),neg(mul(factor,p)))
            if z[0]:rows[i][n]=z
            else:rows[i].pop(n,None)
        assert degree not in rows[i]
        print('pivot',pivot,'row',i,'degree',max(rows[i],default=-1),'seconds',time.time()-start,flush=True)
    save({'ring':R,'Psi':Psi,'line':L,'original':original,'rows':rows,'operations':operations},str(root/'inverse_eta_quadratic_reduction_partial'))
assert all(max(rows[i],default=-1)<=2 for i in [3,5,6])
cleared=[];summaries=[]
for i in [3,5,6]:
    D=tuple(max(v[1][k] for v in rows[i].values()) for k in range(4))
    cc=[rows[i].get(n,(zero,(0,0,0,0))) for n in range(3)]
    nn=[v[0]*prod(up(k,D[k]-v[1][k]) for k in range(4)) for v in cc]
    common=gcd(nn)
    # Only remove a common factor when it is a proved inverted unit.
    residual=common
    for f in units:
        while residual and not residual.is_constant():
            z,r=residual.quo_rem(f)
            if r:break
            residual=z
    removable=common//residual if common else one
    nn=[N//removable for N in nn];cleared.append(nn)
    summaries.append({'row':i,'denominator':list(map(int,D)),
       'coefficients':[{'degrees':list(map(int,N.degrees())),'terms':len(N.dict())} for N in nn]})
    print(summaries[-1],flush=True)
save({'ring':R,'Psi':Psi,'line':L,'original':original,'rows':rows,'operations':operations,'quadratics':cleared},str(root/'inverse_eta_quadratic_reduction'))
(root/'inverse_eta_quadratic_reduction.json').write_text(json.dumps({'scope':'three exact quadratic consequences, not a locus decision','rows':summaries,'seconds':time.time()-start},indent=2,default=int)+'\n')
