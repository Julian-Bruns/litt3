import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
"""Bounded exact necessary-system test for the remaining (2,3,7) maps.

This is not a cover certificate.  A nonunit ideal may contain degeneracies.
No finite-field point search is substituted for geometric emptiness.
"""
import argparse
import time
from cysignals.alarm import alarm, cancel_alarm

parser=argparse.ArgumentParser()
parser.add_argument('--seconds',type=int,default=30)
parser.add_argument('--method',default='libsingular:slimgb')
parser.add_argument('--degree-bound',type=int,default=0)
parser.add_argument('--protocol',action='store_true')
parser.add_argument('--quadratic-only',action='store_true')
parser.add_argument('--export')
parser.add_argument('--field-only',action='store_true',help='Export coefficient-field data without the expanded matrix')
parser.add_argument('--c-degree',type=int,default=3)
parser.add_argument('--full-degree',type=int,default=1)
parser.add_argument('--mixed-linear-c-degree',type=int,default=0)
parser.add_argument('--exact-derivative-reduction',action='store_true',
                    help='Add three localized consequences, with exact input-ideal identities')
parser.add_argument('--diagnostics-only',action='store_true')
args=parser.parse_args()
started=time.monotonic()
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
if not args.quadratic_only:
    parts.append(passport)
equations=[p for part in parts for p in list(part) if p]
equations.append(v['loc']*scale-1)
if args.exact_derivative_reduction:
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
if args.diagnostics_only:
    linear=[p for p in equations if p.total_degree()==1]
    linear_basis=list(R.ideal(linear).groebner_basis())
    substitutions={g.lm().variables()[0]:g.lm().variables()[0]-g/g.lc()
                   for g in linear_basis}
    assert all(not set(f.variables()).intersection(substitutions)
               for f in substitutions.values())
    reduced=[f.subs(substitutions) for f in equations]
    reduced=[f for f in reduced if f]
    print('DIAGNOSTIC_REDUCED_VARIABLES',R.ngens()-len(substitutions),
          'EQUATIONS',len(set(reduced)),
          'TERMS',sum(f.number_of_terms() for f in set(reduced)),
          'ELIMINATED',list(map(str,substitutions)),flush=True)
    print('TOTAL_SECONDS',round(time.monotonic()-started,3),flush=True)
    raise SystemExit(int(0))
if args.export:
    from scripts.atlases.algebra.export_polynomial_macaulay import export_system
    export_system(R,equations,args.export,args.c_degree,field_only=args.field_only,
                  full_degree=args.full_degree,
                  mixed_linear_c_degree=args.mixed_linear_c_degree)
    raise SystemExit(int(0))
print('BUILD_SECONDS',round(time.monotonic()-started,3),flush=True)
print('VARIABLES',R.ngens(),'EQUATIONS',len(equations),'DEGREES',sorted(set(f.total_degree() for f in equations)),flush=True)
print('TERM_COUNTS',min(f.number_of_terms() for f in equations),max(f.number_of_terms() for f in equations),sum(f.number_of_terms() for f in equations),flush=True)
I=R.ideal(equations)
linear=[p for p in equations if p.total_degree()==1]
print('LINEAR_INPUTS',len(linear),flush=True)
alarm(args.seconds)
try:
    options={'algorithm':args.method,'prot':args.protocol}
    if args.degree_bound:
        options['deg_bound']=args.degree_bound
    basis=I.groebner_basis(**options)
    print('BASIS_LENGTH',len(basis),'UNIT',basis==[R.one()],flush=True)
    print('BASIS_DEGREES',sorted(set(f.total_degree() for f in basis)),flush=True)
except KeyboardInterrupt:
    print('TIME_LIMIT_INCONCLUSIVE',args.seconds,flush=True)
finally:
    cancel_alarm()
print('TOTAL_SECONDS',round(time.monotonic()-started,3),flush=True)
