#!/usr/bin/env python3
"""Exact one-unused-node test for the nonrational constant-character boundary.

Uses the complete45 additive target/subset incidences retained by the
constant-pencil enumeration. Only the intercept changes at an unused node.
The rational endpoint target is deliberately not covered here.
"""
import argparse,json,re
from pathlib import Path
import check_klein_four_constant_pencils as P
T=P.T;Z=P.Z;O=P.O


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('root',type=Path);a=ap.parse_args()
    data=json.loads((a.root/'constant_pencil_targets.json').read_text())
    pairs=re.findall(r'^SUM target=(\d+) complement_mask=(\d+)$',(a.root/'constant_pencil_subsets.log').read_text(),re.M)
    assert len(pairs)==45
    zs=[P.power((0,1,0,0,0,0,0),i) for i in range(29)];checks=[];matches=[]
    for ti,mask in pairs:
        ti=int(ti);mask=int(mask);target=data['nonrational_targets'][ti]
        Cprime=[O]
        for j in range(29):
            if not mask>>j&1:Cprime=P.pm(Cprime,[T.neg(zs[j]),O])
        Qprime,_=P.divide([Z]*22+[O],Cprime)
        slope=T.mul(Cprime[1],T.inv(Cprime[0]));old=P.scale(T.mul(Cprime[0],Qprime[1]),2)
        assert slope==tuple(target['slope'])
        for node in range(29):
            if mask>>node&1:continue
            z=zs[node];C,rem=P.divide(Cprime,[T.neg(z),O]);assert not any(v!=Z for v in rem)
            val=Z
            for coeff in reversed(C):val=T.add(T.mul(val,z),coeff)
            added=T.mul(T.mul(zs[node*21%29],C[0]),T.inv(val))
            intercept=T.add(old,added)
            ok=intercept==tuple(target['intercept'])
            record={'target':ti,'complement14_mask':mask,'unused_node':node,'match':ok}
            checks.append(record)
            if ok:matches.append(record)
    result={'scope':'All nonrational endpoint targets on the d=0,c=14 boundary with one unused pole location; rational target remains separate.',
            'count':len(checks),'matches':matches,'checks':checks}
    assert len(checks)==675
    (a.root/'mixed_constant_nonrational.json').write_text(json.dumps(result,indent=2)+'\n')
    print('Checked675 exact marked-node/target cases; matches:',matches)


if __name__=='__main__':main()
