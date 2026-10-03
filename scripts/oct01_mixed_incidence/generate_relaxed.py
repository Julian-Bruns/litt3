#!/usr/bin/env python3
"""Expand the audited nine source row equations over F5.

The result is a necessary relaxation, not a witness construction. Field
equations preserve the original finite field; target authentication is omitted.
All six K inputs and every actual row constant are unchanged.
"""
import argparse
import json
import os
import sys
from pathlib import Path

ARCHIVE = Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')
sys.path.insert(0, str(ARCHIVE))
from field import K
from source_system import build
from finite import phi
from rank_reconstruction import flat, KBASIS


def add(a, b):
    out = a.copy()
    for mon, coeff in b.items():
        c = (out.get(mon, 0) + coeff) % 5
        if c: out[mon] = c
        else: out.pop(mon, None)
    return out


def scale(a, c):
    return {m: (v*c)%5 for m,v in a.items() if (v*c)%5}


def mul(a, b):
    out = {}
    for m,c in a.items():
        for n,d in b.items():
            key = tuple(sorted(m+n))
            z = (out.get(key, 0)+c*d)%5
            if z: out[key] = z
            else: out.pop(key, None)
    return out


def format_poly(p, names):
    from collections import Counter
    terms=[]
    for mon,c in sorted(p.items(), key=lambda z:(len(z[0]),z[0]), reverse=True):
        factor = '*'.join(names[i]+(f'^{power}' if power>1 else '')
                          for i,power in sorted(Counter(mon).items()))
        terms.append(str(c) if not mon else ((str(c)+'*' if c!=1 else '')+factor))
    return '+'.join(terms) or '0'


def generate(ep, output, field_equations=True, reduced=False):
    if reduced:
        from direction_system import build_direction
        spec=build_direction(ep)
    else:spec=build(ep)
    variable_count=14*len(spec['inputs'])
    equations={n:g for n,g in spec['K_equations'].items() if not n.startswith('root_')}
    needed=set()
    def visit(g):
        if g in needed:return
        needed.add(g)
        node=spec['nodes'][g]
        if node['op'] in ('add','multiply'):
            for h in node['args']:visit(h)
        elif node['op'] in ('Frobenius','F5_coordinate'):visit(node['args'][0])
    for g in equations.values():visit(g)
    products=[[flat(K.mul(a,b)) for b in KBASIS] for a in KBASIS]
    frobs={n:[flat(phi(a,n)) for a in KBASIS] for n in range(14)}
    semantic_names=[f'{name}_{i}' for name in spec['inputs'] for i in range(14)]
    # Equal-length identifiers avoid any external parser's prefix ambiguity.
    names=[f'v{i:02}' for i in range(variable_count)]
    vals={}
    for g in sorted(needed):
        node=spec['nodes'][g];op=node['op'];args=node['args']
        if op=='constant':
            v=[{():c} if c else {} for c in flat(K.decode(args[0]))]
        elif op=='input':v=[{(14*args[0]+i,):1} for i in range(14)]
        elif op=='add':v=[add(a,b) for a,b in zip(vals[args[0]],vals[args[1]])]
        elif op=='Frobenius':
            v=[{} for _ in range(14)]
            for i,p in enumerate(vals[args[0]]):
                for j,c in enumerate(frobs[args[1]][i]):
                    if c:v[j]=add(v[j],scale(p,c))
        elif op=='multiply':
            v=[{} for _ in range(14)]
            for i,a in enumerate(vals[args[0]]):
                if not a:continue
                for j,b in enumerate(vals[args[1]]):
                    if not b:continue
                    p=mul(a,b)
                    for k,c in enumerate(products[i][j]):
                        if c:v[k]=add(v[k],scale(p,c))
        else:raise ValueError(op)
        vals[g]=v
    result=[p for g in equations.values() for p in vals[g]]
    # Independent exact substitution against the inherited circuit prevents
    # polynomial-expansion mistakes before any solver result is used.
    import random
    from source_system import evaluate
    rng=random.Random(101)
    for _ in range(3):
        inputs=[K.decode(rng.randrange(5**14)) for _ in spec['inputs']]
        values=evaluate(spec,inputs+[K.zero]*(6-len(inputs)))
        point=[c for z in inputs for c in flat(z)]
        want=[c for g in equations.values() for c in flat(values[g])]
        got=[]
        for p in result:
            answer=0
            for mon,c in p.items():
                for j in mon:c=c*point[j]%5
                answer=(answer+c)%5
            got.append(answer)
        assert got==want, 'independent circuit substitution mismatch'
    if field_equations:
        result += [{(i,)*5:1,(i,):4} for i in range(variable_count)]
    text=','.join(names)+'\n5\n'+',\n'.join(format_poly(p,names) for p in result)+'\n'
    output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(text)
    meta={'source':ep,'variables':variable_count,'original_K_equations':list(equations),
          'F5_equations':len(result),'terms':sum(map(len,result)),
          'maximum_degree':max(len(m) for p in result for m in p),
          'coordinate_names':semantic_names,
          'field_equations':field_equations,'status':'necessary row/rank relaxation only'}
    output.with_suffix('.json').write_text(json.dumps(meta,indent=2)+'\n')
    # Pickled sparse integer coefficients are a parser-independent Sage input.
    import pickle
    output.with_suffix('.pickle').write_bytes(pickle.dumps((names,result)))
    print(json.dumps(meta),flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--source',required=True)
    p.add_argument('--output',type=Path,required=True);p.add_argument('--omit-field',action='store_true')
    p.add_argument('--reduced',action='store_true')
    a=p.parse_args();generate(json.loads(a.source),a.output,not a.omit_field,a.reduced)
