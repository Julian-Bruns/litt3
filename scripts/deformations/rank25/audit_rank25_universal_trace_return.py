"""Provenance and finite-replay check; geometric proof audited separately."""
import hashlib
import json
from pathlib import Path
import zipfile


def main():
    root=Path(__file__).resolve().parents[3]
    base=Path('/Users/julian/Documents/litt3-computation-data/rank25-universal-trace-return-20260913-9D6dTa')
    original=base/'universal_fifth_trace';replay=base/'replay'
    submitted=root/'Research/pro_inputs/rank25_universal_fifth_trace_inputs.zip'
    with zipfile.ZipFile(submitted) as z:
        for name in z.namelist():
            assert z.read(name)==(original/'inputs'/name).read_bytes(),name
    hashes=json.loads((original/'certificates/input_hashes.json').read_text())
    for name,digest in hashes.items():
        assert hashlib.sha256((original/'inputs'/name).read_bytes()).hexdigest()==digest
    exact=[]
    for path in sorted((original/'certificates').glob('*.json')):
        assert path.read_bytes()==(replay/'certificates'/path.name).read_bytes(),path.name
        exact.append(path.name)
    source={}
    for path in [original/'verify.py',*(original/'lib').glob('*.py')]:
        name=str(path.relative_to(original))
        assert path.read_bytes()==(replay/name).read_bytes()
        source[name]=hashlib.sha256(path.read_bytes()).hexdigest()
    receipt={
        'verdict':'PASS: exact finite replay and unchanged inputs',
        'auditor':'root, with independent geometric audit /root/audit_universal_trace',
        'date':'2026-09-13','original_evidence':str(original),'replay_directory':str(replay),
        'submitted_archive_sha256':hashlib.sha256(submitted.read_bytes()).hexdigest(),
        'input_files_unchanged':list(hashes),'byte_identical_replayed_certificates':exact,
        'replay_source_sha256':source,'replay_command':'python3 verify.py',
        'geometric_audit':'Research/audits/RANK25_UNIVERSAL_TRACE_INDEPENDENT_2026_09_13.md',
        'clarification':'Fixed-splitting residual receives two factors of5; separate coefficientwise lift discrepancies remain in the cubic support. No new hypothesis or coefficient correction.',
        'scope':'Universal trace on the entire reduced fourth locus, all fourth choices. Other three fifth residuals remain unknown. This is not a fresh full W5 replay or Lean verification.'}
    (root/'Research/computations/rank25_universal_trace_return_checks.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))


if __name__=='__main__':main()
