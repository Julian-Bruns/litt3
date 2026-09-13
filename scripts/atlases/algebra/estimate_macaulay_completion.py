#!/usr/bin/env python3
"""Back-test finite-pass ETA rules; refuse to turn them into a proof ETA.

Only completed exact passes are calibration data. Prefixes use no future
information to make their predictions. Bounds are observed calibration
envelopes, NOT statistical confidence intervals or mathematical bounds.
"""
import argparse,json,math,statistics
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--completed',type=Path,action='append',required=True)
p.add_argument('--current',type=Path,required=True)
p.add_argument('--output',type=Path)
p.add_argument('--max-nonzeros',type=int,default=5000000)
args=p.parse_args()
def load(path):
    rows=[]
    for line in path.read_text().splitlines():
        try:r=json.loads(line)
        except json.JSONDecodeError:continue # a currently written final line
        if 'high_columns' in r:rows.append(r)
    return rows
def predictions(rows,i):
    first=rows[0];now=rows[i];elapsed=now['seconds']-first['seconds']
    out={}
    for key,label in [('high_rows','rows_fraction'),('high_columns','columns_fraction')]:
        done=first[key]-now[key]
        if done>0:out[label]=elapsed*now[key]/done
    # Work forecasts are translated with the CURRENT arithmetic throughput,
    # separating fill-in from CPU/memory contention during other jobs.
    prior=max((j for j in range(i) if rows[j]['seconds']<=now['seconds']-20),default=0)
    before=rows[prior];dt=now['seconds']-before['seconds']
    dc=before['high_columns']-now['high_columns']
    du=now['updates']-before['updates']
    if dt>0 and dc>0 and du>0:
        remaining_work=du*now['high_columns']/dc
        out['recent_column_rate']=remaining_work/(du/dt)
    if dt>0 and du>0 and now['high_rows']>0 and now['high_columns']>0:
        rowsize=now['nonzeros']/now['high_rows']
        colsize=now['high_nonzeros']/now['high_columns']
        work=now['high_columns']*max(0,colsize-1)*max(0,rowsize-1)
        out['stationary_sparsity']=work/(du/dt)
    return out
calibration=[];details=[]
for path in args.completed:
    rows=load(path);assert rows[-1]['stage']=='elimination_complete',path
    finish=rows[-1]['seconds'];first=rows[0]
    checkpoints=[]
    for fraction in (.25,.5,.75,.9):
        i=min(range(1,len(rows)-1),key=lambda j:abs((rows[j]['seconds']-first['seconds'])/(finish-first['seconds'])-fraction))
        now=rows[i];remaining=finish-now['seconds'];pred=predictions(rows,i)
        checkpoints.append(dict(elapsed_seconds=now['seconds'],actual_remaining_seconds=remaining,
            column_fraction_removed=1-now['high_columns']/first['high_columns'],predictions=pred,
            multiplicative_error={k:max(v/remaining,remaining/v) for k,v in pred.items() if v>0}))
    for i in range(1,len(rows)-1):
        if rows[i]['seconds']-first['seconds']<20:continue
        remaining=finish-rows[i]['seconds']
        if remaining<5:continue
        for method,estimate in predictions(rows,i).items():
            if estimate>0:
                calibration.append(dict(method=method,actual_over_prediction=remaining/estimate,
                    relative_columns=rows[i]['high_columns']/first['high_columns']))
    details.append(dict(trace=str(path.resolve()),elimination_seconds=finish-first['seconds'],
        final_updates=rows[-1]['updates'],checkpoints=checkpoints))
rows=load(args.current);now=rows[-1];current=predictions(rows,len(rows)-1) if len(rows)>1 else {}
summaries={}
for method in current:
    values=[c['actual_over_prediction'] for c in calibration if c['method']==method]
    if not values:continue
    lo,hi=min(values),max(values)
    summaries[method]=dict(point_seconds=current[method],calibration_prefixes=len(values),
        observed_actual_over_prediction=[lo,hi],
        observed_envelope_remaining_seconds=[lo*current[method],hi*current[method]],
        envelope_factor=hi/lo)
max_known_nonzeros=max(r['nonzeros'] for path in args.completed for r in load(path))
ood=now['nonzeros']>max_known_nonzeros
result=dict(scope='Finite high-column elimination only; does not predict a unit, required future rounds, or geometric exclusion',
    current_trace=str(args.current.resolve()),current_state=now,completed_backtests=details,
    estimates=summaries,current_nonzeros_exceed_every_calibration_state=ood,
    largest_calibration_nonzeros=max_known_nonzeros,
    reliability=('finite pass complete' if now['stage']=='elimination_complete' else
                 'ABSTAIN: fill-in outside calibration range' if ood else
                 'PRELIMINARY observed envelopes only; two/few completed passes do not justify a confidence interval'),
    remaining_coefficient_update_bound=now['high_columns']*args.max_nonzeros,
    update_bound_scope='Exact bound before completion OR the NNZ stop: shortest incident pivot row implies at most current NNZ updates per pivot; at most this many high-column pivots remain. Not a wall-time bound or proof-completion bound.',
    proof_completion_eta=None)
text=json.dumps(result,indent=2)+'\n'
if args.output:args.output.write_text(text)
print(text)
