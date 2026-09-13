#!/usr/bin/env sage-python
"""Check coefficient-span certificates for actual abelian-cover flags.

Reconstruct the Frobenius-fixed bases and quadratic/dual coefficient spans;
no enumeration of cyclic directions, planes or truncated quotient lengths.
The all-exponent lengths are proved in frobenius_truncated_hypersurfaces.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, vector


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    output=Path(args.output)
    if output.exists():
        raise FileExistsError(output)
    started=time.monotonic()
    data=Path(__file__).resolve().parents[2]/'Research/computations'
    prime=GF(5); zz=PolynomialRing(prime,'z')
    small=GF(125,name='a',modulus=zz([1,1,0,1]))
    ext,embed=small.extension(4,'b',map=True); beta=ext.gen()
    alpha=embed(small.gen())
    assert ext.degree()==12
    decode=lambda co:sum((ext(c)*alpha**i for i,c in enumerate(co)),ext.zero())
    encode=lambda x:[prime(ext(x).polynomial()[i]) for i in range(12)]
    flatten=lambda v:vector(prime,[c for x in v for c in encode(x)])
    unflatten=lambda v:vector(ext,[sum((ext(v[12*j+i])*beta**i for i in range(12)),ext.zero()) for j in range(3)])
    polynomial=PolynomialRing(ext,'u'); u=polynomial.gen()
    f=u*(u-1)*(u-2)*(u-3)*(u-alpha); fsq=f*f
    span_a=[[1,0,0,0,0,0],[0,1,0,0,0,0],[0,0,1,0,0,0],[0,0,0,1,0,0]]
    span_b=[[1,0,0,0,0,0],[0,1,3,0,0,0],[0,0,0,1,0,0]]
    span_c=[[1,0,0,3,0,0],[0,1,0,2,0,0],[0,0,1,4,0,0]]
    span_d=[[1,0,0,0,0,0],[0,1,0,0,0,0],[0,0,0,1,0,0]]
    spans={'A':span_a,'B':span_b,'C':span_c,'D':span_d}
    records=[]
    for index in range(12):
        path=data/('backup_bad_double_jet_%d.json'%index)
        raw=json.loads(path.read_text())
        rr=polynomial([decode(c) for c in raw['R']]); ss,rem=f.quo_rem(rr)
        assert not rem
        frob=matrix(ext,[[fsq[4],fsq[9],0],[fsq[3],fsq[8],0],[0,0,(ss*ss)[4]]])
        assert frob==matrix(ext,[[decode(c) for c in row] for row in raw['H1O_frobenius']])
        assert frob.det()
        columns=[]
        for j in range(3):
            for i in range(12):
                v=vector(ext,[0,0,0]); v[j]=beta**i
                columns.append(flatten(frob*vector(ext,[c**5 for c in v])-v))
        fixed=[unflatten(v) for v in matrix(prime,columns).transpose().right_kernel().basis()]
        assert len(fixed)==3 and matrix(ext,fixed).det()
        assert all(frob*vector(ext,[c**5 for c in v])==v for v in fixed)
        assert fixed[0][2]==fixed[1][2]==fixed[2][0]==fixed[2][1]==0
        quadratic={tuple(map(int,key.split(','))):decode(value)
                   for key,value in raw['scalar_jet'].items() if sum(map(int,key.split(',')))==2}
        unit=[vector(ext,[int(i==j) for i in range(3)]) for j in range(3)]
        evaluate=lambda v:sum((co*ext.prod(v[i]**powers[i] for i in range(3)) for powers,co in quadratic.items()),ext.zero())
        hessian=matrix(ext,3,3,lambda i,j:evaluate(unit[i]+unit[j])-evaluate(unit[i])-evaluate(unit[j]))
        assert hessian==matrix(ext,[[decode(c) for c in row] for row in raw['hessian']])
        V=matrix(ext,[[c**5 for c in v] for v in fixed]); H=V*hessian*V.transpose()
        assert H.rank()==(2 if raw['kind']=='branch' else 3)
        certificates={}
        for label,G in [('quadratic',H),('dual',H.adjugate())]:
            coeff=[G[i,i] for i in range(3)]+[2*G[i,j] for i,j in [(0,1),(0,2),(1,2)]]
            row_basis=[list(map(int,v)) for v in matrix(prime,[encode(x) for x in coeff]).transpose().row_space().basis()]
            expected=('B' if index==9 else 'C' if index==11 else 'A') if label=='quadratic' else ('D' if raw['kind']=='branch' else 'A')
            assert row_basis==spans[expected],(index,label,row_basis)
            certificates[label]=expected
        records.append(dict(case=index,kind=raw['kind'],source=raw['source_index'],target=raw['twist_index'],
                            input_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            fixed_dimension=3,gram_rank=int(H.rank()),spans=certificates))

    k=GF(25,name='a',modulus=zz([3,0,1])); a=k.gen()
    ring=PolynomialRing(k,'t'); t=ring.gen(); field=ring.fraction_field()
    aa,bb,cc,dd,ee=map(field,[3*t*t+4*t+1,3*t+3,3*t*t+3*t,t*t+4*t+3,t*t+2*t+3])
    c=field(a)/(t+1)
    assert 3*c*c+4/(t+1)**2==0
    s5=(ee**5*c-aa**5*c**5)/bb**5
    s=(cc**5*c**5+dd**5*s5)/ee**5
    obstruction=s**5-s5
    numerator,denominator=obstruction.numerator(),obstruction.denominator()
    normalized=ring(numerator/a)
    assert normalized.degree()==76 and all(x**5==x for x in normalized)
    allowed=(t+1)*(t*t+2*t+3)
    assert all(allowed%g==0 for g,_ in denominator.factor())
    prime_ring=PolynomialRing(prime,'t'); t0=prime_ring.gen()
    normalized=prime_ring([prime(x) for x in normalized])
    factors=normalized.factor()
    assert sorted((int(g.degree()),int(e)) for g,e in factors)==[(1,1),(1,1),(10,1),(18,1),(23,1),(23,1)]
    assert normalized.gcd(t0**3+t0+1)==1
    generic=dict(normalized_numerator=[int(x) for x in normalized],
                 irreducible_factors=[dict(coefficients=[int(x) for x in g],multiplicity=int(e)) for g,e in factors],
                 factor_degrees=[int(g.degree()) for g,e in factors],backup_coprime=True,
                 denominator_support='(t+1)(t^2+2t+3)',sufficient_F5_degree=23)
    result=dict(status='PASS',monomials=['x^2','y^2','z^2','xy','xz','yz'],coefficient_spans=spans,
                cases=records,generic_cyclic_test=generic,seconds=time.monotonic()-started)
    output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(status='PASS',cases=len(records),factor_degrees=generic['factor_degrees'],seconds=result['seconds'])),flush=True)


if __name__=='__main__':
    main()
