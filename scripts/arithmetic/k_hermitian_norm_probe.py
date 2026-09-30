#!/usr/bin/env python3
"""Necessary cubic-orbit norm tests for twisted sections of K tensor F*K.

The norm lies in the invariant part of Sym3(K) tensor F*Sym3(K),
embedded in Sym18(K). Its biform has bidegree(3,3) and factors into
three (1,1) forms over k(X). Consequently its discriminant in either
variable is a square. Specialization at fixed unramified x-values
preserves this closed square condition. No parameter point search is
an emptiness proof; this program only prepares exact geometric ideals.
The fixed-points mode instead uses the quartic relation on a cubic norm
of one bilinear fiber form at the eleven fixed points of the cubic action.
"""
import argparse
import hashlib
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('sections', type=Path)
    ap.add_argument('--points', type=int, nargs='+', default=[0,1])
    ap.add_argument('--chart', type=int, choices=range(9), required=True)
    ap.add_argument('--fixed-points-only', action='store_true',
                    help='Use the quartic cubic-orbit relation at all ten branch points and infinity.')
    ap.add_argument('--full-fiber-relations', action='store_true',
                    help='Retain all six fixed-point coefficients and three necessary quartics.')
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    assert not args.full_fiber_relations or args.fixed_points_only
    data = json.loads(args.sections.read_text())
    assert data['symmetric_degree'] == 18 and data['rank'] == 489
    assert data['independent_F5_rank'] == 978 and len(data['sections']) == 19
    k = GF(25,'a',modulus=PolynomialRing(GF(5),'w')([2,4,1]))
    dec = lambda c: k(c%5)+k(c//5)*k.gen()
    enc = lambda c: int(c.polynomial()[0])+5*int(c.polynomial()[1])
    source = [s for s in data['sections'] if s['C3_character']==0]
    assert len(source) == 10
    bad = sorted({(i,r,m) for s in source for i in (4,9,14)
                  for r,m,c in s['affine'][i]})
    M = matrix(k,[[sum(dec(c) for rr,mm,c in s['affine'][i]
                     if rr==r and mm==m) for s in source] for i,r,m in bad])
    assert M.rank() == 1
    coordinates = M.right_kernel().basis_matrix()
    assert coordinates.nrows() == 9
    Rx = PolynomialRing(k,'x'); x=Rx.gen()
    P = Rx([dec(c) for c in (11,22,18,5,19,20,15,16,9,22,1)])
    biforms = []; affine_sections=[]
    for row in coordinates:
        coeff = []; affine=[]
        for i in range(19):
            assert all(r == i%3 and m>=0 for s in source
                       for r,m,c in s['affine'][i])
            f = sum(row[j]*sum(dec(c)*x**m for r,m,c in s['affine'][i])
                    for j,s in enumerate(source))
            affine.append(f)
            if i in (4,9,14): assert f == 0
            else: coeff.append((i%5,i//5,f*P**(6-i//3)))
        biforms.append(coeff)
        affine_sections.append(affine)
    names = [f'b{i}' for i in range(args.chart+1,9)]
    if not args.fixed_points_only:
        names += [f'q{j}_{i}' for j in range(len(args.points)) for i in range(7)]
    elif not names:
        names=['unused']
    S = PolynomialRing(k,names,order='degrevlex')
    Z = PolynomialRing(S,'z'); z=Z.gen()
    b = [S.zero() if i<args.chart else S.one() if i==args.chart
         else S(f'b{i}') for i in range(9)]
    equations=[]; point_ranks=[]; discriminants=[]
    if args.fixed_points_only:
        indices=(0,3,6,12,15,18) if args.full_fiber_relations else (0,6,12,18)
        G={i:sum(b[j]*sum(c*z**m for m,c in enumerate(affine[i]))
                     for j,affine in enumerate(affine_sections)) for i in indices}
        modulus=Z([S(c) for c in P])
        G={i:f%modulus for i,f in G.items()}
        def relations(g):
            A,X,Y,D=g[0],g[6],g[12],g[18]
            result=[X**3*D-Y**3*A]
            if args.full_fiber_relations:
                B,C=g[15],g[3]
                result += [X**4-9*A*Y*X**2+27*A**2*Y**2+27*A*B*C*X-27*A**2*D*X,
                           Y**4-9*D*X*Y**2+27*D**2*X**2+27*D*B*C*Y-27*D**2*A*Y]
            return result
        equations=[(rel%modulus)[m] for rel in relations(G) for m in range(10)]
        infinity={}
        for i in indices:
            m=(-90+11*i)//3
            values=[sum(dec(c) for r,mm,c in s['other_chart'][i] if r==0 and mm==m)
                    for s in source]
            infinity[i]=sum(b[j]*sum(row[h]*values[h] for h in range(10))
                            for j,row in enumerate(coordinates))
        equations.extend(relations(infinity))
        if args.chart==8:equations.append(S('unused'))
    for j,code in enumerate([] if args.fixed_points_only else args.points):
        x0=dec(code); assert P(x0) != 0
        evaluation = matrix(k,[[next(f(x0) for s,t,f in form if (s,t)==(u,v))
                               for form in biforms] for v in range(4) for u in range(4)])
        point_ranks.append(int(evaluation.rank()))
        F = [sum(b[h]*sum(f(x0)*z**u for u,v,f in form if v==i)
                 for h,form in enumerate(biforms)) for i in range(4)]
        d,c,bb,a=F
        disc = bb**2*c**2-4*a*c**3-4*bb**3*d-27*a**2*d**2+18*a*bb*c*d
        assert disc.degree() <= 12
        square=sum(S(f'q{j}_{i}')*z**i for i in range(7))
        equations += [disc[i]-square.__pow__(2)[i] for i in range(13)]
        discriminants.append([str(disc[i]) for i in range(13)])
    equations=[f for f in equations if f]
    scope=('Necessary fixed-point quartic equations for the actual cubic orbit norm. No existence assertion.'
           if args.fixed_points_only else
           'Necessary discriminant-square specializations of the actual cubic orbit norm. No existence assertion.')
    receipt=dict(status='PREPARED',scope=scope,
                 variables=names,equations=[str(f) for f in equations],
                 chart=args.chart,points=[] if args.fixed_points_only else args.points,
                 fixed_point_quartic_relation=args.fixed_points_only,
                 full_fiber_relations=args.full_fiber_relations,
                 point_evaluation_ranks=point_ranks,
                 invariant_norm_dimension=9,
                 invariant_coordinates=[[enc(c) for c in row] for row in coordinates],
                 section_input_sha256=hashlib.sha256(args.sections.read_bytes()).hexdigest(),
                 discriminants=discriminants)
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('PREPARED',args.chart,'variables',len(names),'equations',len(equations),
          'point ranks',point_ranks,flush=True)


if __name__=='__main__':main()
