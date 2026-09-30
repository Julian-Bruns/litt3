"""Hash the retained archive files, excluding generated build/cache files."""
from pathlib import Path
import hashlib
ROOT=Path(__file__).resolve().parents[1]
def retained(p):
    r=p.relative_to(ROOT)
    return p.is_file() and 'scratch' not in r.parts and r.as_posix() not in {'data/global_residual.npz','data/global_contents.json','data/zero_scale_certificate.json'} and '__pycache__' not in r.parts and p.suffix not in {'.so','.pyc'} and p.name not in {'SHA256SUMS'} and not p.name.endswith('.tmp')
lines=[]
for p in sorted(ROOT.rglob('*')):
    if retained(p):lines.append(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+p.relative_to(ROOT).as_posix())
(ROOT/'SHA256SUMS').write_text('\n'.join(lines)+'\n')
print('Manifest entries:',len(lines))
