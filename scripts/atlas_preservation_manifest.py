#!/usr/bin/env python3
"""Read-only hash inventory of completed tensor, direction and proof artifacts."""
import argparse,json,time
from pathlib import Path
from atlas_native_tensor_input import sha

ap=argparse.ArgumentParser();ap.add_argument('--authority',type=Path)
ap.add_argument('--output',type=Path);ap.add_argument('--verify',type=Path);args=ap.parse_args()
start=time.monotonic()
if args.verify:
    saved=json.loads(args.verify.read_text());bad=[p for p,d in saved['files'].items() if not Path(p).exists() or sha(p)!=d]
    assert not bad, bad
    print(json.dumps(dict(all_preserved_hashes_identical=True,files=len(saved['files']),seconds=time.monotonic()-start)))
else:
    assert args.authority and args.output and not args.output.exists()
    state=json.loads(args.authority.read_text());paths=set()
    external=args.authority.parent.parent
    for rep in state['selected_representatives']:
        job=state['jobs'][rep];tensor=Path(job['tensor'])
        if tensor.exists():paths.add(tensor)
        folder=tensor.parent
        paths.update(folder.glob('*.sobj'))
        paths.update(folder.glob('complete_native/binding-*.json'))
        paths.update(folder.glob('complete_native/block-*.bin'))
        for base in [Path(job['charts']),external/'atlas-native-affine'/rep]:
            for p in base.rglob('result.json'):
                data=json.loads(p.read_text())
                if data.get('status')=='verified_polynomial_certificate':
                    paths.add(p)
                    if (p.parent/'replay.json').exists():paths.add(p.parent/'replay.json')
    result=dict(selected=state['selected_representatives'],deferred=state['deferred_representatives'],
        authority_sha256=sha(args.authority),files={str(p.resolve()):sha(p) for p in sorted(paths)},
        total_bytes=sum(p.stat().st_size for p in paths),seconds=time.monotonic()-start,
        scope='Preservation manifest, not a new mathematical certificate')
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(files=len(paths),total_bytes=result['total_bytes'],seconds=result['seconds'])))
