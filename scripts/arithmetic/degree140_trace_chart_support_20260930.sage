"""Inspect an exact change to the ratio of the two infinity leading terms.

New support analysis only; no previous certificate replay.  Work in the
open chart a0*a1 != 0 and put H=(a0/a1)*u.  The output records guaranteed
common coefficient factors before any global elimination is attempted.
"""
import json, sys, time
from pathlib import Path

root=Path(sys.argv[1]); name=sys.argv[2] if len(sys.argv)>2 else 'global_multiplied'
d=load(str(root/(name+'_rational_coefficients.sobj')))
R=d['ring']; H,q=R.gens(); K=R.base_ring()
Q=PolynomialRing(K,'q'); qq=Q.gen()
toQ=R.hom([Q.zero(),qq],Q)
a0=toQ(d['a0']); a1=toQ(d['Psi'].derivative(H)); linear=a1//qq
def val(p,f):
    if not p:return 100000
    n=0
    while True:
        z,r=p.quo_rem(f)
        if r:return n
        p=z;n+=1
def row_polys(N):
    groups={}
    for (i,j),c in N.dict().items():groups.setdefault(int(i),{})[int(j)]=c
    return {i:Q(v) for i,v in groups.items()}

out=[]; start=time.time()
for j,n,N,(dh,dq,dp) in d['coefficients']:
    pp=row_polys(N); top=max(pp)
    v0=min(val(p,a0)+i for i,p in pp.items())
    vl=min(val(p,linear)+top-i for i,p in pp.items())
    vq=min(val(p,qq)+top-i for i,p in pp.items())
    degree=max(p.degree()+7*i+2*(top-i) for i,p in pp.items())-7*v0-vl-vq
    item={'j':int(j),'n':int(n),'H_degree':top,'a0_factor':int(v0),
          'linear_a1_factor':int(vl),'q_factor':int(vq),'new_q_degree':int(degree),
          'denominator_u_1plusu_a0_linear_q':list(map(int,[dh,dp,dh+dp-v0,top-dh-vl,dq+top-dh-vq]))}
    out.append(item);print(item,flush=True)
(root/(name+'_ratio_chart_support.json')).write_text(json.dumps({'status':'exact_coefficient_support',
 'change':'H=a0(q)*u/a1(q), a1=q*linear','rows':out,'seconds':time.time()-start},indent=2)+'\n')
