#!/usr/bin/env sage
"""Coefficientwise independent check of the optimized finite-field gcd."""
import json
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from direction_boundary import build_boundary, marked_field
from sage.all import pari, power_mod
from sage.env import SAGE_VERSION

raw = Path('/Users/julian/Documents/litt3-computation-data/oct01_local_continuation/mixed')
fixtures = [x['source'] for x in json.loads((raw/'direction_boundary_benchmark100.json').read_text())['results'][:8]]
fixtures += [[[0,0],[0,1],[1,1],[2,3]], [[0,1],[0,2],[0,1],[2,3]]]
data = marked_field()
checks = []
for ep in fixtures:
    out = build_boundary(ep, data)
    if 'empty_stage' in out:
        checks.append(dict(source=ep, empty_stage=out['empty_stage']))
        continue
    mon = out['monodromy']; R = mon.parent(); q = R.gen()
    sage_rem = power_mod(q, 5**14, mon)
    pm, pq = pari(mon), pari(str(q))
    pari_rem = R((pq.Mod(pm)**(5**14)).lift())
    assert sage_rem == pari_rem
    sg = mon.gcd(sage_rem-q).monic()
    pg = R(pm.gcd(pari_rem-q)).monic()
    assert sg == pg
    checks.append(dict(source=ep, monodromy_degree=int(mon.degree()),
                       finite_field_gcd_degree=int(sg.degree()),
                       exact_remainder_equality=True, exact_gcd_equality=True))
result = dict(sage_version=SAGE_VERSION, checks=checks,
              tested_polynomial_count=sum('exact_gcd_equality' in x for x in checks),
              verification='full coefficient equality, not only degrees or root counts')
(raw/'direction_boundary_pari_independent_checks.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result))
