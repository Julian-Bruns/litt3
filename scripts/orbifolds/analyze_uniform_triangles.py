#!/usr/bin/env python3
"""Exact source filters on the complete characteristic-zero triangle tables.

Run with `sage -python` for exact GAP permutation-group orders. All
cycle, centralizer, block and fixed-point witnesses are checked here.
This records necessary exclusions, not good-reduction certificates.
"""
from collections import Counter
from pathlib import Path
from fractions import Fraction
import json
import sys
sys.path.insert(0, str(Path(__file__).parent / 'triangle237_certificate'))
from permutation_tools import cycles, rooted_key, commuting_permutations, invariant_partitions
from sage.all import PermutationGroup

SURVIVORS = {(3,3,5),(2,4,8),(2,5,5),(3,3,4),(2,3,10),
             (2,3,9),(2,4,5),(2,3,7)}


def block_record(t, part, signature):
    reps = sorted(set(part))
    labels = {b:i for i,b in enumerate(reps)}
    assert len(set(Counter(part).values())) == 1
    qt = [[labels[part[t[b][g]]] for g in range(3)] for b in reps]
    generators = [[r[0] for r in qt], [r[1] for r in qt]]
    generators.append([generators[1][generators[0][x]] for x in range(len(qt))])
    branches = [cycles(g) for g in generators]
    twice_genus = 2 + len(qt) - sum(map(len, branches))
    assert twice_genus >= 0 and twice_genus % 2 == 0
    inner = []
    for e, branch in zip(signature, branches):
        for orbit in branch:
            assert e % len(orbit) == 0
            if len(orbit) < e: inner.append(e//len(orbit))
    return {'partition':part, 'quotient_genus':twice_genus//2,
            'inner_degree':len(t)//len(qt), 'inner_profile':sorted(inner)}


def analyze(filename):
    _, n, a, b, c = filename.stem.split('_')
    n,a,b,c = map(int,(n,a,b,c)); signature=(a,b,c)
    tables=[json.loads(line) for line in filename.read_text().splitlines()]
    keys=set(); records=[]
    for number,raw in enumerate(tables,1):
        assert len(raw)==n and all(len(r)==4 for r in raw)
        for g in range(4): assert sorted(r[g] for r in raw)==list(range(n))
        assert all(raw[raw[x][0]][1]==x and raw[raw[x][2]][3]==x for x in range(n))
        t=[[r[0],r[2],r[3]] for r in raw]
        gens=[[r[0] for r in t],[r[1] for r in t]]
        gens.append([gens[1][gens[0][x]] for x in range(n)])
        cyc=[cycles(g) for g in gens]
        assert [sorted(map(len,s)) for s in cyc]==[[e]*(n//e) for e in signature]
        key=min(rooted_key(t,root) for root in range(n))
        assert key not in keys;keys.add(key)
        deck=commuting_permutations(t)
        record={'class_number':number,'deck_order':len(deck)}
        if len(deck)>2:
            record.update(category='extra_automorphisms',deck_witnesses=deck[:3])
        else:
            if len(deck)==2:
                involution=next(p for p in deck if p[0]!=0)
                assert all(involution[involution[x]]==x for x in range(n))
                counts=[sum({involution[x] for x in orbit}==set(orbit) for orbit in branch)
                        for branch in cyc]
                assert sum(counts) in (2,6)
                record.update(deck_involution=involution,branch_fixed_counts=counts)
                if sum(counts)==2: record['category']='elliptic_deck_quotient'
            if 'category' not in record:
                partitions=invariant_partitions(t)
                blocks=[block_record(t,p,signature) for p in partitions if 1<len(set(p))<n]
                record['block_quotients']=blocks
                elliptic=next((p for p in blocks if p['quotient_genus']==1),None)
                excluded=next((p for p in blocks if p['quotient_genus']==0
                               and tuple(p['inner_profile']) not in SURVIVORS
                               and p['inner_profile']!=[2]*6),None)
                if elliptic: record.update(category='elliptic_intermediate',witness=elliptic)
                elif excluded: record.update(category='excluded_uniform_factor',witness=excluded)
                else:
                    group=PermutationGroup([[x+1 for x in g] for g in gens[:2]])
                    order=int(group.order())
                    record['monodromy_order']=order
                    record['category']='prime_to_five_monodromy' if order%5 else 'unresolved'
        records.append(record)
    return {'degree':n,'profile':signature,'count':len(records),
            'mass':str(sum((Fraction(1,r['deck_order']) for r in records),Fraction(0))),
            'category_counts':dict(Counter(r['category'] for r in records)),
            'unresolved_buckets':dict(Counter(str(r['monodromy_order']) for r in records
                                             if r['category']=='unresolved')),
            'records':records}


def main():
    directory=Path(sys.argv[1])
    results=[]
    for filename in sorted(directory.glob('tri_*.jsonl')):
        result=analyze(filename);results.append(result)
        print(result['profile'],result['category_counts'],result['unresolved_buckets'],flush=True)
        (directory/'analysis.json').write_text(json.dumps(results,indent=2)+'\n')


if __name__=='__main__': main()
