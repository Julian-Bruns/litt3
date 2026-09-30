#!/usr/bin/env python3
"""Global division-free elimination of map variables in a bilinear chart.

Use constant row combinations whose coefficient of a chosen map variable
is exactly one, then substitute. Each step is an isomorphism of solution
schemes and retains its linear-combination witness. No nonconstant
coefficient is inverted and no rank-drop branch is discarded.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--max-steps', type=int, default=15)
    ap.add_argument('--all-variables', action='store_true',
                    help='Also allow source variables; each substitution still has a constant-unit coefficient.')
    args = ap.parse_args()
    original = json.loads(args.input.read_text())
    k = GF(25, 'a', modulus=PolynomialRing(GF(5), 't')([2,4,1]))
    R = PolynomialRing(k, original['variables'], order='degrevlex')
    equations = [R(s) for s in original['equations']]
    names = list(original['variables'])
    active = list(names) if args.all_variables else [name for name in names if name.startswith(('p','c'))]
    steps = []
    for step_index in range(args.max_steps):
        best = None
        for name in active:
            v = R(name)
            if any(f.degree(v)>1 for f in equations): continue
            derivatives = [{tuple(e):c for e,c in f.derivative(v).dict().items()}
                           for f in equations]
            monomials = sorted({e for f in derivatives for e in f}|{(0,)*R.ngens()})
            coefficients = matrix(k, [[f.get(e,k.zero()) for e in monomials]
                                      for f in derivatives])
            target = vector(k,[int(not any(e)) for e in monomials])
            try: weights = coefficients.transpose().solve_right(target)
            except ValueError: continue
            equation = sum(w*f for w,f in zip(weights,equations))
            assert equation.derivative(v)==1
            replacement = v-equation
            assert replacement.degree(v)<=0
            cost = (replacement.total_degree(),len(replacement.dict()))
            if best is None or cost<best[0]:
                best=(cost,name,weights,replacement)
        if best is None: break
        cost,name,weights,replacement=best
        v=R(name)
        steps.append({'variable':name,'row_combination':[str(w) for w in weights],
                      'replacement':str(replacement)})
        equations=[f.subs({v:replacement}) for f in equations]
        equations=[f for f in equations if f]
        names.remove(name);active.remove(name)
        print('ELIMINATED',name,'cost',cost,'remaining',len(names),flush=True)
        receipt={'status':'PREPARED','scope':'Scheme-equivalent division-free elimination of the supplied necessary chart.',
                 'input_sha256':hashlib.sha256(args.input.read_bytes()).hexdigest(),
                 'variables':names,'equations':[str(f) for f in equations],
                 'elimination_steps':steps}
        args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    if not steps:
        print('NO CONSTANT ROW PIVOT',flush=True)
    else:
        print('COMPLETE reduction',len(steps),'variables removed',flush=True)


if __name__ == '__main__':
    main()
