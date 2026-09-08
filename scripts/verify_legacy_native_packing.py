#!/usr/bin/env python3
"""Pack explicit held legacy cases and verify every old byte survives.

This writes only representation bindings/logs and a verification report.
It NEVER changes the owning controller's state or any chart attempt.
"""
import argparse,json,subprocess,time
from pathlib import Path
from atlas_native_tensor_input import sha

ap=argparse.ArgumentParser();ap.add_argument('--directory',type=Path,required=True)
ap.add_argument('--representatives',nargs='+',required=True)
ap.add_argument('--workers',type=int,default=6);ap.add_argument('--sage',default='sage')
ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
assert 1<=args.workers<=10
state=json.loads((args.directory/'all18.json').read_text());start=time.monotonic();reports=[]
for rid in args.representatives:
    job=state['jobs'][rid];assert job['stage']=='needs_attention' and job['reason']=='exit_1'
    log=Path(job['last_log']);assert 'atlas_legacy_native_blocks.py' in log.read_text()
    tensor=Path(job['tensor']);folder=tensor.parent;native=folder/'complete_native'
    binaries=sorted(native.glob('legacy-block-*.bin'));assert len(binaries)==32
    originals=[folder/('direction_%02d.sobj'%i) for i in range(32)]
    preserved={str(p.resolve()):sha(p) for p in [tensor,folder/'oper.sobj',*originals,*binaries,log]}
    before=time.monotonic()
    subprocess.run([__import__('sys').executable,str(Path(__file__).with_name('atlas_legacy_native_blocks.py')),
        '--folder',str(folder),'--workers',str(args.workers),'--sage',args.sage],check=True)
    assert all(sha(p)==digest for p,digest in preserved.items())
    bindings={}
    for i in range(32):
        path=native/('binding-%02d.json'%i);b=json.loads(path.read_text())
        assert b['direction']==i and b['all_original_native_coordinate_roundtrips_verified']
        assert b['raw_R_rows']==56 and b['original_path']==str(originals[i].resolve())
        assert sha(b['original_path'])==b['original_sha256']
        assert sha(b['binary'])==b['binary_sha256'] and str(Path(b['binary']).resolve()) in preserved
        bindings[str(path.resolve())]=sha(path)
    reports.append(dict(representative=rid,tensor_sha256=sha(tensor),failed_log=str(log),
        failed_log_sha256=sha(log),all32_original_coordinate_roundtrips_verified=True,
        all_preexisting_binary_and_original_hashes_preserved=True,preserved=preserved,bindings=bindings,
        seconds=time.monotonic()-before))
    report=dict(status='verified',representatives=reports,workers=args.workers,
        seconds=time.monotonic()-start,controller_or_chart_state_changed=False,
        packer_sha256=sha(Path(__file__).with_name('pack_legacy_native_direction.sage')))
    temp=args.output.with_suffix('.tmp');temp.write_text(json.dumps(report,indent=2)+'\n');temp.replace(args.output)
    print(json.dumps({k:v for k,v in reports[-1].items() if k not in ('preserved','bindings')}),flush=True)
