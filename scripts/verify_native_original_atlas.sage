#!/usr/bin/env sage
"""Replay a native-field unit certificate without running a Groebner solver."""
import argparse,json,time
from pathlib import Path
from atlas_original_chart import OriginalChart,sha

ap=argparse.ArgumentParser();ap.add_argument('certificate')
ap.add_argument('--output',type=Path,help='Save this no-solver replay, without changing the certificate')
args=ap.parse_args()
started=time.monotonic();path=Path(args.certificate);d=json.loads(path.read_text())
assert d['status']=='verified_polynomial_certificate'
assert sha(d['tensor_path'])==d['source_sha256']
model=OriginalChart(d['tensor_path'],d['chart'],field_model=d['field_model'])
assert model.names==d['variables'] and len(model.original)==d['original_equation_count']==97
weights=[model.parse(f) for f in d['polynomial_multipliers']]
model.verify_unit(weights)
result=dict(certificate=str(path.resolve()),certificate_sha256=sha(path),
    source_sha256=d['source_sha256'],chart=d['chart'],rows=97,
    verified_original_unit_identity=True,search_or_groebner_solver_used=False,
    construction=model.timings,seconds=time.monotonic()-started)
if args.output:
    if args.output.exists():
        previous=json.loads(args.output.read_text())
        assert previous['certificate_sha256']==result['certificate_sha256']
        assert previous['source_sha256']==result['source_sha256']
        assert previous['verified_original_unit_identity'] is True
    else:
        temporary=Path(str(args.output)+'.tmp');temporary.write_text(json.dumps(result,indent=2,default=int)+'\n')
        temporary.replace(args.output)
print(json.dumps(result,default=int),flush=True)
