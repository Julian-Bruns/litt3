#!/usr/bin/env python3
"""Recompute the endpoint algebra in F_25[X]/(A), including auxiliary data."""
import json
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'history/previous/src'))
from gf25 import add,sub,mul,div,power,inv
from poly25 import pa,ps,pm,sm,mod,pp,gcd,deriv,pinv,evalp

def check(name,condition):
    if not condition:raise AssertionError(name)
    print('PASS:',name,flush=True)

def determinant3(m):
    a,b,c=m
    return add(sub(mul(a[0],sub(mul(b[1],c[2]),mul(b[2],c[1]))),mul(a[1],sub(mul(b[0],c[2]),mul(b[2],c[0])))),mul(a[2],sub(mul(b[0],c[1]),mul(b[1],c[0]))))

def main():
    data=json.loads((ROOT/'data/input.json').read_text())
    cert=json.loads((ROOT/'data/endpoint_certificate.json').read_text())
    A,P=data['A'],data['P'];x=[0,1]
    check('A irreducible over F_25 (degree 4 Frobenius criterion)',
          gcd(A,ps(pp(x,25,A),x))==[1] and gcd(A,ps(pp(x,625,A),x))==[1]
          and not mod(ps(pp(x,25**4,A),x),A))
    check('monic A row used by both endpoint checkers',sm(A,inv(A[4]))==[5,2,6,7,1])
    Ap=deriv(A);App=deriv(Ap)
    H=mod(pm(pp(Ap,3),pp(P,2)),A)
    C=div(3,power(A[4],3))
    check('endpoint constant C and H',C==cert['C']==14 and H==cert['H'])
    exponent=cert['inverse_29_mod_25pow4_minus1']
    check('inverse exponent for the canonical 29th root',(29*exponent)%(25**4-1)==1)
    canonical=pp(sm(H,C),exponent,A)
    check('canonical L and its 29th-power identity',canonical==cert['canonical_L'] and pp(canonical,29,A)==sm(H,C))
    a=mod(sm(pinv(Ap,A),A[4]),A)
    logarithm=mod(ps(pm(deriv(P),pinv(P,A)),pm(App,pinv(Ap,A))),A)
    b=mod(pm(ps(sm(logarithm,4),sm(pm(App,pinv(Ap,A)),3)),pp(a,2)),A)
    m=mod(pm(logarithm,a),A)
    check('three endpoint coefficient formulas',a==cert['a_coefficient'] and logarithm==cert['F_log'] and b==cert['b_coefficient'] and m==cert['m_coefficient'])
    bv=mod(pm(b,pp(canonical,8,A)),A)
    mv=mod(pm(m,pp(canonical,5,A)),A)
    check('canonical b and m values used in the full enumeration',bv==cert['canonical_b_value']==[1,3,8,15] and mv==cert['canonical_m_value']==[22,7,9,23])
    conjugates=[pp(bv,25**i,A) for i in range(4)]
    check('all four b-value Frobenius rows',conjugates==cert['b_frobenius_conjugates'])
    for item in cert['independence_minors']:
        j=item['conjugate_index']
        cols=[[1,0,0,0],bv+[0]*(4-len(bv)),conjugates[j]+[0]*(4-len(conjugates[j]))]
        matrix=[[cols[c][r] for c in range(3)] for r in item['row_indices']]
        det=determinant3(matrix)
        check(f'auxiliary independence minor for conjugate {j}',matrix==item['matrix'] and det==item['determinant'] and det!=0)
    check('recorded quartic non-evenness coefficient',evalp(deriv([10,18,16,22,1]),22)==cert['quartic_derivative_at_even_candidate']==10)
    print('RESULT: every stored endpoint algebraic constant was recomputed.',flush=True)

if __name__=='__main__':main()

