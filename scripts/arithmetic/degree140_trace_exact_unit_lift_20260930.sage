"""Lift a chart unit in an exact trace-leading ideal.

ROOT BASIS_STEM OUTPUT_STEM. The basis stem names an output of
degree140_trace_next_leading_ideal_20260930.sage. Removed chart units
are retained for subsequent full-polynomial DAG combinations.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]); basisstem=sys.argv[2]; stem=sys.argv[3]; start=time.time()
data=load(str(root/(basisstem+'.sobj'))); R=data['ring']; H,q=R.gens(); Psi=data['Psi']
rows=data['inputs']; polynomials=[N for i,N in rows]
I=R.ideal(polynomials); basis=R.ideal(data['ideal_basis']); target=None
for total in range(41):
    for a in range(total+1):
        candidate=H^a*q^(total-a)
        if not basis.reduce(candidate):
            target=candidate; break
    if target is not None: break
if target is None:
    for exponent in range(1,21):
        candidate=(H*q*Psi)^exponent
        if not basis.reduce(candidate):
            target=candidate; break
if target is None:
    raise RuntimeError('No chart unit found in bounded lift search; inspect the exact saturated ideal')
print('target degree',target.degree(),'terms',len(target.dict()),flush=True)
weights=list(target.lift(I))
assert sum((w*N for w,N in zip(weights,polynomials)),R.zero())==target
out={'ring':R,'Psi':Psi,'target':target,'weights':[(int(rows[j][0]),w) for j,w in enumerate(weights) if w],
     'inputs':rows,'removed_units':data.get('removed_units',[]),
     'parent':data['parent'],'degree':data['degree']}
save(out,str(root/stem))
report={'scope':'exact leading unit certificate, not a full-locus decision',
        'target':str(target),'degree':int(data['degree']),
        'weights':[{'row':int(i),'terms':len(w.dict()),'H_degree':int(w.degree(H)),
                    'q_degree':int(w.degree(q))} for i,w in out['weights']],
        'seconds':time.time()-start}
(root/(stem+'.json')).write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
