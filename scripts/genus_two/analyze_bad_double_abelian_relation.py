#!/usr/bin/env python3
"""Cross-check31 quotients and determine the transverse quartic radical jet."""
import argparse,hashlib,itertools,json
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('universal',type=Path);p.add_argument('cyclic',type=Path)
p.add_argument('--output',type=Path)
args=p.parse_args();raw=args.universal.read_bytes();data=json.loads(raw);cyclic=json.loads(args.cyclic.read_text())
assert data['status']=='complete' and cyclic['status']=='complete'
assert data['field_modulus']==cyclic['field_modulus'] and data['parameter']==cyclic['parameter']
P=PolynomialRing(GF(5),'a');k=GF(5**(len(data['field_modulus'])-1),'a',modulus=P(data['field_modulus']),impl='pari_ffelt');a=k.gen()
decode=lambda c:sum(k(x)*a**i for i,x in enumerate(c))
encode=lambda c:[int(x) for x in k(c).polynomial().list()]
R=PolynomialRing(k,['x','y','z']);x,y,z=R.gens()
f=R({tuple(t['exponent']):decode(t['coefficient']) for t in data['relation']})
P1=PolynomialRing(k,'s');s=P1.gen()
for rec in cyclic['covers']:
    aa,bb,cc=rec['coordinates']
    val=P1(f((1+s)**aa-1,(1+s)**bb-1,(1+s)**cc-1))%s**3
    assert [val[i] for i in range(3)]==[decode(c) for c in rec['schur_coefficients'][:3]],rec['number']
H=matrix(k,3,3,lambda i,j:f.derivative(R.gen(i)).derivative(R.gen(j))(0,0,0)/2,implementation='generic')
assert H.rank()==2 and H[0,2]==H[1,2]==0 and H[1,1] and H[2,2]
v=H.right_kernel().basis()[0];v=v/v[0];assert v[2]==0
lam=v[1]
transformed=f(x,y+lam*x,z)
trunc=lambda f,n:R({e:c for e,c in f.dict().items() if sum(e)<=n})
F4=trunc(transformed,4)
u=R.zero();vv=R.zero()
for j in (2,3):
    cu=F4.derivative(y)(x,u,vv).monomial_coefficient(x**j)
    cv=F4.derivative(z)(x,u,vv).monomial_coefficient(x**j)
    u-=cu/(2*H[1,1])*x**j;vv-=cv/(2*H[2,2])*x**j
assert trunc(F4.derivative(y)(x,u,vv),3)==0
assert trunc(F4.derivative(z)(x,u,vv),3)==0
g=trunc(F4(x,u,vv),4)
assert not any(g.monomial_coefficient(x**j) for j in range(3))
# This125-dimensional multiplication rank is independent of the750-column
# source matrix; the six-column Schur construction identifies its cokernel.
indices=list(itertools.product(range(5),repeat=3));pos={e:i for i,e in enumerate(indices)}
cols=[]
for e in indices:
    col=[k.zero()]*125
    for m,c in f.dict().items():
        out=tuple(m[i]+e[i] for i in range(3))
        if all(v<5 for v in out):col[pos[out]]+=c
    cols.append(col)
rank=matrix(k,cols,implementation='generic').rank()
result=dict(status='PASS',universal_sha256=hashlib.sha256(raw).hexdigest(),
    all31_quadratic_restrictions_match=True,quadratic_rank=2,
    radical=[encode(c) for c in v],
    transverse_graph_y=[[list(e),encode(c)] for e,c in u.dict().items()],
    transverse_graph_z=[[list(e),encode(c)] for e,c in vv.dict().items()],
    corrected_radical_cubic=encode(g.monomial_coefficient(x**3)),
    corrected_radical_quartic=encode(g.monomial_coefficient(x**4)),
    elementary_abelian_defect=125-int(rank),
    scope='Actual elementary-abelian module and finite4-jet; uniform parameter/formal assertion requires proof')
print(json.dumps(result,indent=2))
if args.output:args.output.write_text(json.dumps(result,indent=2)+'\n')
