#!/usr/bin/env sage
"""Two NEW21 degree-seven section-span tests, one core, hard40 seconds total."""
import json,time,signal,struct,sys,subprocess,hashlib
from pathlib import Path
started=time.monotonic();limit=40
def expired(signum,frame):raise TimeoutError('21 native hard40-second budget expired; checkpoints retained')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,limit)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'triple_kernel_maps.json').read_text())
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(data['field_modulus']))
beta=E(data['beta_coordinates']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
P=R([code(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
def coords(v):return [int(a) for a in v.polynomial().list()]
def write_input(path,cofactors):
 def element(stream,v):
  value=bytes(coords(v));stream.write(struct.pack('<I',len(value)));stream.write(value)
 with path.open('wb') as stream:
  stream.write(struct.pack('<QI',0x4d39564552373031,24));stream.write(bytes(data['field_modulus']))
  stream.write(struct.pack('<I',len(P.list())))
  for v in P.list():element(stream,v)
  for f in cofactors:
   for h in f:
    stream.write(struct.pack('<I',len(h.list())))
    for v in h.list():element(stream,v)
sys.path.insert(0,'/Users/julian/Documents/litt3')
from scripts.atlases.native.atlas_native_rref import compile_engine
native_source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_veronese_native.cpp')
assert json.loads((folder/'native_veronese_generator_check.json').read_text())['all_equal']
engine=compile_engine(native_source);completed=[]
for i,prototype in enumerate(data['prototypes'][1:]):
 cofactors=[[R([E(v) for v in h]) for h in f] for f in prototype['cofactors']]
 prefix=folder/('21_native_prototype%s'%i);input_path=Path(str(prefix)+'.input.bin');write_input(input_path,cofactors)
 record={'scope':'NEW21 prototype degree7 monomial-span rank, not an all21 pattern certificate.',
         'relaxed_endpoint_indices':prototype['relaxed_endpoint_indices'],'field_modulus':data['field_modulus'],
         'cofactors':prototype['cofactors'],'line_bundle_degree':35,'section_power':7,'rr_target_rank':237,
         'native_source_sha256':hashlib.sha256(native_source.read_bytes()).hexdigest()}
 output=Path(str(prefix)+'.json');output.write_text(json.dumps(record,indent=2,default=int)+'\n')
 run=subprocess.run([str(engine),str(input_path),str(prefix)],check=True,capture_output=True,text=True,
                    timeout=max(.1,limit-(time.monotonic()-started)))
 backend=json.loads(run.stdout);record.update(rank=backend['rank'],native_metadata=backend,
      row_factor_certificate=prefix.name+'.factor.bin',seconds_at_completion=time.monotonic()-started)
 output.write_text(json.dumps(record,indent=2,default=int)+'\n');completed.append(record)
 print('NEW21',prototype['relaxed_endpoint_indices'],'rank',record['rank'],'target237; seconds',time.monotonic()-started,flush=True)
(folder/'21_native_prototype_batch.json').write_text(json.dumps({'records':completed,'seconds':time.monotonic()-started},indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
