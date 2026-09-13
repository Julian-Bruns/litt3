#!/usr/bin/env sage-python
"""Small exact checks for the relative two-digit comparison.

These check local graph algebra, the actual AS filtration, the integral
norm identities and divided-Taylor valuation inequalities. The geometric
identification and the complete precision audit are in the separate note.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
import sympy as sp
from sage.all import GF, PolynomialRing, Zmod, matrix


def valuation_factorial(n):
    answer=0
    while n:
        n//=5
        answer+=n
    return answer


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output",required=True)
    args=parser.parse_args()
    started=time.monotonic()
    p=sp.Symbol("p")
    A,B,D,li,lj=sp.symbols("A B D li lj")
    K11,K12,K21,K22,L11,L12,L21,L22=sp.symbols("K11 K12 K21 K22 L11 L12 L21 L22")
    G=sp.Matrix([[A, B],[0,D]])+p*sp.Matrix([[K11,K12],[K21,K22]])+p**2*sp.Matrix([[L11,L12],[L21,L22]])
    Ri=sp.Matrix([[1,0],[p*li,1]]); Rj_inv=sp.Matrix([[1,0],[-p*lj,1]])
    normal=sp.expand((Rj_inv*G*Ri)[1,0])
    expected=p*(K21+D*li-A*lj)+p**2*(L21+K22*li-K11*lj-B*li*lj)
    assert all(sp.expand(normal-expected).coeff(p,j)==0 for j in range(3))
    # A general ordinary quadratic normal term has no surviving relative
    # AS degree >2 when each changed factor has degree zero in w.
    w,b=sp.symbols("w b")
    coeff=sp.symbols("c0:12"); change=sp.symbols("z0:4")
    old=[sum(coeff[3*i+j]*w**j for j in range(3)) for i in range(4)]
    new=[old[i]+b*change[i] for i in range(4)]
    quadratic=lambda V: V[0]*V[2]-V[1]*V[3]-B*V[2]*V[3]
    relative=sp.expand(quadratic(new)-quadratic(old))
    assert sp.Poly(relative,w).degree()<=2
    # Actual AS degree filtration: finite differences act on the basis
    # 1,w,...,w^4, with the same formula for w^5-w=f on either chart.
    F=PolynomialRing(GF(5),"w"); ww=F.gen()
    delta=matrix(GF(5),5,5,lambda i,j:((ww+1)**j-ww**j)[i])
    assert delta**5==0 and (delta**2).rank()==3 and (delta**4).rank()==1
    assert (delta**2).column_space()==matrix(GF(5),5,3,lambda i,j:int(i==j)).column_space()
    assert (delta**4).column_space()==matrix(GF(5),5,1,lambda i,j:int(i==0)).column_space()
    # Mixed Frobenius preserves degree <=2 because w^5=w+f. No claim
    # that the augmentation operator is a derivation is used.
    # Integral identities are checked BEFORE division.
    RR=PolynomialRing(Zmod(25),"e"); ee=RR.gen()
    quotient=RR.quotient((1+ee)**5-1,"e"); e=quotient.gen()
    N=sum((1+e)**i for i in range(5))
    assert N*e==0
    assert N==5+10*e+10*e**2+5*e**3+e**4
    assert e**5==-5*e-10*e**2-10*e**3-5*e**4
    for power in range(5):
        for other in range(5):
            assert N*(e*e**power+5*e**other)==5*N*e**other
    # Integer representative of the e6 carry, then reduce (5,e²).
    e6=(e**6).lift()
    assert all(int(cc)%5==0 for cc in e6)
    assert all((int(e6[j])//5)%5==0 for j in range(2))
    # All-order inequalities are proved in the note. Check an ample finite
    # range, retaining the full binomial numerator of Taylor variations.
    checked=0
    for j in range(2,501):
        for ell in range(2,j+1):
            assert ell+j-1-valuation_factorial(ell)-valuation_factorial(j-ell)>=3
            checked+=1
        assert j-1-valuation_factorial(j)>=0
    result={"status":"PASS local algebra for relative parameter-independence",
            "normal_graph_identity":True,"relative_quadratic_AS_degree_at_most":2,
            "AS_e2_image_dimension":3,"AS_e4_image_dimension":1,
            "integral_norm_identity":True,"e6_divided_residue_zero":True,
            "mixed_Taylor_bounds_checked":checked,"seconds":time.monotonic()-started,
            "scope":"Local and integral identities only; geometric conclusion is the separate audit proof."}
    Path(args.output).write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result))


if __name__=="__main__":main()
