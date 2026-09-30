"""Reconstruct the full degree84 coefficient system and exact affine reduction."""
import argparse
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from scripts.atlases.algebra.export_polynomial_macaulay import export_system

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('output',type=Path)
args=parser.parse_args()
k=GF(125,'alpha',modulus=PolynomialRing(GF(5),'z')([1,1,0,1]))
alpha=k.gen()
Z=PolynomialRing(k,'z'); z=Z.gen()
sep=z**5+(alpha+1)*z**4+(2*alpha**2-2)*z**3-2*alpha**2*z**2+(-2*alpha**2+alpha+1)*z+2*alpha**2+2*alpha-2
assert sep.is_irreducible()
K=GF(5**15,'a')
VK=PolynomialRing(K,'v'); vv=VK.gen()
alpha=(vv**3+vv+1).roots(multiplicities=False)[0]
beta=(vv**5+(alpha+1)*vv**4+(2*alpha**2-2)*vv**3-2*alpha**2*vv**2+(-2*alpha**2+alpha+1)*vv+2*alpha**2+2*alpha-2).roots(multiplicities=False)[0]
names=['loc']+['b%d'%i for i in range(14)]+['a%d'%i for i in range(18)]+['c%d'%i for i in range(6)]
R=PolynomialRing(K,names,order='degrevlex')
v=R.gens_dict()
U=PolynomialRing(R,'u'); u=U.gen()
F=prod(u-K(t) for t in [0,1,2,3,alpha])
A=u**18+sum(v['a%d'%i]*u**i for i in range(18))
B=-u**14+sum(v['b%d'%i]*u**i for i in range(14))
C=u**6+sum(v['c%d'%i]*u**i for i in range(6))
b1=beta**2+3*F[4]*beta+3*F[3]
b0=-F[2]+(F[4]+2*beta)*b1
P=2*u**3+beta*u**2+b1*u+b0
H=A*C
hor=F*H.derivative(2)+4*F.derivative()*H.derivative()+(3*F.derivative(2)-P)*H
scale=3*v['b13']+2*v['c5']
passport=scale*F*A**2-B**3-C**7
derivative=(F.derivative()*A+2*F*A.derivative())*C-2*F*A*C.derivative()+B**2
second_derivative=3*C*B.derivative()-2*B*C.derivative()+scale*A
parts=[hor,derivative,second_derivative]
parts.append(passport)
equations=[p for part in parts for p in list(part) if p]
equations.append(v['loc']*scale-1)
# In characteristic five, the second identity is 3*(BC)' + scale*A.
# The u^(5j+4) coefficients of a derivative vanish identically.
assert second_derivative == 3*(B*C).derivative()+scale*A
guard=equations[-1]
for i in (4,9,14):
    ai=v['a%d'%i]
    coefficient=second_derivative[i]
    assert coefficient == scale*ai and coefficient in equations
    assert v['loc']*coefficient-ai*guard == ai
    equations.append(ai)
print('EXACT_LOCALIZED_LINEAR_CONSEQUENCES', ['a4','a9','a14'],flush=True)

export_system(R,equations,args.output,c_degree=0,field_only=True,full_degree=1)
print('NATIVE_EQUATIONS',len(equations),'VARIABLES',R.ngens(),flush=True)
