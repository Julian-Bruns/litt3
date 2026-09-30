#!/usr/bin/env python3
"""Reconstruct the unique equivariant logarithmic differential at R-O.

Then solve its horizontal polynomial-section spaces and high-contact
subspaces; no enumeration of possible extra zero divisors is performed.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
from supported_one_sheet_jets import field_and_jets
p=argparse.ArgumentParser();p.add_argument('output',type=Path);args=p.parse_args()
args.output.mkdir(parents=True,exist_ok=True)
K,_,_,field,code=field_and_jets(1)
decode=lambda n:K([GF(5)((n//(5**i))%5) for i in range(8)])
alpha=decode(field['alpha']);p0=decode(field['p0']);beta=decode(field['beta'])
dec=lambda n:K(n%5)+K(n//5)*beta
R=PolynomialRing(K,'x');x=R.gen();den=x-alpha
P=R([dec(n) for n in [11,22,18,5,19,20,15,16,9,22,1]])
assert P(alpha)==p0
car=lambda f:R([f[5*j+4]**(5**7) for j in range(max(0,(f.degree()-4)//5+1))])
root=lambda a:a**(5**7)
def lin(vals):
    A=R(vals[:4]);B=R(vals[4:])
    AA=root(p0**-1)*car(B*P*den**4)-A
    BB=root(p0**-3)*car(A*P**3*den**4)-B
    return [AA[i] for i in range(4)]+[BB[i] for i in range(7)]+[A(alpha),B(alpha)]
def coords(vals):return [GF(5)(K(v)[i]) for v in vals for i in range(8)]
cols=[]
for j in range(11):
    for i in range(8):
        v=[K(0)]*11;v[j]=K.gen()**i;cols.append(coords(lin(v)))
M=matrix(GF(5),cols).transpose();rhs=vector(GF(5),coords([K(0)]*11+[K(1)/3,K(1)/3]))
assert M.rank()==88
sol=M.solve_right(rhs);vals=[sum((K(sol[j*8+i])*K.gen()**i for i in range(8)),K(0)) for j in range(11)]
assert lin(vals)==[K(0)]*11+[K(1)/3,K(1)/3]
A=R(vals[:4]);B=R(vals[4:]);Q=P/p0
record={'field':field,'A':[code(c) for c in A],'B':[code(c) for c in B],
        'cartier_matrix_shape':[M.nrows(),M.ncols()],'rank':int(M.rank()),'section_tests':[]}
print('CONNECTION',record,flush=True)
for n in range(19,105,5):
    mons=[(i,j) for j in range(3) for i in range(max(-1,(n-10*j)//3)+1)]
    def differential(col):
        i,j=col;g=[R(0)]*3;g[j]=x**i;U,V,W=g
        return [den*Q*U.derivative()-4*(Q*U/3+(B*W+A*V)*Q),
                den*(Q*V.derivative()+Q.derivative()*V/3)-4*(Q*V/3+B*U+A*W*Q),
                den*(Q*W.derivative()+2*Q.derivative()*W/3)-4*(Q*W/3+B*V+A*U)]
    ims=[differential(c) for c in mons];maxd=max(f.degree() for fs in ims for f in fs)
    L=matrix(K,[[fs[j][i] for j in range(3) for i in range(maxd+1)] for fs in ims]).transpose()
    ker=L.right_kernel().basis_matrix().transpose()
    # g uses v=y/rho0, so its jets at R are obtained from (P/p0)^(1/3).
    S=PolynomialRing(K,'t');t=S.gen();prec=60
    q=S(Q(t+alpha));power=pow(3,-1,5**3)
    v=(q**power)%(t**prec);assert ((v**3-q)%(t**prec))==0
    vv=(v*v)%(t**prec)
    local=[S(1),v,vv]
    jets=matrix(K,[[((t+alpha)**i*local[j])[k] for i,j in mons] for k in range(59)])
    dims={str(a):int(ker.ncols()-(jets[:a,:]*ker).rank()) for a in [4,9,14,19,24,29,53,58]}
    item={'pole_bound':n,'horizontal_dimension':int(ker.ncols()),'contact_dimensions':dims}
    if ker.ncols():item['basis']=[[code(c) for c in col] for col in ker.columns()];item['monomials']=mons
    record['section_tests'].append(item);print({k:v for k,v in item.items() if k not in ['basis','monomials']},flush=True)
    (args.output/'connection_and_sections.json').write_text(json.dumps(record,indent=2)+'\n')
print('PASS',flush=True)
