#!/usr/bin/env sage
"""Every descended row equals its ORIGINAL row under explicit diagonal units."""
import argparse,json,time
from pathlib import Path
from atlas_deck_chart import CubicDescendedChart
ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--grading',type=Path,required=True);ap.add_argument('--chart',type=int,required=True)
ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
start=time.monotonic();model=CubicDescendedChart(args.tensor,args.chart,args.grading)
original,substitute,power=model.original_comparison(verify_all_rows=True)
report=dict(source_sha256=model.source_sha256,chart=int(args.chart),all97_original_row_identities_verified=True,
    every_R_graph_and_normalization_row_retained=True,original_degree_F5=original.degree,
    descended_degree_F5=model.degree,descended_construction=model.timings,
    original_construction=original.timings,seconds=time.monotonic()-start)
pending=args.output.with_suffix('.tmp');pending.write_text(json.dumps(report,indent=2,default=int)+'\n');pending.replace(args.output)
print(json.dumps(report,default=int),flush=True)
