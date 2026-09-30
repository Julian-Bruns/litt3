#!/usr/bin/env python3
"""Check constants, field models, endpoint jets and finite arithmetic independently."""
from pathlib import Path
from itertools import combinations, combinations_with_replacement
import argparse
import json
import math
import platform
from ff25 import *
from make_constants import ROOT, MOD, kmul, kpow, kval, reconstruct, header_text


def pmpow(a, n, modulus):
    out = [1]
    while n:
        if n & 1:
            out = pmod(pmul(out,a),modulus)
        a = pmod(pmul(a,a),modulus)
        n //= 2
    return out


def rank_matrix(rows):
    a = [list(r) for r in rows]
    if not a:
        return 0
    rank = 0
    for j in range(len(a[0])):
        pivot = next((i for i in range(rank,len(a)) if a[i][j]),None)
        if pivot is None:
            continue
        a[rank],a[pivot] = a[pivot],a[rank]
        s = inv(a[rank][j])
        a[rank] = [mul(x,s) for x in a[rank]]
        for i in range(len(a)):
            if i != rank and a[i][j]:
                s = a[i][j]
                a[i] = [sub(x,mul(s,y)) for x,y in zip(a[i],a[rank])]
        rank += 1
        if rank == len(a):
            break
    return rank


def determinant(rows):
    a = [list(r) for r in rows]
    d = 1
    for j in range(len(a)):
        p = next((i for i in range(j,len(a)) if a[i][j]),None)
        if p is None:
            return 0
        if p != j:
            a[j],a[p] = a[p],a[j]
            d = neg(d)
        pivot = a[j][j]
        d = mul(d,pivot)
        a[j] = [div(x,pivot) for x in a[j]]
        for i in range(j+1,len(a)):
            s = a[i][j]
            a[i] = [sub(x,mul(s,y)) for x,y in zip(a[i],a[j])]
    return d


def main():
    if not __debug__:
        raise RuntimeError('Run without Python -O: assertions are verification checks')
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path)
    args = parser.parse_args()
    fields = json.loads((ROOT/'data/field_data.json').read_text())
    problem = json.loads((ROOT/'data/problem.json').read_text())
    assert problem['P'] == P and problem['A'] == A
    assert fields['base_field_modulus'] == problem['F25_modulus_ascending_over_F5'] == [2,4,1]
    checks = []

    for a in range(25):
        assert add(a,neg(a)) == 0
        if a:
            assert mul(a,inv(a)) == 1
        for b in range(25):
            assert add(a,b) == add(b,a) and mul(a,b) == mul(b,a)
            for c in range(25):
                assert mul(a,mul(b,c)) == mul(mul(a,b),c)
                assert mul(a,add(b,c)) == add(mul(a,b),mul(a,c))
    assert mul(5,5) == add(5,3)
    checks.append('F25 field arithmetic: exhaustive inverses, associativity, distributivity')
    assert pgcd(P,pder(P)) == [1]
    assert pgcd(A,pder(A)) == [1]
    assert pgcd(P,A) == [1]
    assert pmonic(A) == MOD == fields['alpha_modulus']
    assert pmpow([0,1],25**4,MOD) == [0,1]
    assert pgcd(psub(pmpow([0,1],25**2,MOD),[0,1]),MOD) == [1]
    checks.append('P,A squarefree and coprime; A/A4 is the irreducible quartic alpha model')

    product = [1]
    for f in fields['cyclotomic_factors']:
        assert len(f) == 8
        assert pmpow([0,1],29,f) == [1]
        assert pmpow([0,1],25**7,f) == [0,1]
        assert pgcd(psub(pmpow([0,1],25,f),[0,1]),f) == [1]
        product = pmul(product,f)
    assert product == [1]*29
    assert fields['zeta_modulus'] in fields['cyclotomic_factors']
    checks.append('all four degree-seven cyclotomic factors verified; zeta has order 29')

    data = reconstruct()
    assert data == json.loads((ROOT/'data/endpoint_data.json').read_text())
    assert header_text(data,fields['zeta_modulus']) == (ROOT/'src/field_constants.h').read_text()
    constants_B = []
    for i in range(4):
        alpha = data['alpha'][i]
        assert kval(A,alpha) == [0]
        ap,pa = kval(pder(A),alpha),kval(P,alpha)
        B = pscale(kmul(kpow(ap,3),kpow(pa,2)),div(3,pow_(A[4],3)))
        assert kpow(data['b'][i],29) == B
        constants_B.append(tuple(B))
    assert len(set(map(tuple,data['alpha']))) == 4
    assert len(set(constants_B)) == 4
    cmat = [[data['C'][j][i] if i<len(data['C'][j]) else 0 for j in range(4)] for i in range(4)]
    mmat = [[data['M'][j][i] if i<len(data['M'][j]) else 0 for j in range(4)] for i in range(4)]
    assert rank_matrix(cmat) == 4
    assert rank_matrix(mmat) == 3  # recorded; no false normal-basis claim about M
    cs,ms = [0],[0]
    for c,m in zip(data['C'],data['M']):
        cs,ms = padd(cs,c),padd(ms,m)
    assert cs == [5] and ms == [22]
    checks.append('all endpoint constants reconstructed, C rank 4, M rank 3, traces 5 and 22')

    f = fields['zeta_modulus']
    zs = [pmpow([0,1],j,f)+[0]*7 for j in range(29)]
    zs = [z[:7] for z in zs]
    independent_sets = 0
    for indices in combinations(range(29),4):
        assert rank_matrix([[zs[j][i] for j in indices] for i in range(7)]) == 4
        independent_sets += 1
    sum_counts = {}
    for size in (2,3,4):
        seen = set()
        for indices in combinations_with_replacement(range(29),size):
            z = [0]*7
            for j in indices:
                z = [add(a,b) for a,b in zip(z,zs[j])]
            key = tuple(z)
            assert key not in seen
            seen.add(key)
        assert len(seen) == math.comb(29+size-1,size)
        sum_counts[str(size)] = len(seen)
    checks.append('all 23751 four-root sets independent; all size 2/3/4 root-multiset sums distinct')

    a = mul(4,P[9])
    gamma = div(5,a)
    assert a == 8 and gamma == 13
    assert pow_(gamma,5) == 15 and div(pow_(gamma,5),gamma) == 19 != 1
    assert math.gcd(25**4-1,29) == 1
    assert math.gcd(8,14) == 2 and math.lcm(8,14) == 56
    assert next(i for i in range(1,29) if pow(5,i,29)==1) == 14
    assert next(i for i in range(1,29) if pow(25,i,29)==1) == 7
    assert pow(5,7,29) == 28
    checks.append('arithmetic used in the epsilon-in-F_(5^56) descent lemma')

    assert div(4,13%5) == 3
    assert div(2,48%5) == 4
    local = {}
    for e in (1,3):
        coeff = [(17+3*j*pow(e,-1,5)-48*4*pow(13,-1,5))%5 for j in range(1,5)]
        allowed = [j for j,c in enumerate(coeff,1) if c==0]
        assert allowed == ([4] if e==1 else [2])
        local[str(e)] = {'first_difference_coefficients_j1_to_j4':coeff,'allowed_first_exponent':allowed}
    checks.append('universal local coefficient and resonance arithmetic, not a sampled jet search')
    result = {
        'status':'passed', 'python':platform.python_version(), 'checks':checks,
        'C_determinant_F25_code':determinant(cmat), 'C_rank':4, 'M_rank':3,
        'C_trace_code':5, 'M_trace_code':22,
        'A_endpoint_B_rows':[list(x) for x in constants_B],
        'four_root_independent_sets':independent_sets,
        'root_multiset_sum_counts':sum_counts,
        'inverse_29_mod_390624':pow(29,-1,25**4-1),
        'a_code':a, 'gamma_code':gamma, 'bar_gamma_over_gamma_code':19,
        'local_coefficient_checks':local,
        'field_cardinality':'5^56 = 25^28',
        'scope_warning':'These checks validate arithmetic inputs and coefficient identities; theoretical proofs are in REPORT.md. They do not enumerate curve models.'
    }
    text = json.dumps(result,indent=2)+'\n'
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(text)
    print(text,end='')

if __name__ == '__main__':
    main()
