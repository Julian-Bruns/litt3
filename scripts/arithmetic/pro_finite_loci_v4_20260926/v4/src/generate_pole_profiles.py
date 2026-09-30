#!/usr/bin/env python3
"""Exhaustive affine-orbit reduction of pole masses 2 through 5 (degrees 14..17)."""
from __future__ import annotations
import argparse, json, math
from collections import Counter
from itertools import combinations_with_replacement
from pathlib import Path

def profiles(mass:int)->dict:
    if mass not in (2,3,4,5):raise ValueError('Only small masses 2..5 are implemented')
    slopes=sorted({pow(25,i,29) for i in range(7)}|{(-pow(25,i,29))%29 for i in range(7)})
    assert len(slopes)==14
    todo={q for q in combinations_with_replacement(range(29),mass) if mass<5 or q[0]!=q[-1]}
    total=len(todo);rows=[]
    # Mass five cannot be concentrated at one node: allowed node weights exclude five.
    assert total==math.comb(28+mass,mass)-(29 if mass==5 else 0)
    while todo:
        rep=min(todo)
        orbit={tuple(sorted((h*x+b)%29 for x in rep)) for h in slopes for b in range(29)}
        assert rep==min(orbit) and orbit<=todo
        todo.difference_update(orbit)
        rows.append({'id':f'm{mass}_{len(rows):0{3 if mass==5 else 2}d}','multiset':list(rep),
                     'weighted_nodes':[list(x) for x in sorted(Counter(rep).items())], 'orbit_size':len(orbit)})
    assert sum(r['orbit_size'] for r in rows)==total
    return {'mass':mass,'degree':mass+12,'total_profiles':total,'slopes':slopes,
            'profiles':rows,'endpoint_quartets':math.comb(119,4)}

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--mass',type=int,choices=(2,3,4,5),required=True)
    ap.add_argument('--output',type=Path,required=True);ap.add_argument('--reference',type=Path)
    a=ap.parse_args();r=profiles(a.mass)
    if a.reference:assert r==json.loads(a.reference.read_text())
    a.output.write_text(json.dumps(r,indent=2)+'\n')
    print(f"PASS mass {a.mass}: {r['total_profiles']} weighted profiles in {len(r['profiles'])} complete orbits")
if __name__=='__main__':main()
