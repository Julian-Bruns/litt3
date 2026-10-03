#!/usr/bin/env sage
"""Changed native-generator comparison, or seven NEW111 orbit certificates."""
import json,time,signal,struct,sys,os,subprocess,hashlib
from pathlib import Path
task_started=time.monotonic();mode=os.environ.get('M9_V7_NATIVE_MODE','samples')
limit=60 if mode=='batch' else 25
def budget_expired(signum,frame):raise TimeoutError('native Veronese hard budget expired; checkpoints retained')
signal.signal(signal.SIGALRM,budget_expired);signal.setitimer(signal.ITIMER_REAL,limit)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_triple_kernel_map.sage').read_text().split('rank_records=[]')[0]
exec(compile(source,'triple_kernel_prefix','exec'))
sys.path.insert(0,'/Users/julian/Documents/litt3')
from scripts.atlases.native.atlas_native_rref import compile_engine
native_source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_veronese_native.cpp')
engine=compile_engine(native_source)
def write_input(path,cofactors):
 def element(stream,v):
  value=bytes(coords(v));stream.write(struct.pack('<I',len(value)));stream.write(value)
 with path.open('wb') as stream:
  stream.write(struct.pack('<QI',0x4d39564552373031,24));stream.write(bytes(meta['field_modulus']))
  stream.write(struct.pack('<I',len(P.list())))
  for v in P.list():element(stream,v)
  for f in cofactors:
   for h in f:
    stream.write(struct.pack('<I',len(h.list())))
    for v in h.list():element(stream,v)
def exponent_vectors(n,slots=5):
 if slots==1:yield (n,);return
 for a in range(n+1):
  for tail in exponent_vectors(n-a,slots-1):yield (a,)+tail
if mode=='samples':
 previous=json.loads((folder/'111_native_orbit1.json').read_text())
 cofactors=[[R([unpack(v) for v in h]) for h in f] for f in previous['cofactors']]
 prefix=folder/'native_generator_arithmetic';input_path=prefix.with_suffix('.input.bin');write_input(input_path,cofactors)
 run=subprocess.run([str(engine),str(input_path),str(prefix),'samples-only'],check=True,capture_output=True,text=True,timeout=max(.1,limit-(time.monotonic()-task_started)))
 cache={(0,0,0,0,0):[R.one(),R.zero(),R.zero()]}
 for n in range(1,5):
  for tag in exponent_vectors(n):
   i=next(i for i,a in enumerate(tag) if a);parent=list(tag);parent[i]-=1
   cache[tag]=mul(cache[tuple(parent)],cofactors[i])
 tags=list(exponent_vectors(7));checked=0
 with Path(str(prefix)+'.samples.bin').open('rb') as stream:
  rows,count=struct.unpack('<II',stream.read(8));stride=rows//3
  for _ in range(count):
   index=struct.unpack('<I',stream.read(4))[0];left=list(tags[index]);right=[0]*5;remaining=3
   for i in range(5):
    moved=min(left[i],remaining);left[i]-=moved;right[i]+=moved;remaining-=moved
   expected=mul(cache[tuple(left)],cache[tuple(right)])
   for row in range(rows):
    length=struct.unpack('<I',stream.read(4))[0];actual=E(list(stream.read(length)))
    assert actual==expected[row//stride][row%stride]
    checked+=1
  assert not stream.read(1)
 out={'scope':'Only changed native monomial generator compared on six columns, not an embedding rank replay.',
      'native_source_sha256':hashlib.sha256(native_source.read_bytes()).hexdigest(),'native_samples_metadata':json.loads(run.stdout),
      'checked_exact_field_entries':checked,'all_equal':True,'seconds':time.monotonic()-task_started}
 (folder/'native_veronese_generator_check.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
 print('PASSnative generator',checked,'entries; seconds',time.monotonic()-task_started)
else:
 assert json.loads((folder/'native_veronese_generator_check.json').read_text())['all_equal']
 representatives=[(0,3,8),(0,4,6),(0,4,7),(0,4,8),(0,5,6),(0,5,7),(0,5,8)]
 completed=[]
 for orbit_index,indices in enumerate(representatives,start=2):
  hit={endpoints[i] for i in indices};kernel=contact_matrix(hit).right_kernel_matrix();assert kernel.nrows()==5
  sections=[]
  for v in kernel.rows():
   fs=[[R.zero() for _ in range(3)] for _ in range(4)]
   for c,bas in zip(v,basis):
    if c:
     for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
   sections.append(fs)
  cofactors=[]
  for missing in range(5):
   cols=[i for i in range(5) if i!=missing]
   cofactors.append(scale(determinant([[sections[i][j] for i in cols] for j in range(4)]),(-1)**missing))
  norms=[norm(f) for f in cofactors if any(f)];gcd=norms[0]
  for g in norms[1:]:gcd=gcd.gcd(g)
  poles=[int(max(3*h.degree()+10*c for c,h in enumerate(f) if h)) for f in cofactors]
  assert gcd.degree()==45 and max(poles)==82
  prefix=folder/('111_native_orbit%s'%orbit_index);input_path=Path(str(prefix)+'.input.bin');write_input(input_path,cofactors)
  record={'scope':'NEW111 representative with exact rank factorization; selected-pole exclusions separate.',
          'orbit_index':orbit_index,'relaxed_endpoint_indices':indices,'field_modulus':meta['field_modulus'],
          'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()],
          'sections':[[encoded(f) for f in fs] for fs in sections],'cofactors':[encoded(f) for f in cofactors],
          'common_norm_gcd':encoded([gcd.monic()])[0],'cofactor_poles':poles,'line_bundle_degree':37,
          'native_source_sha256':hashlib.sha256(native_source.read_bytes()).hexdigest()}
  output=Path(str(prefix)+'.json');output.write_text(json.dumps(record,indent=2,default=int)+'\n')
  run=subprocess.run([str(engine),str(input_path),str(prefix)],check=True,capture_output=True,text=True,timeout=max(.1,limit-(time.monotonic()-task_started)))
  backend=json.loads(run.stdout);record.update(rank=backend['rank'],native_metadata=backend,row_factor_certificate=prefix.name+'.factor.bin',seconds_at_completion=time.monotonic()-task_started)
  assert record['rank']==251
  output.write_text(json.dumps(record,indent=2,default=int)+'\n');completed.append(orbit_index)
  print('PASSNEWorbit',orbit_index,'rank251; total seconds',time.monotonic()-task_started,flush=True)
 (folder/'111_native_remaining_batch.json').write_text(json.dumps({'completed_new_orbits':completed,'seconds':time.monotonic()-task_started},indent=2)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
