import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
"""Small symbolic cofactor diagnostic, not an emptiness certificate.

Use the degree-four horizontal basis and the exact derivative consequence
A_4=A_9=A_14=0. No general-position hypothesis is silently imposed: the
geometric argument justifying a nonzero leading cofactor is separate.
"""
import itertools
import time
import argparse
import hashlib

parser=argparse.ArgumentParser()
parser.add_argument('--system-seconds',type=int,default=0)
parser.add_argument('--system-diagnostics',action='store_true')
parser.add_argument('--omit-passport',action='store_true')
parser.add_argument('--triangular-b',action='store_true',
                    help='Eliminate eleven B coefficients using constant-unit derivative pivots')
parser.add_argument('--b-pivots',type=int,default=11)
parser.add_argument('--substitution',choices=['generic','sparse'],default='generic')
parser.add_argument('--construction-seconds',type=int,default=60)
parser.add_argument('--audit-generic',action='store_true')
args=parser.parse_args()

started=time.monotonic()
K=GF(5**15,'a')
U0=PolynomialRing(K,'u'); u0=U0.gen()
alpha=(u0**3+u0+1).roots(multiplicities=False)[0]
beta=(u0**5+(alpha+1)*u0**4+(2*alpha**2-2)*u0**3-2*alpha**2*u0**2+
      (-2*alpha**2+alpha+1)*u0+2*alpha**2+2*alpha-2).roots(multiplicities=False)[0]
F0=prod(u0-t for t in [K(0),K(1),K(2),K(3),alpha])
b1=beta**2+3*F0[4]*beta+3*F0[3]
b0=-F0[2]+(F0[4]+2*beta)*b1
P0=2*u0**3+beta*u0**2+b1*u0+b0
def ode0(h):
    return F0*h.derivative(2)+4*F0.derivative()*h.derivative()+(3*F0.derivative(2)-P0)*h
columns=[ode0(u0**j) for j in range(5)]
M0=matrix(K,8,5,lambda i,j:columns[j][i],implementation='generic')
basis=M0.right_kernel().basis()
assert len(basis)==2
hs=[sum(v[j]*u0**j for j in range(5)) for v in basis]
assert all(ode0(h)==0 for h in hs)
wr=hs[0]*hs[1].derivative()-hs[0].derivative()*hs[1]
assert wr and wr % F0 == 0 and (wr//F0).degree()==0
assert hs[0].gcd(hs[1])==1

R=PolynomialRing(K,['c%d'%i for i in range(6)],order='degrevlex')
cv=R.gens(); RT=PolynomialRing(R,'T'); T=RT.gen()
# C*u^j reduced modulo u^5=T; the last columns encode -H0,-H1.
mat=[[RT.zero() for j in range(6)] for i in range(5)]
for j in range(4):
    for power,coef in enumerate(list(cv)+[R.one()]):
        mat[(power+j)%5][j]+=coef*T**((power+j)//5)
for j,h in enumerate(hs):
    for i in range(5):mat[i][4+j]=-h[i]
perms=list(itertools.permutations(range(5)))
signs=[(-1)**sum(p[i]>p[j] for i in range(5) for j in range(i+1,5)) for p in perms]
def minor_without(j):
    keep=[i for i in range(6) if i!=j]
    return sum(sign*prod(mat[i][keep[p[i]]] for i in range(5))
               for p,sign in zip(perms,signs))
cof=[(-1)**j*minor_without(j) for j in range(6)]
assert any(cof)
assert all(sum(mat[i][j]*cof[j] for j in range(6))==0 for i in range(5))
RU=PolynomialRing(R,'u'); u=RU.gen()
def inflate(poly):return sum(coef*u**(5*i) for i,coef in enumerate(poly.list()))
A=sum(u**j*inflate(cof[j]) for j in range(4))
C=u**6+sum(cv[i]*u**i for i in range(6))
F=RU(F0); P=RU(P0); H=A*C
assert F*H.derivative(2)+4*F.derivative()*H.derivative()+(3*F.derivative(2)-P)*H==0
assert all(A[i]==0 for i in (4,9,14))
assert A.degree()<=18
print('HORIZONTAL_BASIS_DEGREES',[h.degree() for h in hs],flush=True)
print('WRONSKIAN_IS_NONZERO_CONSTANT_TIMES_F',True,flush=True)
print('COFACTOR_T_DEGREES',[f.degree() for f in cof],flush=True)
print('A_DEGREE',A.degree(),'LEADING_C_DEGREE',A[18].total_degree(),
      'LEADING_TERMS',A[18].number_of_terms(),flush=True)
print('A_COEFFICIENT_TERM_TOTAL',sum(c.number_of_terms() for c in A),
      'MAX_COEFFICIENT_C_DEGREE',max(c.total_degree() for c in A if c),flush=True)
print('COFACTOR_AND_ORIGINAL_ODE_IDENTITIES_PASS',flush=True)
print('TOTAL_SECONDS',round(time.monotonic()-started,3),flush=True)
if args.system_diagnostics or args.system_seconds:
    from cysignals.alarm import alarm,cancel_alarm
    alarm(args.construction_seconds)
    S=PolynomialRing(K,['loc','inv']+['b%d'%i for i in range(14)]+
                     ['c%d'%i for i in range(6)],order='degrevlex')
    sv=S.gens_dict(); SU=PolynomialRing(S,'u'); uu=SU.gen()
    transport=R.hom([sv['c%d'%i] for i in range(6)],S)
    AA=sum(transport(c)*uu**i for i,c in enumerate(A))
    CC=uu**6+sum(sv['c%d'%i]*uu**i for i in range(6))
    BB=-uu**14+sum(sv['b%d'%i]*uu**i for i in range(14))
    FF=SU(F0); original_lead=AA[18];lead=original_lead
    scale=3*sv['b13']+2*sv['c5']
    if args.triangular_b:
        # inv*original_lead=1 supplies the same normalized A as the
        # cleared system, with no unrecorded nonzero divisor introduced.
        AA=sv['inv']*AA;lead=S.one()
    d1=(FF.derivative()*AA+2*FF*AA.derivative())*CC-2*FF*AA*CC.derivative()+lead*BB**2
    d2=3*lead*(CC*BB).derivative()+scale*AA
    passport=scale*FF*AA**2-lead**2*(BB**3+CC**7)
    parts=[d1,d2]
    if not args.omit_passport:parts.append(passport)
    equations=[f for part in parts for f in part if f]
    equations.extend([sv['inv']*original_lead-1,sv['loc']*scale-1])
    if args.triangular_b:
        substitutions={}
        for j in reversed(range(13)):
            if j in (4,9):continue
            if len(substitutions)>=args.b_pivots:break
            variable=sv['b%d'%j]
            relation=d2[j+5].subs(substitutions)
            coefficient=S(K(3*(j+6)))
            assert coefficient and relation.monomial_coefficient(variable)==coefficient
            replacement=variable-relation/coefficient
            assert variable not in replacement.variables()
            substitutions[variable]=replacement
        assert len(substitutions)==args.b_pivots
        # Earlier replacements only involve higher indices, so after a
        # prefix of pivots they contain no eliminated variable.
        assert all(not set(f.variables()).intersection(substitutions) for f in substitutions.values())
        remaining=[v for v in S.gens() if v not in substitutions]
        small=PolynomialRing(K,names=[str(v) for v in remaining],order='degrevlex')
        positions=[S.gens().index(v) for v in remaining]
        def project(f):
            assert not set(f.variables()).intersection(substitutions)
            return small({tuple(e[j] for j in positions):c for e,c in f.dict().items()})
        print('SUBSTITUTION_PLAN','pivots',len(substitutions),
              'replacement_terms',sum(f.number_of_terms() for f in substitutions.values()),
              'backend',args.substitution,flush=True)
        substarted=time.monotonic()
        if args.substitution=='generic':
            reduced=[f.subs(substitutions) for f in equations]
            reduced=list(dict.fromkeys(f for f in reduced if f))
            equations=[project(f) for f in reduced]
            assert all(S(f)==g for f,g in zip(equations,reduced))
        else:
            from scripts.atlases.algebra.sparse_polynomial_substitution import SparsePolynomialTransport
            images=[project(substitutions[v]) if v in substitutions else small(str(v)) for v in S.gens()]
            transport=SparsePolynomialTransport(S,small,images)
            reduced=[]
            for row,f in enumerate(equations):
                ff=transport(f)
                if args.audit_generic and f.number_of_terms()<=3:
                    assert ff==project(f.subs(substitutions))
                if ff:reduced.append(ff)
                if row%10==0:print('SUBSTITUTION_ROW',row,'terms',ff.number_of_terms(),flush=True)
            equations=list(dict.fromkeys(reduced))
            print('SPARSE_TRANSPORT_STATS',transport.stats(),flush=True)
        print('SUBSTITUTION_SECONDS',round(time.monotonic()-substarted,3),flush=True)
        S=small
        print('EXACT_CONSTANT_UNIT_B_PIVOTS',list(map(str,substitutions)),flush=True)
    cancel_alarm()
    print('COFACTOR_SYSTEM_VARIABLES',S.ngens(),'EQUATIONS',len(equations),
          'DEGREES',sorted(set(f.total_degree() for f in equations)),
          'TERMS',sum(f.number_of_terms() for f in equations),
          'FULL_PASSPORT',not args.omit_passport,flush=True)
    digest=hashlib.sha256()
    for f in equations:
        for exponent,c in sorted(f.dict().items()):
            digest.update(bytes(exponent))
            coeffs=[int(a) for a in c.polynomial().list()]
            digest.update(bytes(coeffs+[0]*(K.degree()-len(coeffs))))
        digest.update(b'|')
    print('EXACT_EQUATION_SHA256',digest.hexdigest(),flush=True)
    if args.system_seconds:
        from cysignals.alarm import alarm,cancel_alarm
        alarm(args.system_seconds)
        try:
            gb=S.ideal(equations).groebner_basis(algorithm='libsingular:slimgb')
            print('GROEBNER_LENGTH',len(gb),'UNIT',gb==[S.one()],flush=True)
        except KeyboardInterrupt:
            print('TIME_LIMIT_INCONCLUSIVE',args.system_seconds,flush=True)
        finally:cancel_alarm()
        print('TOTAL_SECONDS',round(time.monotonic()-started,3),flush=True)
