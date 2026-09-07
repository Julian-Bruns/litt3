#!/usr/bin/env sage
"""Bounded scalar-Higgs identities and canonical-divisor rank checks.

Only the saved first F25 oper and five already verified nowhere-zero
sections are used. No orbit0011 field, atlas solver, or production input
is opened. The saved sections FAIL R and are not reported as atlases.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path


def run(output):
    started = time.monotonic()
    root = Path(__file__).resolve().parents[1]
    source = root/'Research/computations/direct_wronskian_samples.json'
    saved = json.loads(source.read_text())
    frame_source = root/'Research/computations/canonical_atlas_system.json'
    frame = json.loads(frame_source.read_text())
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
    a = k.gen()
    get = lambda s: k(sage_eval(s, locals={'a':a}))
    X = PolynomialRing(k, 'x')
    x = X.gen()
    F = X([2*a+1,4*a+2,3*a+3,a,3*a+4,4*a,3*a,3*a+1,a+4,4*a+2,1])
    P = tuple(X([get(c) for c in saved[key]]) for key in ['A','B','C'])
    P = (P[0],P[1]+2*x**8,P[2])
    zero = (X.zero(),)*3
    add = lambda v,w: tuple(f+g for f,g in zip(v,w))
    scale = lambda c,v: tuple(c*f for f in v)
    sub = lambda v,w: add(v,scale(-1,w))
    def basis(n):
        return sorted([(i,j) for j in range(3) for i in range(n//3+1)
                       if 3*i+10*j<=n], key=lambda m:3*m[0]+10*m[1])
    def delta(v):
        ans = [X.zero()]*3
        for j,f in enumerate(v):
            ans[(j+2)%3] += f.derivative()*F**((j+2)//3)
            if j: ans[j-1] += 2*j*f*F.derivative()
        return tuple(ans)
    def mul(v,w):
        ans = [X.zero()]*3
        for i,f in enumerate(v):
            for j,g in enumerate(w): ans[(i+j)%3] += f*g*F**((i+j)//3)
        return tuple(ans)
    def monomial(m):
        ans = list(zero)
        ans[m[1]] = x**m[0]
        return tuple(ans)
    def polynomial(row, mons):
        ans = zero
        for c,m in zip(row,mons): ans=add(ans,scale(c,monomial(m)))
        return ans
    def coefficients(v, mons):
        row = vector(k,[v[j][i] for i,j in mons])
        assert polynomial(row,mons)==v
        return row
    L = lambda v: sub(delta(delta(v)),mul(P,v))
    dP = delta(P)
    Q = lambda v: add(add(delta(delta(delta(v))),mul(P,delta(v))),scale(3,mul(dP,v)))
    mons16,mons32,mons64,mons112,mons192 = map(basis,[16,32,64,112,192])
    ku = matrix(k,[[get(c) for c in row] for row in frame['SU_basis']])
    assert mons112 == [tuple(m) for m in frame['SU_monomials']]
    ub = [polynomial(row,mons112) for row in ku]
    hb = [monomial(m) for m in mons32]
    lb = [L(h) for h in hb]
    assert matrix(k,[coefficients(h,mons64) for h in lb]).rank()==24
    assert all(Q(h)==zero for h in lb) and all(L(u)==zero for u in ub)
    fifth = lambda m: mul(mul(mul(m,m),mul(m,m)),m)
    rb = [fifth(monomial(m)) for m in mons16]
    f5 = fifth((X.zero(),x**2,X.zero()))
    ub2 = [mul(f5,u) for u in ub]
    ff = matrix(k,[coefficients(v,mons192) for v in ub+ub2]).transpose()
    rows = list(ff.transpose().pivots())
    assert ff.ncols()==64 and len(rows)==64
    inv = ff.matrix_from_rows(rows).inverse()
    def coordinates(v):
        vv = coefficients(v,mons192)
        answer = inv*vector(k,[vv[i] for i in rows])
        assert ff*answer==vv
        return answer
    # Each matrix is linear in the 32 U coordinates. Compare ALL products,
    # not merely random values of the differential identity.
    ht = []
    for h,lh in zip(hb,lb):
        values = []
        for u in ub:
            action = sub(scale(2,mul(lh,delta(u))),mul(delta(lh),u))
            assert action==scale(-1,Q(mul(u,h))) and L(action)==zero
            values.append(coordinates(action))
        ht.append(matrix(k,values).transpose())
    st = [matrix(k,[coordinates(mul(r,u)) for u in ub]).transpose() for r in rb]
    high = [i for i,m in enumerate(mons192)
            if 112<3*m[0]+10*m[1]<=192 and (3*m[0]+10*m[1])%5 in [1,2]]
    assert len(high)==32
    positive_poles = [3*i+10*j for i,j in mons16[1:]]
    ktop = ku.matrix_from_columns(list(ku.pivots())).inverse()
    cases = []
    for sample in saved['samples']:
        uv = vector(k,[get(c) for c in sample['U_coefficients']])
        co = vector(k,[uv[i] for i in ku.pivots()])*ktop
        assert co*ku==uv
        u = polynomial(uv,mons112)
        tt = polynomial(vector(k,[get(c) for c in sample['T_coefficients']]),basis(197))
        assert sub(mul(u,delta(tt)),mul(tt,delta(u)))==(X.one(),X.zero(),X.zero())
        assert sample['residual_zero'] is False
        phi = matrix(k,[m*co for m in ht+st]).transpose()
        assert phi.rank()==33
        direct = (ff*phi).matrix_from_rows(high)
        assert direct.nrows()==32 and direct.ncols()==33
        hblock = direct.matrix_from_columns(range(24))
        trace = direct.matrix_from_columns(range(25,33))
        assert direct.column(24).is_zero() and trace.rank()==8
        d = int(sample['U_pole'])
        assert d in [111,112]
        selected = [[3*mons192[row][0]+10*mons192[row][1] for row in high].index(d+5*e)
                    for e in positive_poles]
        minor = trace.matrix_from_rows(selected)
        leading = uv[mons112.index(next(m for m in mons112 if 3*m[0]+10*m[1]==d))]
        assert minor.det()==leading**8
        remaining = [i for i in range(32) if i not in selected]
        small = (hblock.matrix_from_rows(remaining)
                 -trace.matrix_from_rows(remaining)*minor.inverse()*hblock.matrix_from_rows(selected))
        assert small.nrows()==small.ncols()==24
        assert 33-direct.rank()==1+small.right_nullity()
        ranks = []
        for t in list(k)[:16]:
            ev = phi.matrix_from_rows(range(32,64))-t*phi.matrix_from_rows(range(32))
            rank = ev.rank()
            assert rank<=31 and (33-rank)%2==0
            ranks.append(int(rank))
        infinity_rank = phi.matrix_from_rows(range(32)).rank()
        assert infinity_rank<=31 and (33-infinity_rank)%2==0
        cases.append({'seed':int(sample['seed']),'pole_U':d,
                      'nowhere_zero_verified_by_actual_Wronskian_one':True,
                      'R_fails':True,'theta_evaluation_rank':int(direct.rank()),
                      'trace_pivot_determinant_equals_leading_U_to_eight':True,
                      'small_matrix_rank':int(small.rank()),
                      'pencil_evaluation_ranks_16_parameters':ranks,
                      'infinity_evaluation_rank':int(infinity_rank),
                      'normal_corank':int(33-max(ranks+[infinity_rank]))})
    report = {'scope':'Dormant Higgs identities and five admissible NON-atlas controls; no exclusion.',
              'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
              'frame_sha256':hashlib.sha256(frame_source.read_bytes()).hexdigest(),
              'all_768_transvectant_equals_minus_Q_product_identities_verified':True,
              'all_768_output_horizontal_and_L192_bounds_verified':True,
              'fixed_L32_images_independent_and_in_Q_kernel':True,
              'tracefree_dimension':24,'Higgs_dimension':33,
              'small_rank_matrix_dimension':24,
              'cases':cases,'elapsed_seconds':time.monotonic()-started}
    output=Path(output)
    output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(report,indent=2,default=int)+'\n')
    print(json.dumps(report,indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    run(args.output)
