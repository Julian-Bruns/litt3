#!/usr/bin/env sage
"""Literal verification of the new 420 quartic-twist unit identities.

No Groebner computation and no old-source replay.  The input file for
each branch retains its exact original coefficient equations.
"""
import json,sys
from pathlib import Path
d=Path(sys.argv[1]);summary={};quartics={}
for branch in ['generic','boundary']:
    count=0;terms=0;qs=[]
    for i in range(210):
        v=load(str(d/('%s_%03d.sobj'%(branch,i))));ps=v['equations'];ms=v['multipliers'];S=ps[0].parent()
        assert len(ps)==len(ms) and sum((p*m for p,m in zip(ps,ms)),S.zero())==1
        f=v['quartic'];assert f.degree()==4 and f.is_monic();qs.append(str(f));count+=1;terms+=sum(len(m.dict()) for m in ms)
    assert len(set(qs))==210;quartics[branch]=set(qs);summary[branch]={'identities':count,'multiplier_terms':terms,'literal_identity':'PASS'}
    print('LITERAL_UNIT_IDENTITIES_PASS',branch,count,flush=True)
assert quartics['generic']==quartics['boundary']
summary['coverage']='All210 distinct monic quartic divisors, each on the leading-comparison nonzero open and its zero boundary.'
(d/'independent_identity_receipt.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
