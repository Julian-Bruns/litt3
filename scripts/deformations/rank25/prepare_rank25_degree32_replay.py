"""Prepare degree-eight-over-k0 root representatives for the same geometric engine.

Run with sage -python. The coefficient ring is W5(F5^32), h^8=t.
"""
import json
from pathlib import Path
import shutil
import sys
from sage.all import GF, PolynomialRing

dest=Path(sys.argv[1]);assert not dest.exists();dest.mkdir()
source=Path('/Users/julian/Documents/litt3-computation-data/rank25-quadratic-local-20260912-v2')
shutil.copytree(source/'reconstruction',dest/'reconstruction',ignore=shutil.ignore_patterns('__pycache__'))
shutil.copytree(source/'supplied',dest/'supplied')
path=dest/'reconstruction/witt.py';text=path.read_text()
assert text.count('DEG=8')==1
text=text.replace('DEG=8','DEG=32')
text=text.replace('Q=np.array([3,0,4,0,1,0,4,0,1],dtype=np.int64)',
    'STRIDE=DEG//4\nQ=np.zeros(DEG+1,dtype=np.int64);Q[::STRIDE]=[3,4,1,4,1]')
text=text.replace('a[0:2*len(x):2]=x','a[0:STRIDE*len(x):STRIDE]=x')
text=text.replace('out[...,::2]=a','out[...,::STRIDE]=a')
assert '0:2*len(x):2' not in text and 'out[...,::2]' not in text
path.write_text(text)
helper=Path(__file__).resolve().parent/'rank25_adaptive_as_convolution.py'
shutil.copy2(helper,dest/'reconstruction'/helper.name)
path=dest/'reconstruction/as25.py';text=path.read_text()
text=text.replace('class AS:',
    'from rank25_adaptive_as_convolution import adaptive_dense_product\n'
    'dense_product_unoptimized=dense_product\n'
    'def dense_product(a,b,precision):\n'
    ' return adaptive_dense_product(globals(),dense_product_unoptimized,a,b,precision)\n\n'
    'class AS:')
path.write_text(text)
P=PolynomialRing(GF(5),'X');X=P.gen()
modulus=X**32+4*X**24+X**16+4*X**8+3
assert modulus.is_irreducible()
K=GF(5**32,'h',modulus=modulus);h=K.gen();t=h**8
assert t**4+4*t**3+t*t+4*t+3==0
R=PolynomialRing(K,'L');L=R.gen()
def coef(n):return sum(K((n//5**i)%5)*t**i for i in range(4))
def serial(v):
    a=list(v.polynomial());return [int(x) for x in a]+[0]*(32-len(a))
G=(4+3*t+t*t+4*t**3)+(3+3*t+2*t*t+3*t**3)*L**16+(t+2*t*t+t**3)*L**20+(1+2*t+4*t*t+2*t**3)*L**30
factors=[[392,146,215,270,215,116,231,378,1],
         [468,0,536,0,383,0,143,0,1]]
points=[]
for i,cs in enumerate(factors):
    f=R([coef(c) for c in cs]);roots=f.roots(multiplicities=False)
    assert len(roots)==8
    lam=roots[0];q=lam**5
    assert G(lam)==0
    assert lam**(625**8)==lam and lam**(625**4)!=lam
    x=[2+t+3*t*t+q**-2,(4+3*t+3*t*t+t**3)*q,(2+2*t+3*t*t+4*t**3)*q,
       3+3*t**3,3*t+t*t+4*t**3,(3+t+t*t+2*t**3)*q,q,K(0),K(0)]
    out=dest/f'octic_{i}';out.mkdir()
    point={'factor_codes':cs,'lambda':serial(lam),'x':[serial(v) for v in x]}
    (out/'parameters.json').write_text(json.dumps(point,indent=2)+'\n')
    points.append(point)
receipt={'status':'PASS exact field/root preparation only','degree_over_F5':32,
         'embedding':'t=h^8','modulus':str(modulus),'points':points}
(dest/'preparation.json').write_text(json.dumps(receipt,indent=2)+'\n')
print('PASS: two representative degree-eight factors, exact roots and curve parameters; t=h^8.')
