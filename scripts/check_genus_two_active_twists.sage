"""Exact small certificate for the active Pic[2] table; NOT a common-cover test.
Run with sage; --output optionally saves the executed summary. Symbolic zero identities plus one
finite-field specialization certify the bounded parameter polynomials.
"""
import argparse, itertools, json, time
from pathlib import Path
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backup',action='store_true',
    help='Check the actual degree-three backup parameter instead of the degree-thirteen witness.')
parser.add_argument('--output', help='Write the complete executed summary as JSON')
args=parser.parse_args()
started=time.monotonic()
F5=GF(5); Z=PolynomialRing(F5,'z'); z=Z.gen()
modulus=z**3+z+1 if args.backup else z**13+4*z**2+3*z+3
assert modulus.is_irreducible()
k=GF(5**modulus.degree(),'a',modulus=modulus); a=k.gen()
U=PolynomialRing(k,'u'); u=U.gen()
roots=[k(0),k(1),k(2),k(3),a]
F=prod(u-r for r in roots)
ids=[(i,) for i in range(5)]+list(itertools.combinations(range(5),2))
Rs=[prod(u-roots[i] for i in pair) for pair in ids]
expected={(4,7),(4,9),(8,2),(8,10),(11,0),(11,12),
          (13,3),(13,5),(14,1),(14,6)}

def blocks(A,R,S,ring):
    B=A*S**2
    return matrix(ring,2,2,lambda i,j:B[5*i+4-j]),(A*R**2)[4]

# Prove the ten claimed scalar zeroes identically, not only at a point.
TT=PolynomialRing(F5,'t'); tt=TT.gen()
UU=PolynomialRing(TT,'u'); uu=UU.gen()
rr=[TT(0),TT(1),TT(2),TT(3),tt]
FF=prod(uu-r for r in rr)
RR=[prod(uu-rr[i] for i in pair) for pair in ids]
for source,target in expected:
    R0=RR[source]; S0=FF//R0; c=(S0*R0**2)[4]
    assert (c*S0*RR[target]**2)[4]==0

bad=set(); checks=0; eigen_checks=0; backup_records=[]
for source,R in enumerate(Rs):
    S=F//R; D=R*S**2; J=R.derivative()*S+2*R*S.derivative()
    K=sum(k(binomial(i,6))*D[i]*u**(i-6) for i in range(6,D.degree()+1))
    c=(S*R**2)[4]
    assert J.degree()==4 and gcd(J,J.derivative())==gcd(J,K)==1 and c!=0
    for kind in ['branch','mixed']:
        Qpoly=J if kind=='mixed' else u
        Q=U.quotient(Qpoly,'h'); h=Q.gen()
        P=PolynomialRing(Q,'x'); x=P.gen(); FF=P(list(F))
        A=Q(K)*P(list(R))*(x-h)**2 if kind=='mixed' else P(list(c*S))
        C=FF**2*A**4
        assert all(C[5*i+4]==A[i]**5 for i in range(5))
        eigen_checks+=Qpoly.degree()
        M=matrix(Q,3,3,lambda i,j:(FF**2*A)[5*i+4-j])
        assert gcd(U(M.det().lift()),Qpoly)==1
        factors=[factor.monic() for factor,multiplicity in Qpoly.factor()]
        local_bad={str(factor):[] for factor in factors}
        for target,R1 in enumerate(Rs):
            M,c1=blocks(A,P(list(R1)),P(list(F//R1)),Q)
            determinant=M.det()*c1
            count=gcd(U(determinant.lift()),Qpoly).degree()
            checks+=Qpoly.degree()
            if count:
                if not args.backup:
                    assert kind=='branch' and count==1
                    assert c1==0 and M.det()!=0
                if kind=='branch':
                    bad.add((source,target))
                if args.backup:
                    for factor in factors:
                        if U(determinant.lift()) % factor == 0:
                            rank2=2 if U(M.det().lift()) % factor != 0 else int(any(
                                U(entry.lift()) % factor != 0 for entry in M.list()))
                            scalar_rank=int(U(c1.lift()) % factor != 0)
                            local_bad[str(factor)].append(dict(target=int(target),
                                corank=int(3-rank2-scalar_rank),
                                rank_two_block=int(rank2),rank_scalar=int(scalar_rank)))
        if args.backup:
            for factor in factors:
                backup_records.append(dict(kind=kind,source=int(source),
                    factor=str(factor),geometric_connections=int(factor.degree()),
                    bad_twists=local_bad[str(factor)]))
if not args.backup:
    assert bad==expected

# The ten split data: include every root, not just rational dormant points.
T=PolynomialRing(k,'T'); lam=T.gen()
WW=lam**2+3*F[4]*lam+3*F[3]
VV=-F[2]+(F[4]+2*lam)*WW
psi=2*F[0]-2*F[1]*lam+F[2]*WW-VV*WW
assert gcd(psi,psi.derivative())==1
degrees=[f.degree() for f,e in psi.factor()]; m=lcm(degrees)
if m==1:
    ee=k; emb=k.hom([a],k)
else:
    ee,emb=k.extension(m,'b',map=True)
TE=PolynomialRing(ee,'T'); psiE=TE([emb(c) for c in psi.list()])
lams=psiE.roots(multiplicities=False); assert len(lams)==5
P=PolynomialRing(ee,'x'); x=P.gen(); FF=P([emb(c) for c in F.list()])
RRE=[P([emb(c) for c in R.list()]) for R in Rs]
def numerator(l):
    w=l**2+3*FF[4]*l+3*FF[3]
    v=-FF[2]+(FF[4]+2*l)*w
    return 2*x**3+l*x**2+w*x+v
for split_id,(la,mu) in enumerate(itertools.combinations(lams,2)):
    A=(3*(numerator(la)-numerator(mu)))**2
    C=FF**2*A**4
    assert all(C[5*i+4]==A[i]**5 for i in range(5))
    eigen_checks+=1
    assert matrix(ee,3,3,lambda i,j:(FF**2*A)[5*i+4-j]).det()!=0
    split_bad=[]
    for target,R1 in enumerate(RRE):
        M,c1=blocks(A,R1,FF//R1,ee)
        if not args.backup:
            assert M.det()*c1!=0
        elif M.det()*c1==0:
            split_bad.append(dict(target=int(target),corank=int(3-M.rank()-int(c1!=0)),
                rank_two_block=int(M.rank()),rank_scalar=int(c1!=0)))
        checks+=1
    if args.backup:
        backup_records.append(dict(kind='split',source=int(split_id),
            geometric_connections=1,bad_twists=split_bad))
assert checks==1275 and eigen_checks==85
if args.backup:
    histogram={}
    for record in backup_records:
        count=len(record['bad_twists'])
        histogram[count]=histogram.get(count,0)+record['geometric_connections']
    assert sum(histogram.values())==85
    backup_summary=dict(backup_bad_twist_histogram=histogram,
        geometric_bad_pairs=sum(r['geometric_connections']*len(r['bad_twists'])
            for r in backup_records),
        bad_records=[r for r in backup_records if r['bad_twists']])
else:
    backup_summary={}
result=dict(status='PASS',active_connections=85,
    geometric_nontrivial_twist_tests=checks,identically_bad_twists=len(expected),
    parameter_degree_bound=None if args.backup else 828,
    specialization='actual backup C_alpha' if args.backup else 'nonzero-polynomial witness',
    parameter_modulus=str(modulus),
    dormant_factor_degrees=[int(d) for d in degrees],
    seconds=float(time.monotonic()-started),
    scope='Exact endpoint/double-cover table, not arbitrary common-source ordinariness.',
    **backup_summary)
if args.output:
    Path(args.output).write_text(json.dumps(result,indent=2,default=int)+'\n')
print(json.dumps(result,indent=2,default=int))
