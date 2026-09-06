#!/usr/bin/env sage
"""Exact14-variable normalized C3 quotient; Lambda is already a unit."""
from pathlib import Path
import sys
requested=list(sys.argv)
stem='normalized_oper'
sys.argv=['build','--build-only']
exec(compile(Path('scripts/fixed_x_dormant_opers.sage').read_text(),'fixed','exec'))
base_n0=2*Fpp*F+2*Fp**2+2*x**8*F
original_field=k
# C=t*Chat, A=t^2*Ahat, t=c4, lambda=t^3. Chat and Ahat are monic.
Q=PolynomialRing(k,names=[f'c{i}' for i in range(4)]+[f'a{i}' for i in range(10)],order='degrevlex')
S=PolynomialRing(Q,'x'); x=S.gen(); F=S([k(c) for c in F.list()])
Fp=F.derivative(); Fpp=Fp.derivative()
base=2*Fpp*F+2*Fp**2+2*x**8*F
Cs=x**4+sum(Q.gen(i)*x**i for i in range(4))
As=x**10+sum(Q.gen(4+i)*x**i for i in range(10))
def L(n,j):
    return F**2*n.derivative(2)+(4*j-4)*F*Fp*n.derivative()+(2*j-2)*F*Fpp*n+(2*j-2)*(2*j-3)*Fp**2*n
T,rem=(L(As,2)-base*As-3*F**2*Cs**2).quo_rem(F)
assert not rem
assert T.degree()<=17
print('T_degree',T.degree(),flush=True)
Bs,e2=T.quo_rem(As)
assert Bs.degree()<=7
N0=base+F*Bs
W=F*(Cs*F).derivative(2)-N0*Cs
assert W.degree()<=20
lam=2*W[20]
print('B_max_parameter_degree',max(c.total_degree() for c in Bs.list()),flush=True)
print('W_degree',W.degree(),'lambda',lam,flush=True)
print('W_x21',W[21],flush=True)
e1=W-3*lam*As**2
e0,rem=(L(N0,0)-3*N0**2).quo_rem(F**2)
assert not rem
e0-=lam*Cs*As
assert L(N0,0)-3*(N0**2+2*lam*F**2*Cs*As)==F**2*e0
assert L(Cs*F,1)-3*(2*N0*Cs*F+lam*F*As**2)==F*e1
assert L(As,2)-3*(2*N0*As+F**2*Cs**2)==F*e2
coefs=list(dict.fromkeys(c for e in [e0,e1,e2] for c in e.list() if c))
# normalized_oper_lambda_unit.sage certifies that no inverse is needed.
print('quotient_vars',Q.ngens(),'equations',len(coefs),'max_degree',max(c.total_degree() for c in coefs),flush=True)
print('total_terms',sum(len(c.dict()) for c in coefs),flush=True)
save((Q,coefs,As,Cs,Bs,lam),'Research/computations/'+stem+'_quotient.sobj')
if '--msolve-input' in requested:
    generators=list(Q.ideal(coefs).interreduced_basis())
    Prime=PolynomialRing(GF(5),names=list(Q.variable_names())+['zeta'],order='degrevlex')
    output=[]
    for eq in generators:
        data={}
        for exponent,c in eq.dict().items():
            for j,ci in enumerate(c.polynomial().list()):
                if ci: data[tuple(exponent)+(j,)]=ci
        output.append(Prime(data))
    zz=Prime.gens()[-1]
    output.append(zz**2+4*zz+2)
    destination=Path('Research/computations')/(stem+'_msolve.in')
    destination.write_text(','.join(Prime.variable_names())+'\n5\n'+
        ',\n'.join(str(f).replace('**','^') for f in output)+'\n')
    print('Saved normalized msolve input',len(output),'equations',flush=True)
