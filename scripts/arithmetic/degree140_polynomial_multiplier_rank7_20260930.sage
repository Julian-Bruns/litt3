"""Add one column to the saved infinity-block rank calculation.

This is only the degeneracy of the top five scale coefficients, not the
actual scale locus.  Reuse the completed six-column calculation.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);mode=sys.argv[2] if len(sys.argv)>2 else 'prepare';start=time.time()
data=load(str(root/'polynomial_multiplier_extended7.sobj'))
old=load(str(root/'polynomial_multiplier_rank_inputs.sobj'))
R=data['ring'];M=data['matrix'];F=M.base_ring()
col=vector(F,M.column(6));comb=vector(F,[0,0,0,0,0,0,1])
for row,pivot in old['pivots']:
    ratio=col[row]/M[row,pivot]
    col-=ratio*M.column(pivot);comb[pivot]-=ratio
assert all(not col[r] for r in range(2,5))
small=old['small_matrix'].augment(matrix(F,2,1,list(col[:2])))
combinations=[vector(F,list(c)+[0]) for c in old['combinations']]+[comb]
assert M*matrix(F,combinations).transpose()==block_matrix([[small],[zero_matrix(F,3,4)]])
H,q=R.gens();K=R.base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    ans=K.zero()
    for i in range(4):
        c=n%25;n//=25;ans+=(K(c%5)+(c//5)*beta)*alpha^i
    return ans
a0=sum(dec(c)*q^i for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
Psi=a0+H*q*(dec(299833)+dec(232505)*q)
units=[H,q,Psi,a0,q-1,q-dec(15383)]
def strip(f):
    for u in units:
        while f:
            quotient,remainder=f.quo_rem(u)
            if remainder:break
            f=quotient
    return f
new_minors=[small.matrix_from_columns([i,3]).det() for i in range(3)]
new_eq=[strip(m.numerator()) for m in new_minors]
equations=old['equations']+new_eq
report={'scope':'top-coefficient rank only, not actual scales or covers',
        'shape':[int(2),int(4)], 'equation_degrees':[list(map(int,e.degrees())) for e in equations],
        'equation_terms':[len(e.dict()) for e in equations],
        'new_column_combination_checked':True,'seconds':time.time()-start}
save({'ring':R,'small_matrix':small,'combinations':combinations,
      'equations':equations,'chart':old['chart'],'pivots':old['pivots']},
     str(root/'polynomial_multiplier_rank7_inputs'))
(root/'polynomial_multiplier_rank7_inputs.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
if mode=='prepare':exit()
assert mode=='solve'
I=R.ideal(equations).saturation(R.ideal(old['chart']))[0]
gb=list(I.groebner_basis())
save({'ring':R,'basis':gb,'inputs':equations},str(root/'polynomial_multiplier_rank7_locus'))
report['unit_ideal']=bool(R.one() in I)
report['basis_degrees']=[list(map(int,f.degrees())) for f in gb]
if not report['unit_ideal']:
    report['dimension']=int(I.dimension())
    if I.dimension()==0:report['length']=int(I.vector_space_dimension())
report['seconds']=time.time()-start
(root/'polynomial_multiplier_rank7_locus.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
