"""Reduce the new ACTUAL trace top block using its two unit pivots.

Only exact known coefficients are used; there is no scale-series cutoff.
The two remaining quartic leading coefficients describe a necessary
exceptional locus for this reduction, not an actual cover locus.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
data=load(str(root/'actual_derivative_topblock.sobj'))
R=data['ring'];H,w=R.gens();F=R.fraction_field();M=data['matrix']
# Rows ell^3,...,ell^7; columns 1,x,x^2,x^3,y.
assert M[4,0]==M[4,1]==M[4,2]==M[3,0]==0
assert len(M[2,0].numerator().dict())==len(M[3,1].numerator().dict())==1
vectors=[vector(F,[0,0,1,0,0]),vector(F,[0,0,0,M[4,4],-M[4,3]])]
for v in vectors:
    v[1]-=(M*v)[3]/M[3,1]
    v[0]-=(M*v)[2]/M[2,0]
    assert list(M*v)[2:]==[0,0,0]
small=M*matrix(F,vectors).transpose()
polys=[v.numerator() for v in small.row(1)]
out={'ring':R,'matrix':M,'combinations':vectors,'small':small,'quartic_leading':polys}
save(out,str(root/'actual_derivative_quartic_reduction'))
report={'scope':'two degree-at-most-four necessary traces',
 'leading_numerator_degrees':[list(map(int,p.degrees())) for p in polys],
 'leading_numerator_terms':[len(p.dict()) for p in polys],
 'leading_denominator_degrees':[list(map(int,v.denominator().degrees())) for v in small.row(1)],
 'seconds':time.time()-start}
(root/'actual_derivative_quartic_reduction.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
