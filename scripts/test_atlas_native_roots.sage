#!/usr/bin/env sage
"""Native coefficient roots, independently checked in the ORIGINAL native field."""
import argparse,json,struct,time
from pathlib import Path
from atlas_native_roots import NativeRoots
from atlas_field_maps import from_power_coordinates,inverse_frobenius_map

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--direction',type=int,default=0);ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
start=time.monotonic();header=json.loads((args.tensor.parent/'native-original-input.json').read_text())
model=header['field_model'];degree=int(model['degree_F5'])
k=GF(5**degree,'c',modulus=PolynomialRing(GF(5),'z')(model['modulus']))
engine=NativeRoots(k,args.output);binding=header['blocks'][args.direction];record=engine.run(binding)
def coefficient(stream):
    length=struct.unpack('<I',stream.read(4))[0];value=stream.read(length)
    assert len(value)==length and length<=degree and all(c<5 for c in value)
    return from_power_coordinates(k,value)
independent=inverse_frobenius_map(k);checked=0;before=time.monotonic()
with Path(binding['binary']).open('rb') as original,Path(record['binary']).open('rb') as roots:
    assert struct.unpack('<QI',original.read(12))==(0x41544c4449524f31,degree)
    assert struct.unpack('<QI',roots.read(12))==(0x41544c524f4f5431,degree)
    for rows in [64,32]:
        assert struct.unpack('<II',original.read(8))==(rows,32)
        assert struct.unpack('<II',roots.read(8))==(rows,32)
        for i in range(rows*32):
            a=coefficient(original);b=coefficient(roots);assert b**5==a
            # Full independent scalar fifth-power replay; a deterministic
            # sample also compares PARI's differently implemented inverse.
            if i%97==0:assert b==independent(a)
            checked+=1
    assert not roots.read(1)
report=dict(record,independent_Sage_fifth_power_checks=checked,
            independent_Sage_seconds=time.monotonic()-before,total_seconds=time.monotonic()-start)
target=args.output/'report.json';temporary=target.with_suffix('.tmp');temporary.write_text(json.dumps(report,indent=2,default=int)+'\n');temporary.replace(target)
print(json.dumps(report,default=int),flush=True)
