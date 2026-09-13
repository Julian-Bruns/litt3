#!/usr/bin/env python3
"""Bounded certified consequence reuse, adapting A18 predecessor reuse.

Each iteration retains all original polynomial equations and appends only
independently replayed consequences. It uses linear multipliers, avoiding
the enormous next full-degree matrix. Sources/certificates remain a DAG.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import json
import subprocess
import sys
import time
from pathlib import Path
from sage.all import GF,PolynomialRing
from scripts.atlases.algebra.export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('seed_source',type=Path);p.add_argument('seed_consequences',type=Path)
p.add_argument('out',type=Path);p.add_argument('--rounds',type=int,default=3)
p.add_argument('--seconds',type=int,default=60)
p.add_argument('--max-consequence-degree',type=int,default=2)
p.add_argument('--recursive-linear',action='store_true')
p.add_argument('--full-degree',type=int,default=1)
p.add_argument('--consequence-form',choices=['raw','echelon','sparsest'],default='raw')
p.add_argument('--max-consequence-terms',type=int,default=1000000)
p.add_argument('--max-new-generators',type=int,default=1000000)
p.add_argument('--total-seconds',type=int,default=1200)
p.add_argument('--max-nonzeros',type=int,default=2000000)
p.add_argument('--engine',choices=['python','cython'],default='python')
p.add_argument('--preserve-degree',type=int,default=2)
p.add_argument('--low-provenance',choices=['expanded','dag'],default='expanded')
args=p.parse_args();args.out.mkdir(exist_ok=False)
scripts=Path(__file__).resolve().parent;start=time.monotonic()
source=args.seed_source;consequences=args.seed_consequences
history=[]
def checkpoint(status):
    value=dict(status=status,seconds=time.monotonic()-start,
        source=str(source.resolve()),consequences=str(consequences.resolve()),
        stages=history,scope='Exact predecessor DAG; no geometric verdict without full replay')
    temporary=args.out/'progress.tmp'
    temporary.write_text(json.dumps(value,indent=2)+'\n')
    temporary.replace(args.out/'progress.json')

def checked_run(command,**kwargs):
    remaining=args.total_seconds-(time.monotonic()-start)
    if remaining<=0:
        checkpoint('total_budget_reached_completed_stages_saved');raise SystemExit(0)
    try:return subprocess.run(command,check=True,timeout=remaining,**kwargs)
    except subprocess.TimeoutExpired:
        checkpoint('total_budget_reached_completed_stages_saved');raise SystemExit(0)

checkpoint('started')
for iteration in range(args.rounds):
    if time.monotonic()-start>=args.total_seconds:
        checkpoint('total_budget_reached');break
    # A recursive affine substitution changes the next source ring. Rebuild
    # from that source, rather than silently coercing later certificates into
    # the old variables. Each source retains its substitution provenance.
    data=json.loads(source.read_text());d=data['field_degree']
    K=GF(5**d,'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
    R=PolynomialRing(K,data['variables'],order='degrevlex')
    equations=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
    certificates=sorted(c for c in consequences.glob('consequence*.json')
                        if c.stem[len('consequence'):].isdigit())
    certificates=[c for c in certificates if
        max(sum(e) for e,v in json.loads(c.read_text())['polynomial'])<=args.max_consequence_degree
        and len(json.loads(c.read_text())['polynomial'])<=args.max_consequence_terms]
    certificates.sort(key=lambda c:(len(json.loads(c.read_text())['polynomial']),c.name))
    # Keep sparse generators instead of importing every dense reduced row.
    certificates=certificates[:args.max_new_generators]
    if not certificates:
        print('NO_SELECTED_CONSEQUENCES_NOT_A_STABILITY_OR_GEOMETRIC_VERDICT',flush=True);break
    t=time.monotonic();added=[]
    for certificate in certificates:
        replay=certificate.with_suffix('.replay.json')
        # This independent replay is performed even if a prior receipt exists.
        command=['python3',str(scripts/'verify_field_macaulay_certificate.py'),str(source),
                 str(certificate),'--kind','consequence']
        result=checked_run(command,capture_output=True,text=True)
        receipt=json.loads(result.stdout)
        if not replay.exists():replay.write_text(json.dumps(receipt,indent=2)+'\n')
        c=json.loads(certificate.read_text());f=R({tuple(e):K(v) for e,v in c['polynomial']})
        if f not in equations:equations.append(f);added.append(str(certificate.resolve()))
    print(json.dumps(dict(stage='all_predecessors_independently_replayed',iteration=iteration,
        certificates=len(certificates),added=len(added),seconds=time.monotonic()-t)),flush=True)
    if not added:break
    checkpoint('predecessors_replayed')
    folder=args.out/('round%d'%iteration)
    export_system(R,equations,folder,c_degree=0,field_only=True,
                  full_degree=args.full_degree,eliminate_linear=args.recursive_linear)
    (folder/'predecessors.json').write_text(json.dumps(dict(previous_source=str(source.resolve()),
        initial_source=str(args.seed_source.resolve()),certificates=added),indent=2)+'\n')
    source=folder/'source.json';peeling=folder/('peeling_low%d.json'%args.preserve_degree);consequences=folder/'consequences'
    command=[sys.executable,str(scripts/'diagnose_macaulay_field_support.py'),str(source),
        '--preserve-degree',str(args.preserve_degree),'--receipt',str(peeling)]
    result=checked_run(command,capture_output=True,text=True)
    peel=json.loads(result.stdout)
    print(json.dumps(dict(stage='predecessor_matrix_peeled',iteration=iteration,
        rows=peel['remaining_rows'],columns=peel['remaining_columns'],
        terms=peel['remaining_nonzeros'])),flush=True)
    checked_run([sys.executable,str(scripts/'extract_macaulay_low_degree.py'),str(source),
        str(peeling),str(consequences),'--degree',str(args.preserve_degree),'--seconds',str(args.seconds),
        '--certificates','0','--consequence-form',args.consequence_form,
        '--engine',args.engine,
        '--low-provenance',args.low_provenance,
        '--max-nonzeros',str(args.max_nonzeros)])
    result=json.loads((consequences/'result.json').read_text());history.append(result)
    checkpoint('round_complete')
    if result.get('unit_candidate'):
        checked_run(['python3',str(scripts/'verify_field_macaulay_certificate.py'),str(source),
            str(consequences/'unit.json'),'--kind','primal'])
        print('FINAL_SOURCE_UNIT_REPLAY_PASS_NEEDS_FULL_DAG_AND_GEOMETRIC_REVIEW',flush=True);break
    if not result['new_independent_consequences']:break
(args.out/'history.json').write_text(json.dumps(dict(seconds=time.monotonic()-start,
    stages=history,scope='Exact predecessor consequence DAG; no geometric verdict without complete replay'),indent=2)+'\n')
checkpoint('bounded_batch_complete')
