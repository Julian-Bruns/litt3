"""Run the new exhaustive repeated-pair sectors with compact atomic checkpoints.

The incoming sector certificates are inputs, not rerun here. Only newly
computed necessary-row survivors are retained; every processed interval has
its exact coverage counts. A partial interval collection proves no full theorem.
"""
import gzip
import json
import os
from pathlib import Path
import subprocess
import time

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT.parent / 'litt3-computation-data/seventeen_hour_continuation_20260929/rank3'
OUT.mkdir(parents=True, exist_ok=True)
ENV = dict(os.environ, OMP_NUM_THREADS='6')
intervals = [(0, 128)] + [(s, min(s + 8192, 402678)) for s in range(128, 402678, 8192)]
started = time.time()

def atomic_json(path, obj):
    tmp = path.with_suffix(path.suffix + '.tmp')
    tmp.write_text(json.dumps(obj, separators=(',', ':')) + '\n')
    tmp.replace(path)

records = []
for start, end in intervals:
    path = OUT / f'{start:06d}_{end:06d}.json.gz'
    if path.exists():
        with gzip.open(path, 'rt') as f:
            result = json.load(f)
    else:
        first = OUT / '000000_000128.json'
        if start == 0 and first.exists():
            result = json.loads(first.read_text())
        else:
            proc = subprocess.run([str(OUT / 'repeated'), str(start), str(end), '2'],
                                  env=ENV, text=True, capture_output=True, check=True)
            result = json.loads(proc.stdout)
        tmp = path.with_suffix('.tmp')
        with gzip.open(tmp, 'wt') as f:
            json.dump(result, f, separators=(',', ':'))
        tmp.replace(path)
    if (result['start'], result['end']) != (start, end):
        raise RuntimeError('interval metadata mismatch')
    if result['processed_base_pairs'] != (end - start) * 4228119:
        raise RuntimeError('interval did not complete its prescribed domain')
    records.append({k: v for k, v in result.items() if k != 'hits'})
    summary = {
        'status': 'complete' if end == 402678 else 'partial',
        'scope': 'All adjacent/adjacent and adjacent/opposite full-support phase-span-two endpoint pairs, modulo proved symmetries.',
        'incoming_results_replayed': False,
        'first_representatives_completed': end,
        'first_representatives_total': 402678,
        'partner_bases': 4228119,
        'processed_base_pairs': sum(r['processed_base_pairs'] for r in records),
        'row_hits': sum(r['row_hits'] for r in records),
        'rank_three': sum(r['rank_three'] for r in records),
        'elapsed_seconds': time.time() - started,
        'intervals': records,
    }
    atomic_json(OUT / 'progress.json', summary)
    print(json.dumps({k: v for k, v in summary.items() if k != 'intervals'}), flush=True)
print('FINISHED new repeated-pair sectors', flush=True)
