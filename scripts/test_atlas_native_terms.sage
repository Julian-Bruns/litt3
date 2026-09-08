#!/usr/bin/env sage
"""Exact low-row term reuse and byte-identical unit provenance regression."""
import argparse,json,time
from pathlib import Path
from atlas_original_chart import OriginalChart
from atlas_deck_chart import CubicDescendedChart
from atlas_affine_precondition import AffinePrecondition

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--chart',type=int,required=True);ap.add_argument('--grading',type=Path)
ap.add_argument('--previous-search-unit',type=Path);ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args();start=time.monotonic()
model=(CubicDescendedChart(args.tensor,args.chart,args.grading) if args.grading else
       OriginalChart(args.tensor,args.chart,native_input=True,retain_terms=True))
n=64+args.chart+1
assert len(model.original_low_terms)==n
assert all(model.ring(terms)==f for terms,f in zip(model.original_low_terms,model.original[:n]))
bad=dict(model.original_low_terms[-1]);zero=(0,)*model.ring.ngens();bad[zero]+=1
assert model.ring(bad)!=model.original[n-1]
conditioner=AffinePrecondition(model,reuse_native_terms=True)
weights=conditioner.immediate_unit();assert weights is not None
model.verify_unit(weights)
if args.previous_search_unit:
    previous=json.loads(args.previous_search_unit.read_text())
    assert previous['source_sha256']==model.source_sha256 and previous['chart']==args.chart
    assert previous['field_model']==model.field_model
    assert [str(h) for h in weights]==previous['polynomial_multipliers']
report=dict(source_sha256=model.source_sha256,chart=int(args.chart),degree_F5=model.degree,
    all_low_term_dictionaries_equal_original_polynomials=True,bad_constant_negative_control_passed=True,
    exact_unit_identity_verified=True,unchanged_previous_unit_multipliers=bool(args.previous_search_unit),
    polynomial_type=str(type(model.original[0])),construction=model.timings,
    precondition_seconds=conditioner.seconds,statistics=conditioner.statistics,
    seconds=time.monotonic()-start)
temp=args.output.with_suffix('.tmp');temp.write_text(json.dumps(report,indent=2,default=int)+'\n');temp.replace(args.output)
print(json.dumps(report,default=int),flush=True)
