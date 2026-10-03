#!/usr/bin/env python3
"""New21 orbit enumeration from the already certified exact endpoint permutations."""
import json,itertools,time
from pathlib import Path
started=time.monotonic()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
d=json.loads((folder/'111_endpoint_orbits.json').read_text())
t=json.loads((folder/'triple_kernel_maps.json').read_text())
fp=d['Frobenius25_point_permutation'];cp=d['diagonal_C3_point_permutation'];fr=d['Frobenius25_root_permutation']
configs=set()
for omit in range(4):
 valid=[i for i in range(12) if i//3!=omit]
 for triple in itertools.combinations(valid,3):
  if len({i//3 for i in triple})==2:configs.add((omit,triple))
remaining=set(configs);orbits=[]
while remaining:
 seed=min(remaining);orbit={seed};todo=[seed]
 while todo:
  omit,triple=todo.pop()
  for v in [(omit,tuple(sorted(cp[i] for i in triple))),(fr[omit],tuple(sorted(fp[i] for i in triple)))]:
   if v not in orbit:orbit.add(v);todo.append(v)
 assert orbit<=configs
 orbits.append(sorted(orbit));remaining-=orbit
assert len(configs)==216 and len(orbits)==18 and all(len(o)==12 for o in orbits)
points=[(tuple(a),tuple(b)) for a,b in d['points']]
ends=[(tuple(a),tuple(b)) for a,b in t['selected_endpoints']]
omit=d['A_roots'].index(t['omitted_A_root']);reps=[]
for orbit in orbits:
 hit=next(v for v in orbit if v[0]==omit)
 reps.append(tuple(sorted(ends.index(points[i]) for i in hit[1])))
keys=[(omit,tuple(sorted(points.index(ends[i]) for i in p['relaxed_endpoint_indices']))) for p in t['prototypes'][1:]]
prototype_orbits=[next(k for k,o in enumerate(orbits) if key in o) for key in keys]
out={'scope':'All216 omitted-root/21 configurations under the stored exact diagonal C3 and Frobenius25 permutations only.',
     'orbits':orbits,'orbit_sizes':[len(o) for o in orbits],'fixed_omission_representatives':reps,
     'stored_prototype_orbit_indices':prototype_orbits,'seconds':time.monotonic()-started}
(folder/'21_endpoint_orbits.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS18orbits of12; prototype orbits',prototype_orbits)
