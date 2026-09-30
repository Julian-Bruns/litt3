#!/usr/bin/env python3
"""Build a symmetry-closed over-approximation of nonrational pencil jets."""
import argparse,json
from pathlib import Path
import klein_four_constant_pencil_targets as T


def power(a,n):
    r=T.ONE
    while n:
        if n&1:r=T.mul(r,a)
        a=T.mul(a,a);n//=2
    return r


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input',type=Path);ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();src=json.loads(args.input.read_text())['nonrational_targets']
    z=(0,1,0,0,0,0,0);zs=[power(z,i) for i in range(29)]
    base=[]
    for t in src:
        assert t.get('degree_over_M',2)==2
        base.append(tuple(tuple(t[k]) for k in ('slope','intercept','minimal_trace','minimal_constant')))
    closure=set(base);pending=list(base)
    while pending:
        t=pending.pop();u=tuple(power(v,5) for v in t)
        if u not in closure:closure.add(u);pending.append(u)
    full=set()
    for t in closure:
        for k in range(29):full.add(tuple(T.mul(v,zs[(w*k)%29]) for v,w in zip(t,(4,3,-1,-2))))
    rows=sorted(full)
    out={'scope':'Over-approximation closed under all coefficient Frobenius and common-root phases; extra conjugates are retained for a safe exclusion test.',
         'source_targets':len(base),'frobenius_closure':len(closure),'full_targets':len(rows),'targets':rows}
    args.output.write_text(json.dumps(out,separators=(',',':'))+'\n')
    with args.output.with_suffix('.dat').open('w') as f:
        print(len(rows),file=f)
        for row in rows:print(*(c for v in row for c in v),file=f)
    print('Source',len(base),'Frobenius closure',len(closure),'full targets',len(rows))


if __name__=='__main__':main()
