#!/usr/bin/env python3
"""Field-aware operation logs for every atlas representative, not an ETA model."""
import argparse
import hashlib
import json
import re
from pathlib import Path
import time
import uuid

ROOT=Path(__file__).resolve().parents[1]


def context(folder, backend, representative=None):
    folder=Path(folder)
    m=json.loads((folder/'metadata.json').read_text())
    manifest=json.loads((ROOT/'Research/computations/oper_representatives_manifest.json').read_text())
    known={r['id']:r for r in manifest['representatives']}
    rep=representative or m.get('oper_representative')
    if rep is None and m.get('source_sha256')=='bcc027f5e4c283d35f71bc0cdd58a404ee880a5f65b6df1685a62fa670339a06':
        rep='orbit_0000'  # The identified old cache, not a generic default.
    if rep not in known:
        raise ValueError('Unknown representative; do not silently label it first/F25')
    desc=m.get('field_description')
    degree=m.get('field_degree_F5')
    if degree is None and m.get('field')=='F5[a]/(a^2+4*a+2)':
        degree=2
    if degree is None:
        raise ValueError('Missing actual coefficient-field degree')
    names=m.get('final_variables',[])
    return dict(schema=1,representative=rep,chart=m['chart'],backend=backend,
        source_sha256=m['source_sha256'],input_sha256=m.get('input_sha256'),
        coefficient_field_degree_F5=int(degree),
        coefficient_field_description_sha256=hashlib.sha256(json.dumps(desc,sort_keys=True).encode()).hexdigest() if desc else None,
        coefficient_description_source=str((folder/'metadata.json').resolve()),
        arithmetic_domain='F5_encoded' if backend=='f4_encoded' else backend,
        encoded_coefficient_variables=[n for n in names if not re.fullmatch(r'[vb][0-9]+|w',n)],
        geometric_coverage=known[rep]['geometric_coverage'],
        field_operation_warning='Counts in F5_encoded are base-field operations, NOT multiplications in the represented extension field.')


def start_run(log, data, **extra):
    record=dict(event='run_start',run_id=uuid.uuid4().hex,unix_seconds=time.time(),**data,**extra)
    with Path(log).open('a') as stream:stream.write(json.dumps(record,sort_keys=True)+'\n')
    return record


def summarize(path):
    """Report each invocation separately; never sum cumulative resume counters."""
    runs=[];current=None
    with Path(path).open() as stream:
        for raw in stream:
            try:e=json.loads(raw)
            except json.JSONDecodeError:break  # A concurrent final record may be incomplete.
            if e.get('event')=='run_start':
                current=dict(context=e.get('context',e),run_id=e.get('run_id'),rounds=0,counts={},phase_seconds={},notes=[])
                runs.append(current)
            if current is None:
                current=dict(context={'legacy_log':True},rounds=0,counts={},phase_seconds={},notes=[])
                runs.append(current)
            if e.get('event') in ('run_start','interval') and e.get('counter_scope')=='interval_actual_work':
                for k,v in e.get('counts',{}).items():
                    target=current['phase_seconds'] if k.endswith('_seconds') else current['counts']
                    target[k]=target.get(k,0)+v
                current['phase_seconds']['measured_interval_seconds']=current['phase_seconds'].get('measured_interval_seconds',0)+e.get('interval_seconds',0)
                current['last_processed_row']=e['processed_end']
                current['last_rank']=e['rank']
                current['counter_scope']=e['counter_scope']
            elif e.get('event')=='round':
                current['rounds']+=1
                for k in ('select_seconds','symbol_seconds','la_seconds','update_seconds','round_seconds'):
                    current['phase_seconds'][k]=current['phase_seconds'].get(k,0)+e.get(k,0)
            elif e.get('event')=='granular_round':
                for k in ('coefficient_updates','row_subtractions','row_reducer_calls','reducer_column_probes',
                          'reducer_zero_returns','symbol_queries','symbol_mask_skips','symbol_full_divisibility_rejects',
                          'symbol_generated_rows','symbol_generated_terms','zero_rows','gm_criterion_rejections','redundant_basis_elements'):
                    current['counts'][k]=current['counts'].get(k,0)+e[k]
                current['phase_seconds']['checkpoint_seconds']=current['phase_seconds'].get('checkpoint_seconds',0)+e['checkpoint_seconds']
                current['counter_scope']=e['counter_scope']
                current['largest_matrix_nnz']=max(current.get('largest_matrix_nnz',0),e['matrix_nnz'])
                if e.get('coefficient_degree_profile_available'):
                    for k in ('max_coefficient_generator_degree','max_genuine_unknown_degree'):
                        current[k]=max(current.get(k,0),e[k])
    for run in runs:
        c=run['counts']
        if c.get('row_subtractions'):
            run['coefficient_updates_per_subtraction']=c['coefficient_updates']/c['row_subtractions']
        run['notes'].append('Zero rows and criterion rejections are measured redundancy; repeated nonzero work may still be necessary.')
        if not c:run['notes'].append('No granular engine records: arithmetic counts unavailable, not zero.')
    return dict(schema=1,source=str(Path(path).resolve()),invocations=runs)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('log');parser.add_argument('--output')
    args=parser.parse_args();data=summarize(args.log)
    text=json.dumps(data,indent=2)+'\n'
    if args.output:Path(args.output).write_text(text)
    print(text,end='')
