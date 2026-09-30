#!/usr/bin/env python3
"""Independent complete polynomial-identity check using four Hasse jets.

This verifier does not use GMP multiplication, polynomial gcd, or the unit-
factorization algorithm. The degree bound makes all K-valued four-jet data
an exact test of a polynomial identity, not a geometric point search.
"""
from pathlib import Path
import ctypes as C, hashlib, json, math, time
import numpy as np
from ff import Poly, va, vm, u32p
ROOT=Path(__file__).resolve().parents[1]
Q=390625


def digest(p):
    return hashlib.sha256(p.a.astype('<u4').tobytes()).hexdigest()


def folded_hasse(p,j):
    """Polynomial of degree <Q with the same values as D^[j]p on K."""
    a=p.a
    out=np.zeros(Q,dtype=np.uint32)
    if len(a)<=j:
        return out
    multipliers=np.array([math.comb(i,j)%5 if i>=j else 0 for i in range(5)],dtype=np.uint32)
    coeff=vm(a[j:],multipliers[np.arange(j,len(a))%5])
    out[0]=coeff[0]
    # x^Q=x: positive exponents fold modulo Q-1, staying positive.
    for first in range(1,len(coeff),Q-1):
        part=coeff[first:first+Q-1]
        out[1:len(part)+1]=va(out[1:len(part)+1],part)
    return out


def verify():
    start=time.time()
    cert=json.loads((ROOT/'data/global_resultant_certificate.json').read_text())
    assert cert['resultant_indices']==[72,73]
    arr=np.load(ROOT/cert['bezout_array_file'])
    pp=np.load(ROOT/'scratch/global_resultants.npz')
    U,V,P72,P73=Poly(arr['U']),Poly(arr['V']),Poly(pp['72']),Poly(pp['73'])
    for n,p in [(72,P72),(73,P73)]:
        assert digest(p)==cert['reconstructed_resultant_hashes'][str(n)]
    # This small product uses the original field polynomial implementation.
    H=Poly(json.loads((ROOT/'data/slope_minus_model.json').read_text())['norm_squarefree'])
    rhs=Poly([370130,1])**384 * H.frob()
    assert rhs.degree()==744 and digest(rhs)==cert['stages'][0]['gcd_sha256']
    degree_bound=max(U.degree()+P72.degree(),V.degree()+P73.degree(),rhs.degree())
    assert degree_bound==1287730 and degree_bound<4*Q
    polys=[U,P72,V,P73,rhs]
    coefficients=np.empty((Q,20),dtype=np.uint32)
    for i,p in enumerate(polys):
        for j in range(4):
            coefficients[:,4*i+j]=folded_hasse(p,j)
    lib=C.CDLL(str(ROOT/'src/fast_tails.so'))
    lib.ft_field_evaluate.argtypes=[u32p,C.c_int,u32p]
    values=np.zeros_like(coefficients)
    assert lib.ft_field_evaluate(coefficients.ravel(),20,values.ravel())==1
    del coefficients
    checked=[]
    for j in range(4):
        lhs=np.zeros(Q,dtype=np.uint32)
        for i in range(j+1):
            lhs=va(lhs,vm(values[:,i],values[:,4+j-i]))
            lhs=va(lhs,vm(values[:,8+i],values[:,12+j-i]))
        assert np.array_equal(lhs,values[:,16+j]),('Hasse identity failed',j)
        checked.append({'hasse_order':j,'distinct_field_nodes':Q,'all_equal':True})
    result={'status':'exact global Bezout identity independently verified by four complete Hasse jets',
            'polynomial_degree_bound':degree_bound,'vanishing_modulus_degree':4*Q,
            'vanishing_modulus':'(q^390625-q)^4','Hasse_orders':[0,1,2,3],
            'distinct_field_nodes':Q,'total_conditions':4*Q,'checks':checked,
            'GMP_used':False,'gcd_used':False,'factorization_used':False,
            'scope':'complete polynomial identity, not a bounded geometric square search',
            'seconds':round(time.time()-start,3)}
    (ROOT/'checks/bezout_hasse_verification.json').write_text(json.dumps(result,indent=2)+'\n')
    print('INDEPENDENT_COMPLETE_HASSE_BEZOUT_VERIFICATION_PASSED='+json.dumps(result),flush=True)
    return result


if __name__=='__main__':
    verify()
