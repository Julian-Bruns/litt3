#!/usr/bin/env python3
"""Hash selected exact checkpoints before/after a coordinated deployment."""
import argparse,datetime,hashlib,json
from pathlib import Path

def sha(path):
    digest=hashlib.sha256()
    with path.open('rb') as stream:
        for chunk in iter(lambda:stream.read(1024*1024),b''):digest.update(chunk)
    return digest.hexdigest()

ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--directory',type=Path);ap.add_argument('--patterns',nargs='+')
ap.add_argument('--verify',action='store_true');args=ap.parse_args()
if args.verify:
    d=json.loads(args.output.read_text())
    for name,record in d['files'].items():
        path=Path(name);assert path.stat().st_size==record['bytes'] and sha(path)==record['sha256'],name
    print(json.dumps(dict(manifest=str(args.output.resolve()),files_verified_unchanged=len(d['files']))))
else:
    assert args.directory and args.patterns and not args.output.exists()
    paths=sorted({p.resolve() for pattern in args.patterns for p in args.directory.glob(pattern) if p.is_file()})
    assert paths
    d=dict(created_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),
           files={str(p):dict(bytes=p.stat().st_size,sha256=sha(p)) for p in paths})
    args.output.write_text(json.dumps(d,indent=2)+'\n')
    print(json.dumps(dict(manifest=str(args.output.resolve()),files_preserved=len(paths),
                         bytes=sum(v['bytes'] for v in d['files'].values()))))
