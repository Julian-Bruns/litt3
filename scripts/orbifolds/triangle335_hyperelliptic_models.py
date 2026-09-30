#!/usr/bin/env sage-python
"""Construct the normalized rational-map equations for the (3,3,5) branch.

Through the actual (2,3,10) extension and hyperelliptic quotient, the
outer degree-15 map has profiles (3^5,1^5 2^5,5 10). Put its poles
at infinity and zero and normalize B to be monic with B(0)=1.
Then q=B^3/(c*x^10), A=3*x*B'-10*B, and A divides B^3-c*x^10.
The script records the rational equations and a Groebner calculation;
it does not regard a raw solution as a smooth source without checking.
"""
from sage.all import QQ, PolynomialRing
from pathlib import Path
import json,sys,time


def main():
    out=Path(sys.argv[1]);out.mkdir(parents=True,exist_ok=True)
    ring=PolynomialRing(QQ,names=('b1','b2','b3','b4','c'),order='degrevlex')
    b1,b2,b3,b4,c=ring.gens()
    polys=PolynomialRing(ring,'x');x=polys.gen()
    B=x**5+b4*x**4+b3*x**3+b2*x**2+b1*x+1
    A=3*x*B.derivative()-10*B
    remainder=(B**3-c*x**10).mod(A)
    equations=[ring(v)*ring(v).denominator() for v in remainder.list()]
    (out/'equations.txt').write_text('\n'.join(map(str,equations))+'\n')
    print('equations',len(equations),'degrees',[p.total_degree() for p in equations],flush=True)
    started=time.time()
    ideal=ring.ideal(equations)
    basis=ideal.groebner_basis()
    (out/'grevlex.txt').write_text('\n'.join(map(str,basis))+'\n')
    print('basis',len(basis),'dimension',ideal.dimension(),'seconds',time.time()-started,flush=True)
    if ideal.dimension()==0:
        print('quotient_length',ideal.vector_space_dimension(),flush=True)
        lex=ideal.transformed_basis('fglm')
        (out/'lex.txt').write_text('\n'.join(map(str,lex))+'\n')
        print('lex',len(lex),'seconds',time.time()-started,flush=True)


if __name__=='__main__':main()
