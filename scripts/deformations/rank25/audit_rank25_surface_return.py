"""Check provenance and exact finite replay of the returned surface proof.

The geometric support argument is audited separately; this script does
not turn an assumed support ledger into a geometric proof.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import hashlib
import json
from pathlib import Path
import zipfile

from scripts.deformations.rank25 import rank25_pro_data_model as m


def main():
    root = Path(__file__).resolve().parents[3]
    evidence = Path('/Users/julian/Documents/litt3-computation-data/rank25-surface-returned-20260912-sKO5ah')
    original = evidence / 'RANK25_SURFACE_W5_EXCLUSION'
    replay = evidence / 'replay'
    manifest = json.loads((original / 'SHA256.json').read_text())
    for name, digest in manifest.items():
        assert hashlib.sha256((original / name).read_bytes()).hexdigest() == digest, name
    submitted = root / 'Research/pro_inputs/rank25_surface_fifth_inputs.zip'
    with zipfile.ZipFile(submitted) as archive:
        for info in archive.infolist():
            if not info.is_dir():
                assert archive.read(info.filename) == (original / 'inputs' / Path(info.filename).name).read_bytes()
    for name in ('finite_certificate.json', 'integral_certificate.json'):
        assert (original / name).read_bytes() == (replay / name).read_bytes(), name
    for name in ('verify_surface.py', 'check_integral_algebra.py'):
        assert (original / name).read_bytes() == (replay / name).read_bytes(), name
    packet = json.loads((original / 'inputs/surface.json').read_text())
    # The original surface and particular fourth digit extend polynomially
    # to lambda=0; this permits the boundary-line consequence in the proof.
    assert all(a >= 0 and b >= 0 for a, b, _ in packet['fourth_digit'])
    assert all(a >= 0 and b >= 0 for a, b, _ in packet['normal4'])
    kappa = (3, 0, 4, 0)
    inverse = (2, 3, 3, 2)
    assert m.mul(kappa, inverse) == m.ONE
    assert m.neg(kappa) == (2, 0, 1, 0)
    receipt = {
        'verdict': 'PASS finite replay, provenance and local boundary extension checks',
        'date': '2026-09-12',
        'original_evidence': str(original),
        'replay_directory': str(replay),
        'manifest_files_checked': len(manifest),
        'submitted_input_bytes_unchanged': True,
        'replayed_certificates_byte_identical': ['finite_certificate.json', 'integral_certificate.json'],
        'replay_commands': ['python3 verify_surface.py', 'python3 check_integral_algebra.py'],
        'kappa': list(kappa), 'kappa_inverse': list(inverse),
        'lambda_zero_extension': 'Polynomial original third and particular fourth digits; constant trace 2+t^2.',
        'geometric_audit': 'Research/audits/RANK25_SURFACE_RETURN_AUDIT_2026_09_12.md',
        'scope_limit': 'Finite verifiers do not themselves prove geometric support; no fresh full W5 replay or Lean verification.'
    }
    output = root / 'Research/computations/rank25_surface_return_checks.json'
    output.write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps(receipt, indent=2))


if __name__ == '__main__':
    main()
