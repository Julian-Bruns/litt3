"""Exact local certificates for the continuation; Python standard library only.

All finite enumerations concern forced leading labels or Fourier minors.
They are NOT a search for curves or rational-function coefficient tuples.
"""
from pathlib import Path
import itertools
import json
import math
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT/'prior/src'))
import finite25 as f

M14 = [1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]
D7 = [4,6,23,9,5,23,8,1]
ADD = [[f.add(a,b) for b in range(25)] for a in range(25)]
MUL = [[f.mul(a,b) for b in range(25)] for a in range(25)]
NEG = [f.neg(a) for a in range(25)]
AMONIC = f.scale(f.A, f.inv(f.A[-1]))
ZERO = (0,0,0,0)
ONE = (1,0,0,0)

def ea(a,b):
    return tuple(ADD[x][y] for x,y in zip(a,b))
def en(a):
    return tuple(NEG[x] for x in a)
def es(a,s):
    return tuple(MUL[x][s] for x in a)
def em(a,b):
    r = [0]*7
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            r[i+j] = ADD[r[i+j]][MUL[x][y]]
    for i in range(6,3,-1):
        x = r[i]
        if x:
            for j,y in enumerate(AMONIC):
                r[i-4+j] = ADD[r[i-4+j]][NEG[MUL[x][y]]]
    return tuple(r[:4])
def ep(a,n):
    r = ONE
    while n:
        if n & 1:
            r = em(r,a)
        a = em(a,a)
        n //= 2
    return r
def ei(a):
    if a == ZERO:
        raise ZeroDivisionError('zero in F_(25^4)')
    result = ep(a,25**4-2)
    assert em(a,result) == ONE
    return result
def ev(row,a):
    r = ZERO
    for x in row[::-1]:
        r = ea(em(r,a),(x,0,0,0))
    return r

def construct_data():
    x = [0,1]
    assert f.egcd(AMONIC,f.ps(f.ppow(x,25**2,AMONIC),x))[0] == [1]
    assert f.ppow(x,25**4,AMONIC) == x
    assert f.rem(f.ps(f.ppow(x,29),[1]),D7) == []
    assert f.rem(D7,[4,1]) != []  # D7(1) != 0
    assert next(d for d in range(1,30) if pow(25,d,29)==1) == 7
    assert f.rem([1]*29,M14) == []
    assert next(d for d in range(1,30) if pow(5,d,29)==1) == 14
    alpha = [(0,1,0,0)]
    for _ in range(3):
        alpha.append(ep(alpha[-1],25))
    assert len(set(alpha)) == 4 and ep(alpha[-1],25) == alpha[0]
    assert all(ev(f.A,a) == ZERO for a in alpha)
    exponent = pow(29,-1,25**4-1)
    base = []
    for a in alpha:
        h = em(ep(ev(f.P,a),2),ep(ev(f.der(f.A),a),3))
        h = es(h,f.mul(3,f.inv(f.powf(f.A[-1],3))))
        b = ep(h,exponent)
        assert ep(b,29) == h and b != ZERO
        base.append(b)
    ratios = []
    for i,j in itertools.combinations(range(4),2):
        ratio_b = em(base[j],ei(base[i]))
        da = em(ep(base[i],3),ei(ev(f.der(f.A),alpha[i])))
        db = em(ep(base[j],3),ei(ev(f.der(f.A),alpha[j])))
        ratio_d = em(db,ei(da))
        assert any(ratio_b[1:]) and any(ratio_d[1:])
        ratios.append({'i':i,'j':j,'B_j_over_B_i':list(ratio_b),
                       'd_j_over_d_i':list(ratio_d)})
    ap = f.der(f.A)
    app = f.der(ap)
    appp = f.der(app)
    schwarz = f.ps(f.pm(ap,appp),f.scale(f.pm(app,app),4))
    gcd,bA,bS = f.egcd(f.A,schwarz)
    assert schwarz == [17,5,7] and gcd == [1]
    assert f.pa(f.pm(bA,f.A),f.pm(bS,schwarz)) == [1]
    return {
        'encoding':'[a+5*b]=a+b*beta; beta^2=beta+3; ascending rows',
        'A_monic':AMONIC,
        'F25_extension_for_alpha':'F25[alpha]/A_monic(alpha); ascending four-tuples',
        'omega_minpoly_over_F25':D7,
        'omega_minpoly_over_F5_for_confluent_checks':M14,
        'alpha_roots':[list(a) for a in alpha],
        'B_base':[list(b) for b in base],
        'power29_inverse_mod_25power4_minus1':exponent,
        'cross_coset_ratios':ratios,
        'schwarz_numerator':schwarz,
        'schwarz_bezout':{'A_multiplier':bA,'S_multiplier':bS,'result':[1]},
        'expected_checks':{
            'normalized_three_node_multisets':435,
            'h2_zero_multisets':[],
            'normalized_four_node_multisets':4495,
            's22_zero_multisets':[[0,0,0,0]],
            's52_zero_multisets':[],
            'four_distinct_alpha_cases_per_matrix':24389,
            'mobius_distinct_alpha_zero_cases':[],
            'quadratic_distinct_alpha_zero_cases':[]
        }
    }

# Cyclic polynomials in F5[X]/(X^29-1), for exact Fourier evaluation.
def ca(p,q):
    return [(a+b)%5 for a,b in zip(p,q)]
def cn(p):
    return [(-a)%5 for a in p]
def cm(p,q):
    r = [0]*29
    for i,a in enumerate(p):
        if a:
            for j,b in enumerate(q):
                if b:
                    r[(i+j)%29] = (r[(i+j)%29]+a*b)%5
    return r
def cr(p):
    p = p[:]
    for i in range(28,13,-1):
        a = p[i]
        if a:
            for j,b in enumerate(M14):
                p[i-14+j] = (p[i-14+j]-a*b)%5
    return p[:14]
def elementary(exponents,maxd):
    es = [[1]+[0]*28]+[[0]*29 for _ in range(maxd)]
    for n,x in enumerate(exponents):
        for d in range(min(n+1,maxd),0,-1):
            for i,a in enumerate(es[d-1]):
                es[d][(i+x)%29] = (es[d][(i+x)%29]+a)%5
    return es

def complete(exponents,maxd):
    hs = [[1]+[0]*28]+[[0]*29 for _ in range(maxd)]
    for x in exponents:
        for d in range(1,maxd+1):
            for i,a in enumerate(hs[d-1]):
                hs[d][(i+x)%29] = (hs[d][(i+x)%29]+a)%5
    return hs

def direct_confluent(exponents,columns):
    """Hasse derivative rows at each repeated node; no divisions at collisions."""
    seen = {}
    rows = []
    for node in exponents:
        order = seen.get(node,0)
        seen[node] = order+1
        rows.append([(math.comb(e,order)%5,(node*(e-order))%29)
                     if e >= order else (0,0) for e in columns])
    out = [0]*29
    for perm in itertools.permutations(range(len(columns))):
        sign = -1 if sum(perm[i]>perm[j] for i in range(len(perm))
                        for j in range(i+1,len(perm)))%2 else 1
        coeff = sign
        exponent = 0
        for i,j in enumerate(perm):
            c,e = rows[i][j]
            coeff *= c
            exponent += e
        out[exponent%29] = (out[exponent%29]+coeff)%5
    return out

def confluent_vandermonde(exponents):
    counts = {x:exponents.count(x) for x in set(exponents)}
    r = [1]+[0]*28
    for a,b in itertools.combinations(sorted(counts),2):
        factor = [0]*29
        factor[b] += 1
        factor[a] = (factor[a]-1)%5
        for _ in range(counts[a]*counts[b]):
            r = cm(r,factor)
    assert any(cr(r))
    return r

def verify_confluent():
    zeros_h2 = []
    zeros_s22 = []
    zeros_s52 = []
    n3 = n4 = 0
    for tail in itertools.combinations_with_replacement(range(29),2):
        nodes = (0,)+tail
        es = elementary(nodes,2)
        h2 = ca(cm(es[1],es[1]),cn(es[2]))
        if not any(cr(h2)):
            zeros_h2.append(list(nodes))
        direct = direct_confluent(nodes,(0,1,4))
        assert cr(direct) == cr(cm(h2,confluent_vandermonde(nodes)))
        n3 += 1
    for tail in itertools.combinations_with_replacement(range(29),3):
        nodes = (0,)+tail
        es = elementary(nodes,3)
        hs = complete(nodes,6)
        s22 = ca(cm(es[2],es[2]),cn(cm(es[1],es[3])))
        s52 = ca(cm(hs[5],hs[2]),cn(cm(hs[6],hs[1])))
        if not any(cr(s22)):
            zeros_s22.append(list(nodes))
        if not any(cr(s52)):
            zeros_s52.append(list(nodes))
        vand = confluent_vandermonde(nodes)
        for cols,schur in [((0,1,4,5),s22),((0,1,4,8),s52)]:
            assert cr(direct_confluent(nodes,cols)) == cr(cm(schur,vand))
        n4 += 1
    assert n3 == 435 and n4 == 4495
    assert zeros_h2 == [] and zeros_s22 == [[0,0,0,0]] and zeros_s52 == []
    print('PASS all 435 normalized three-node multisets: h2 nonzero, including collisions.')
    print('PASS all 4495 normalized four-node multisets: s22 zero only when all nodes coincide.')
    print('PASS all 4495 normalized four-node multisets: s52 always nonzero.')
    print('PASS independent direct confluent determinants for all 9425 matrix cases.')

def verify_distinct_alpha(data):
    alpha = [tuple(a) for a in data['alpha_roots']]
    base = [tuple(b) for b in data['B_base']]
    powers = []
    p = [1]
    for _ in range(29):
        powers.append(tuple(p+[0]*(7-len(p))))
        p = f.rem([0]+p,D7)
    assert p == [1]
    for kind in ('mobius','quadratic'):
        coeffs = {}
        for perm in itertools.permutations(range(4)):
            negative = sum(perm[i]>perm[j] for i in range(4)
                           for j in range(i+1,4))%2
            coeff = ONE
            monomial = []
            for row,col in enumerate(perm):
                if kind == 'mobius':
                    if col in (2,3):
                        coeff = em(coeff,alpha[row])
                    if col in (1,3):
                        coeff = em(coeff,base[row]); monomial.append(row)
                else:
                    if col in (1,2):
                        coeff = em(coeff,ep(alpha[row],col))
                    if col == 3:
                        coeff = em(coeff,base[row]); monomial.append(row)
            if negative:
                coeff = en(coeff)
            key = tuple(monomial)
            coeffs[key] = ea(coeffs.get(key,ZERO),coeff)
        contribution = {
            key:[tuple(MUL[x][y] for x in c for y in powers[r]) for r in range(29)]
            for key,c in coeffs.items()
        }
        checked = 0
        zeros = []
        for r1,r2,r3 in itertools.product(range(29),repeat=3):
            exponents = (0,r1,r2,r3)
            value = [0]*28
            for key,table in contribution.items():
                term = table[sum(exponents[i] for i in key)%29]
                value = [ADD[a][b] for a,b in zip(value,term)]
            if not any(value):
                zeros.append(list(exponents))
            checked += 1
        assert checked == 24389 and zeros == []
        print(f'PASS {kind}: all {checked} normalized four-distinct-alpha label determinants nonzero.')

def run(root=ROOT):
    expected = json.loads((root/'data/local_certificates.json').read_text())
    computed = construct_data()
    assert computed == expected
    print('PASS field presentations, four conjugate roots of A, and all 116 leading labels.')
    print('PASS six B-ratios and six (B^3/A-prime)-ratios are outside F25.')
    print('PASS Schwarzian numerator [17,5,7] and its exact Bezout identity with A.')
    verify_confluent()
    verify_distinct_alpha(computed)

if __name__ == '__main__':
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument('--write-data',type=Path)
    args = ap.parse_args()
    if args.write_data:
        args.write_data.write_text(json.dumps(construct_data(),indent=2)+'\n')
        print('Wrote exact local field and Bezout data:',args.write_data)
    else:
        run()
