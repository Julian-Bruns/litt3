#!/usr/bin/env sage
"""Exact descended Q^-1 effectivity test, using its horizontal gauge."""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--point',required=True)
parser.add_argument('--horizontal',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(30)
start=time.monotonic()
E,alpha,point,factor,annihilator,U,adj_norm,mumford_u,mumford_v=load(args.point)
E2,alpha2,horizontal,gauge,ratios,delta,mu,mv=load(args.horizontal)
assert E2==E and alpha2==alpha
Rx=U.parent()
x0=Rx.gen()
F=Rx.fraction_field()
x=F(x0)
A,B,C=1+4*alpha,2+4*alpha,E(-1)
H=A*x^5+B*x^4+C
zero=(F.zero(),F.zero())
def add(p,q):return (p[0]+q[0],p[1]+q[1])
def scale(p,z):return (p[0]*z,p[1]*z)
def mul(p,q):return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])
def inverse(p):
    norm=p[0]^2-H*p[1]^2
    return (p[0]/norm,-p[1]/norm)
def derivative(p):return (p[0].derivative(),p[1].derivative()+H.derivative()*p[1]/(2*H))
for f,g in annihilator:
    if g.gcd(U).degree()==0:
        sheet=(-f*g.inverse_mod(U))%U
        break
else:raise AssertionError('No affine sheet equation')
assert (Rx(H)-sheet^2)%U==0
affine_basis=[(x0^j,Rx.zero()) for j in range(6)]+[(Rx.zero(),x0^j) for j in range(4)]
conditions=matrix(E,6,10,lambda i,j:((affine_basis[j][0]+affine_basis[j][1]*sheet)%U)[i])
section_vectors=conditions.right_kernel().basis()
assert len(section_vectors)==4
sections=[]
for vector in section_vectors:
    sections.append(tuple(sum(vector[j]*affine_basis[j][i] for j in range(10)) for i in range(2)))
lambda_pair=mul(derivative(gauge),inverse(gauge))
images=[add(derivative(tuple(F(z) for z in p)),scale(mul(tuple(F(z) for z in p),lambda_pair),-1))
        for p in sections]
denominators=[lcm([p[i].denominator() for p in images]) for i in range(2)]
polynomial_images=[tuple(Rx(p[i]*denominators[i]) for i in range(2)) for p in images]
maximum_degrees=[max(int(p[i].degree()) for p in polynomial_images) for i in range(2)]
rows=[(i,j) for i in range(2) for j in range(maximum_degrees[i]+1)]
connection_matrix=matrix(E,len(rows),4,lambda r,c:polynomial_images[c][rows[r][0]][rows[r][1]])
kernel=connection_matrix.right_kernel()
dimension=int(kernel.dimension())
assert dimension in (0,1)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((E,conditions,section_vectors,sections,lambda_pair,connection_matrix,kernel.basis()),str(out/'effectivity.sobj'))
(out/'effectivity.txt').write_text('H0(F*Q^-1) section pairs = '+str(sections)+'\n'+
    'connection coefficient dg/g = '+str(lambda_pair)+'\n'+
    'horizontal kernel vectors = '+str(kernel.basis())+'\n')
summary={'scope':'exact descended Q^-1, not just F*Q^-1',
         'threads':1,'H0_FstarQ_inverse_dimension':4,
         'connection_matrix_rank':int(connection_matrix.rank()),
         'H0_descended_Q_inverse_dimension':dimension,
         'descended_Q_inverse_effective':dimension==1,
         'every_Q_inclusion_lifts_Fstar_O':dimension==0,
         'relative_Frobenius_convention':'coefficient field held fixed by connection; no unidentified tensor-fifth root',
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
