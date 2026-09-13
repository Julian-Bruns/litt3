"""Combine actual representative fifth residuals using Frobenius and marked sign.

Requires completed original-frame audits at both octic representatives.
The result is a finite-etale Bezout certificate, not interpolation of a
universal fifth cochain. Run with sage -python.
"""
import json
from pathlib import Path
import sys
import zipfile
from sage.all import GF, PolynomialRing, matrix, vector

root=Path(__file__).resolve().parents[3]
data_root=Path('/Users/julian/Documents/litt3-computation-data')
octic=Path(sys.argv[1])
P=PolynomialRing(GF(5),'H');H=P.gen();K0=GF(625,'t',modulus=H**4+4*H**3+H**2+4*H+3);t=K0.gen()
R=PolynomialRing(K0,'X');X=R.gen()
def code(c):
    a=list(K0(c).polynomial());return sum(int(v)*5**i for i,v in enumerate(a))
def elem(c):return sum(K0((c//5**i)%5)*t**i for i in range(4))
def serialize(poly):return [code(c) for c in poly.list()]
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_surface_fifth_inputs.zip') as z:data=json.loads(z.read('surface.json'))
G=R(list(map(elem,data['known_curve_G']))).monic()
dual=data['dual'];flat=[0]*(9*75)
for i,c in dual['nonzero']:flat[i]=c
signs=[]
for row in range(9):
    parity={sum(divmod(i//3,5))%2 for i,c in enumerate(flat[row*75:(row+1)*75]) if c}
    assert len(parity)==1
    signs.append(-1 if parity=={1} else 1)
assert signs==[1,1,1,-1,-1,1,1,-1,-1]
# B is even in lambda, hence both final quotient components are even.
for a,b,tensor in data['relative_J']:
    if b%2:
        vals=dict(tensor['nonzero'])
        assert all(vals.get(i*9+j,0)==0 for i in (5,6) for j in (7,8))

jobs=[
    data_root/'rank25-one-parameter-returned-20260912-hsze3x/root_plus',
    data_root/'rank25-quadratic-local-20260912-v2/quadratic_0',
    octic/'octic_0',octic/'octic_1']
pieces=[]
for index,path in enumerate(jobs):
    if index==0:
        lam0=3+2*t+2*t*t+2*t**3
        fac=X-lam0;values=[R(4*t+2*t*t+2*t**3),R(3+4*t*t+4*t**3)]
        label='base-field root, already independently audited'
    else:
        receipt=json.loads((path/'independent_fifth_audit_4200_0.json').read_text())
        assert receipt['rank_J']==5 and receipt['rank_augmented']==6
        assert not any(receipt['residuals'][0]) and not any(receipt['residuals'][1])
        parameter=json.loads((path/'parameters.json').read_text());degree=receipt['coefficient_degree'];stride=degree//4
        modulus=H**degree+4*H**(3*stride)+H**(2*stride)+4*H**stride+3
        K=GF(5**degree,'h',modulus=modulus);h=K.gen();tt=h**stride
        def large(a):return sum(K(c)*h**i for i,c in enumerate(a))
        lam=large(parameter['lambda']);d=degree//4
        cs=parameter.get('factor',parameter.get('factor_codes'));fac=R(list(map(elem,cs)))
        def coords(v):
            cs=list(v.polynomial())
            return vector(GF(5),cs+[0]*(degree-len(cs)))
        cols=[coords(tt**i*lam**j) for j in range(d) for i in range(4)]
        basis=matrix(GF(5),cols).transpose();assert basis.rank()==degree
        values=[]
        for residual in receipt['residuals'][2:]:
            v=large(residual);sol=basis.solve_right(coords(v))
            poly=R([sum(K0(sol[4*j+i])*t**i for i in range(4)) for j in range(d)])
            check=sum(sum(K(int(c))*tt**i for i,c in enumerate(a.polynomial()))*lam**j for j,a in enumerate(poly))
            assert check==v
            values.append(poly)
        label=str(path)
    pieces.append((fac,values,label))
    opposite=R(fac(-X)).monic()
    if opposite!=fac:
        pieces.append((opposite,[R(p(-X)) for p in values],label+'; marked sign'))
    else:
        assert all(p(-X)==p for p in values),'marked evenness failed on self-opposite orbit'
assert len(pieces)==7
prod=R(1)
for f,_,_ in pieces:prod*=f
assert prod==G
remainders=[]
for j in range(2):
    answer=R(0)
    for f,values,_ in pieces:
        other=G//f;answer+=(other*other.inverse_mod(f)*values[j])
    answer%=G
    assert answer(-X)==answer
    assert all(answer%f==values[j] for f,values,_ in pieces)
    remainders.append(answer)
for c in range(625):
    combination=remainders[0]+elem(c)*remainders[1]
    gcd,a,b=G.xgcd(combination)
    if gcd==1:break
else:raise AssertionError('joint surviving root: cannot certify exclusion')
assert a*G+b*combination==1
result={'status':'PASS complete one-parameter fifth-lift exclusion',
    'scope':'all geometric lambda!=0 and every compatible fourth choice on s=lambda^-2',
    'method':'actual representatives, F625 Frobenius orbits, marked evenness, then finite-etale CRT',
    'root_count':30,'dual_signs':signs,'G_monic':serialize(G),
    'residual_polynomials_mod_G':[serialize(p) for p in remainders],
    'separating_combination_coefficient':c,'separating_polynomial':serialize(combination),
    'bezout_G':serialize(a),'bezout_separator':serialize(b),
    'pieces':[{'factor':serialize(f),'residuals':[serialize(p) for p in ps],'evidence':label} for f,ps,label in pieces]}
(root/'Research/computations/rank25_one_parameter_full_exclusion.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:result[k] for k in ['status','root_count','separating_combination_coefficient','residual_polynomials_mod_G']},indent=2))
