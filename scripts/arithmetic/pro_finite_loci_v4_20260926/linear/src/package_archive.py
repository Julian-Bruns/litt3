#!/usr/bin/env python3
"""Stream the self-contained checkpoint to one ZIP and verify its SHA-256 manifest."""
from pathlib import Path
import argparse
import hashlib
import zipfile

ROOT = Path(__file__).resolve().parents[1]
ROOT_FILES = ('README.md', 'REPORT.md', 'RESUME.md', 'INPUT.md', 'claims.json', 'verify.sh', 'verify_continuation.sh', 'CONTINUATION.md')

def selected_files():
    files = [ROOT / name for name in ROOT_FILES]
    for directory in ('src', 'data', 'evidence', 'logs', 'new', 'global', 'history'):
        files.extend(p for p in (ROOT / directory).rglob('*')
                     if p.is_file() and '__pycache__' not in p.parts and p.suffix != '.pyc' and not p.name.startswith('probe_'))
    return sorted(files, key=lambda p: p.relative_to(ROOT).as_posix())

def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    output = args.output.resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    files = selected_files()
    manifest = ROOT / 'MANIFEST.sha256'
    manifest.write_text(''.join(f'{digest(p)}  {p.relative_to(ROOT).as_posix()}\n' for p in files))
    prefix = 'linear140/'
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for path in files + [manifest]:
            archive.write(path, prefix + path.relative_to(ROOT).as_posix())
    with zipfile.ZipFile(output, 'r') as archive:
        assert archive.testzip() is None, 'ZIP CRC verification failed'
        for line in archive.read(prefix + 'MANIFEST.sha256').decode().splitlines():
            expected, relative = line.split('  ', 1)
            assert hashlib.sha256(archive.read(prefix + relative)).hexdigest() == expected, relative
        assert len(archive.namelist()) == len(files) + 1
    print(f'PASS: {len(files)} files plus manifest; ZIP CRC and every SHA-256 checked.')
    print(f'ZIP: {output.name}; bytes={output.stat().st_size}; SHA-256={digest(output)}')

if __name__ == '__main__':
    main()
