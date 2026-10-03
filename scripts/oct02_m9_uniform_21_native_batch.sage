#!/usr/bin/env sage
"""Sixteen remaining NEW21 orbit reps, hard75 seconds, checkpoints each."""
import json,time,signal,struct,sys,subprocess,hashlib,os
from pathlib import Path
lease_started=time.monotonic();limit=float(os.environ.get('M9_21_NATIVE_SECONDS','75'))
def expired(signum,frame):raise TimeoutError('NEW21 hard75-second budget expired; checkpoints retained')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,limit)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_triple_kernel_map.sage').read_text().split('rank_records=[]')[0]
exec(compile(source,'triple_kernel_prefix','exec'))
sys.path.insert(0,'/Users/julian/Documents/litt3')
from scripts.atlases.native.atlas_native_rref import compile_engine
native_source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_veronese_native.cpp')
engine=compile_engine(native_source)
assert json.loads((folder/'native_veronese_generator_check.json').read_text())['all_equal']
orbits=json.loads((folder/'21_endpoint_orbits.json').read_text())
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
S=PowerSeriesRing(E,'s',default_prec=8);s=S.gen()
def polseries(g,r):return sum((S(c)*(r+s)**j for j,c in enumerate(g)),S.zero())
ys={}
for r,y in endpoints:
 pp=polseries(P,r);yy=S(y)
 for j in range(1,8):yy+=((pp-yy**3)[j]/(3*y*y))*s**j
 ys[r,y]=yy
completed=[]
for orbit_index,indices in enumerate(orbits['fixed_omission_representatives']):
 if orbit_index in orbits['stored_prototype_orbit_indices']:continue
 prefix=folder/('21_native_orbit%s'%orbit_index)
 existing=Path(str(prefix)+'.json')
 if existing.exists() and json.loads(existing.read_text()).get('rank',0)>=236:
  assert Path(str(prefix)+'.factor.bin').exists()
  completed.append(orbit_index);continue
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
 local_orders=[]
 for i,(r,y) in enumerate(endpoints):
  vv=[sum((polseries(f[c],r)*ys[r,y]**c for c in range(3)),S.zero()).valuation() for f in cofactors]
  local_orders.append(int(min(vv)))
 assert sum(local_orders)==47 and gcd.degree()==47 and max(poles)==82
 input_path=Path(str(prefix)+'.input.bin');write_input(input_path,cofactors)
 record={'scope':'NEW21 orbit representative, exact finite-base support plus full degree7 rank factor.',
      'orbit_index':orbit_index,'relaxed_endpoint_indices':indices,'field_modulus':meta['field_modulus'],
      'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()],
      'sections':[[encoded(f) for f in fs] for fs in sections],'cofactors':[encoded(f) for f in cofactors],
      'common_norm_gcd':encoded([gcd.monic()])[0],'cofactor_poles':poles,'local_common_orders':local_orders,
      'line_bundle_degree':35,'rr_target_rank':237,
      'native_source_sha256':hashlib.sha256(native_source.read_bytes()).hexdigest()}
 output=Path(str(prefix)+'.json');output.write_text(json.dumps(record,indent=2,default=int)+'\n')
 run=subprocess.run([str(engine),str(input_path),str(prefix)],check=True,capture_output=True,text=True,
                    timeout=max(.1,limit-(time.monotonic()-lease_started)))
 backend=json.loads(run.stdout);record.update(rank=backend['rank'],native_metadata=backend,
      row_factor_certificate=prefix.name+'.factor.bin',seconds_at_completion=time.monotonic()-lease_started)
 output.write_text(json.dumps(record,indent=2,default=int)+'\n');completed.append(orbit_index)
 (folder/'21_native_remaining_batch.json').write_text(json.dumps({'completed_new_orbits':completed,'seconds':time.monotonic()-lease_started},indent=2,default=int)+'\n')
 print('NEW21orbit',orbit_index,'rank',record['rank'],'threshold236; total seconds',time.monotonic()-lease_started,flush=True)
 assert record['rank']>=236
signal.setitimer(signal.ITIMER_REAL,0)
