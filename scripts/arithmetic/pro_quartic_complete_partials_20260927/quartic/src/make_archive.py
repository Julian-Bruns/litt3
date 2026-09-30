"""Build one self-contained ZIP, streaming files and recording SHA-256 hashes.

Only top-level documentation, src/, and evidence/ are included. Build products,
Python caches, temporary chunks, and other ZIPs are excluded. The manifest
covers every included regular file except SHA256SUMS itself.
"""
import argparse,hashlib,json,pathlib,zipfile
ROOT=pathlib.Path(__file__).resolve().parents[1]

def tracked():
    out=[]
    for p in sorted(ROOT.rglob('*')):
        if not p.is_file():continue
        rel=p.relative_to(ROOT)
        if any(x in {'build','__pycache__','.git'} for x in rel.parts):continue
        if len(rel.parts)>1 and rel.parts[0] not in {'src','evidence'}:continue
        if p.suffix in {'.zip','.pyc','.part'}:continue
        if p.name=='SHA256SUMS':continue
        out.append(p)
    return out

def digest(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda:f.read(1024*1024),b''):h.update(block)
    return h.hexdigest()

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',type=pathlib.Path,required=True);a=p.parse_args()
    files=tracked();manifest=ROOT/'SHA256SUMS'
    manifest.write_text(''.join(digest(f)+'  '+f.relative_to(ROOT).as_posix()+'\n' for f in files))
    a.output.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(a.output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for f in files+[manifest]:z.write(f,f.relative_to(ROOT).as_posix())
    with zipfile.ZipFile(a.output) as z:assert z.testzip() is None
    print(json.dumps({'archive':str(a.output),'files':len(files)+1,'bytes':a.output.stat().st_size,'sha256':digest(a.output)}))
