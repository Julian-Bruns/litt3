"""PREPARED ONLY: one new ten-dimensional finite-P-branch weight gate.

No execution is authorized yet. A parent-approved run must use one
thread and a hard external bounded process-group timeout. No root-pair
enumeration, Groebner basis, PSC replay or group calculation is used.

At both actual finite P-branches, the degree-five wild local comparison
forces frozen contact>=3 (degree-ten forces>=5). The quadratic coefficient
then requires K(a)=K(b), where p(U)=P(U-1),
K(U)=U*p'(U)^2/(U^2+d0)^9 and a,b are geometric p-roots. If multiplication
by K in the ETale ten-dimensional algebra F25[U]/p has squarefree
characteristic polynomial, all ten K(a) are distinct. Then a=b and s1.
The s1 sector and actual source existence remain explicit exceptions.
"""
from sage.all import *
import json,time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n): return k(n%5)+k(n//5)*beta
def code(a):
    v=a.polynomial().list()
    return int(v[0] if v else 0)+5*int(v[1] if len(v)>1 else 0)
def codes(poly): return [code(c) for c in poly.list()]
def emit(obj):
    obj['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(obj),flush=True)
R=PolynomialRing(k,'U');U=R.gen()
P=sum(elt(n)*U**i for i,n in enumerate([11,22,18,5,19,20,15,16,9,22,1]))
p=P(U-1)
d0=elt(23)
q=U**2+d0
emit({'event':'initialized','field':'F25,beta^2=beta+3; a+5b encoding',
      'p_shift_coefficients':codes(p),'q_coefficients':codes(q),
      'scope':'new exact weight separation on all ten geometric finite P-roots; necessary both-P-branch gate only',
      'retained_exceptions':['s=1 diagonal branch','actual source existence']})

# These tiny unit checks are needed for THIS new K-definition. They do
# not rerun any fixed-X norm, PSC or branch-pair certificate.
units={}
unit_failed=False
for name,poly in [('U',U),('q',q)]:
    g,a,b=poly.xgcd(p)
    assert a*poly+b*p==g
    if g.degree()!=0:
        emit({'event':'unit_failed_unresolved','name':name,'gcd_codes':codes(g),
              'conclusion':'K-definition invalid on part of the root algebra; no separation decision'})
        unit_failed=True
        break
    scale=g[0]**(-1)
    a*=scale;b*=scale
    assert a*poly+b*p==1
    units[name]=a%p
    emit({'event':'root_algebra_unit_certificate','name':name,
          'inverse_mod_p_codes':codes(a%p),'bezout_a_codes':codes(a),
          'bezout_b_codes':codes(b),'identity':'a*poly+b*p=1'})
if unit_failed:
    raise SystemExit(0)
assert p.degree()==10 and p.is_monic()
assert gcd(p,p.derivative())==1  # fixed smoothness, needed algebra etaleness
weight=(U*p.derivative()**2*units['q']**9)%p
columns=[(weight*U**j)%p for j in range(10)]
M=matrix(k,10,10,lambda i,j:columns[j][i])
chi=R(M.charpoly('U'))
assert chi.degree()==10 and chi.is_monic()
assert chi(weight)%p==0
emit({'event':'multiplication_weight_checkpoint','weight_mod_p_codes':codes(weight),
      'multiplication_matrix_row_codes':[[code(M[i,j]) for j in range(10)] for i in range(10)],
      'characteristic_polynomial_codes':codes(chi),
      'characteristic_annihilation_mod_p':'PASS'})
g,a,b=chi.xgcd(chi.derivative())
assert a*chi+b*chi.derivative()==g
if g.degree()==0:
    scale=g[0]**(-1)
    a*=scale;b*=scale
    assert a*chi+b*chi.derivative()==1
    emit({'event':'all_geometric_p_weights_separate','verdict':'PASS',
          'bezout_chi_codes':codes(a),'bezout_derivative_codes':codes(b),
          'identity':'a*chi+b*chi_derivative=1',
          'conclusion':'All ten geometric p-roots have distinct K-values; K(a)=K(b) implies a=b and s=1',
          'retained_exceptions':['s=1 diagonal branch','actual source existence']})
else:
    emit({'event':'weight_separation_unresolved','gcd_codes':codes(g),
          'conclusion':'Repeated K-values may occur; no all-geometric both-P-branch decision',
          'retained_exceptions':['all pairs with equal weight','s=1','actual source existence']})
