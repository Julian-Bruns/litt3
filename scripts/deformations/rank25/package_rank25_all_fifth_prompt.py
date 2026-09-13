#!/usr/bin/env python3
"""Build finite mathematical inputs for the family question (<=20,000 bytes)."""
import argparse
import ast
import hashlib
import io
import json
from math import prod
from pathlib import Path
import subprocess
import sys
import tempfile
import zipfile

LIMIT = 20_000
IDENTITY = 'RANK25-OPEN-W5-minimal-v4'
README = """# Finite inputs for the residual open-family fifth-lift question

These supplement the self-contained mathematical prompt. They are not a
full higher-Witt replay or a fifth-obstruction calculation.

All coefficients are in F_5[t]/(t^4+4t^3+t^2+4t+3). Sparse tensors use
row-major indices and encode a0+a1*t+a2*t^2+a3*t^3 as a0+5*a1+25*a2+125*a3.
model.py decodes them to coefficient tuples; unspecified entries are zero.

- data.json: the actual Hodge matrix M, nine kernel vectors (rows), nine
  obstruction dual rows, primary repair, and coupled cover coefficients.
  The 75 tangent coordinates are (i,j,epsilon), lexicographically, with
  0<=i,j<=4 and epsilon=-3,-1,1. Psi(v)=M*v^[5].
- fourth.json: the complete nine-coordinate fourth obstruction
  C+sum ordinary[i]*x_i+sum frobenius[i]*x_i^5
  +sum quadratic[i,j]*x_i^5*x_j^5. It also contains the full 75-coordinate
  normal representative restricted to the candidates x7=x8=0.
- first_repairs.json: actual affine Hodge primitive u_U at the primary
  origin, then its seven variations U_i. Thus u_U=U_origin+sum x_i^5*U_i
  on the candidate family. A record [i,j,v_power,u_power,c] denotes
  c*w1^i*w2^j*v^v_power*u^u_power. The sign already includes u_U=-affine(rho2).
  The regular infinity primitive is the full (rho2+u_U)/z^2.
- family.json: the audited adjoint row and quotient matrices, the reported
  trace candidate, and one freshly computed reference-independent residual.
  A/B polynomials use sorted lists of variable indices in (y0,y1,y2,a,b,s);
  [] denotes a constant. Theta uses exponent vectors in (U,A,B,q).
  The trace candidate is NOT a proved universal fifth calculation. The
  point residual is geometric evidence at that point only.

Run `python3 model.py` for finite-field consistency checks. Import load,
evaluate_fourth, jacobian_fourth, mv and rank for calculations. Arithmetic
is over F_625; geometric parameters in larger fields require their actual
field arithmetic. Inverse Frobenius a^125 applies only over F_625.
"""


def sha(blob):
    return hashlib.sha256(blob).hexdigest()


def flatten_fields(value):
    if isinstance(value[0], int):
        assert len(value) == 4 and all(0 <= a < 5 for a in value)
        yield value
    else:
        for row in value:
            yield from flatten_fields(row)


def pack(value):
    shape = []
    first = value
    while isinstance(first, list):
        shape.append(len(first))
        first = first[0]
    assert shape[-1] == 4
    rows = list(flatten_fields(value))
    assert len(rows) == prod(shape[:-1])
    result = {'shape': shape[:-1], 'nonzero': [
        [i, sum(c * 5**j for j, c in enumerate(row))]
        for i, row in enumerate(rows) if any(row)]}
    decoded = [[0]*4 for _ in rows]
    for i, code in result['nonzero']:
        decoded[i] = [(code // 5**j) % 5 for j in range(4)]
    assert decoded == rows
    return result


def fourth_block(raw, normal=False):
    prefix = 'normal_cohomology_' if normal else ''
    count = 7 if normal else 9
    terms = []
    for row in raw['quadratic_fifth']:
        if row['i'] >= count or row['j'] >= count:
            continue
        coefficient = row['normal_cohomology' if normal else 'coefficient']
        if any(any(c) for c in coefficient):
            terms.append([row['i'], row['j'], pack(coefficient)])
    return {
        'constant': pack(raw[prefix+'constant']),
        'ordinary': pack(raw[prefix+'linear_x'][:count]),
        'frobenius': pack(raw[prefix+'linear_fifth'][:count]),
        'quadratic': terms,
    }


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('w5', type=Path)
    p.add_argument('--fresh-w4', type=Path, required=True)
    p.add_argument('--returns', type=Path, required=True)
    a = p.parse_args()
    root = Path(__file__).resolve().parents[3]
    source = a.w5/'supplied/inputs/rank25_fourth.json'
    source_blob = source.read_bytes()
    manifest = json.loads((a.w5/'MANIFEST.json').read_text())['files']
    assert sha(source_blob) == manifest['supplied/inputs/rank25_fourth.json']['sha256']
    primary = json.loads(source_blob)
    raw_path = a.fresh_w4/'work/receipts/universal2100.json'
    raw_blob = raw_path.read_bytes()
    raw = json.loads(raw_blob)
    assert raw['status'].startswith('PASS') and raw['parameter_indices'] == list(range(9))
    assert not any(any(c) for row in raw['linear_x'] for c in row)
    data = {key: pack(primary[key]) for key in [
        'additive_matrix', 'hodge_matrix', 'kernel_basis',
        'primary_repair', 'obstruction_dual_rows']}
    data['affine_Q_coefficients'] = [pack(q) for q in primary['affine_Q_coefficients']]
    fourth = {'obstruction': fourth_block(raw),
              'normal_on_candidates': fourth_block(raw, normal=True)}
    records = raw['primitive_affine_records'][:8]
    assert len(raw['primitive_affine_records']) == 10 and len(records) == 8
    repairs = []
    for row in records:
        repaired = []
        for r in row:
            c = [(-v) % 5 for v in r['coefficient']]
            code = sum(v * 5**i for i, v in enumerate(c))
            assert [(-((code // 5**i) % 5)) % 5 for i in range(4)] == r['coefficient']
            repaired.append([r['w1_degree'], r['w2_degree'], r['v_degree'], r['u_degree'], code])
        repairs.append(repaired)
    files = {
        'README.md': README.encode(),
        'model.py': (root/'scripts/deformations/rank25/rank25_pro_data_model.py').read_bytes(),
        **{name: json.dumps(value, separators=(',', ':')).encode()+b'\n'
           for name, value in [('data.json', data), ('fourth.json', fourth),
                               ('first_repairs.json', repairs)]},
    }
    cert_path = a.returns/'second/rank25_family_partial_audit/audit_certificate.json'
    cert = json.loads(cert_path.read_text())
    trace_path = a.returns/'first/trace_all_charts.json'
    trace = json.loads(trace_path.read_text())
    checked = json.loads((root/'Research/computations/rank25_two_family_returns_checks.json').read_text())
    point = checked['actual_fifth_value_at_test']
    assert isinstance(point, dict) and point['C5'][0] == [0]*4
    family = {
        'status': 'Relative J, adjoint identity, quotient algebra proved; universal Theta is a candidate.',
        'polynomial_variables': cert['polynomial_variables'],
        'ell_nonzero': [[i, v] for i, v in enumerate(cert['adjoint_row_ell']) if v],
        'normal_relation': cert['normal_relation'],
        'K': cert['K'], 'det_K': cert['det_K'], 'A': cert['A'], 'B': cert['B'],
        'theta_variables': ['U', 'A', 'B', 'q'],
        'theta_candidate': [[row['powers'], sum(c*5**i for i,c in enumerate(row['coefficient']))]
                            for row in trace['open']['geometric_zero_equation']],
        'geometric_test': {
            'x': [sum(c*5**i for i,c in enumerate(row)) for row in checked['trace_zero_open_test_x']],
            'quotient': [sum(c*5**i for i,c in enumerate(row)) for row in point['quotient']],
            'meaning': 'Q_x(C5), independent of the compatible fourth origin; NOT a fifth lift.',
        },
    }
    files['family.json'] = json.dumps(family, separators=(',', ':')).encode()+b'\n'
    ast.parse(files['model.py'])
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for name, blob in files.items():
            info = zipfile.ZipInfo(name, date_time=(2026, 9, 12, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            z.writestr(info, blob, compresslevel=9)
    blob = buffer.getvalue()
    assert len(blob) <= LIMIT, ('20,000-byte attachment budget exceeded', len(blob))
    with zipfile.ZipFile(io.BytesIO(blob)) as z:
        assert z.testzip() is None
        assert all(z.read(name) == value for name, value in files.items())
    with tempfile.TemporaryDirectory(prefix='rank25-minimal-check-') as check_dir:
        for name, value in files.items():
            (Path(check_dir)/name).write_bytes(value)
        check = subprocess.run([sys.executable, 'model.py'], cwd=check_dir,
                               capture_output=True, text=True, timeout=60)
        assert check.returncode == 0, check.stdout+check.stderr
    target = root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip'
    target.write_bytes(blob)
    prompt = (root/'Research/requests/rank25_all_fifth_lifts_request.md').read_bytes()
    result = {
        'status': 'PASS', 'packet_identity': IDENTITY, 'archive': str(target),
        'sha256': sha(blob), 'files': len(files), 'bytes': len(blob),
        'uncompressed_bytes': sum(map(len, files.values())), 'hard_limit_bytes': LIMIT,
        'prompt_words': len(prompt.decode().split()), 'prompt_sha256': sha(prompt),
        'contents': {name: {'bytes': len(value), 'sha256': sha(value)} for name, value in files.items()},
        'provenance': {str(source): sha(source_blob), str(raw_path): sha(raw_blob),
                       str(cert_path): sha(cert_path.read_bytes()), str(trace_path): sha(trace_path.read_bytes())},
        'checks': 'Exact round-trip for every retained field coefficient and primitive sign; ZIP integrity, hard size limit, and isolated standard-library model.py execution.',
        'isolated_check_output': check.stdout.strip(),
        'omitted': 'Historical prompts, duplicate certificates, proofs, audit logs, receipts, full higher-Witt replay machinery, and data outside the required candidate cochain family. Original evidence retained locally.',
        'scope': 'Finite mathematical support only. New target: reference-independent fifth residual on s!=0. Global trace candidate explicitly unproved; boundary families outside this request. Whole-family fifth verdict remains OPEN.',
    }
    (root/'Research/computations/rank25_all_fifth_prompt_packet.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
