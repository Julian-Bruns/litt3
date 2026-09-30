"""Exploit unit triangular pivots in the new five-by-six infinity block.

The remaining two-by-three matrix controls a monic quintic obtainable
by constant linear combinations.  Its rank locus is NOT the actual
scale or common-cover locus.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);mode=sys.argv[2] if len(sys.argv)>2 else 'prepare';start=time.time()
data=load(str(root/'polynomial_multiplier_extended.sobj'));R=data['ring'];H,q=R.gens();K=R.base_ring()
M=data['matrix'];F=M.base_ring()
assert M.nrows()==5 and M.ncols()==6
pivots=[(4,5),(3,2),(2,1)]
columns=[];combos=[]
for j in [0,3,4]:
    col=vector(F,M.column(j));comb=vector(F,[int(i==j) for i in range(6)])
    for row,pivot in pivots:
        assert M[row,pivot]
        assert all(not M[r,pivot] for r in range(row+1,5))
        ratio=col[row]/M[row,pivot]
        col-=ratio*M.column(pivot)
        comb[pivot]-=ratio
    assert all(not col[r] for r in range(2,5))
    columns.append(col[:2]);combos.append(comb)
small=matrix(F,columns).transpose()
assert M*matrix(F,combos).transpose()==block_matrix([[small],[zero_matrix(F,3,3)]])
minors=[small.matrix_from_columns([i,j]).det() for i,j in [(0,1),(0,2),(1,2)]]
alpha=K.gen();beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    value=K.zero()
    for i in range(4):
        c=n%25;n//=25;value+=(K(c%5)+(c//5)*beta)*alpha^i
    return value
a0=sum(dec(c)*q^i for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
Psi=a0+H*q*(dec(299833)+dec(232505)*q)
units=[H,q,Psi,a0,q-1,q-dec(15383)]
def strip(f):
    for unit in units:
        while f:
            quotient,remainder=f.quo_rem(unit)
            if remainder:break
            f=quotient
    return f
for row,pivot in pivots:
    assert strip(M[row,pivot].numerator()).is_constant()
    assert strip(M[row,pivot].denominator()).is_constant()
equations=[strip(m.numerator()) for m in minors]
report={'scope':'rank degeneration of the infinity block only',
        'pivot_positions':[[int(r),int(c)] for r,c in pivots],'pivot_units_verified':True,
        'entry_numerator_degrees':[[list(map(int,v.numerator().degrees())) for v in row] for row in small.rows()],
        'equation_degrees':[list(map(int,e.degrees())) for e in equations],
        'equation_terms':[len(e.dict()) for e in equations],
        'seconds':time.time()-start}
save({'ring':R,'small_matrix':small,'combinations':combos,'minors':minors,
      'equations':equations,'chart':prod(units),'pivots':pivots},str(root/'polynomial_multiplier_rank_inputs'))
(root/'polynomial_multiplier_rank_inputs.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
if mode=='prepare':exit()
assert mode=='solve'
I=R.ideal(equations).saturation(R.ideal(prod(units)))[0]
gb=list(I.groebner_basis())
save({'ring':R,'basis':gb,'inputs':equations},str(root/'polynomial_multiplier_rank_locus'))
report['unit_ideal']=bool(R.one() in I)
report['basis_degrees']=[list(map(int,f.degrees())) for f in gb]
if not report['unit_ideal']:
    report['dimension']=int(I.dimension())
    if I.dimension()==0:report['length']=int(I.vector_space_dimension())
report['seconds']=time.time()-start
(root/'polynomial_multiplier_rank_locus.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
