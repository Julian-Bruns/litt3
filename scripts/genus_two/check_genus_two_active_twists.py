#!/usr/bin/env sage-python
"""Exact affine-orbit certificate for genus-two critical data and twists.

Run with sage -python. The default proves generic nonvanishing by exact
F5[t] factors; --backup checks the actual cubic parameter. Split twists
are covered by the dormant-tangent theorem, not enumerated here.
"""
import argparse
import itertools
import json
from math import comb
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, gcd, matrix, prod


IDS=[(i,5) for i in range(5)]+list(itertools.combinations(range(5),2))


def blocks(A,R,S,ring):
    B=A*S*S
    return matrix(ring,2,2,lambda i,j:B[5*i+4-j]),(A*R*R)[4]


def affine_orbits():
    # z=1/(u-4); label4 is the variable branch point, label5 is infinity.
    labels={0:1,1:3,2:2,3:4,5:0}; inverse={v:k for k,v in labels.items()}
    lookup={frozenset(pair):i for i,pair in enumerate(IDS)}
    permutations=[]
    for a in range(1,5):
        for b in range(5):
            perm={i:inverse[(a*v+b)%5] for i,v in labels.items()};perm[4]=4
            permutations.append([lookup[frozenset(perm[j] for j in pair)] for pair in IDS])
    unseen=set(itertools.product(range(15),repeat=2));orbits=[]
    while unseen:
        source,target=min(unseen)
        orbit={(perm[source],perm[target]) for perm in permutations}
        unseen-=orbit;orbits.append((source,target,sorted(orbit)))
    assert len(orbits)==14 and sum(len(v) for s,t,v in orbits)==225
    return orbits


def generic_check():
    prime=GF(5); T=PolynomialRing(prime,'t'); t=T.gen(); K=T.fraction_field()
    U=PolynomialRing(K,'u');u=U.gen();roots=[K(0),K(1),K(2),K(3),K(t)]
    F=prod(u-r for r in roots)
    Rs=[prod(u-roots[i] for i in pair if i!=5) for pair in IDS]
    H=PolynomialRing(K,'h');h=H.gen();P=PolynomialRing(H,'x');x=P.gen()

    def factor_record(value,bound):
        value=K(value)
        assert value and value.denominator()==1
        polynomial=T(value.numerator());factors=polynomial.factor()
        assert all(g.degree()<=bound for g,e in factors)
        assert factors.value()==polynomial
        return dict(coefficients=[int(c) for c in polynomial],unit=int(factors.unit()),
                    factors=[dict(coefficients=[int(c) for c in g],multiplicity=int(e)) for g,e in factors],
                    factor_degrees=[int(g.degree()) for g,e in factors])

    def source_data(source):
        R=Rs[source];S=F//R;D=R*S*S
        J=R.derivative()*S+2*R*S.derivative()
        sixth=sum((prime(comb(i,6))*D[i]*u**(i-6) for i in range(6,D.degree()+1)),U.zero())
        return R,S,J,sixth,(S*R*R)[4]

    critical=[]
    for source in (0,4):
        R,S,J,sixth,c=source_data(source)
        assert J.degree()==4 and J.leading_coefficient() in prime
        Q=U.quotient(J,'r');r=Q.gen();V=PolynomialRing(Q,'x');xx=V.gen()
        FF=V(list(F))
        for A in (Q(sixth)*V(list(R))*(xx-r)**2,V(list(c*S))):
            cartier=FF**2*A**4
            assert all(cartier[5*i+4]==A[i]**5 for i in range(5))
        critical.append(dict(source=source,discriminant=factor_record(J.discriminant(),6),
                             critical_K=factor_record(J.resultant(sixth),3),
                             branch_c=factor_record(c,1),
                             generic_quartic_identities=['branch','entire critical algebra']))
    records=[];bad=set()
    for source,target,orbit in affine_orbits():
        R,S,J,sixth,c=source_data(source)
        R1=P(list(Rs[target]));S1=P(list(F//Rs[target]))
        A=H(list(sixth))*P(list(R))*(x-h)**2
        B,scalar=blocks(A,R1,S1,H)
        resultant=H(list(J)).resultant(B.det()*scalar)
        fiber=factor_record(resultant,9)
        B0,scalar0=blocks(P(list(c*S)),R1,S1,H)
        branch_det=factor_record(B0.det()[0],2)
        if scalar0:
            branch_product=factor_record((B0.det()*scalar0)[0],2)
        else:
            assert (source,target)==(4,7)
            branch_product=None;bad.update(orbit)
        records.append(dict(source=source,target=target,orbit_size=len(orbit),
                            fiber_resultant=fiber,branch_determinant=branch_det,
                            branch_product=branch_product))
    expected={(4,7),(4,9),(8,2),(8,10),(11,0),(11,12),(13,3),(13,5),(14,1),(14,6)}
    assert bad==expected
    return dict(status='PASS',mode='symbolic affine orbits',class_labels=[list(p) for p in IDS],
                critical_representatives=critical,twist_representatives=records,
                represented_nonzero_class_pairs=225,identically_bad_pairs=[list(p) for p in sorted(bad)],
                critical_parameter_degree_bound=6,full_twist_parameter_degree_bound=9,
                split_twists='V_d1 direct-sum V_d2; all two-torsion dormant tangents vanish by the count theorem.')


def backup_check():
    prime=GF(5);Z=PolynomialRing(prime,'z');z=Z.gen();modulus=z**3+z+1
    assert modulus.is_irreducible()
    k=GF(125,'a',modulus=modulus);alpha=k.gen();U=PolynomialRing(k,'u');u=U.gen()
    roots=[k(0),k(1),k(2),k(3),alpha];F=prod(u-r for r in roots)
    Rs=[prod(u-roots[i] for i in pair if i!=5) for pair in IDS]
    checks=identities=0;records=[]
    for source,R in enumerate(Rs):
        S=F//R;D=R*S*S;J=R.derivative()*S+2*R*S.derivative()
        sixth=sum((k(comb(i,6))*D[i]*u**(i-6) for i in range(6,D.degree()+1)),U.zero())
        c=(S*R*R)[4]
        assert J.degree()==4 and gcd(J,J.derivative())==gcd(J,sixth)==1 and c
        for kind in ('branch','mixed'):
            Qpoly=J if kind=='mixed' else u
            Q=U.quotient(Qpoly,'h');h=Q.gen();P=PolynomialRing(Q,'x');x=P.gen();FF=P(list(F))
            A=Q(sixth)*P(list(R))*(x-h)**2 if kind=='mixed' else P(list(c*S))
            cartier=FF**2*A**4
            assert all(cartier[5*i+4]==A[i]**5 for i in range(5))
            identities+=Qpoly.degree()
            factors=[factor.monic() for factor,multiplicity in Qpoly.factor()]
            local_bad={str(factor):[] for factor in factors}
            for target,R1 in enumerate(Rs):
                B,scalar=blocks(A,P(list(R1)),P(list(F//R1)),Q)
                determinant=B.det()*scalar;checks+=Qpoly.degree()
                for factor in factors:
                    if U(determinant.lift())%factor==0:
                        rank2=2 if U(B.det().lift())%factor else int(any(U(entry.lift())%factor for entry in B.list()))
                        scalar_rank=int(bool(U(scalar.lift())%factor))
                        local_bad[str(factor)].append(dict(target=target,corank=3-rank2-scalar_rank,
                                                          rank_two_block=rank2,rank_scalar=scalar_rank))
            for factor in factors:
                records.append(dict(kind=kind,source=source,factor=str(factor),
                                    geometric_connections=int(factor.degree()),bad_twists=local_bad[str(factor)]))
    assert identities==75 and checks==1125
    histogram={}
    for record in records:
        count=len(record['bad_twists'])
        histogram[count]=histogram.get(count,0)+record['geometric_connections']
    assert histogram=={0:69,2:6}
    return dict(status='PASS',mode='actual cubic backup',parameter_modulus=str(modulus),
                nonsplit_connections=75,nonsplit_quartic_identity_checks=int(identities),
                nonsplit_nontrivial_twist_tests=int(checks),nonsplit_bad_twist_histogram=histogram,
                geometric_bad_pairs=sum(r['geometric_connections']*len(r['bad_twists']) for r in records),
                bad_records=[r for r in records if r['bad_twists']],
                split_twists='Ten split active points have no bad twists by dormant-tangent direct sum; not numerical tests.')


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backup',action='store_true')
    parser.add_argument('--output',required=True)
    args=parser.parse_args();output=Path(args.output)
    if output.exists():raise FileExistsError(output)
    started=time.monotonic();result=backup_check() if args.backup else generic_check()
    result['seconds']=time.monotonic()-started
    output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(status=result['status'],mode=result['mode'],seconds=result['seconds'])),flush=True)


if __name__=='__main__':main()
