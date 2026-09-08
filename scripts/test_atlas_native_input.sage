#!/usr/bin/env sage
"""Native search input vs an independent ORIGINAL-JSON97-row reconstruction."""
import argparse,json,time
from pathlib import Path
from atlas_original_chart import OriginalChart

ap=argparse.ArgumentParser();ap.add_argument('--tensor',required=True)
ap.add_argument('--chart',type=int,default=31);ap.add_argument('--output',type=Path);args=ap.parse_args()
start=time.monotonic();original=OriginalChart(args.tensor,args.chart,native_input=False)
cached=OriginalChart(args.tensor,args.chart,native_input=True)
assert cached.timings['indexed_native_input']
assert cached.field_model==original.field_model
assert cached.names==original.names and cached.original==original.original
report=dict(source_sha256=original.source_sha256,chart=int(args.chart),
    exact_all_97_original_rows_agree=True,degree_F5=original.degree,
    original_json=original.timings,indexed_native=cached.timings,
    seconds=time.monotonic()-start)
if args.output:
    temporary=Path(str(args.output)+'.tmp');temporary.write_text(json.dumps(report,indent=2,default=int)+'\n');temporary.replace(args.output)
print(json.dumps(report,default=int),flush=True)
