#!/usr/bin/env sage
"""Precompute ALL verified fifth roots once, with resumable direction jobs."""
import argparse,concurrent.futures,json,os,struct,time
from pathlib import Path
from atlas_native_roots import NativeRoots
from atlas_native_tensor_input import sha,cache_path,NativeTensorInput

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--workers',type=int,default=10);args=ap.parse_args();assert 1<=args.workers<=10
start=time.monotonic();source=args.tensor.resolve();target=cache_path(source)
header=json.loads(target.read_text());assert header['source_sha256']==sha(source)
if header.get('all_native_fifth_roots_verified'):
    checked=NativeTensorInput(source,header['source_sha256']);checked.close()
    print(json.dumps(dict(resumed_all_verified_native_roots=True,seconds=time.monotonic()-start)),flush=True)
else:
    model=header['field_model'];degree=int(model['degree_F5'])
    k=GF(5**degree,'c',modulus=PolynomialRing(GF(5),'z')(model['modulus']))
    engine=NativeRoots(k,source.parent/'native_roots')
    root_blocks=[None]*32
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures={pool.submit(engine.run,b):int(b['direction']) for b in header['blocks']}
        for future in concurrent.futures.as_completed(futures):
            i=futures[future];record=future.result();root_blocks[i]=record
            print(json.dumps(dict(stage='native_root_direction_verified',direction=i,
                native_seconds=record['seconds'],completed=sum(r is not None for r in root_blocks),
                seconds=time.monotonic()-start,workers=args.workers),default=int),flush=True)
    offsets=[]
    for block in root_blocks:
        assert block['binary_sha256']==sha(block['binary'])
        with Path(block['binary']).open('rb') as stream:
            assert struct.unpack('<QI',stream.read(12))==(0x41544c524f4f5431,degree)
            for rows in [64,32]:
                assert struct.unpack('<II',stream.read(8))==(rows,32)
                for _ in range(rows*32):
                    offsets.append(stream.tell());length=struct.unpack('<I',stream.read(4))[0]
                    assert length<=degree
                    values=stream.read(length);assert len(values)==length and all(c<5 for c in values)
            assert not stream.read(1)
    assert len(offsets)==32*96*32
    index=source.parent/'native-root-input-index.bin';pending=index.with_suffix('.tmp')
    pending.write_bytes(struct.pack('<'+'Q'*len(offsets),*offsets));pending.replace(index)
    header.update(root_blocks=root_blocks,all_native_fifth_roots_verified=True,
        root_index_path=str(index.resolve()),root_index_sha256=sha(index),
        root_cache_preparation_seconds=time.monotonic()-start,root_cache_workers=args.workers)
    pending=target.with_suffix('.tmp');pending.write_text(json.dumps(header,indent=2,default=int)+'\n');pending.replace(target)
    print(json.dumps(dict(all_98304_native_fifth_root_identities_verified=True,
        degree_F5=degree,workers=args.workers,seconds=time.monotonic()-start),default=int),flush=True)
