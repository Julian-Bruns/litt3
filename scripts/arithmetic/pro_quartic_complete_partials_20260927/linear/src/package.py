"""Rebuild the SHA-256 manifest and stream one ZIP outside the source tree."""
from __future__ import annotations

import hashlib
from pathlib import Path
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]
out = (Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT.parent / 'moving_ratio_r9.zip').resolve()
if out == ROOT or ROOT in out.parents:
    raise ValueError('Write the ZIP outside the source tree, e.g. ../output.zip.')
paths = sorted(
    p for p in ROOT.rglob('*')
    if p.is_file() and '__pycache__' not in p.parts and p.name != 'SHA256SUMS'
)
lines = []
for path in paths:
    value = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(1 << 20), b''):
            value.update(block)
    lines.append(value.hexdigest() + '  ' + str(path.relative_to(ROOT)))
(ROOT / 'SHA256SUMS').write_text('\n'.join(lines) + '\n')
with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
    for path in paths + [ROOT / 'SHA256SUMS']:
        with path.open('rb') as source, archive.open(str(path.relative_to(ROOT)), 'w') as target:
            for block in iter(lambda: source.read(1 << 20), b''):
                target.write(block)
print(out)
