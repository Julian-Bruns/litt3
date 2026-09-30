#!/usr/bin/env sage-python
"""Normalized, nondegenerate equations for the degree-15 rational quotient.

Use the exact square-divisibility condition, with b0*c invertible.
The open chart has b4=1; the boundary has b4=0 and b0=1.
Every desired map is covered by one of these two scaling charts.
"""
from sage.all import QQ,PolynomialRing
from pathlib import Path
import sys,time


def main():
    out=Path(sys.argv[1]);out.mkdir(parents=True,exist_ok=True)
    boundary='--boundary' in sys.argv[2:]
    names=('b1','b2','b3','c','inv') if boundary else ('b0','b1','b2','b3','c','inv')
    ring=PolynomialRing(QQ,names=names,order='degrevlex')
    if boundary:
        b1,b2,b3,c,inv=ring.gens();b0,b4=ring(1),ring(0)
    else:
        b0,b1,b2,b3,c,inv=ring.gens();b4=ring(1)
    polys=PolynomialRing(ring,'x');x=polys.gen()
    B=x**5+b4*x**4+b3*x**3+b2*x**2+b1*x+b0
    A=3*x*B.derivative()-10*B
    remainder=(B**3-c*x**10).mod(A**2)
    equations=[ring(v)*ring(v).denominator() for v in remainder.list()]
    equations.append(inv*b0*c-1)
    (out/'equations.txt').write_text('\n'.join(map(str,equations))+'\n')
    print('boundary',boundary,'equations',len(equations),'degrees',
          [p.total_degree() for p in equations],flush=True)
    started=time.time();ideal=ring.ideal(equations)
    basis=ideal.groebner_basis()
    (out/'grevlex.txt').write_text('\n'.join(map(str,basis))+'\n')
    dimension=ideal.dimension()
    print('basis',len(basis),'dimension',dimension,'seconds',time.time()-started,flush=True)
    if dimension==0:
        print('quotient_length',ideal.vector_space_dimension(),flush=True)
        lex=ideal.transformed_basis('fglm')
        (out/'lex.txt').write_text('\n'.join(map(str,lex))+'\n')
        print('lex',len(lex),'seconds',time.time()-started,flush=True)


if __name__=='__main__':main()
