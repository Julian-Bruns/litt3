#!/usr/bin/env python3
"""Complete a bounded backward tree over the fixed field F_(5^15).

Reuse completed fibers with identical target coordinates. Every new fiber
is reconstructed and checked by continue_rational_oper_chain.py.
"""
import argparse
from collections import deque
import json
from pathlib import Path
import subprocess
import sys


def code(row):
    return sum(c*125**i for i,c in enumerate(row))


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--root',type=Path,required=True)
    ap.add_argument('--limit',type=int,default=64)
    args=ap.parse_args()
    root=args.root.resolve()
    certificate=root/'second_frobenius_locus'
    source=Path(__file__).with_name('continue_rational_oper_chain.py')
    cached={}
    for p in root.iterdir():
        result=p/'certificates/rational_fiber.json'
        if p.is_dir() and result.exists():
            inp=json.loads((p/'input.json').read_text())
            data=json.loads(result.read_text())
            if 'rational_points' in data:
                cached[tuple(code(row) for row in inp['A'])+(1,)]=p
    witness=json.loads((certificate/'certificates/witness.json').read_text())
    z=tuple(witness['z'][:3])+(1,)
    queue=deque([(2,z,None)])
    nodes=[]
    seen=set()
    while queue and len(nodes)<args.limit:
        height,z,parent=queue.popleft()
        if z in seen:
            raise ValueError('repeated point in backward tree')
        seen.add(z)
        n=len(nodes)
        if z in cached:
            folder=cached[z]
        else:
            target=root/f'tree_target_{n:03d}.json'
            target.write_text(json.dumps({'z':list(z)})+'\n')
            folder=root/f'tree_node_{n:03d}'
            with (root/f'tree_node_{n:03d}.log').open('w') as log:
                subprocess.run([sys.executable,str(source),'--certificate',str(certificate),
                                '--target',str(target),'--output',str(folder)],
                               stdout=log,stderr=log,check=True)
        result=json.loads((folder/'certificates/rational_fiber.json').read_text())
        if len(result['rational_points'])!=result['rational_count']:
            raise ValueError('incomplete root list')
        node={'index':n,'first_unstable_height':height,'point':list(z),
              'parent':parent,'fiber':str(folder),'children':result['rational_points']}
        nodes.append(node)
        for child in result['rational_points']:
            queue.append((height+1,tuple(child),n))
        print(f'node {n}: height {height}, children {len(node["children"])}, pending {len(queue)}',flush=True)
        record={'field':'F_(5^15)','target':'one fixed Bol root T',
                'status':'complete' if not queue else 'partial',
                'nodes':nodes,'pending':[[h,list(p),i] for h,p,i in queue],
                'maximum_first_unstable_height':max(x['first_unstable_height'] for x in nodes)}
        (root/'rational_tree.json').write_text(json.dumps(record,indent=2)+'\n')
    if queue:
        print('Bound reached; only a partial tree is asserted.',flush=True)
    else:
        print('COMPLETE fixed-field tree.',flush=True)


if __name__=='__main__':
    main()
