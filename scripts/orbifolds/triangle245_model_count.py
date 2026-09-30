#!/usr/bin/env python3
"""Count normalizations of the desired hyperelliptic quotient passport."""
from collections import Counter
from fractions import Fraction
from pathlib import Path
import json
import sys
sys.path.insert(0,str(Path(__file__).parent/'triangle237_certificate'))
from permutation_tools import cycles,commuting_permutations


def main():
    source=Path(sys.argv[1]);counts=Counter();records=[]
    for number,line in enumerate(source.read_text().splitlines(),1):
        raw=json.loads(line);table=[[r[0],r[2],r[3]] for r in raw]
        a=[r[0] for r in table];b=[r[1] for r in table]
        branches=[cycles(g) for g in (a,b,[b[a[x]] for x in range(40)])]
        deck=commuting_permutations(table)
        for h in deck:
            if h[0]==0 or any(h[h[x]]!=x for x in range(40)):continue
            fixed=tuple(sum({h[x] for x in orbit}==set(orbit) for orbit in branch)
                        for branch in branches)
            if fixed!=(4,2,0):continue
            counts[len(deck)]+=1
            records.append({'class_number':number,'deck_order':len(deck),
                            'normalized_count':str(Fraction(16,len(deck)))})
    total=sum((Fraction(16,d)*m for d,m in counts.items()),Fraction(0))
    assert dict(counts)=={2:21,4:15,8:4} and total==236
    output={'by_deck_order':dict(counts),'normalized_model_count':str(total),'records':records}
    (source.parent/'triangle245_normalized_model_count.json').write_text(json.dumps(output,indent=2)+'\n')
    print('hyperelliptic passport by deck order:',dict(counts),flush=True)
    print('normalized model count:',total,': PASS',flush=True)


if __name__=='__main__':main()
