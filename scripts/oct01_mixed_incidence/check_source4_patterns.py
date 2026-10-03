#!/usr/bin/env sage
"""Exact literal-F5 check of the remaining four-distinct source parametrization."""
import argparse, hashlib, json
from pathlib import Path
from scan_direction_boundary import templates
from incidence import phase_polynomials, f5rank


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args()
    all_patterns=templates(4)
    distinct=[ep for ep in all_patterns if len(set(ep))==4]
    repeated=[ep for ep in all_patterns if len(set(ep))==3]
    assert len(all_patterns)==426 and len(distinct)==48 and len(repeated)==378
    loop_path=[ep for ep in distinct if sum(a==b for a,b in ep)==2]
    cycles=[ep for ep in distinct if all(a!=b for a,b in ep)]
    assert len(loop_path)==36 and len(cycles)==12
    assert len({tuple(sorted(ep)) for ep in loop_path})==6
    assert len({tuple(sorted(ep)) for ep in cycles})==3
    for ep in distinct:
        q=phase_polynomials(ep)
        assert f5rank(q)==2 and all(any(v) for v in q)
        assert len(set().union(*map(set,ep)))==4
        assert not set.intersection(*map(set,ep))
    result=dict(status='PASS',abstract_support4_templates=426,
                four_distinct_abstract=48,repeated_abstract=378,
                loop_path_patterns=36,cycle_patterns=12,
                actual_support_orbits=117,four_distinct_marked=5616,
                repeated_marked=44226,total_marked=49842,
                patterns=distinct,
                scanner_sha256=hashlib.sha256(Path(__file__).with_name('scan_direction_boundary.py').read_bytes()).hexdigest(),
                scope='exact support-four template count and literal-F5 phase conditions; no incidence decision')
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='patterns'}))


if __name__=='__main__':
    main()
