#!/usr/bin/env python3
"""Check the scope of the fixed-denominator theorem on retained profiles."""
import argparse
import collections
import hashlib
import json
from pathlib import Path

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('profiles',type=Path)
    p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();data=json.loads(a.profiles.read_text());rows=[]
    for row in data['rows']:
        if row['n'] not in (86,87):continue
        count=unique=0;hist=collections.Counter();checks=[]
        for profile in row['profiles']:
            g=profile['g'];j=profile['j1']+profile['j2'];u=29-profile['e']
            D=27+2*j-g;H=15+D-u
            for allocation in profile['character_allocations']:
                ds=allocation['d'];cs=allocation['c'];hs=allocation['h']
                assert sum(ds)==D and sum(cs)==2*j and sum(hs)==g+3
                rank_one=g>57-2*u-2*profile['j2']
                axis_margin=min(2*c+u-15-d for c,d in zip(cs,ds))
                slack=H-(2*j+2)//3
                passed=rank_one and axis_margin>0 and slack<=3
                rational=j>H
                count+=1;unique+=passed;hist[slack]+=1
                if row['n']==87:assert passed and rational
                checks.append({'profile':{k:v for k,v in profile.items() if k!='character_allocations'},
                               'd':ds,'c':cs,'H':H,'slack':slack,
                               'axis_margin':axis_margin,'rank_one':rank_one,
                               'homogeneous_direction_over_M':rational,
                               'completion_unique':passed})
        assert (count,unique)==((729,580) if row['n']==86 else (109,109))
        rows.append({'n':row['n'],'allocations':count,'unique_completions':unique,
                     'slack_histogram':dict(hist),'checks':checks})
        print('PASS:',row['n'],'unique completion on',unique,'of',count,'necessary allocations')
    assert len(rows)==2
    a.output.write_text(json.dumps({'status':'PASS','scope':'Integer consequences of the retained complete necessary-profile enumeration; no actual curve existence assertion.',
        'input_sha256':hashlib.sha256(a.profiles.read_bytes()).hexdigest(),'rows':rows},indent=2)+'\n')

if __name__=='__main__':main()
