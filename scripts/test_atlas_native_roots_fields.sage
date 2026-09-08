#!/usr/bin/env sage
"""Small NEW-root-cache fixtures in actual census fields, no atlas tensors.

Run one case in each FRESH Sage process. Only 24 selected coefficient slots
may be nonzero in the real native direction format; this is not a full-tensor
benchmark. Both inverse Frobenius and every scalar fifth-power identity
are independently replayed in Sage. Existing saved files are hash-checked,
never replaced with incompatible fixtures.
"""
import argparse,hashlib,json,random,struct,subprocess,time
from pathlib import Path
from sage.env import SAGE_VERSION
from atlas_field_maps import from_power_coordinates,inverse_frobenius_map
from atlas_native_roots import NativeRoots
from atlas_native_rref import NativeRref
from atlas_native_tensor_input import sha

ap=argparse.ArgumentParser()
ap.add_argument('--representative',required=True)
ap.add_argument('--field-kind',choices=['intrinsic','chosen'],default='intrinsic')
ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--negative-controls',action='store_true')
args=ap.parse_args();started=time.monotonic()
root=Path(__file__).resolve().parents[1];data=root/'Research/computations'
prime=GF(5);Z=PolynomialRing(prime,'z');rep=args.representative
sources={}
def saved(name):
    path=data/name;sources[name]=sha(path);return json.loads(path.read_text())

if rep.startswith('orbit_'):
    row=next(r for r in saved('normalized_oper_closed_points.json')['factors'] if r['id']==rep)
    modulus=Z(row['polynomial']);n=int(modulus.degree())
    original=GF(5**n,'alpha',modulus=modulus,check_irreducible=False)
    field=original;model_description='intrinsic normalized census field'
    if args.field_kind=='chosen':
        cert=saved('normalized_oper_algebra_certificate.json')
        lam=from_power_coordinates(original,(Z(cert['lambda'])%modulus).list())
        cube=bool(lam**((5**n-1)//3)==1)
        if not cube:
            T=PolynomialRing(original,'t');tower=T.quotient(T.gen()**3-lam,names='t')
            layers=[(original,dict(kind='finite_field',degree=n)),
                    (tower,dict(kind='polynomial_quotient_field',degree=3))]
            bridge=NativeRref(tower,layers);field=bridge.native_field
            model_description=bridge.field_model
            assert field.degree()==3*n
            assert bridge.to_native(tower.gen())**3==bridge.to_native(tower(lam))
        else:model_description='chosen branch needs no additional field'
else:
    assert rep.startswith('invariant_') and args.field_kind=='intrinsic'
    number=int(rep.split('_')[1]);base=GF(25,'a',modulus=Z([2,4,1]))
    row=next(r for r in saved('invariant_oper_solutions.json')['orbits'] if int(r['orbit_id'])==number)
    T=PolynomialRing(base,'u');modulus=T(sage_eval(row['factor'],locals={'a':base.gen(),'b7':T.gen()}))
    n=2*int(modulus.degree())
    if modulus.degree()==1:field=base;model_description='intrinsic invariant F25'
    else:
        tower=T.quotient(modulus,names='u')
        bridge=NativeRref(tower,[(base,dict(kind='finite_field',degree=2)),
                               (tower,dict(kind='polynomial_quotient_field',degree=int(modulus.degree())))])
        field=bridge.native_field;model_description=bridge.field_model

degree=int(field.degree());assert degree>=2
seed=int(hashlib.sha256((rep+':'+args.field_kind+':root-fixture-v1').encode()).hexdigest()[:16],16)
rng=random.Random(seed);values=[field.zero(),field.one(),field(4),field.gen(),field.gen()**2,
    from_power_coordinates(field,[0]*(degree-1)+[1])]
for index in range(12):
    cs=[rng.randrange(5) for _ in range(degree)]
    if index<3:cs=[c if i%3==index else 0 for i,c in enumerate(cs)]
    values.append(from_power_coordinates(field,cs))
values += [values[6]**5,values[7]+values[8],values[9]*values[10],
           3*values[11]+1,values[12]**2,values[13]*field.gen()]
assert len(values)==24
positions=[0,1,2,31,32,63,64,127,255,511,1023,2047,
           2048,2049,2050,2079,2080,2111,2175,2303,2559,2815,3070,3071]
selected=dict(zip(positions,values));assert len(selected)==24

args.output.mkdir(parents=True,exist_ok=True)
def persist_exact(path,value):
    if path.exists():assert path.read_bytes()==value
    else:
        tmp=path.with_suffix(path.suffix+'.tmp');tmp.write_bytes(value);tmp.replace(path)

def encoded(c):
    cs=bytes(int(x) for x in c.polynomial().list())
    assert from_power_coordinates(field,cs)==c
    return struct.pack('<I',len(cs))+cs

block=bytearray(struct.pack('<QI',0x41544c4449524f31,degree));offset=0
for rows in [64,32,56]:
    block+=struct.pack('<II',rows,32)
    for index in range(rows*32):
        block+=encoded(selected.get(offset+index,field.zero()) if rows!=56 else field.zero())
    offset+=rows*32
original_file=args.output/'fixture-original-direction.bin';persist_exact(original_file,bytes(block))
binding=dict(direction=0,binary=str(original_file.resolve()),binary_sha256=sha(original_file))
prepared=time.monotonic();engine=NativeRoots(field,args.output/'native-roots');record=engine.run(binding)
native_done=time.monotonic();independent=inverse_frobenius_map(field)

def coefficient(stream):
    raw=stream.read(4);assert len(raw)==4
    length=struct.unpack('<I',raw)[0];assert length<=degree
    value=stream.read(length);assert len(value)==length and all(c<5 for c in value)
    return from_power_coordinates(field,value)

checked=0;distinct=0
with Path(record['binary']).open('rb') as stream:
    assert struct.unpack('<QI',stream.read(12))==(0x41544c524f4f5431,degree)
    for rows in [64,32]:
        assert struct.unpack('<II',stream.read(8))==(rows,32)
        for index in range(rows*32):
            answer=coefficient(stream);expected=selected.get(checked,field.zero())
            assert answer**5==expected
            if checked in selected:
                assert answer==independent(expected);distinct+=1
            checked+=1
    assert not stream.read(1)
assert checked==3072 and distinct==24
# The source cannot change under cache reuse. This invokes no native work.
resumed=engine.run(binding)
assert resumed['resumed_verified_roots'] and resumed['binary_sha256']==record['binary_sha256']

negative_results=[]
if args.negative_controls:
    # A validly encoded but WRONG inverse-Frobenius generator must be rejected
    # by the native arithmetic check, not merely by a metadata hash guard.
    wrong=struct.pack('<QI',0x41544c524f4f4931,degree)+bytes(int(c) for c in field.modulus().list())+encoded(field.zero())
    bad_map=args.output/'negative-wrong-generator.bin';persist_exact(bad_map,wrong)
    proc=subprocess.run([str(engine.engine),str(bad_map),str(original_file),str(args.output/'negative-unused-output.bin')],
        capture_output=True,text=True,timeout=10)
    assert proc.returncode!=0 and 'generator fifth-root identity failed' in proc.stderr
    negative_results.append('native wrong-generator rejection')
    try:engine.run(dict(binding,binary_sha256='0'*64))
    except AssertionError:negative_results.append('changed-source-hash rejection')
    else:raise AssertionError('changed source hash accepted')

report=dict(schema=1,representative=rep,field_kind=args.field_kind,intrinsic_degree_F5=n,
    degree_F5=degree,model_description=model_description,
    field_model=dict(degree_F5=degree,modulus=[int(c) for c in field.modulus().list()]),
    source_hashes=sources,seed=seed,sage_version=SAGE_VERSION,element_type=str(type(field.gen())),
    native_source_sha256=sha(Path(__file__).with_name('atlas_frobenius_roots.cpp')),
    native_record=record,all_3072_independent_fifth_power_checks=True,
    independent_inverse_checks=distinct,selected_positions=positions,
    resume_hash_check_passed=True,negative_controls=negative_results,
    preparation_seconds=prepared-started,native_cache_seconds=native_done-prepared,
    replay_seconds=time.monotonic()-native_done,total_seconds=time.monotonic()-started,
    scope='Small arithmetic fixture only; no atlas tensor, oper enumeration or exclusion')
target=args.output/'report.json';tmp=target.with_suffix('.tmp');tmp.write_text(json.dumps(report,indent=2,default=int)+'\n');tmp.replace(target)
print(json.dumps({k:v for k,v in report.items() if k not in ['field_model','source_hashes','native_record','selected_positions']},default=int),flush=True)
