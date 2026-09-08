#!/usr/bin/env sage
"""Index retained native directions ONCE before independent chart searches.

The field model and every binary/checkpoint binding are checked. Search
certificates still require a fresh replay against ALL original JSON rows.
This is a representation cache, never an additional mathematical exclusion.
"""
import argparse,json,struct,time
from pathlib import Path
from atlas_native_rref import NativeRref
from atlas_native_tensor_input import sha,cache_path

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True);args=ap.parse_args()
start=time.monotonic();source=args.tensor.resolve();target=cache_path(source);digest=sha(source)
if target.exists():
    record=json.loads(target.read_text());assert record['source_sha256']==digest
    assert sha(record['index_path'])==record['index_sha256']
    assert all(sha(b['binary'])==b['binary_sha256'] for b in record['blocks'])
    print(json.dumps(dict(resumed_validated_native_input=True,seconds=time.monotonic()-start)),flush=True)
else:
    data=json.loads(source.read_text());desc=data.get('field_description') or dict(
        kind='finite_field',characteristic=5,degree=2,generator='a',modulus=[2,4,1])
    assert data['variables']=={'u':32,'beta':32}
    assert data.get('coupled_N_kernel_forces_R_output_in_J_verified') or data.get('checks',{}).get('coupled_R_image_verified')
    oper=load(str(source.parent/'oper.sobj'));old=oper['k']
    assert oper['field_description']==desc
    def layers(k,d):return [(k,d)] if d['kind']=='finite_field' else layers(k.base_ring(),d['base'])+[(k,d)]
    all_layers=layers(old,desc);bridge=NativeRref(old,all_layers)
    images={d['generator']:list(bridge.to_native(old(f.gen())).polynomial().list()) for f,d in all_layers}
    if 'base_F25_generator' in desc:images['a']=list(bridge.to_native(oper['a']).polynomial().list())
    model=dict(degree_F5=bridge.degree,modulus=list(bridge.modulus),layer_generator_images=images,
               construction=bridge.field_model)
    blocks=[];offsets=[]
    for i in range(32):
        binding=source.parent/'complete_native'/('binding-%02d.json'%i)
        b=json.loads(binding.read_text());binary=Path(b['binary'])
        assert b['direction']==i and b['original_path']==str((source.parent/('direction_%02d.sobj'%i)).resolve())
        assert sha(b['original_path'])==b['original_sha256'] and sha(binary)==b['binary_sha256']
        assert bytes(b['native_modulus'])==bridge.modulus
        with binary.open('rb') as stream:
            assert struct.unpack('<QI',stream.read(12))==(0x41544c4449524f31,bridge.degree)
            for number,(rows,cols) in enumerate([(64,32),(32,32),(56,32)]):
                assert struct.unpack('<II',stream.read(8))==(rows,cols)
                for _ in range(rows*cols):
                    at=stream.tell();length=struct.unpack('<I',stream.read(4))[0]
                    assert length<=bridge.degree
                    value=stream.read(length);assert len(value)==length and all(c<5 for c in value)
                    if number<2:offsets.append(at)
            assert not stream.read(1)
        blocks.append(b)
    assert len(offsets)==32*96*32
    index=source.parent/'native-original-input-index.bin';temporary=Path(str(index)+'.tmp')
    temporary.write_bytes(struct.pack('<'+'Q'*len(offsets),*offsets));temporary.replace(index)
    record=dict(schema=1,source_tensor=str(source),source_sha256=digest,
        field_description=desc,field_model=model,variables=data['variables'],checks=data.get('checks',{}),
        coupled_N_kernel_forces_R_output_in_J_verified=data.get('coupled_N_kernel_forces_R_output_in_J_verified',False),
        blocks=blocks,index_path=str(index.resolve()),index_sha256=sha(index),
        all_native_checkpoint_bindings_verified=True,
        original_JSON_replay_required_for_every_unit_certificate=True,
        scope='Search representation only; original JSON is the independent certificate authority',
        seconds=time.monotonic()-start)
    temporary=Path(str(target)+'.tmp');temporary.write_text(json.dumps(record,indent=2,default=int)+'\n');temporary.replace(target)
    print(json.dumps(dict(native_input_prepared=True,degree_F5=bridge.degree,
        seconds=time.monotonic()-start,index_bytes=index.stat().st_size),default=int),flush=True)
