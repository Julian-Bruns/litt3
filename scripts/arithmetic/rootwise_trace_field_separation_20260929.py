#!/usr/bin/env python3
"""New small field-separation test; no old phase enumeration is replayed."""
import argparse,json
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix
p=argparse.ArgumentParser();p.add_argument('output',type=Path);args=p.parse_args()
F=GF(5);R=PolynomialRing(F,'b');b=R.gen();B=GF(25,'b',modulus=b*b-b-3);b=B.gen()
dec=lambda c:B(c%5)+B(c//5)*b
code=lambda c:int(B(c)[0])+5*int(B(c)[1])
R=PolynomialRing(B,'a');a=R.gen();E=B.extension(R([dec(c) for c in [5,2,6,7,1]]),'a');a=E.gen()
roots=[a**(25**i) for i in range(4)]
R=PolynomialRing(E,'x');x=R.gen()
P=R([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
A=R([dec(c) for c in [1,21,14,22,13]])
cc=R([dec(c) for c in [22,7,9,23]])
def expanded(M):return matrix(B,[[M[j,i].lift()[r] for i in range(4)] for j in range(M.nrows()) for r in range(4)])
def data(M):
    e=expanded(M);return {'rank_over_E':int(M.rank()),'rank_over_B_expanded':int(e.rank()),
        'matrix_over_B':[[code(c) for c in row] for row in e.rows()],
        'first_row_coefficient_determinant':code(e[:4,:].det())}
record={'scope':'exact new rootwise trace coefficient test','characters':{}}
for k in (1,2):
    weights0=[];weights1=[];linear=[]
    for i,alpha in enumerate(roots):
        lead=(3*A.derivative()(alpha)**3*P(alpha)**2/dec(13)**3)**pow(29,-1,5**8-1)
        aa=dec(13)*lead**4/A.derivative()(alpha)
        bb=(4*dec(13)*lead**3*cc(alpha)-A.derivative(2)(alpha)*aa*aa/2)/A.derivative()(alpha)
        relrho=P(roots[0])**((25**i-1)//3)
        weights0.append(aa/relrho**k)
        weights1.append(aa**2/relrho**k)
        linear.append(2*bb/aa**2-E(k)*P.derivative()(alpha)/(3*P(alpha)))
    M0=matrix(E,[[roots[i]**j*weights0[i] for i in range(4)] for j in range(3)])
    M1=matrix(E,[[(roots[i]**j*linear[i]+(j*roots[i]**(j-1) if j else 0))*weights1[i]
                  for i in range(4)] for j in range(3)])
    record['characters'][str(k)]={'constant':data(M0),'linear':data(M1)}
    print('CHARACTER',k,'CONSTANT',record['characters'][str(k)]['constant']['first_row_coefficient_determinant'],
          'LINEAR',record['characters'][str(k)]['linear']['first_row_coefficient_determinant'])
args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record,indent=2))
