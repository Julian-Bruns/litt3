"""PREPARED ONLY: NEW P-root weight for a tame finite fold at common infinity.

Actual pi-index2,Q/z-index3 gives source index6,different5.
Frozen P-branch contact3 and common s=rho² impose equal values of
V0=U²*p'(U)^4/q(U)^19 on a,b. This source tests ONLY V0 separation.
Old W-weight data/PSC/phase samples/root enumeration are not replayed.
No execution or lease inferred; nonconstant common factor is unresolved.
"""
from sage.all import *
import json,time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n):return k(n%5)+k(n//5)*beta
def code(a):
    v=a.polynomial().list()
    return int(v[0] if v else 0)+5*int(v[1] if len(v)>1 else 0)
def codes(f):return [code(a) for a in f.list()]
def emit(d):
    d['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(d),flush=True)
R=PolynomialRing(k,'U');U=R.gen()
p=sum(elt(a)*U**i for i,a in enumerate([8,3,21,23,22,12,22,21,1,22,1]))
q=U**2+elt(23);pp=p.derivative()
for f in [U,q,pp]:
    g,aa,bb=f.xgcd(p);assert g.degree()==0
g,qi,unused=q.xgcd(p);qi=(qi/g[0])%p
assert (q*qi)%p==1
value=(U**2*pp**4*qi**19)%p
A=R.quotient(p,'u');u=A.gen()
vv=A(value)
def vec(a):
    pol=a.lift()
    return vector(k,[pol[i] for i in range(10)])
M=matrix(k,10,10)
for j in range(10):
    column=vec(vv*u**j)
    M.set_column(j,column)
    assert A(sum(column[i]*U**i for i in range(10)))==vv*u**j
C=R(M.charpoly('U'));Cp=C.derivative()
assert C.degree()==10 and C[10]==1
emit({'event':'common_finite_fold_weight_setup',
      'field':'F25,beta²=beta+3;a+5b encoding',
      'scope':'actual tame finite pi-fold in common-infinity Q-fiber,source z-index6',
      'p_coefficients':codes(p),'q_coefficients':codes(q),
      'q_inverse_mod_p_coefficients':codes(qi),
      'V0_mod_p_coefficients':codes(value),
      'multiplication_matrix_rows':[[code(M[i,j]) for j in range(10)] for i in range(10)],
      'characteristic_polynomial_coefficients':codes(C),
      'characteristic_derivative_coefficients':codes(Cp)})
g,B0,B1=C.xgcd(Cp);assert B0*C+B1*Cp==g
row={'event':'common_finite_fold_weight_result','common_factor_coefficients':codes(g)}
if g.degree()==0:
    scale=g[0]**(-1);B0*=scale;B1*=scale
    assert B0*C+B1*Cp==1
    row.update({'verdict':'PASS','Bezout_C_coefficients':codes(B0),
                'Bezout_C_derivative_coefficients':codes(B1),
                'identity':'B0*C+B1*C_derivative=1',
                'conclusion':'all ten geometric V0 values distinct; necessary finite common-fold P-pair diagonal'})
else:
    row.update({'verdict':'UNRESOLVED','conclusion':'nonconstant repeated-value locus retained; no exclusion'})
emit(row)
