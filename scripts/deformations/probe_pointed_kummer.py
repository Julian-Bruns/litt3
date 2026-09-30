#!/usr/bin/env sage -python
"""Research prototype: Rosenhain coordinates and the genus-two quintic map.

Reconstruct the cubic backup's theta Kummer surface and Ducrohet's
characteristic-five polynomials. Arithmetic checks are not by themselves
a proof of the moduli dictionary or specialization of the generic formula.
All generated evidence is written outside the research workspace.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import time
from sage.all import *


def normalize(v):
    c=next(a for a in v if a)
    return tuple(a/c for a in v)


def theta_from_rosenhain(lam,mu,nu):
    """Return the compatible SECOND-ORDER theta node of the given curve.

    The intermediate lowercase constants describe a Richelot neighbor
    if they are used directly as a Hudson node.  Use the dual constants
    with their AB/CD sign retained.  The corrected node is independently
    checked by reconstructing the six branch points on a trope conic.
    """
    z=(lam*mu/nu).sqrt()
    ratio=lam/z
    ef=mu/z
    ab_cd=(ef+1)/(ef-1)
    y2=((z+1)**2-ab_cd**2*(z-1)**2)/((ratio+1)**2-ab_cd**2*(ratio-1)**2)
    y=y2.sqrt()
    x=ratio*y
    a,b,c,d=x.sqrt(),y.sqrt(),z.sqrt(),x.parent()(1)
    AA=a*a+b*b+c*c+d*d
    BB=a*a+b*b-c*c-d*d
    CC=a*a-b*b+c*c-d*d
    DD=a*a-b*b-c*c+d*d
    AB=(AA*BB).sqrt()
    CD=AB/ab_cd
    assert CD*CD==CC*DD
    ef_recovered=(AB+CD)/(AB-CD)
    assert (a*a*c*c/(b*b*d*d),c*c*ef_recovered/(d*d),a*a*ef_recovered/(b*b))==(lam,mu,nu)
    dual_a=(AA/4).sqrt()
    dual_b=AB/(4*dual_a)
    dual_c=(CC/4).sqrt()
    dual_d=CD/(4*dual_c)
    assert dual_b**2==BB/4 and dual_d**2==DD/4
    assert dual_a*dual_b/(dual_c*dual_d)==ab_cd
    return (dual_a,dual_b,dual_c,dual_d)


def kummer_from_node(node,ring):
    x=ring.gens();k=ring.base_ring()
    terms=[2*prod(x),x[0]**2*x[1]**2+x[2]**2*x[3]**2,
           x[0]**2*x[2]**2+x[1]**2*x[3]**2,
           x[0]**2*x[3]**2+x[1]**2*x[2]**2]
    S=sum(v**4 for v in x)
    mat=matrix(k,[[term.derivative(v)(node) for term in terms] for v in x])
    target=vector(k,[-S.derivative(v)(node) for v in x])
    coeff=mat.solve_right(target)
    assert mat*coeff==target
    K=S+sum(a*t for a,t in zip(coeff,terms))
    assert K(node)==0 and all(K.derivative(v)(node)==0 for v in x)
    k00,k01,k10,k11=coeff
    assert 4+k01*k10*k11-k01*k01-k10*k10-k11*k11+k00*k00==0
    return K,tuple(coeff)


def ducrohet_quintics(coeff,ring):
    """Proposition6.6: target coefficients, source Frobenius-twisted coordinates."""
    k00,k01,k10,k11=coeff
    x,y,z,w=ring.gens()
    V=x**5
    for v,c in [(y,k01),(z,k10),(w,k11)]:
        V+=c*(c*c+2)*x**3*v**2+(c*c+2)*x*v**4
    V+=(3*k11*(k00*k00+k11*k11)+k01*k10*(1-k11*k11))*x*y*y*z*z
    V+=(3*k10*(k00*k00+k10*k10)+k01*k11*(1-k10*k10))*x*y*y*w*w
    V+=(3*k01*(k00*k00+k01*k01)+k10*k11*(1-k01*k01))*x*z*z*w*w
    V+=(2*k00*(k00*k00+1)-k00*k01*k10*k11)*x*x*y*z*w
    V+=k00*(k01+3*k10*k11)*y**3*z*w
    V+=k00*(k10+3*k01*k11)*y*z**3*w
    V+=k00*(k11+3*k01*k10)*y*z*w**3
    xs=ring.gens()
    return [V(*[xs[j^i] for j in range(4)]) for i in range(4)]


def frobenius_coefficients(poly,power=5):
    return poly.parent()({e:c**power for e,c in poly.dict().items()})


def heisenberg_nodes(node):
    result=set()
    for shift in range(4):
        for character in range(4):
            v=[(-1)**((j&character).bit_count()%2)*node[j^shift] for j in range(4)]
            result.add(normalize(v))
    return sorted(result,key=lambda v:tuple(str(c) for c in v))


def trope_planes(nodes,k):
    result=set()
    for triple in itertools.combinations(nodes,3):
        M=matrix(k,triple)
        if M.rank()!=3:
            continue
        v=M.right_kernel().basis()[0]
        assert M*v==0
        if sum(sum(a*b for a,b in zip(v,n))==0 for n in nodes)==6:
            result.add(normalize(v))
    return sorted(result,key=lambda v:tuple(str(c) for c in v))


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--first-plane-test',action='store_true')
    args=parser.parse_args()
    root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    started=time.monotonic()
    k=GF(5**12,'b')
    U=PolynomialRing(k,'u');u=U.gen()
    alpha=(u**3+u+1).roots(multiplicities=False)[0]
    node=theta_from_rosenhain(k(2),k(3),alpha)
    ring=PolynomialRing(k,names=['x0','x1','x2','x3'])
    K,coeff=kummer_from_node(node,ring)
    nodes=heisenberg_nodes(node)
    assert len(nodes)==16
    for n in nodes:
        assert K(n)==0 and all(K.derivative(v)(n)==0 for v in ring.gens())
    tropes=trope_planes(nodes,k)
    assert len(tropes)==16
    V=ducrohet_quintics(coeff,ring)
    K1=frobenius_coefficients(K)
    quotient,remainder=K(*V).quo_rem(K1)
    assert remainder==0
    # A polynomial square is checked by factorization, with its scalar
    # separately tested in the coefficient field.
    factors=quotient.factor()
    assert all(e%2==0 for _,e in factors)
    square_root=ring(factors.unit().sqrt())*prod(f**(e//2) for f,e in factors)
    assert K(*V)==K1*square_root**2
    receipt=dict(kind='pointed_kummer_prototype',status='arithmetic_only_pending_moduli_audit',
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 field_modulus=str(k.modulus()),alpha=str(alpha),theta_node=list(map(str,node)),
                 coefficients=list(map(str,coeff)),nodes=16,tropes=16,
                 coefficient_field_degrees=[next(i for i in divisors(12) if c**(5**i)==c) for c in coeff],
                 kummer_pullback_square=True,square_degree=int(square_root.degree()),
                 quintic_terms=[len(f.dict()) for f in V],first_plane_charts=[])
    print({key:receipt[key] for key in ['coefficients','coefficient_field_degrees','kummer_pullback_square']},flush=True)
    if args.first_plane_test:
        # Input lies on the Frobenius twist of a trope of the target Kummer.
        ell=vector(k,[c**5 for c in tropes[0]])
        pivot=next(i for i,c in enumerate(ell) if c)
        free=[i for i in range(4) if i!=pivot]
        S=PolynomialRing(k,names=['z0','z1','z2']);zs=S.gens()
        substitution=[S(0)]*4
        for i,z in zip(free,zs):substitution[i]=z
        substitution[pivot]=-sum(ell[i]*substitution[i] for i in free)/ell[pivot]
        forms=[S(f(*substitution)) for f in V]
        for j,z in enumerate(zs):
            ideal=S.ideal(forms+[z-1])
            basis=ideal.groebner_basis()
            empty=len(basis)==1 and basis[0]==1
            receipt['first_plane_charts'].append(dict(chart=j,empty=empty))
            print('plane chart',j,'empty',empty,flush=True)
    receipt['seconds']=round(time.monotonic()-started,2)
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print('Arithmetic prototype complete; no higher-height verdict.',flush=True)


if __name__=='__main__':
    main()
