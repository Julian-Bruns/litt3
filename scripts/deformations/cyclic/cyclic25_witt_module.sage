#!/usr/bin/env sage
"""Compressed universal unramified (Z/5)^2 diagnostic for the F625 pair.

First replay the audited cyclic5 script, then reuse its exact field,
Laurent arithmetic and AS classes. Only THREE Frobenius columns are
needed upstairs: tangent cohomology is free of rank three over the
deck group algebra. No new higher-Witt calculation is made.
"""
import itertools
from sage.repl.preparse import preparse
from pathlib import Path
import json
import time

source=Path('scripts/deformations/cyclic/cyclic5_witt_obstruction.sage')
ns=dict(globals())
exec(compile(preparse(source.read_text()),str(source),'exec'),ns)
started=time.monotonic()
k,t,z,LS,reduce0,coefficient=[ns[s] for s in ['k','t','z','LS','reduce0','coefficient']]
lc=ns['laurent_coefficient']
orders=[-3,-1,1]
shifts=[sum(cl[i]*z**[-3,-1][i] for i in range(2)) for cl in ns['fixed']]
rhs=[]
for shift in shifts:
    rem,fu=reduce0(shift**5-shift)
    assert rem.valuation()>=1
    rhs.append(fu)
indices=list(itertools.product(range(5),repeat=2))
position={ij:n for n,ij in enumerate(indices)}
local={}
for a,b in indices:
    local[a,b]=[(position[i,j],binomial(a,i)*binomial(b,j)*(-shifts[0])**(a-i)*(-shifts[1])**(b-j))
                for i in range(a+1) for j in range(b+1) if (i,j)!=(a,b)]


def reduce_vector(vec):
    vec=list(vec)
    for a,b in reversed(indices):
        n=position[a,b]
        rem,_=reduce0(vec[n])
        assert rem.precision_absolute()>3*(a+b)+2, ('precision',a,b,rem.precision_absolute())
        canonical=sum(lc(rem,e)*z**e for e in orders)
        tail=rem-canonical
        assert tail.valuation()>=2
        for m,entry in local[a,b]:
            vec[m]-=entry*tail
        vec[n]=canonical
    return vector(k,[lc(vec[n],e) for n in range(25) for e in orders])


# The three free generators are z^e w1^4 w2^4. Their deck translates
# span all 75 Cech classes. Delta^4(w_i^4)=4!=4, so the double norm
# sends each generator to z^e, with scalar 4*4=1.
PX=PolynomialRing(GF(5),'X');X=PX.gen()
polys=[X**4]
for i in range(4):
    polys.append(polys[-1](X+1)-polys[-1])
triangular=matrix(GF(5),5,5,lambda i,j:polys[j][i])
conversion=triangular.tensor_product(triangular).tensor_product(identity_matrix(GF(5),3))
assert conversion.is_invertible()
inverse=conversion.inverse().change_ring(k)
columns=[]
terms=[binomial(4,i)*binomial(4,j)*rhs[0]**(4-i)*rhs[1]**(4-j) for i,j in indices]
for e in orders:
    col=reduce_vector([coefficient*z**(5*e)*term for term in terms])
    columns.append(inverse*col)
    print(json.dumps(dict(stage='free_generator',exponent=int(e),seconds=float(time.monotonic()-started))),flush=True)

PR=PolynomialRing(k,['e1','e2']);e1,e2=PR.gens()
R=PR.quotient([e1**5,e2**5],names=['d1','d2']);d1,d2=R.gens()
matrixR=matrix(R,3,3,lambda i,j:sum(columns[j][3*position[a,b]+i]*d1**a*d2**b for a,b in indices))
constant=matrix(k,3,3,lambda i,j:matrixR[i,j].lift().constant_coefficient())
assert constant==ns['base']


def inverse_unit(f):
    c=f.lift().constant_coefficient()
    assert c
    nil=1-f/c
    return sum(nil**i for i in range(9))/c


for rows in itertools.combinations(range(3),2):
    for cols in itertools.combinations(range(3),2):
        if constant.matrix_from_rows_and_columns(rows,cols).det():
            pivotrows,pivotcols=list(rows),list(cols)
            break
    else:
        continue
    break
i=next(i for i in range(3) if i not in pivotrows)
j=next(j for j in range(3) if j not in pivotcols)
B=matrixR.matrix_from_rows_and_columns(pivotrows,pivotcols)
Binv=matrix(R,[[B[1,1],-B[0,1]],[-B[1,0],B[0,0]]])*inverse_unit(B.det())
assert B*Binv==identity_matrix(R,2)
relation=matrixR[i,j]-(matrix(R,1,2,[matrixR[i,c] for c in pivotcols])*Binv*matrix(R,2,1,[matrixR[r,j] for r in pivotrows]))[0,0]
poly=relation.lift()
assert poly
lowest=min(sum(m) for m in poly.dict())
assert lowest>=1
quadratic=sum(c*e1**a*e2**b for (a,b),c in poly.dict().items() if a+b==2)
discriminant=quadratic.monomial_coefficient(e1*e2)**2-4*quadratic.monomial_coefficient(e1**2)*quadratic.monomial_coefficient(e2**2)
assert lowest==2 and discriminant, 'The universal relation must have an ordinary node'
directions=[(1,c) for c in range(5)]+[(0,1)]
assert all(quadratic(k(a),k(b)) for a,b in directions), 'A rational tangent direction has exceptional contact'


def expand(col):
    answer=[k(0)]*75
    for i in range(3):
        for ab,c in col[i].lift().dict().items():
            answer[3*position[tuple(ab)]+i]=c
    return vector(k,answer)


full=matrix(k,[expand([matrixR[i,j]*d1**a*d2**b for i in range(3)])
               for a,b in indices for j in range(3)]).transpose()
source_defect=75-full.rank()
multiplication=matrix(k,[[lc0 for lc0 in [
    (relation*d1**a*d2**b).lift().monomial_coefficient(e1**c*e2**d)
    for c,d in indices]] for a,b in indices]).transpose()
assert source_defect==25-multiplication.rank()

PE=PolynomialRing(k,'e');e=PE.gen()
RE=PE.quotient(e**5,names='s');s=RE.gen()
cyclic_lengths=[]
for a,b in directions:
    value=sum(c*((1+s)**a-1)**ij[0]*((1+s)**b-1)**ij[1] for ij,c in poly.dict().items())
    vv=value.lift()
    length=int(vv.valuation()) if vv else 5
    cyclic_lengths.append(length)
assert cyclic_lengths==[c['defect'] for c in ns['receipt']['covers']]

encode=lambda c:[int(x) for x in ns['coordinates'](c)]
result=dict(status='PASS',source_genus=int(26),source_defect=int(source_defect),
    relation_lowest_degree=int(lowest),cyclic_lengths=cyclic_lengths,
    quadratic_discriminant=encode(discriminant),
    quadratic_discriminant_minpoly=[int(c) for c in discriminant.minpoly()],
    quadratic_direction_values=[encode(quadratic(k(a),k(b))) for a,b in directions],
    relation=[dict(exponent=[int(x) for x in ab],coefficient=encode(c)) for ab,c in poly.dict().items()],
    seconds=float(time.monotonic()-started),precision=int(ns['args'].precision),
    field=ns['receipt']['field_modulus'],parameter=ns['receipt']['parameter'])
Path('Research/computations/cyclic25_witt_module.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ['relation','field','parameter']}),flush=True)
