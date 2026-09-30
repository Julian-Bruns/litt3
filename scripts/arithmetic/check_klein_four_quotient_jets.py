#!/usr/bin/env python3
"""Check the exact scope of denominator-free quotient-jet rigidity."""
import argparse
import hashlib
import json
from pathlib import Path

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('profiles',type=Path,nargs='+')
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    inputs=[json.loads(path.read_text()) for path in args.profiles];rows=[]
    for row in [r for data in inputs for r in data['rows']]:
        if row['n'] not in (85,86,87):continue
        checks=[]
        for profile in row['profiles']:
            u=29-profile['e']
            for a in profile['character_allocations']:
                first=[c+u>=12+2*d for c,d in zip(a['c'],a['d'])]
                second=[2*c+u>=12+2*d for c,d in zip(a['c'],a['d'])]
                old_good=sum(first)>=2 and all(v or w for v,w in zip(first,second))
                j=profile['j1']+profile['j2']
                varying_quadratic=profile['g']>38+j-u-profile['j2']
                assert varying_quadratic == (2*j+2*profile['j2']>22+2*sum(a['d'])-2*u)
                good=(sum(first)>=2 or (any(first) and varying_quadratic)) and all(v or w for v,w in zip(first,second))
                lifts=[d<=3 or (d<=10 and c-profile['j2']>2*d+8)
                       for c,d in zip(a['c'],a['d'])]
                known_t=[d<=3 or (v and w) for d,v,w in zip(a['d'],first,lifts)]
                quadratic=profile['g']>57-2*u-2*profile['j2']
                axes=all(2*c+u>15+d for c,d in zip(a['c'],a['d']))
                bootstrap=any(first) and all(known_t) and quadratic and axes
                checks.append({'g':profile['g'],'e':profile['e'],'j1':profile['j1'],'j2':profile['j2'],
                               'd':a['d'],'c':a['c'],'first':first,'coupled':second,'previous_quotients_unique':old_good,
                               'varying_denominator_quadratic':varying_quadratic,'quotients_unique':good,
                               'lift_conditions':lifts,'known_denominators':known_t,
                               'quadratic_bootstrap':bootstrap,
                               'complete_characters_unique':(good and all(lifts)) or bootstrap})
        total=len(checks);unique=sum(v['quotients_unique'] for v in checks)
        assert (total,unique)=={85:(4616,4559),86:(729,729),87:(109,109)}[row['n']]
        complete=sum(v['complete_characters_unique'] for v in checks)
        if row['n'] in (86,87):assert complete==total
        rows.append({'n':row['n'],'allocations':total,'unique_quotients':unique,
                     'unique_complete_characters':complete,'checks':checks})
        print('PASS degree',row['n'],':',unique,'of',total,'quotient triples uniquely determined')
        print('PASS complete character lifts:',complete,'of',total)
    assert len({row['n'] for row in rows})==len(rows)
    args.output.write_text(json.dumps({'status':'PASS','scope':'Integer hypotheses only; no actual candidate existence assertion.',
        'inputs':[{'path':str(path),'sha256':hashlib.sha256(path.read_bytes()).hexdigest()} for path in args.profiles],
        'rows':rows},indent=2)+'\n')

if __name__=='__main__':main()
