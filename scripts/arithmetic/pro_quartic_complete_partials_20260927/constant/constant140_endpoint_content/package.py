#!/usr/bin/env python3
"""Create a deterministic, streamed ZIP and SHA-256 manifest of the source payload."""
from pathlib import Path
import hashlib
import shutil
import sys
import zipfile

ROOT = Path(__file__).resolve().parent
EXCLUDED = {'build', 'regenerated', '__pycache__', '.git'}

def payload_files():
    for p in sorted(ROOT.rglob('*')):
        rel = p.relative_to(ROOT)
        if any(part in EXCLUDED for part in rel.parts) or p.suffix == '.zip':
            continue
        if p.is_file() and p.name != 'SHA256SUMS':
            if p.is_symlink():
                raise RuntimeError('Symlink payloads are not permitted: ' + str(rel))
            yield p

def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as source:
        for block in iter(lambda: source.read(1 << 20), b''):
            h.update(block)
    return h.hexdigest()

def main():
    if len(sys.argv) != 2:
        raise SystemExit('Usage: python3 package.py /path/to/output.zip')
    output = Path(sys.argv[1]).resolve()
    files = list(payload_files())
    manifest = ROOT / 'SHA256SUMS'
    manifest.write_text(''.join(f'{sha(p)}  {p.relative_to(ROOT).as_posix()}\n' for p in files))
    files.append(manifest)
    output.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for path in sorted(files):
            name = 'constant140_endpoint_content/' + path.relative_to(ROOT).as_posix()
            info = zipfile.ZipInfo(name, date_time=(2026, 9, 26, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            with path.open('rb') as source, archive.open(info, 'w') as dest:
                shutil.copyfileobj(source, dest, length=1 << 20)
    print(f'{len(files)} files; {output.stat().st_size} compressed bytes; {output}')

if __name__ == '__main__':
    main()
