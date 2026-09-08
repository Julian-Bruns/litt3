#!/usr/bin/env sage
"""Convert one retained ORIGINAL direction to a verified native power basis.

No kernel or tensor is recomputed. Every encoded coefficient is decoded
back and compared to its original value; all56 raw R rows are retained.
"""
import argparse,json,struct,time
from pathlib import Path
from atlas_native_rref import NativeRref
from atlas_native_tensor_input import sha

ap=argparse.ArgumentParser();ap.add_argument('--folder',type=Path,required=True)
ap.add_argument('--direction',type=int,required=True);args=ap.parse_args();assert 0<=args.direction<32
start=time.monotonic();folder=args.folder.resolve();i=args.direction
original=folder/('direction_%02d.sobj'%i);digest=sha(original)
out=folder/'complete_native';out.mkdir(parents=True,exist_ok=True)
binding=out/('binding-%02d.json'%i)
if binding.exists():
    b=json.loads(binding.read_text());assert b['original_sha256']==digest and sha(b['binary'])==b['binary_sha256']
    print(json.dumps(dict(direction=i,resumed_verified_native_binding=True,seconds=time.monotonic()-start)),flush=True)
else:
    oper=load(str(folder/'oper.sobj'));matrices=load(str(original));k=matrices[0].base_ring()
    assert [tuple(M.dimensions()) for M in matrices]==[(64,32),(32,32),(56,32)]
    assert all(M.base_ring()==k for M in matrices) and k==oper['k']
    def layers(k,d):return [(k,d)] if d['kind']=='finite_field' else layers(k.base_ring(),d['base'])+[(k,d)]
    native=NativeRref(k,layers(k,oper['field_description']))
    target=out/('legacy-block-%02d-%s.bin'%(i,digest));temporary=target.with_suffix('.tmp')
    with temporary.open('wb') as stream:
        stream.write(struct.pack('<QI',0x41544c4449524f31,native.degree))
        for M in matrices:
            stream.write(struct.pack('<II',int(M.nrows()),int(M.ncols())))
            for c in M.list():
                value=native.encode(c)  # Includes the exact inverse-map check.
                stream.write(struct.pack('<I',len(value)));stream.write(value)
    binary_digest=sha(temporary)
    if target.exists():
        assert sha(target)==binary_digest
        temporary.unlink()  # Only our redundant, fully validated temporary.
    else:temporary.replace(target)
    b=dict(schema=1,direction=i,binary=str(target),native_modulus=list(native.modulus),
        binary_sha256=binary_digest,original_path=str(original),original_sha256=digest,
        all_original_native_coordinate_roundtrips_verified=True,raw_R_rows=56,
        source='Retained original direction, not a new atlas computation',seconds=time.monotonic()-start)
    pending=binding.with_suffix('.tmp');pending.write_text(json.dumps(b,indent=2,default=int)+'\n');pending.replace(binding)
    print(json.dumps(dict(direction=i,degree_F5=native.degree,all_original_coordinate_roundtrips_verified=True,
        seconds=b['seconds'],binary_bytes=target.stat().st_size),default=int),flush=True)
