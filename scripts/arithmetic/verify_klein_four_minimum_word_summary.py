#!/usr/bin/env python3
"""Check complete word logs and regenerate the new degree89 count profile."""
import argparse
import hashlib
import json
import math
import re
import sys
from pathlib import Path


def read_numbers(line):
    return {k:int(v) for k,v in re.findall(r'(\w+)=(-?\d+)',line)}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('evidence',type=Path)
    args=ap.parse_args()
    path=args.evidence
    first=read_numbers((path/'minimum_word_endpoints.log').read_text().strip())
    assert first['normalized_subsets']==math.comb(28,12)==first['covered']
    assert first['representatives']==167367
    assert first['first_endpoint_orbits']==first['both_endpoint_orbits']==0
    rows=[]
    for line in (path/'minimum_word_all.log').read_text().splitlines():
        assert line.startswith('d=')
        row=read_numbers(line);d=row['d'];rows.append(row)
        assert row['complementary_nodes']==13-2*d
        assert row['normalized_subsets']==math.comb(28,12-2*d)==row['covered']
        for key in ('zero_cofactor_kernel','simple_end_zero','first_endpoint_orbits',
                    'both_endpoint_orbits','both_ends_double_zero'):assert row[key]==0
    assert [r['d'] for r in rows]==[1,2,3,4,5]
    assert [r['representatives'] for r in rows]==[85358,24739,3872,299,10]
    independent=json.loads((path/'minimum_word_independent.json').read_text())
    assert independent['status']=='PASS' and independent['count']==24
    sys.path.insert(0,str(Path(__file__).resolve().parent/'pro_finite_square_secant_20260926/klein/src'))
    import new_profile_checks as P
    old=P.one_degree(89)
    profiles=[r for r in old['surviving_tuples'] if r['g']<=49+r['j1']+r['j2']]
    assert profiles==[{'g':73,'s':5,'a':5,'j1':24,'j2':0,'e':29}]
    allocations=[]
    for q0 in range(25):
        for q1 in range(q0,25-q0):
            q2=24-q0-q1
            if q2<q1:continue
            qs=(q0,q1,q2);cs=tuple(24-q for q in qs)
            for d0 in range(3):
                for d1 in range(3-d0):
                    ds=(d0,d1,2-d0-d1)
                    if any(c>15+2*d for c,d in zip(cs,ds)):continue
                    hs=tuple(10+c-d for c,d in zip(cs,ds))
                    assert sum(hs)==76
                    if any(q>15+2-d for q,d in zip(qs,ds)):continue
                    allocations.append({'q':qs,'c':cs,'d':ds,'h':hs})
    assert len(allocations)==4
    source=Path(__file__).resolve().parent
    files=[source/'klein_four_minimum_word_endpoints.cpp',source/'klein_four_minimum_word_all.cpp',
           source/'check_klein_four_minimum_words.py',source/'verify_klein_four_minimum_word_summary.py',
           path/'minimum_word_endpoints.log',path/'minimum_word_all.log',path/'minimum_word_independent.json']
    out={'status':'PASS','scope':'Complete forced cyclotomic minimum-word exclusions and necessary degree89 integer profiles; not a geometric-cover search.',
         'd0':first,'d1_to_d5':rows,'independent_checks':24,
         'degree89_scalar_profiles':profiles,'degree89_character_allocations':allocations,
         'sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}
    (path/'minimum_word_summary.json').write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: all six complete logs,24 independent reconstructions,unique degree89 scalar profile and four character profiles.')


if __name__=='__main__':main()
