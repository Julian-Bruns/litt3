"""Make a deterministic, compact ZIP and a SHA-256 payload manifest."""
from pathlib import Path
import hashlib,zipfile
ROOT=Path(__file__).resolve().parent.parent
DEST=ROOT.parent/'companion140.zip'

def payload():
    return sorted(p for p in ROOT.rglob('*') if p.is_file() and '__pycache__' not in p.parts and 'work' not in p.relative_to(ROOT).parts and p.name!='SHA256SUMS' and not p.name.endswith('.pyc'))

def main():
    lines=[hashlib.sha256(p.read_bytes()).hexdigest()+'  '+str(p.relative_to(ROOT)) for p in payload()]
    (ROOT/'SHA256SUMS').write_text('\n'.join(lines)+'\n')
    with zipfile.ZipFile(DEST,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as zz:
        for p in sorted(payload()+[ROOT/'SHA256SUMS']):
            zi=zipfile.ZipInfo('companion140/'+str(p.relative_to(ROOT)),date_time=(2026,9,28,0,0,0));zi.compress_type=zipfile.ZIP_DEFLATED;zi._compresslevel=9;zi.external_attr=0o100644<<16
            with p.open('rb') as source,zz.open(zi,'w') as target:
                while chunk:=source.read(1024*1024):target.write(chunk)
    print(f'{DEST.name}: {DEST.stat().st_size} bytes; {len(lines)} manifested files')
if __name__=='__main__':main()
