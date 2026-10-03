#!/usr/bin/env sage
"""NEW dimensionless univariate gcd/Bezout gate for saved fixed20 oper.

Read the saved two cleared equations only. Transport tau=(e/A)*T and
check exact coefficient mapback into the reduced degree10 q algebra.
Run bounded Euclidean division with EVERY coefficient pivot checked as
a unit; stop with a retained exceptional q locus if a pivot is nonunit.
Record exact Bezout/division identities on success. No GB, resultant,
factorization, sampling, gauge/pencil replay or source construction.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser=argparse.ArgumentParser()
parser.add_argument('--linear-split',required=True)
parser.add_argument('--source',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
inp=Path(args.linear_split)
source=Path(args.source)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
assert not (out/'univariate_bezout.sobj').exists()
(k,Kq,parameter,Q,E,S,R,L,N,tstar,cleared,mapbacks,element,norm,
 norm_gcd,norm_bezout,inverse,exceptional_original)=load(str(inp))
alpha=k.gen()
A,B=k(1)-alpha,k(2)-alpha
q0=Q.gen()
e=E.gen()
U=PolynomialRing(Q,'T')
Tvar=U.gen()
transported=[]
odd_flags=[]
for original in cleared:
    coefficients=[]
    for i,coefficient in enumerate(original.list()):
        moved=E(coefficient)*(e/A)^i
        parts=moved.list()
        assert len(parts)<=2
        odd=parts[1] if len(parts)>1 else Q(0)
        assert odd==0
        odd_flags.append(bool(odd==0))
        base=Q(parts[0]) if parts else Q(0)
        assert E(base)==moved
        coefficients.append(base)
    transported.append(U(coefficients))

pivots=[]
def checked_inverse(coefficient,stage):
    coefficient=Q(coefficient)
    gcd,bezout,_=coefficient.lift().xgcd(parameter)
    unit=(gcd.degree()==0 and gcd!=0)
    inv=Q(bezout/gcd[0]) if unit else None
    if unit:assert coefficient*inv==1
    pivots.append((stage,coefficient,gcd,bezout,inv))
    return inv

def divided_remainder(a,b,inv):
    quotient=U(0)
    remainder=U(a)
    while remainder!=0 and remainder.degree()>=b.degree():
        term=U(remainder.leading_coefficient()*inv)*Tvar^(remainder.degree()-b.degree())
        quotient+=term
        remainder-=term*b
    assert a==quotient*b+remainder
    assert remainder==0 or remainder.degree()<b.degree()
    return quotient,remainder

f0,f1=transported
r0,r1=f0,f1
a0,b0=U(1),U(0)
a1,b1=U(0),U(1)
steps=[]
exception=None
for step in range(9):
    if r1==0:break
    inv=checked_inverse(r1.leading_coefficient(),'division_'+str(step))
    if inv is None:
        exception=('nonunit_euclidean_pivot',step,r0,r1,a0,b0,a1,b1)
        break
    quotient,remainder=divided_remainder(r0,r1,inv)
    steps.append((r0,r1,quotient,remainder))
    r0,r1=r1,remainder
    a0,a1=a1,a0-quotient*a1
    b0,b1=b1,b0-quotient*b1
    assert r0==a0*f0+b0*f1 and r1==a1*f0+b1*f1
else:
    raise AssertionError('Euclidean loop exceeded degree bound')

gcd_polynomial=None
bezout0=None
bezout1=None
quotients=None
if exception is None:
    assert r1==0 and r0!=0
    inv=checked_inverse(r0.leading_coefficient(),'final_normalization')
    if inv is None:
        exception=('nonunit_final_pivot',r0,a0,b0)
    else:
        gcd_polynomial=r0*inv
        bezout0=a0*inv
        bezout1=b0*inv
        assert gcd_polynomial.leading_coefficient()==1
        assert bezout0*f0+bezout1*f1==gcd_polynomial
        quotients=[]
        for original in transported:
            quotient,remainder=divided_remainder(original,gcd_polynomial,Q(1))
            assert remainder==0
            quotients.append(quotient)

summary={
 'scope':'NEW necessary fixed20 original-oper univariate gate; no finite source realization',
 'sage_version':SAGE_VERSION,'threads':1,
 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
 'input_sha256':hashlib.sha256(inp.read_bytes()).hexdigest(),
 'new_groebner_basis':False,'resultant_or_factorization':False,
 'samples_or_gauge_replay':False,
 'parameter_degree':10,'both_e_signs_retained':True,
 'variable_transport':'tau=(e/A)*T; original tau!=0 and L!=0 retained',
 'transport_mapback_flags':odd_flags,
 'transported_degrees':[int(p.degree()) for p in transported],
 'division_steps':len(steps),
 'division_degree_pairs':[[int(a.degree()),int(b.degree()),int(rem.degree())] for a,b,quo,rem in steps],
 'pivot_gcd_degrees':[int(record[2].degree()) for record in pivots],
 'all_executed_pivots_unit':bool(exception is None),
 'retained_exception':None if exception is None else str(exception[0]),
 'gcd_degree':None if gcd_polynomial is None else int(gcd_polynomial.degree()),
 'unit_ideal':bool(gcd_polynomial==U(1)) if gcd_polynomial is not None else False,
 'bezout_readback':bool(gcd_polynomial is not None),
 'original_division_readback':bool(quotients is not None),
 'elapsed_seconds':time.monotonic()-start,
}
save((k,Kq,parameter,Q,E,U,transported,pivots,steps,exception,gcd_polynomial,
      bezout0,bezout1,quotients),str(out/'univariate_bezout.sobj'))
(out/'certificate.txt').write_text(
    'transported_E0 = '+str(f0)+'\ntransported_E1 = '+str(f1)+'\n'
    +'gcd = '+str(gcd_polynomial)+'\nbezout0 = '+str(bezout0)+'\n'
    +'bezout1 = '+str(bezout1)+'\nexception = '+str(exception)+'\n'
    +'pivots = '+str(pivots)+'\n')
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
