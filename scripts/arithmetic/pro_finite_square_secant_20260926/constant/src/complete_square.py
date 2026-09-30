"""A complete division-free 54+16 equation circuit for degree-140 squares.

Input coefficients are ascending in T for A(T)=T^140 W(T^-1), with
A(0)=L != 0. This is a geometric-square test: a scalar square root need
not belong to the input finite field. The global polynomial identities
and saturation statement are proved in REPORT.md, Section 13.

Only this numerical circuit and its equivalence tests are executed here.
No global Groebner elimination or isolated-point enumeration is claimed.
"""
from residual import *
import random, hashlib

DEGREE=140

def trim_to(a,n):
 return list(a[:n])+[0]*max(0,n-len(a))

def mul_trunc(a,b,n):
 return trim_to(pmul(a,b),n)

def frob5(a,stride=5,n=125):
 out=[0]*n
 for i,c in enumerate(a):
  if i*stride>=n:break
  out[i*stride]=power(c,stride)
 return out

def power63_truncated(A):
 """A^63 mod T^125 via 63=3+2*5+2*25; no inversions."""
 A=trim_to(A,125)
 A2=mul_trunc(A,A,125)
 A3=mul_trunc(A2,A,125)
 return mul_trunc(mul_trunc(A3,frob5(A2,5),125),frob5(A2,25),125)

def complete_equations(A):
 """Return 70 exact equations: 54 root-tail and 16 final-square coefficients.

 A must be a 141-term (padded if needed) reverse polynomial with A[0]!=0.
 The equations are polynomials in its coefficients; there is no division.
 """
 if len(A)>141:raise ValueError('degree exceeds 140')
 A=trim_to(A,141)
 if not A[0]:raise ValueError('nonzero degree-140 coefficient required')
 C=power63_truncated(A)
 B=C[:71]
 B2=trim_to(pmul(B,B),141)
 L125=power(A[0],125)
 eqs=C[71:125]+[sub(B2[m],mul(L125,A[m])) for m in range(125,141)]
 assert len(eqs)==70
 return eqs,B

def incidence_descriptor():
 return {
  'status':'complete equivalent incidence specified; NOT solved',
  'base_field':'K=F25(alpha), original integer codes',
  'parameter_variables':['H','q','mu'],
  'saturation_variable':'z',
  'residual_sha256':'436fae7b0bb93fb03e40e2b6c66507440569ebd591bdf988acc40b47593fecf2',
  'input_polynomial':'W(x)=q^35*Rcal(H,q,mu,x)',
  'reverse_polynomial':'A(T)=T^140*W(T^-1)',
  'leading_coefficient':'L=(2*epsilon^24/<299619>^6)*H^9*q^42*Psi(H,q)^3',
  'open_factor':'O=H*q*mu*Psi(H,q)*(q-<15383>)*(q-1)',
  'power_circuit':{
   'A2':'A(T)^2 modulo T^125',
   'A3':'A2*A modulo T^125',
   'C':'A3*(A2)^5*(A2)^25 modulo T^125',
   'B':'sum_{m=0}^{70} [T^m]C * T^m'
  },
  'first_equations':{'indices':list(range(71,125)),'formula':'[T^m]C'},
  'last_equations':{'indices':list(range(125,141)),'formula':'[T^m](B(T)^2-L^125*A(T))'},
  'saturation_equation':'z*O-1',
  'equivalence':'A geometric allowed square exists exactly when these 71 equations in H,q,mu,z have a common geometric zero.',
  'root_reconstruction':'U(T)=B(T)/L^63 satisfies U(0)=1 and U(T)^2=A(T)/L. Choose c with c^2=L, reverse c*U to obtain a square root of W. Since W=q^48*R, multiply the root of W by q^-24 to obtain the root of R. Choose w^3=q, then h=H/w and lambda=w*mu.',
  'polynomial_degree_in_residual_coefficients':{'first_54':63,'last_16':126},
  'boundary_handling':'No polynomial division, variable-degree resultant, exceptional-coefficient inversion, or omitted q fiber is used. Only the stated open factor is inverted.',
  'execution_scope':'Descriptor generation and exact finite-field equivalence tests executed; expanded global generators and their saturated Groebner basis NOT computed.'
 }

def run_checks():
 rng=random.Random(1406325)
 cases=[]
 def check(A,label,expected=None):
  A=trim_to(A,141)
  eq,B=complete_equations(A)
  ordinary=square_test(list(reversed(A)))
  got=not any(eq)
  assert got==ordinary['square'],(label,got,ordinary)
  if expected is not None:assert got==expected
  if got:
   U=pscale(B,inv(power(A[0],63)))
   assert trim_to(ppow(U,2),141)==pscale(A,inv(A[0]))
  first=next((i for i,v in enumerate(eq) if v),None)
  m=(71+first if first is not None and first<54 else 125+first-54 if first is not None else None)
  cases.append({'label':label,'square':got,'first_failed_equation_index':m,'all_54_early_equations_vanish':not any(eq[:54]),'last_16_vanish':not any(eq[54:]),'equations_sha256':hashlib.sha256(','.join(map(str,eq)).encode()).hexdigest()})
 # Scalar multiples of exact squares include nonsquare constants in K.
 for i in range(16):
  root=[1]+[rng.randrange(QFIELD) for _ in range(70)]
  scalar_value=1+rng.randrange(QFIELD-1)
  check(pscale(ppow(root,2),scalar_value),f'synthetic_geometric_square_{i}',True)
 for i in range(16):
  A=[1+rng.randrange(QFIELD-1)]+[rng.randrange(QFIELD) for _ in range(140)]
  check(A,f'arbitrary_degree140_{i}')
 # The early 54 equations alone are not sufficient; the final 16 are essential.
 for m in [125,126,130,139,140]:
  A=[0]*141;A[0]=1;A[m]=1
  check(A,f'late_defect_T{m}',False)
 # Actual residual validations: use q^35 Rcal=q^48 R.
 for h,w,lam in [(1,2,1),(2,3,1),(25,6,25),(12345,67890,13579),(1,2,0)]:
  R,data=residual(h,w,lam,True)
  W=pscale(R,power(data['q'],48))
  check(list(reversed(W)),f'actual_residual_{h}_{w}_{lam}',False)
 result={'status':'PASS','number_of_tests':len(cases),'scope':'exact equivalence/implementation validation only; no global square-locus elimination','cases':cases}
 (ROOT/'evidence/complete_square_circuit.json').write_text(json.dumps(incidence_descriptor(),indent=2)+'\n')
 (ROOT/'evidence/complete_square_checks.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({'status':'PASS','number_of_tests':len(cases),'synthetic_square_cases':16,'arbitrary_polynomials':16,'late_defects_requiring_last_16':5,'actual_residual_validation_cases':5,'global_decision':'UNRESOLVED'},sort_keys=True))
 return result

if __name__=='__main__':run_checks()
