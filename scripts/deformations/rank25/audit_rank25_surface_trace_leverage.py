"""Check filtered fourth solves and conditional trace-support leverage."""
import json
from pathlib import Path
import zipfile
from sage.all import GF, PolynomialRing, matrix, vector

root=Path(__file__).resolve().parents[3]
P=PolynomialRing(GF(5),'H');H=P.gen()
K=GF(625,'t',modulus=H**4+4*H**3+H**2+4*H+3);t=K.gen()
def elem(c):return sum(K(c//5**i%5)*t**i for i in range(4))
def tensor(d):
    size=1
    for n in d['shape']:size*=n
    flat=[K(0)]*size
    for i,c in d['nonzero']:flat[i]=elem(c)
    return matrix(K,*d['shape'],flat) if len(d['shape'])==2 else vector(K,flat)
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_surface_fifth_inputs.zip') as z:
    data=json.loads(z.read('surface.json'))
M=tensor(data['matrix']);degrees=[i//15+(i//3)%5 for i in range(75)]
table=[];low_last_sector=None
for a,b,raw in data['normal4']:
    v=tensor(raw)
    for bound in range(9):
        indices=[i for i,d in enumerate(degrees) if d<=bound]
        restricted=M.matrix_from_columns(indices)
        if restricted.rank()==restricted.augment(v).rank():break
    y=restricted.solve_right(v)
    assert restricted*y==v
    if (a,b)==(50,0):
        full=vector(K,75)
        for j,c in zip(indices,y):full[j]=c**125
        assert M*vector(K,[c**5 for c in full])==v
        encode=lambda c:sum(int(c.polynomial()[i])*5**i for i in range(4))
        low_last_sector={'shape':[75], 'nonzero':[[i,encode(c)] for i,c in enumerate(full) if c]}
    table.append({'normal_exponent':[a,b], 'fourth_digit_exponent':[a//5,b//5],
                  'minimal_source_AS_degree':bound})

E=GF(5**8,'h',modulus=H**8+4*H**6+H**4+4*H**2+3);h=E.gen();tt=h*h
lam=2+4*h*h+h**3+3*h**4+2*h**5+2*h**6+3*h**7
r=3+2*tt+2*tt**2+2*tt**3
x=[E(1),r**50,lam**50]
assert len(set(x))==3 and all(x)
# If C=a*s^25*lambda^50+b*s^25+c*lambda^50+d,
# the three proved trace-zero evaluations determine b,c,d exactly.
rows=matrix(E,[[z**-1,z,E(1)] for z in x])
assert rows.det()!=0
a=3+4*tt**2
solution=rows.solve_right(vector(E,[-a]*3))
assert solution==vector(E,[0,0,-a])
result={'status':'PASS finite leverage; proposed trace support remains unproved',
        'filtered_fourth_solves':table,
        'conditional_support':['1','s^25','lambda^50','s^25*lambda^50'],
        'known_mixed_cubic_coefficient':[3,0,4,0],
        'optional_replacement_fourth_digit_10_0':low_last_sector,
        'three_trace_zero_parameters':'s=lambda^-2; lambda=1, 3+2t+2t^2+2t^3, and the audited quadratic root',
        'evaluation_matrix_invertible':True,
        'conditional_result':'C=(3+4t^2)*(lambda^2*s-1)^25',
        'warning':'This does not prove the support bound, which must control divided integral carries.'}
(root/'Research/computations/rank25_surface_trace_leverage.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
