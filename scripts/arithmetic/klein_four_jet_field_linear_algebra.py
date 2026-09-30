#!/usr/bin/env python3
"""Small exact certificate replacing the large endpoint field-jet test.

Only four-dimensional F25 linear algebra is needed. This proves the
coefficient-field obstruction for all geometric 29th-root labels; it does
not enumerate their exponents or any higher curve coefficients.
"""
import argparse
import itertools
import json
from pathlib import Path
import klein_four_constant_character_jet as J

F=J.F


def determinant(columns):
    n=len(columns)
    assert n==4
    result=0
    for p in itertools.permutations(range(n)):
        v=1
        for i,j in enumerate(p):v=F.f.mul(v,columns[j][i])
        if sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))%2:v=F.f.neg(v)
        result=F.f.add(result,v)
    return result


def solve(columns,value):
    den=determinant(columns)
    assert den
    out=[]
    for i in range(4):
        cs=list(columns);cs[i]=value
        out.append(F.f.mul(determinant(cs),F.f.inv(den)))
    direct=F.ZERO
    for c,b in zip(out,columns):direct=F.ea(direct,F.es(b,c))
    assert direct==value
    return out


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    data=F.construct_data()
    roots=list(map(tuple,data['alpha_roots']))
    bases=list(map(tuple,data['B_base']))
    first=[F.es(F.em(F.ep(b,4),F.ei(F.ev(F.f.der(F.f.A),a))),13)
           for a,b in zip(roots,bases)]
    normal_det=determinant(bases)
    assert normal_det
    coords=[solve(bases,a) for a in roots]
    expected=[[21,19,13,23],[23,21,19,13],[13,23,21,19],[19,13,23,21]]
    assert coords==expected
    pairs=[]
    for i,j in itertools.combinations(range(4),2):
        det=determinant([bases[i],bases[j],first[i],first[j]])
        assert det
        pairs.append({'roots':[i,j],'mixed_basis_determinant':det})
    for i in range(4):
        ratio=F.em(first[i],F.ei(bases[i]))
        assert any(ratio[1:])
    zero_values=missing_coordinates=distinct_roots=0
    permitted=[]
    # All branch assignments, retaining the three actual Fourier signs.
    for tags in itertools.product(range(4),repeat=4):
        possibilities=[]
        for index,signs in enumerate(J.SIGNS):
            av=F.ZERO
            signed_counts=[0]*4
            for tag,sign in zip(tags,signs):
                av=F.ea(av,F.es(roots[tag],sign))
                signed_counts[tag]=(signed_counts[tag]+sign)%5
            if av==F.ZERO:
                zero_values+=1
                # If the alpha sum is zero, each occurring root appears
                # equally often in the positive and negative half.
                assert signed_counts==[0]*4
                assert len(set(tags))<=2
                continue
            coeff=solve(bases,av)
            if len(set(tags))<4:
                assert any(coeff[j] for j in range(4) if j not in tags)
                missing_coordinates+=1
                continue
            distinct_roots+=1
            signed=[F.f.mul(sign,coeff[tag]) for tag,sign in zip(tags,signs)]
            assert all(signed)
            if len(set(signed))==1:
                possibilities.append(index)
                permitted.append({'roots':tags,'character':index,'common_coefficient':signed[0]})
        assert len(possibilities)<=1
        if len(set(tags))==4:assert len(possibilities)==1
    assert len(permitted)==24
    assert pow(5,9,29)==4
    assert __import__('math').gcd(29,24)==1
    out={'status':'PASS','scope':'All geometric forced labels by exact F25 basis algebra, with no 29th-root exponent search.',
         'root_data':data,'normal_basis_determinant':normal_det,
         'alpha_coordinates_in_B_basis':coords,'mixed_basis_determinants':pairs,
         'assignments':256,'character_tests':768,
         'zero_alpha_sums':zero_values,'missing_coordinate_obstructions':missing_coordinates,
         'four_distinct_root_characters':distinct_roots,
         'only_possible_rational_value_cases':permitted,
         'conclusion':'At most one character with B_i nonzero can have both ratio value and derivative in F25^7. Any such character forces four distinct alpha labels and a common zeta exponent.'}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: B labels form a normal basis; six mixed determinants nonzero; all768 signed root cases.')
    print('Normal determinant:',normal_det,'mixed determinants:',[x['mixed_basis_determinant'] for x in pairs])
    print('Counts:',zero_values,missing_coordinates,distinct_roots,'permitted:',len(permitted))


if __name__=='__main__':main()
