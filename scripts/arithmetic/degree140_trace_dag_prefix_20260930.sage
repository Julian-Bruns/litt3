"""Export already-computed leading coefficients from an exact DAG checkpoint.

ROOT DAG_STEM DEGREE LAST_ROW OUTPUT_STEM
This does not reconstruct missing coefficients. Every requested entry must
already be present in the full-operation cache, or the export fails.
Use a copied checkpoint when another calculation may still update it.
"""
import sys, json
from pathlib import Path

root=Path(sys.argv[1]); parent=sys.argv[2]; degree=int(sys.argv[3])
last=int(sys.argv[4]); stem=sys.argv[5]
state=load(str(root/(parent+'.sobj')))
rows=[]; report=[]
for i,node in enumerate(state['active_rows']):
    if i>last: break
    bound=int(state['nodes'][node]['degree'])
    if bound>degree:
        raise RuntimeError('Requested row has not been reduced to the target degree')
    value=state['cache'].get((int(node),degree))
    if value is None:
        raise RuntimeError('Missing exact cached coefficient for row '+str(i))
    N,D=value
    rows.append({'label':state['nodes'][node]['label'],
                 'coeff':{degree:value} if N else {}})
    report.append({'row':i,'terms':len(N.dict()),
                   'denominator_exponents':list(map(int,D))})
out={'ring':state['ring'],'Psi':state['Psi'],'rows':rows,'exact':True,
     'complete_through_row':last,'parent_dag':parent,'degree':degree}
save(out,str(root/stem))
(root/(stem+'.json')).write_text(json.dumps({'scope':'exact cached prefix only',
    'source':parent,'degree':degree,'rows':report},indent=2)+'\n')
print(json.dumps(report),flush=True)
