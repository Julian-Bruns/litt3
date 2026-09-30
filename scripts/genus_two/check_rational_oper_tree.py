#!/usr/bin/env python3
"""Independently check every actual Frobenius edge of a completed tree.

Completeness uses the per-fiber boundary, RUR and rational-root certificates;
this script independently checks the new points and parent relations using
the returned pure-Python field implementation.
"""
import argparse
from collections import Counter
import importlib.util
import json
from pathlib import Path


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--root',type=Path,required=True)
    args=ap.parse_args()
    root=args.root.resolve()
    spec=importlib.util.spec_from_file_location('independent_field',
                                               root/'second_frobenius_locus/verify_witness.py')
    ff=importlib.util.module_from_spec(spec); spec.loader.exec_module(ff)
    record=json.loads((root/'rational_tree.json').read_text())
    assert record['status']=='complete' and not record['pending']
    nodes=record['nodes']
    target=[ff.Element(row) for row in ff.DATA['A']]
    counts=Counter()
    for node in nodes:
        z=[ff.decode(x) for x in node['point'][:3]]
        q=ff.evaluate_quintics(z)
        assert q[3]!=ff.C(0) and ff.kummer(z)!=ff.C(0)
        parent=(target if node['parent'] is None else
                [ff.decode(x) for x in nodes[node['parent']]['point'][:3]])
        assert all(q[j]**5==parent[j]*q[3]**5 for j in range(3))
        assert any(x**125!=x for x in z)
        result=json.loads((Path(node['fiber'])/'certificates/rational_fiber.json').read_text())
        assert result['rational_points']==node['children']
        assert (result['raw_degree'],result['base_degree'],result['kummer_degree'],
                result['good_degree'])==(125,80,0,45)
        actual=[n['point'] for n in nodes if n['parent']==node['index']]
        assert sorted(actual)==sorted(node['children'])
        counts[node['first_unstable_height']]+=1
    print('PASS: every edge uses the original fifth-power equations; all source points stable.')
    print('PASS: all nodes have exact degree five over F125; every listed child is expanded.')
    print('Fixed-target first-instability counts:',dict(sorted(counts.items())))
    print('Maximum:',max(counts),'No later coefficient-field points.')


if __name__=='__main__':
    main()
