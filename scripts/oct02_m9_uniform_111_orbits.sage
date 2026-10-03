#!/usr/bin/env sage
"""Exact diagonal-cubic/arithmetic-Frobenius orbits on111 endpoint sets."""
import json,time
from pathlib import Path
from itertools import product
started=time.time()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'triple_kernel_maps.json').read_text())
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(data['field_modulus']))
def unpack(v):return E(v)
beta=unpack(data['beta_coordinates']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
P=R([code(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
A=R([code(c) for c in [1,21,14,22,13]])
aroots=A.roots(multiplicities=False);ys=[(x**3-P(r)).roots(multiplicities=False) for r in aroots]
omega=(x*x+x+1).roots(multiplicities=False)[0]
points=[(r,y) for r,yy in zip(aroots,ys) for y in yy]
frob_roots=[aroots.index(r**25) for r in aroots]
frob_points=[points.index((r**25,y**25)) for r,y in points]
cyclic_points=[points.index((r,omega*y)) for r,y in points]
configurations=set()
for omitted in range(4):
 indices=[i for i in range(4) if i!=omitted]
 for choices in product(range(3),repeat=3):configurations.add((omitted,tuple(sorted(3*i+j for i,j in zip(indices,choices)))))
def generators(config):
 omitted,selected=config
 return [(omitted,tuple(sorted(cyclic_points[i] for i in selected))),
         (frob_roots[omitted],tuple(sorted(frob_points[i] for i in selected)))]
orbits=[];remaining=set(configurations)
while remaining:
 seed=min(remaining);orbit={seed};todo=[seed]
 while todo:
  for config in generators(todo.pop()):
   if config not in orbit:orbit.add(config);todo.append(config)
 assert orbit<=configurations
 orbits.append(sorted(orbit));remaining-=orbit
assert len(configurations)==108 and len(orbits)==9 and all(len(o)==12 for o in orbits)
prototype=(unpack(data['omitted_A_root']),[tuple(unpack(v) for v in data['selected_endpoints'][i]) for i in [0,3,6]])
prototype_key=(aroots.index(prototype[0]),tuple(sorted(points.index(pt) for pt in prototype[1])))
prototype_orbit=next(i for i,orbit in enumerate(orbits) if prototype_key in orbit)
def coords(v):return [int(a) for a in v.polynomial().list()]
out={'scope':'All108 omitted-root/111 sheet configurations under only diagonal C3 and arithmetic Frobenius25.',
     'field_modulus':data['field_modulus'],'omega':coords(omega),'A_roots':list(map(coords,aroots)),
     'points':[[coords(v) for v in pt] for pt in points],'Frobenius25_root_permutation':frob_roots,
     'Frobenius25_point_permutation':frob_points,'diagonal_C3_point_permutation':cyclic_points,
     'orbits':orbits,'prototype_key':prototype_key,'prototype_orbit_index':prototype_orbit,
     'seconds':time.time()-started,'sage_version':version()}
(folder/'111_endpoint_orbits.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('PASS9orbits of12; prototype orbit',prototype_orbit,'root Frob',frob_roots,'seconds',time.time()-started)
