#!/usr/bin/env sage-python
"""Exact local algebra for the actual closure coinvariant comparison.

Geometry and the relationship to the actual Hodge map are audited in the
separate note. These tests deliberately do not substitute arbitrary modules
for the geometric hypotheses.
"""
import hashlib
import itertools
import json
from pathlib import Path
import time
import sympy as sp
from sage.all import GF, Integers, PolynomialRing, matrix


def main():
    start=time.monotonic(); p=sp.Symbol('p')
    aa,bb,dd,li,lj=sp.symbols('A B D li lj')
    kk=sp.symbols('K11 K12 K21 K22'); ll=sp.symbols('L11 L12 L21 L22')
    G=sp.Matrix([[aa,bb],[0,dd]])+p*sp.Matrix(2,2,kk)+p*p*sp.Matrix(2,2,ll)
    normal=sp.expand((sp.Matrix([[1,0],[-p*lj,1]])*G*sp.Matrix([[1,0],[p*li,1]]))[1,0])
    expected=p*(kk[2]+dd*li-aa*lj)+p*p*(ll[2]+kk[3]*li-kk[0]*lj-bb*li*lj)
    assert all(sp.expand(normal-expected).coeff(p,j)==0 for j in range(3))
    w=sp.Symbol('w'); oldc=sp.symbols('a0:12'); newc=sp.symbols('b0:8')
    old=[sum(oldc[3*i+j]*w**j for j in range(3)) for i in range(4)]
    diff=[sum(newc[2*i+j]*w**j for j in range(2)) for i in range(4)]
    quadratic=lambda z:z[0]*z[2]-z[1]*z[3]-bb*z[2]*z[3]
    relative=sp.expand(quadratic([old[i]+diff[i] for i in range(4)])-quadratic(old))
    assert sp.Poly(relative,w).degree()==3
    # Exact degree3 occurs: this argument must use O/eO, not claim zero in O.
    assert sp.expand((w*w+w)*(w*w+w)-w**4).coeff(w,3)==2
    fp=PolynomialRing(GF(5),'w'); wp=fp.gen()
    delta=matrix(GF(5),5,5,lambda i,j:((wp+1)**j-wp**j)[i])
    for n in range(1,5):
        assert (delta**n).column_space()==matrix(GF(5),5,5-n,lambda i,j:int(i==j)).column_space()
    ZZ=PolynomialRing(Integers(25),'e'); ev=ZZ.gen()
    RR=ZZ.quotient((1+ev)**5-1,'e'); e=RR.gen()
    assert e**5==-5*e-10*e**2-10*e**3-5*e**4
    N=sum((1+e)**i for i in range(5)); assert e*N==0
    count=0
    # Complete 5^5 leading inputs x: e³x divisible by5 forces xbar in e²;
    # the arbitrary next source digit contributes e³v after division.
    for cs in itertools.product(range(5),repeat=5):
        x=RR(sum(cs[i]*ev**i for i in range(5))); z=e**3*x
        coeff=[int(z.lift()[i]) for i in range(5)]
        if any(a%5 for a in coeff):continue
        assert cs[0]==cs[1]==0
        div=[a//5%5 for a in coeff]
        assert div[0]==0
        for r in range(5):
            shifted=z+5*e**(r+3)
            cc=[int(shifted.lift()[i]) for i in range(5)]
            assert all(a%5==0 for a in cc) and cc[0]//5%5==0
            count+=1
    assert count==625
    # Every involution compatible with inversion on R/e² and + on the
    # coinvariant has + eigenspace projecting isomorphically to constants.
    ef=matrix(GF(5),[[0,0],[1,0]])
    for c in GF(5):
        tau=matrix(GF(5),[[1,0],[c,-1]])
        assert tau*tau==1 and tau*ef*tau==-ef
        plus=(tau-1).right_kernel(); minus=(tau+1).right_kernel()
        assert plus.dimension()==minus.dimension()==1
        assert plus.basis()[0][0]!=0 and minus.basis()[0][0]==0
    # Independently preserve all divided Taylor factors, including 5!.
    def vf(n):
        result=0
        while n:n//=5; result+=n
        return result
    checks=0
    for j in range(2,501):
        for ell in range(2,j+1):
            assert ell+j-1-vf(ell)-vf(j-ell)>=3; checks+=1
    result=dict(status='PASS closure relative local and integral identities',
                relative_quadratic_AS_degree=3,colon_complete_source_residues=3125,
                divisible_input_and_next_digit_tests=count,reflection_matrices_checked=5,
                mixed_Taylor_inequalities=checks,
                source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                seconds=time.monotonic()-start,
                scope='Finite identities only; actual geometric comparison and coinvariant/trace bridge are proved in separate audit')
    out=Path('Research/computations/neutral5_closure_coinvariant_independent_audit.json')
    out.write_text(json.dumps(result,indent=2)+'\n'); print(json.dumps(result),flush=True)


if __name__=='__main__':main()
