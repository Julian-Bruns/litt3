#!/usr/bin/env sage
"""Exact seven-point incidence in the descended trigonal net pencil.

Tests one fixed kernel witness, not a family or a realization of its
original finite source. Uses the original-net necessary support lemma.
"""
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
assert annihilator[0][1]==0
assert annihilator[0][0].monic()==U
assert adj_norm.monic()==U
affine_basis=[(x0^j,Rx.zero()) for j in range(11)]+[(Rx.zero(),x0^j) for j in range(9)]
conditions=matrix(E,6,20,lambda i,j:((affine_basis[j][0]+affine_basis[j][1]*sheet)%U)[i])
section_vectors=conditions.right_kernel().basis()
assert len(section_vectors)==14
sections=[tuple(sum(vector[j]*affine_basis[j][i] for j in range(20)) for i in range(2))
          for vector in section_vectors]
lambda_pair=mul(derivative(gauge),inverse(gauge))
images=[add(derivative(tuple(F(z) for z in p)),scale(mul(tuple(F(z) for z in p),lambda_pair),-1))
        for p in sections]
denominators=[lcm([p[i].denominator() for p in images]) for i in range(2)]
polynomial_images=[tuple(Rx(p[i]*denominators[i]) for i in range(2)) for p in images]
maximum_degrees=[max(int(p[i].degree()) for p in polynomial_images) for i in range(2)]
rows=[(i,j) for i in range(2) for j in range(maximum_degrees[i]+1)]
connection_matrix=matrix(E,len(rows),14,lambda r,c:polynomial_images[c][rows[r][0]][rows[r][1]])
kernel=connection_matrix.right_kernel()
assert kernel.dimension()==2
flat_sections=[tuple(sum(vector[j]*sections[j][i] for j in range(14)) for i in range(2))
               for vector in kernel.basis()]
f0,f1=flat_sections
assert add(mul(derivative(f1),f0),scale(mul(f1,derivative(f0)),-1))==zero
# R_Q finite part is the hyperelliptic conjugate of D.
image0=(f0[0]-f0[1]*sheet)%U
image1=(f1[0]-f1[1]*sheet)%U
assert U.gcd(image0).gcd(image1).degree()==0
finite_infinity_count=int(U.gcd(image0).degree())
Ry=PolynomialRing(E,'y')
y=Ry.gen()
Rxy=PolynomialRing(Ry,'x')
xx=Rxy.gen()
UU=Rxy(U.list())
image_relation=Rxy(image0.list())*y-Rxy(image1.list())
image_polynomial=Ry(UU.resultant(image_relation))
assert image_polynomial
image_polynomial=image_polynomial.monic()
assert image_polynomial.degree()==6-finite_infinity_count
finite_images_simple=image_polynomial.gcd(image_polynomial.derivative()).degree()==0
# At infinity the line frame eta^5/u has order21. Only x^8w has
# pole21 in the permitted basis, so no Laurent expansion is needed.
p_image0=E.gen()*f0[1][8]
p_image1=E.gen()*f1[1][8]
assert p_image0 or p_image1
if p_image0:
    p_value=p_image1/p_image0
    p_collision=image_polynomial(p_value)==0
else:
    p_value=None
    p_collision=finite_infinity_count!=0
all_distinct=finite_images_simple and finite_infinity_count<=1 and not p_collision
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((E,conditions,sections,connection_matrix,kernel.basis(),flat_sections,
      image0,image1,image_polynomial,p_image0,p_image1),str(out/'net_incidence.sobj'))
(out/'net_incidence.txt').write_text('flat pencil section pairs = '+str(flat_sections)+'\n'+
    'image0 modulo U = '+str(image0)+'\nimage1 modulo U = '+str(image1)+'\n'+
    'finite image polynomial = '+str(image_polynomial)+'\n'+
    'P projective image = '+str((p_image0,p_image1))+'\n')
summary={'scope':'fixed saturated degree-one Cartier witness under actual-net support assumptions',
         'threads':1,'H0_Fstar_omegaQ_inverse_dimension':14,
         'H0_descended_omegaQ_inverse_dimension':2,
         'pencil_ratio_is_horizontal':'PASS',
         'finite_adjunction_zero_count':6,
         'finite_zeros_mapping_to_infinity':finite_infinity_count,
         'finite_image_polynomial_degree':int(image_polynomial.degree()),
         'finite_image_polynomial_squarefree':bool(finite_images_simple),
         'P_collides_with_finite_image':bool(p_collision),
         'all_seven_adjunction_images_distinct':bool(all_distinct),
         'ell_q1_zero_source_excluded':bool(all_distinct),
         'ell_q1_nonzero_source_excluded_by_ineffectivity':True,
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
