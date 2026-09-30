#!/usr/bin/env sage
"""UNEXECUTED INVESTIGATION AID; NOT A SOLVED IDEAL OR A CERTIFICATE.

Usage: sage src/generate_reduced.sage CHART
Construct a chart of the exact reduced determinant-one return problem.
The stability ideal is obtained from the COMPLETE geometric parametrization,
not from a list of finite-field points. No return ideal is solved here.
No SageMath version has been tested for this optional source.
"""
from sage.all import *
from pathlib import Path
import argparse
import json
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / 'data'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('chart', type=int, choices=range(19))
    parser.add_argument('--output', type=Path, default=ROOT / 'generated')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)

    F5 = GF(5)
    R0 = PolynomialRing(F5, 'b0')
    b0 = R0.gen()
    F = GF(25, name='beta', modulus=b0**2-b0-3)
    beta = F.gen()

    def code(n):
        n = int(n)
        if not 0 <= n < 25:
            raise ValueError('Coefficient code is outside 0,...,24')
        return F(n % 5) + F(n // 5)*beta

    # This elimination may be substantial. It is not replaced by sampling.
    dual = json.loads((DATA/'stability_sections.json').read_text())
    names = ['xx','yy','lam','mu'] + ['z%d' % i for i in range(19)]
    E = PolynomialRing(F, names=names, order='lex')
    xx, yy, lam, mu = E.gens()[:4]
    z = E.gens()[4:]
    Pcodes = [11,22,18,5,19,20,15,16,9,22,1]
    PP = sum((code(c)*xx**i for i,c in enumerate(Pcodes)), E.zero())

    def section_value(terms):
        return sum((code(c)*xx**int(i)*yy**int(j) for i,j,c in terms), E.zero())

    equations = [yy**3-PP]
    for i,sec in enumerate(dual['dual_sections']):
        equations.append(z[i]-lam*section_value(sec['a_U'])-mu*section_value(sec['b_U']))
    print('Computing the ideal of the full stability cone, by elimination.', flush=True)
    Isigma = E.ideal(equations).elimination_ideal([xx,yy,lam,mu])
    fsigma = [f for f in Isigma.gens() if f != 0]
    if not fsigma:
        raise RuntimeError('No nonzero stability generators were returned')
    assert Isigma.dimension() == 7  # dim cone = 3, plus four unused variables
    for f in fsigma:
        assert all(f.degree(v) == 0 for v in [xx,yy,lam,mu])

    # Include/check the infinity fiber as a geometric line, not two points.
    W = PolynomialRing(F, names=['l0','l1'])
    l0,l1 = W.gens()
    infinity = dual['infinity_fiber']
    infmap = E.hom([W.zero()]*4 + [code(infinity[0][i])*l0 + code(infinity[1][i])*l1 for i in range(19)], W)
    assert all(infmap(f) == 0 for f in fsigma)
    save({'ring':E, 'ideal':Isigma, 'infinity_verified':True}, str(args.output/'stability_cone.sobj'))
    print('Stability generators:', len(fsigma), 'infinity fiber checked.', flush=True)

    names = (['x%d' % i for i in range(19)] + ['c%d' % i for i in range(35)]
             + ['s%d' % i for i in range(16)] + ['h%d%d' % (i,j) for i in range(3) for j in range(3)]
             + ['w%d' % i for i in range(len(fsigma))])
    S = PolynomialRing(F, names=names, order='degrevlex')
    vv = S.gens()
    xi, c, s = vv[:19], vv[19:54], vv[54:70]
    h = matrix(S, 3, 3, vv[70:79])
    auxiliary = vv[79:]
    eta = [x**25 for x in xi]  # absolute Frobenius on ALL extension coefficients
    data = np.load(DATA/'reduced_return.npz', allow_pickle=False)

    def lin(row, variables):
        return sum((code(int(a))*variables[i] for i,a in enumerate(row) if a), S.zero())

    eq = []
    T,Q,C = data['T'], data['Q'], data['C']
    for r in range(80):
        eq.append(sum((eta[j]*lin(T[j,r],c) for j in range(19)), S.zero()))
    for r in range(43):
        poly = sum((eta[j]*lin(Q[j,r],s) for j in range(19)), S.zero())
        for i in range(19):
            poly += xi[i]*sum((eta[j]*lin(C[i,j,r],c) for j in range(19)), S.zero())
        eq.append(poly)
    assert len(eq) == 123

    # Recover every entry of the entire return matrix at P_*.
    star = matrix(S,3,3)
    star[0,0] = lin(data['top_first_s'],s) + sum((xi[i]*lin(data['top_first_c'][i],c) for i in range(19)), S.zero())
    star[1,0] = lin(data['first_at_point'][0],c)
    star[2,0] = lin(data['first_at_point'][1],c)
    # lower_at_point order is g,q,h,r, NOT matrix row order.
    for row,col,index in [(2,1,0),(1,1,1),(2,2,2),(1,2,3)]:
        star[row,col] = sum((eta[j]*lin(data['lower_at_point'][j,index],c) for j in range(19)), S.zero())
    for col in [1,2]:
        entry = sum((eta[j]*lin(data['top_other_s'][j,col-1],s) for j in range(19)), S.zero())
        for i in range(19):
            entry += xi[i]*sum((eta[j]*lin(data['top_other_c'][i,j,col-1],c) for j in range(19)), S.zero())
        star[0,col] = entry
    eq += [h[i,j]-star[i,j] for i in range(3) for j in range(3)]
    eq += [h.det()-1, xi[args.chart]-1]

    # Complement of Sigma over the algebraic closure, not a necessary proxy.
    transfer = E.hom([S.zero()]*4+list(xi), S)
    eq.append(sum((w*transfer(f) for w,f in zip(auxiliary,fsigma)),S.zero())-1)
    assert len(eq) == 135
    J = S.ideal(eq)
    base = args.output / ('reduced_chart_%d' % args.chart)
    save({'ring':S,'ideal':J,'equations':eq,'evaluation_matrix':star,
          'chart':args.chart,'stability_generators':[transfer(f) for f in fsigma],
          'decision_status':'NOT SOLVED'},str(base)+'.sobj')
    meta = {'chart':args.chart,'variables':len(names),'equations':len(eq),
            'regularity_equations':123,'core_morphism_coefficients':51,
            'evaluation_auxiliaries':9,'stability_auxiliaries':len(fsigma),
            'absolute_source_power':25,'determinant_one_retained':True,
            'entire_stability_open_retained':True,'return_ideal_solved':False}
    Path(str(base)+'.json').write_text(json.dumps(meta,indent=2)+'\n')
    print('Generated',str(base)+'.sobj',flush=True)
    print('NO RETURN IDEAL SOLVED. NO EXISTENCE OR EMPTINESS CERTIFICATE.',flush=True)


if __name__ == '__main__':
    main()
