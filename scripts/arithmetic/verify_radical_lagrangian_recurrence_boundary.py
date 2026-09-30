#!/usr/bin/env python3
"""Second arithmetic check of the bounded radical recurrence certificate.

Reconstructs cup matrices through Laurent reduction, verifies every saved
minor by interpolation, and checks the actual saturated section and local
extension for each one-point modification. No height beyond two is used.
"""

import argparse
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("directory")
    args=parser.parse_args()
    directory=Path(args.directory).resolve()
    started=time.monotonic()
    data=json.loads((directory/'result.json').read_text())
    K=GF(25,"a",modulus=PolynomialRing(GF(5),"z")([2,4,1]))
    a=K.gen()
    decode=lambda n: K(n%5)+(n//5)*a
    R=PolynomialRing(K,"t")
    t=R.gen()
    S=PolynomialRing(K,"x")
    x=S.gen()
    P=S([decode(n) for n in [11,22,18,5,19,20,15,16,9,22,1]])
    av=[decode(n) for n in [19,9,15,6,16]]
    bv=[decode(n) for n in [4,16,17,22,14]]
    polynomial=lambda row: R([decode(v) for v in row])
    xpoly=lambda row: S([decode(v) for v in row])
    load_matrix=lambda rows: matrix(R,[[polynomial(v) for v in row] for row in rows])

    # At most 28 evaluations certify a determinant of an affine pencil.
    J=GF(625,"b")
    W=PolynomialRing(J,"w")
    alpha=(W.gen()**2-W.gen()-3).roots()[0][0]
    embedding=K.hom([alpha],J)
    points=list(J)[:28]

    def evaluate(p,value):
        return sum(embedding(coefficient)*value**i for i,coefficient in enumerate(p))

    def specialize(M,value,field=K):
        return matrix(field,[[p(value) for p in row] for row in M.rows()])

    def residue(f):
        if f.degree()==1:
            return K,-f[0]/f[1]
        field=K.extension(f,"r")
        return field,field.gen()

    def cup(height,twist):
        q=5**height
        e=q%3
        full={}
        for h in range(1,6):
            for i,v in enumerate(P**((q-e)//3)):
                degree=i-q*h
                full[degree]=full.get(degree,R(0))+v*(av[h-1]**q-t*bv[h-1]**q)
        limit=-((-6*q-10*e)//3)-1
        reduced={i:v for i,v in full.items() if -limit<=i<=-1}
        result=[]
        for source in range(3):
            n=max(0,(3*q+twist-10*source)//3+1)
            if not n:
                continue
            target=(source+e)%3
            m=max(0,-((twist-3*q-10*target)//3)-1)
            multiplied={}
            for i,v in reduced.items():
                for j,p in enumerate(P**((source+e)//3)):
                    multiplied[i+j]=multiplied.get(i+j,R(0))+v*p
            M=matrix(R,[[multiplied.get(-k-j,R(0)) for j in range(n)] for k in range(1,m+1)])
            result.append((source,target,M))
        return result

    checks=[]
    for result in data['results']:
        height=result['height']
        assert height in (1,2)
        q=5**height
        blocks=cup(height,3)
        global_bad=R(1)
        for (source,target,M),saved in zip(blocks,result['twist3_blocks']):
            assert [source,target]==[saved['source_character'],saved['target_character']]
            assert M==load_matrix(saved['matrix'])
            assert specialize(M,decode(saved['anchor_t'])).rank()==M.ncols()
            selected=R(0)
            for witness in saved['minor_witnesses']:
                minor=M.matrix_from_rows(witness['rows'])
                determinant=polynomial(witness['determinant'])
                assert determinant.degree()<=M.ncols()
                for value in points[:M.ncols()+1]:
                    evaluated=matrix(J,[[evaluate(v,value) for v in row] for row in minor.rows()])
                    assert evaluated.det()==evaluate(determinant,value)
                selected=selected.gcd(determinant)
            assert selected.monic()==polynomial(saved['selected_minor_gcd'])
            bad=[polynomial(row['factor_t']) for row in saved['rank_drop_primes']]
            assert set(bad)==set(f for f,_ in selected.factor())
            for row,f in zip(saved['rank_drop_primes'],bad):
                assert f.is_irreducible()
                field,root=residue(f)
                rank=specialize(M,root,field).rank()
                assert rank==row['rank']<M.ncols()
                global_bad=global_bad.lcm(f)
        assert global_bad.monic()==polynomial(result['twist3_exceptional_t_reduced'])
        assert R([v**q for v in global_bad.monic()])==polynomial(result['twist3_exceptional_c_reduced'])
        for row in result['twist3_specializations']:
            f=polynomial(row['factor_t'])
            field,root=residue(f)
            ranks=[int(specialize(M,root,field).rank()) for _,_,M in blocks]
            assert ranks==row['ranks']
            assert sum(M.ncols() for _,_,M in blocks)-sum(ranks)==row['h0']

        saved=result['one_point_modification']
        c=decode(saved['parameter_c'])
        assert c==0
        blocks4=cup(height,4)
        ranks=[int(specialize(M,c**q).rank()) for _,_,M in blocks4]
        assert ranks==saved['twist4_block_ranks']
        assert sum(M.ncols() for _,_,M in blocks4)-sum(ranks)==1
        source=saved['source_character']
        f=xpoly(saved['source_section'])
        u=xpoly(saved['affine_first_coordinate'])
        M=next(M for s,_,M in blocks4 if s==source)
        assert not specialize(M,c**q)*matrix(K,M.ncols(),1,f.list())
        fraction=S.fraction_field()
        extension_sum=sum(fraction((av[h-1]-c*bv[h-1])**q)*fraction(x)**(-q*h) for h in range(1,6))
        qchar=q%3
        product=P**((q-qchar)//3+(source+qchar)//3)*extension_sum*f
        product_num,product_den=product.numerator(),product.denominator()
        polynomial_part,remainder=product_num.quo_rem(product_den)
        assert polynomial_part==u
        component_character=(source+qchar)%3
        local_order=3*(product_den.degree()-remainder.degree())-10*component_character
        pole=3*f.degree()+10*source
        assert int(local_order)==saved['local_remainder_order']
        assert max(pole-3*q,3*q-local_order)==4
        bezout=saved['bezout']
        if height==1:
            q0=xpoly(bezout['q0'])
            B=xpoly(bezout['B'])
            assert q0*u+B*P*f**3==1
            rational=-fraction(q0)/(P*f)
            assert pole-3*q==4
        else:
            A=xpoly(bezout['A'])
            B=xpoly(bezout['B'])
            assert A*P*u**3+B*f==1
            H=u-P**8*extension_sum*f
            # Choose the local splitting cancelling the first old-frame
            # coordinate, which is the component with pole four here.
            rational=-fraction(A*u**2)/f+1/(P*f*H)
            assert 3*q-local_order==4
        # Extract the actual normalized extension using power-series
        # arithmetic, independently of the builder's coefficient loop.
        numerator,denominator=rational.numerator(),rational.denominator()
        _,proper=numerator.quo_rem(denominator)
        T=PowerSeriesRing(K,"z",default_prec=12)
        z=T.gen()
        series=z**(denominator.degree()-proper.degree())*T(list(reversed(proper.list())))/T(list(reversed(denominator.list())))
        ext=[series[j] for j in range(1,10)]
        assert ext==[decode(v) for v in saved['normalized_extension_y2']]
        assert ext[:8]==[decode(v) for v in saved['modified_extension_y2']]
        hankel=matrix(K,[[ext[k+j-1] for j in range(3)] for k in range(1,7)])
        assert hankel.rank()==3
        assert hankel.matrix_from_rows([0,1,2]).det()==decode(6 if height==1 else 1)
        checks.append({'height':height,'cup_reconstruction':'PASS','minor_interpolation':'PASS',
                       'complete_3O_jump_locus':'PASS','saturated_4O_section':'PASS',
                       'actual_local_modification_extension':'PASS','modified_H0_3':1})
    receipt={'status':'PASS','checks':checks,'seconds':time.monotonic()-started,
             'scope':'Exact finite arithmetic for heights1,2 and one-point modifications; geometric character argument is separate'}
    (directory/'verification.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2),flush=True)


if __name__=='__main__':
    main()
