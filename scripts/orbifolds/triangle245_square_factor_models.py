#!/usr/bin/env sage-python
"""Necessary exact models for the surviving (2,4,5) hyperelliptic quotients.

Put the two Weierstrass points over index four at x=0,infinity.
The degree-20 quotient satisfies q=1+s*x^2*B^4/C^5, with monic
quartics B,C and C(0)=1. The remaining critical polynomial is
A=(2B+4xB')C-5xBC', and A^2 divides C^5+s*x^2*B^4.
Invert s*B(0)*Res(B,C). Scaling x to normalize C(0) needs at most
a fourth root and covers every nondegenerate map in this passport.
"""
from sage.all import QQ,GF,PolynomialRing
from pathlib import Path
import sys,time


def main():
    out=Path(sys.argv[1]);out.mkdir(parents=True,exist_ok=True)
    characteristic=int(sys.argv[2]) if len(sys.argv)>2 else 0
    mode=sys.argv[3] if len(sys.argv)>3 else 'resultant'
    field=GF(characteristic) if characteristic else QQ
    c3_one='--c3-one' in sys.argv
    names=('b0','b1','b2','b3','c0','c1','c2','s','inv') if c3_one else ('b0','b1','b2','b3','c1','c2','c3','s','inv')
    if mode=='coefficients': names=('f0','f1','f2','f3')+names
    ring=PolynomialRing(field,names=names,order='degrevlex')
    if c3_one:
        b0,b1,b2,b3,c0,c1,c2,s,inv=ring.gens()[-9:]
        c3=ring(1)
    else:
        b0,b1,b2,b3,c1,c2,c3,s,inv=ring.gens()[-9:]
        c0=ring(1)
    px=PolynomialRing(ring,'x');x=px.gen()
    B=x**4+b3*x**3+b2*x**2+b1*x+b0
    C=x**4+c3*x**3+c2*x**2+c1*x+c0
    A=(2*B+4*x*B.derivative())*C-5*x*B*C.derivative()
    numerator=C**5+s*x**2*B**4
    if mode.startswith('differential'):
        # Differentiating the square identity removes its highest powers.
        # E=C(2A'F+AF')-5C'AF-s*x*B^3; solve its four highest
        # nonzero coefficients successively for the lower terms of F.
        F=x**4/4
        for k in (3,2,1,0):
            E=C*(2*A.derivative()*F+A*F.derivative())-5*C.derivative()*A*F-s*x*B**3
            F-=E[11+k]/(8-2*k)*x**k
        E=C*(2*A.derivative()*F+A*F.derivative())-5*C.derivative()*A*F-s*x*B**3
        assert E.degree()<=10
        equations=list(E)+[4*b0**2*F[0]-c0**3]
        (out/'recovered_F.txt').write_text(str(F)+'\n')
    elif mode=='coefficients':
        f0,f1,f2,f3=ring.gens()[:4]
        remainder=numerator-A**2*(x**4/4+f3*x**3+f2*x**2+f1*x+f0)
        equations=list(remainder)
    else:
        remainder=numerator.mod(A**2)
        equations=list(remainder)
    denominator=s*b0*c0
    if mode in ('resultant','coefficients','differential'): denominator*=B.resultant(C)
    equations.append(inv*denominator-1)
    if not characteristic:
        equations=[ring(v)*ring(v).denominator() for v in equations]
    (out/'equations.txt').write_text('\n'.join(map(str,equations))+'\n')
    (out/'ordinary.ms').write_text(','.join(names)+'\n'+str(characteristic)+'\n'
        +',\n'.join(map(str,equations))+'\n')
    # Supply a separating linear form from the beginning. The coefficient
    # symmetries otherwise make msolve retry several nongeneric variables.
    weights=(1,2,3,5,7,11,13,17,19,23,29,31,37)
    linear=sum(weights[i]*g for i,g in enumerate(ring.gens()))
    (out/'linear.ms').write_text(','.join(names+('z',))+'\n'+str(characteristic)+'\n'
        +',\n'.join(map(str,equations))+',\nz-('+str(linear)+')\n')
    (out/'saturation.ms').write_text(','.join(names[:-1])+'\n'+str(characteristic)+'\n'
        +',\n'.join(map(str,equations[:-1]+[denominator]))+'\n')
    print('characteristic',characteristic,'equations',len(equations),'degrees',
          [p.total_degree() for p in equations],flush=True)
    if '--generate-only' in sys.argv: return
    started=time.time();ideal=ring.ideal(equations)
    basis=ideal.groebner_basis(algorithm='libsingular:slimgb')
    (out/'grevlex.txt').write_text('\n'.join(map(str,basis))+'\n')
    dimension=ideal.dimension()
    print('basis',len(basis),'dimension',dimension,'seconds',time.time()-started,flush=True)
    if dimension==0:
        print('quotient_length',ideal.vector_space_dimension(),flush=True)
        lex=ideal.transformed_basis('fglm')
        (out/'lex.txt').write_text('\n'.join(map(str,lex))+'\n')
        print('lex',len(lex),'seconds',time.time()-started,flush=True)


if __name__=='__main__':main()
