#!/usr/bin/env python3
"""Bounded height-one/two tests of literal and one-point recurrence.

Run under Sage Python. No height-three calculation is performed.
Generated matrices and selected-minor certificates belong outside litt3.
"""

import argparse
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix

from radical_lagrangian_second_frobenius import bareiss_determinant


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    out = Path(args.output_dir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    started = time.monotonic()
    K = GF(25, "a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
    a = K.gen()
    decode = lambda n: K(n % 5)+(n//5)*a

    def encode(v):
        row = list(K(v).polynomial())
        return int(row[0] if row else 0)+5*int(row[1] if len(row)>1 else 0)

    R = PolynomialRing(K, "t")
    t = R.gen()
    S = PolynomialRing(K, "x")
    P = S([decode(n) for n in [11,22,18,5,19,20,15,16,9,22,1]])
    av = [decode(n) for n in [19,9,15,6,16]]
    bv = [decode(n) for n in [4,16,17,22,14]]
    codes = lambda p: [encode(v) for v in p.list()]
    matrix_codes = lambda M: [[codes(v) for v in row] for row in M.rows()]

    def blocks(height, twist):
        q = 5**height
        exponent = q % 3
        output = []
        for source_character in range(3):
            n = max(0, (3*q+twist-10*source_character)//3+1)
            if not n:
                continue
            target_character = (source_character+exponent) % 3
            m = max(0, -((twist-3*q-10*target_character)//3)-1)
            power = P**((q-exponent)//3+(source_character+exponent)//3)

            def entry(k,j):
                return sum((power[q*h-k-j] if 0<=q*h-k-j<=power.degree() else K(0))
                           *(av[h-1]**q-t*bv[h-1]**q) for h in range(1,6))

            M = matrix(R, [[entry(k,j) for j in range(n)] for k in range(1,m+1)])
            output.append((source_character,target_character,M))
        return output

    def specialize(M, root, field=K):
        return matrix(field, [[v(root) for v in row] for row in M.rows()])

    def residue(f):
        if f.degree()==1:
            return K,-f[0]/f[1]
        field = K.extension(f, "u")
        return field,field.gen()

    results = []
    for height in (1,2):
        q=5**height
        blocks3 = blocks(height,3)
        summaries = []
        exceptional = R(1)
        for source_character,target_character,M in blocks3:
            assert M.nrows()>=M.ncols()
            anchor = next(v for v in K if specialize(M,v).rank()==M.ncols())
            rows = list(specialize(M,anchor).transpose().pivots())
            determinant = bareiss_determinant(M.matrix_from_rows(rows))
            assert determinant
            witnesses = [{"rows":rows,"determinant":codes(determinant)}]
            actual_bad = []
            selected_gcd = determinant.monic()
            for f,multiplicity in determinant.factor():
                field,root=residue(f)
                reduced=specialize(M,root,field)
                rank=int(reduced.rank())
                if rank<M.ncols():
                    actual_bad.append({"factor_t":codes(f),"rank":rank,
                                       "degree":int(f.degree())})
                    exceptional=exceptional.lcm(f)
                else:
                    new_rows=list(reduced.transpose().pivots())
                    minor=bareiss_determinant(M.matrix_from_rows(new_rows))
                    assert minor % f
                    witnesses.append({"rows":new_rows,"determinant":codes(minor)})
                    selected_gcd=selected_gcd.gcd(minor).monic()
            assert set(f for f,_ in selected_gcd.factor()) == set(R([decode(v) for v in row["factor_t"]]) for row in actual_bad)
            summary={"source_character":source_character,"target_character":target_character,
                     "shape":[M.nrows(),M.ncols()],"matrix":matrix_codes(M),
                     "generic_rank":M.ncols(),"anchor_t":encode(anchor),
                     "minor_witnesses":witnesses,"selected_minor_gcd":codes(selected_gcd),
                     "selected_minor_factorization":[{"factor":codes(f),"exponent":int(e)} for f,e in selected_gcd.factor()],
                     "rank_drop_primes":actual_bad}
            summaries.append(summary)
        exceptional=exceptional.monic()
        special=[]
        for f,_ in exceptional.factor():
            field,root=residue(f)
            ranks=[int(specialize(M,root,field).rank()) for _,_,M in blocks3]
            special.append({"factor_t":codes(f),"factor_c_reduced":codes(R([v**q for v in f])),
                            "ranks":ranks,"h0":sum(M.ncols() for _,_,M in blocks3)-sum(ranks)})

        # A single good stable parameter certifies an open set of the
        # normalized one-point modification, without parameter searches.
        c_value=next(v for v in K if v!=decode(11) and exceptional(v**q))
        t_value=c_value**q
        blocks4=blocks(height,4)
        block_ranks=[int(specialize(M,t_value).rank()) for _,_,M in blocks4]
        assert sum(M.ncols() for _,_,M in blocks4)-sum(block_ranks)==1
        unique=[(i,M,specialize(M,t_value)) for i,_,M in blocks4 if specialize(M,t_value).right_kernel().dimension()]
        assert len(unique)==1
        source_character,M,M0=unique[0]
        kernel=list(M0.right_kernel().basis()[0])
        f=S(kernel)
        exponent=q%3
        assert (source_character+exponent)%3 in (0,1)
        u_character=(source_character+exponent)%3
        power=P**((q-exponent)//3+(source_character+exponent)//3)
        terms={}
        for h in range(1,6):
            for j,coefficient in enumerate(power*f):
                e=j-q*h
                terms[e]=terms.get(e,K(0))+coefficient*(av[h-1]-c_value*bv[h-1])**q
        u=S([terms.get(j,K(0)) for j in range(max(terms)+1)])
        # The remaining Laurent coefficients satisfy the required local
        # regularity u-e*v of order >= 3q-4 at O.
        assert all(not value or 3*(-e)-10*u_character>=3*q-4
                   for e,value in terms.items() if e<0)
        quotient_pole=3*f.degree()+10*source_character
        local_order=min(3*(-e)-10*u_character for e,value in terms.items() if e<0 and value)
        assert max(quotient_pole-3*q,3*q-local_order)==4
        if source_character==1:
            # Section s=(u, y*f). Choose w=(p,q0) with det(s,w)=1.
            gcd,q0,B=u.xgcd(P*f**3)
            assert gcd==1 and q0*u+B*P*f**3==1
            numerator=-q0
            denominator=P*f
            bezout={"u":codes(u),"f":codes(f),"q0":codes(q0),"B":codes(B),
                    "identity":"q0*u+B*P*f^3=1"}
        else:
            # Section s=(y*u, f). Choose w=(-B,y^2*A*u^2).
            assert source_character==0 and u_character==1
            gcd,A,B=(P*u**3).xgcd(f)
            assert gcd==1 and A*P*u**3+B*f==1
            numerator=-A*u**2
            denominator=f
            bezout={"u":codes(u),"f":codes(f),"A":codes(A),"B":codes(B),
                    "identity":"A*P*u^3+B*f=1"}
        # The normalized extension is y^2*numerator/denominator. Retain
        # x^-1,...,x^-9 for O(-8O), then x^-1,...,x^-8 after balanced
        # modification at O. Polynomial terms are Cech coboundaries.
        quotient,remainder=numerator.quo_rem(denominator)
        reverse_den=S(list(reversed(denominator.list())))
        reverse_rem=S(list(reversed(remainder.list()))) if remainder else S(0)
        offset=denominator.degree()-remainder.degree() if remainder else 100
        expansion=[]
        for j in range(10):
            target=(reverse_rem[j-offset] if 0<=j-offset<=reverse_rem.degree() else K(0))
            target-=sum(reverse_den[i]*expansion[j-i] for i in range(1,min(j,reverse_den.degree())+1))
            expansion.append(target/reverse_den[0])
        ext=expansion[1:10]
        if quotient_pole-3*q<4:
            # At height two the first local component, not v, has pole
            # four. Cancelling that component changes -q0/v by
            # 1/(v*(u-e*v)); this has order seven and affects only the
            # ninth coefficient of H1(O(-8O)), not its image in
            # H1(O(-6O)) after the balanced modification.
            assert height==2 and quotient_pole==78 and local_order==71
            correction=-1/(f.leading_coefficient()*terms[-27])
            ext[8]+=correction
        modified=ext[:8]
        hankel=matrix(K, [[modified[k+j-1] for j in range(3)] for k in range(1,7)])
        assert hankel.rank()==3
        modification={"parameter_c":encode(c_value),"parameter_t":encode(t_value),
                      "twist4_block_ranks":block_ranks,"source_character":source_character,
                      "local_quotient_pole":int(quotient_pole),"local_remainder_order":int(local_order),
                      "source_section":codes(f),"affine_first_coordinate":codes(u),
                      "bezout":bezout,"normalized_extension_y2":codes(S(ext)),
                      "modified_extension_y2":codes(S(modified)),
                      "modified_H0_3_hankel":[[encode(v) for v in row] for row in hankel.rows()],
                      "modified_H0_3":1,"section_saturated":True}
        result={"height":height,"parameter":"t=c^%s"%q,"twist3_blocks":summaries,
                "twist3_exceptional_t_reduced":codes(exceptional),
                "twist3_exceptional_c_reduced":codes(R([v**q for v in exceptional])),
                "twist3_specializations":special,"one_point_modification":modification}
        results.append(result)
        print(json.dumps({"height":height,"exceptional_c":result["twist3_exceptional_c_reduced"],
                          "specializations":special,
                          "selected_minor_factors":[row["selected_minor_factorization"] for row in summaries],
                          "modified_extension_y2":modification["modified_extension_y2"],
                          "modified_H0_3":modification["modified_H0_3"]}),flush=True)
    receipt={"scope":"Heights one and two, literal recurrence and canonical balanced modification at O only",
             "field":"F25, a^2=a+3; coefficient codes n0+5n1", "results":results,
             "seconds":time.monotonic()-started}
    (out/'result.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps({"status":"PASS","seconds":receipt["seconds"]}),flush=True)


if __name__=="__main__":
    main()
