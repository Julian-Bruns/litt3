#!/usr/bin/env sage
"""Replay a native-field unit certificate without running a Groebner solver."""
import argparse,json,time
from pathlib import Path
from atlas_original_chart import OriginalChart,sha

ap=argparse.ArgumentParser();ap.add_argument('certificate');args=ap.parse_args()
started=time.monotonic();path=Path(args.certificate);d=json.loads(path.read_text())
assert d['status']=='verified_polynomial_certificate'
assert sha(d['tensor_path'])==d['source_sha256']
model=OriginalChart(d['tensor_path'],d['chart'],field_model=d['field_model'])
assert model.names==d['variables'] and len(model.original)==d['original_equation_count']==97
weights=[model.parse(f) for f in d['polynomial_multipliers']]
model.verify_unit(weights)
print(json.dumps(dict(certificate=str(path.resolve()),certificate_sha256=sha(path),
    source_sha256=d['source_sha256'],chart=d['chart'],rows=97,
    verified_original_unit_identity=True,search_or_groebner_solver_used=False,
    seconds=time.monotonic()-started),default=int),flush=True)
