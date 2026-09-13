#!/usr/bin/env sage
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
"""Check a saved weak rooted-chart unit directly against the original tensors.

No matrix, row reduction, elimination graph, checkpoint or solver is read.
The original full chart supplies all rows; unused rows have zero multiplier.
This verifier covers the saved F25 pencil certificates.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import sage_eval
from scripts.atlases.atlas_original_chart import OriginalChart, sha


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('certificate', type=Path)
    parser.add_argument('--tensor', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    started = time.monotonic()
    root = Path(__file__).resolve().parents[2]
    record = json.loads(args.certificate.read_text())
    source = args.tensor or Path(record.get('source') or
                                root / 'Research/computations/canonical_atlas_system.json')
    assert sha(source) == record['source_sha256']
    assert record['status'] in ['verified_polynomial_certificate',
                                'verified_original_polynomial_unit_certificate']
    chart = int(record['chart'])
    tensor = json.loads(source.read_text())
    desc = tensor.get('field_description') or dict(
        kind='finite_field', characteristic=5, degree=2,
        generator='a', modulus=[2,4,1])
    assert desc['kind'] == 'finite_field' and desc['characteristic'] == 5
    assert desc['degree'] == 2 and desc['modulus'] == [2,4,1]
    assert desc.get('base_F25_generator', [0,1]) == [0,1]
    model = OriginalChart(source, chart, field_model=dict(
        degree_F5=2, modulus=[2,4,1],
        layer_generator_images={desc['generator']: [0,1]}))
    local = dict(model.locals, **model.images)
    weights = [model.ring(sage_eval(s, locals=local))
               for s in record['polynomial_multipliers']]
    assert len(weights) == 65 + chart
    v_bound, b_bound = record['multiplier_bidegree_bound']
    last = model.ring.ngens() - 1
    assert all(sum(ex[:32]) <= v_bound and sum(ex[32:last]) <= b_bound
               and ex[last] == 0 for f in weights for ex in f.dict())
    weights += [model.ring.zero()] * (97 - len(weights))
    model.verify_unit(weights)
    result = dict(status='PASS_original_tensor_polynomial_identity',
        certificate=str(args.certificate.resolve()),
        certificate_sha256=sha(args.certificate), source=str(source.resolve()),
        source_sha256=sha(source), chart=chart,
        multiplier_bidegree_bound=record['multiplier_bidegree_bound'],
        original_rows=97, nonzero_rows=sum(f != 0 for f in weights),
        matrix_or_solver_used=False, verifier_sha256=sha(Path(__file__).with_suffix(''))
            if str(__file__).endswith('.sage.py') else sha(__file__),
        seconds=time.monotonic() - started,
        scope='This rooted chart is empty over the algebraic closure; no whole-oper conclusion.')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('x') as stream:
        stream.write(json.dumps(result, indent=2, default=int) + '\n')
    print(json.dumps(result, default=int), flush=True)


if __name__ == '__main__':
    main()
