#!/usr/bin/env python3
"""Read-only exact verifier; --record regenerates the supplied certificates.

No point search on the unknown curve is performed. The finite enumeration is
of the COMPLETE 116-element set of possible leading endpoint constants,
and of small finite-field linear algebra and integer profile counts.
The global geometric proofs are in REPORT.md, not machine-checked here.
"""
from __future__ import annotations
import argparse
import csv
import io
import itertools
import json
import platform
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'src'))
from finite25 import (add, sub, neg, mul, power, inv, div, pad, padd, psub,
                      pneg, pscale, pmul, pdiv, pmod, pmon, pgcd, ppow,
                      pdiff, determinant, rref)


def arithmetic() -> dict:
    data = json.loads((ROOT/'inputs.json').read_text())
    P, A = data['P'], data['A']
    # Independently check the small field implementation exhaustively.
    for a in range(25):
        assert add(a, neg(a)) == 0
        assert power(a, 25) == a
        if a:
            assert mul(a, inv(a)) == 1
        for b in range(25):
            assert add(a,b) == add(b,a) and mul(a,b) == mul(b,a)
            for c in range(25):
                assert mul(mul(a,b),c) == mul(a,mul(b,c))
                assert mul(a,add(b,c)) == add(mul(a,b),mul(a,c))
    assert mul(5,5) == 8  # beta^2=beta+3
    assert pgcd(P, pdiff(P)) == [1]
    assert pgcd(A, pdiff(A)) == [1]
    assert pgcd(A, P) == [1]
    Am = pmon(A)
    assert Am == [5,2,6,7,1]
    x = [0,1]
    # Exact irreducibility tests: degrees 4 and 7.
    assert ppow(x,25**4,Am) == x
    assert pgcd(Am,psub(ppow(x,25**2,Am),x)) == [1]
    M = data['root_of_unity_field_modulus_over_F25']
    assert ppow(x,25**7,M) == x
    assert pgcd(M,psub(ppow(x,25,M),x)) == [1]
    assert pmod([1]*29,M) == []
    assert ppow(x,29,M) == [1]
    assert pmod(x,M) != [1]
    Q = 25**4
    def kmul(a,b): return pmod(pmul(a,b),Am)
    def kinv(a):
        assert a
        return ppow(a,Q-2,Am)
    Ap, App, Pp = pdiff(A), pdiff(pdiff(A)), pdiff(P)
    G = pscale(kmul(ppow(Ap,3,Am),ppow(P,2,Am)),div(3,power(A[4],3)))
    exponent = pow(29,-1,Q-1)
    b = ppow(G,exponent,Am)
    assert ppow(b,29,Am) == G
    bs = [pad(ppow(b,25**i,Am),4) for i in range(4)]
    bis = [pad(kinv(v),4) for v in bs]
    det_b, det_inv_b = determinant(bs), determinant(bis)
    assert det_b != 0 and det_inv_b != 0
    Gs = [ppow(G,25**i,Am) for i in range(4)]
    assert len({tuple(v) for v in Gs}) == 4
    H = kmul(pscale(kinv(Ap),A[4]),
             padd(kmul(Pp,kinv(P)),pscale(kmul(App,kinv(Ap)),4)))
    c = kmul(ppow(b,5,Am),H)
    cs = [pad(ppow(c,25**i,Am),4) for i in range(4)]
    # An independent substitution check of the first two endpoint orders.
    # The written homogeneous formulas extend these checks to every phase.
    u1 = kmul(pscale(ppow(b,4,Am),A[4]),kinv(Ap))
    u2 = psub(pscale(kmul(kmul(u1,c),kinv(b)),4),
              kmul(kmul(App,kinv(pscale(Ap,2))),ppow(u1,2,Am)))
    endpoint_residual0 = psub(kmul(ppow(pscale(b,2),3,Am),ppow(P,2,Am)),
                              kmul(ppow(b,20,Am),ppow(u1,3,Am)))
    endpoint_residual1 = psub(
        padd(pscale(kmul(kmul(ppow(pscale(b,2),2,Am),pscale(c,3)),ppow(P,2,Am)),3),
             kmul(ppow(pscale(b,2),3,Am),pscale(kmul(kmul(P,Pp),u1),2))),
        kmul(kmul(ppow(b,20,Am),ppow(u1,2,Am)),u2))
    assert pmod(endpoint_residual0,Am) == []
    assert pmod(endpoint_residual1,Am) == []
    # Express c_i in the normal basis b_0,...,b_3.
    BM = [[bs[i][j] for i in range(4)] for j in range(4)]
    cols = []
    for ci in cs:
        rank, rr = rref([BM[j]+[ci[j]] for j in range(4)])
        assert rank == 4
        cols.append([rr[j][4] for j in range(4)])
    Cmatrix = [[cols[i][j] for i in range(4)] for j in range(4)]
    assert all(a != 0 for row in Cmatrix for a in row)
    for i in range(4):
        reconstruct = []
        for j in range(4):
            reconstruct = padd(reconstruct,pscale(bs[j],Cmatrix[j][i]))
        assert pad(reconstruct,4) == cs[i]
    zeta = [pad(ppow(x,j,M),7) for j in range(29)]
    triple_ranks = {}
    for js in itertools.combinations(range(29),3):
        rank, _ = rref([[zeta[j][i] for j in js] for i in range(7)])
        triple_ranks[str(rank)] = triple_ranks.get(str(rank),0)+1
        assert rank == 3
    ratios = []
    for ids in itertools.combinations_with_replacement(range(4),3):
        sb, sc = [], []
        for i in ids:
            sb, sc = padd(sb,bs[i]), padd(sc,cs[i])
        assert sb
        ratio = kmul(sc,kinv(sb))
        assert len(ratio) > 1  # ratio is not in F_25
        ratios.append({'indices':list(ids),'ratio_in_K4':pad(ratio,4)})
    # A second, direct check of nonvanishing of every three-term sum
    # among all 116 endpoints, including repeated choices. Outer products
    # are coordinates in the FIELD K4 tensor_F25 K7 (coprime degrees).
    def endpoint_set(rows):
        return [tuple(mul(a,z) for a in row for z in zp)
                for row in rows for zp in zeta]
    def no_zero_triples(elements):
        assert len(set(elements)) == 116
        lookup = set(elements)
        for u in elements:
            for v in elements:
                assert tuple(neg(add(a,b)) for a,b in zip(u,v)) not in lookup
        return len(elements)**2
    direct_pairs = no_zero_triples(endpoint_set(bs))
    inverse_pairs = no_zero_triples(endpoint_set(bis))
    center = div(neg(A[3]),mul(4,A[4]))
    d = P[9]
    shift = sub(center,d)
    assert (center,d,shift) == (7,22,10)
    # Scalar identities used in the formal local calculation.
    assert div(3,2) == 4 and div(2,3) == 4 and div(4,3) == 3
    assert (4*(4*2 % 5)+4) % 5 != 0  # r=4/3 in characteristic 5
    assert (4*(5*2 % 5)+4) % 5 != 0  # r=5/3
    return {
        'encoding':'a+5*b means a+b*beta; all polynomial arrays ascending',
        'A_monic':Am,'A_irreducible_degree':4,'mu_modulus':M,
        'mu_modulus_irreducible_degree':7,'mu_order':29,
        'P_squarefree':True,'A_squarefree':True,'P_A_coprime':True,
        'center':center,'P_x9':d,'defect_shift':shift,
        'G_mod_A':G,'inverse_of_29_mod_25pow4_minus_1':exponent,
        'b_in_K4':pad(b,4),'b_conjugates':bs,
        'inverse_b_conjugates':bis,'normal_basis_determinants':[det_b,det_inv_b],
        'G_conjugates':[pad(v,4) for v in Gs],
        'H_mod_A':H,'c_in_K4':pad(c,4),'c_conjugates':cs,
        'endpoint_u1':pad(u1,4),'endpoint_u2':pad(u2,4),
        'endpoint_differential_residual_orders_0_1':[[],[]],
        'c_coordinates_in_b_normal_basis':Cmatrix,
        'zeta_powers':zeta,'ranks_of_all_distinct_mu_triples':triple_ranks,
        'same_phase_ratios':ratios,
        'direct_nonzero_triple_check':{'set_size':116,'ordered_pairs_checked':direct_pairs,
                                      'zero_triples':0},
        'direct_inverse_nonzero_triple_check':{'set_size':116,'ordered_pairs_checked':inverse_pairs,
                                              'zero_triples':0},
        'scope':'Complete endpoint-constant arithmetic, NOT a search for geometric S models'
    }


def profile_bounds() -> dict:
    table=[]
    maximum=0
    coarse_count=0
    for q in range(30):
        ns=set()
        profiles=0
        for full in range(min(29-q,9)+1):
            for extra in range(min(q,9)+1):
                for two in range(29-q-full+1):
                    for one in range(29-q-full-two+1):
                        jdegree=3*full+extra+2*two+one
                        if jdegree > 30+q:
                            continue
                        n=9+3*q+jdegree
                        profiles+=1
                        ns.add(n)
        formula=min(39+4*q,67+q+min(q,9)+min(29-q,9))
        assert min(ns)==9+3*q and max(ns)==formula
        assert ns==set(range(min(ns),max(ns)+1))
        maximum=max(maximum,max(ns))
        coarse_count+=profiles
        table.append({'q':q,'n_min':min(ns),'n_max':max(ns),
                      'genus_upper_before_2n_minus_11':28+2*q,
                      'genus_lower_before_extra_ramification':max(0,(q-3)//2),
                      'coarse_integer_profiles':profiles})
    assert maximum==105
    return {'global_n_upper':maximum,'global_genus_upper':86,
            'full_weight3_fibers_outside_D_upper':9,'weight4_fibers_upper':9,
            'coarse_integer_profiles_checked':coarse_count,'table':table,
            'scope':'Necessary integer profiles only; no geometric realizability is asserted'}


def csv_text(bounds: dict) -> str:
    buf=io.StringIO(newline='')
    fields=list(bounds['table'][0])
    writer=csv.DictWriter(buf,fieldnames=fields,lineterminator='\n')
    writer.writeheader();writer.writerows(bounds['table'])
    return buf.getvalue()


def main() -> None:
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--record',action='store_true',help='Regenerate the deterministic JSON/CSV certificates')
    args=parser.parse_args()
    print('Python:',platform.python_version(),platform.python_implementation())
    print('Dependencies: Python standard library only')
    result=arithmetic()
    print('PASS: F25 arithmetic, polynomial coprimality and irreducibility')
    print('PASS: endpoint G,b,c, low-order substitution residuals, two normal bases and the all-nonzero coefficient matrix')
    print('PASS: 3,654 distinct triples of mu_29 have rank 3 over F25')
    print('PASS: all 20 same-phase endpoint ratios are outside F25')
    print('PASS: complete 116-element endpoint and inverse sets; 13,456 pairs each; no zero triple sums')
    bounds=profile_bounds()
    print('PASS: integer profile bounds; maximum n=105, genus upper bound=86')
    for name,content in [('endpoints.json',result),('profile_bounds.json',bounds)]:
        path=ROOT/'certificates'/name
        if args.record:
            path.write_text(json.dumps(content,indent=2,sort_keys=True)+'\n')
        else:
            assert json.loads(path.read_text()) == content, f'Certificate mismatch: {path}'
    path=ROOT/'certificates'/'profile_bounds.csv'
    text=csv_text(bounds)
    if args.record:
        path.write_text(text)
    else:
        assert path.read_text() == text
    print('PASS: certificates '+('recorded' if args.record else 'recomputed and matched'))
    print('NOT CHECKED BY THIS PROGRAM: the global algebraic-geometric arguments in REPORT.md')
    print('NO SEARCH PERFORMED: geometric coefficients, cubic models, etale covers, or existence in the residual range')
    print('OVERALL: all implemented exact checks passed; the delta=9 existence decision remains partial')


if __name__=='__main__':
    main()
