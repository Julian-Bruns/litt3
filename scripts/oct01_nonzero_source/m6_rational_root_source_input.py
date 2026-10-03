#!/usr/bin/env python3
"""Small necessary source coefficient slice for a rational m6 critical root."""
import argparse,json,sys,time
from pathlib import Path
import numpy as np
archive=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(archive/'src'))
from exact import Field,Curve,Poly,B0_CODES,L0_CODES,monomials
from infinity import InfinitySystem
parser=argparse.ArgumentParser();parser.add_argument('--work',type=Path,required=True);args=parser.parse_args();start=time.time()
data=args.work/'data';k=Field(args.work/'cache');C=Curve(k);P=Poly(k);family=json.loads((data/'adapted_family.json').read_text());system=InfinitySystem(k,family)
matrix,tags,*_=system.case(10,[],6);rows=matrix.tolist();Z=C.polyx(P.sub(B0_CODES,L0_CODES));y=C.monomial(0,1)
D=[];d2=[]
for N in system.N:
    S,_=C.frame(N);d=[C.scale(S[j],j) for j in range(1,5)];D.append(d)
    d2.append(C.add(C.mul(y,d[2]),C.scale(C.mul(Z,d[3]),3)))
for a,r in monomials(max(map(C.pole,d2))):
    if 3*a+10*r>21:
        row=[f[r][a] if a<len(f[r]) else 0 for f in d2]
        if any(row):rows.append(row);tags.append(['short_d2_bound11',a,r])
matrix=np.array(rows,dtype=np.uint32);B,piv,_=k.kernel(matrix);kappa=B[:,0]
Ds=[]
for row in B:
    d=[C.zero() for _ in range(4)]
    for c,old in zip(row,D):
        for j in range(4):d[j]=C.add(d[j],C.scale(old[j],int(c)))
    Ds.append(d)
q=[13,18,24]
for d in Ds:
    assert d[3][1:]==[[],[]]
    assert not d[3][0] or d[3][0]==P.scale(q,k.div(d[3][0][-1],q[-1]))
report={'scope':'necessary D(c) source slice only; v-independent, no actual source realization','homogeneous_dimension':len(B),'source_rank':len(piv),'kappa_functional':kappa.tolist(),'kappa_can_be_nonzero':bool(np.any(kappa)),'source_kernel':B.tolist(),'source_matrix':matrix.tolist(),'source_row_tags':tags,'D_basis_finite':Ds,'q':q,'P':C.P,'curve_Z':Z[0],'source_coefficient_field':'F25(alpha), alpha quartic(5,2,6,7,1)','seconds':time.time()-start}
(data/'m6_rational_root_source_input.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
print(json.dumps({a:report[a] for a in ['homogeneous_dimension','source_rank','kappa_can_be_nonzero','kappa_functional','seconds']}))
