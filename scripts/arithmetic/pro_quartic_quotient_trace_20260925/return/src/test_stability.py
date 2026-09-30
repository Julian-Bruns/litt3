from finite_field import *
from geometric_stability import *
from pathlib import Path
import numpy as np,time
ROOT=Path(__file__).resolve().parents[1];d=json.load(open(ROOT/'data/stability_sections.json'));F=F25()
sec=[(apoly(a),apoly(b)) for a,b in d['dual_sections']]
x,y=5,14
for l in [(1,0),(0,1),(1,1),(5,14)]:
 xi=[F.add(F.mul(l[0],eval_affine(a,x,y,F)),F.mul(l[1],eval_affine(b,x,y,F))) for a,b in sec]
 a=check_stability(xi,F);assert not a['stable'];print('known affine Sigma',l,a,flush=True)
for l in [(1,0),(0,1),(1,1)]:
 xi=[F.add(F.mul(l[0],a),F.mul(l[1],b)) for a,b in zip(*d['infinity_fiber'])]
 a=check_stability(xi,F);assert not a['stable'];print('known infinity Sigma',l,a,flush=True)
rng=np.random.default_rng(926)
for i in range(3):
 xi=[int(a) for a in rng.integers(0,25,19)]
 print('random geometric stability',i,check_stability(xi,F),flush=True)
F2=F25Extension([20,0,1]);assert F2.power(25,25)==100
print('F625 irreducibility PASS; t^25=-t !=t',flush=True)
xi=[1]+[25]+[int(a) for a in rng.integers(0,625,17)]
print('F625 geometric stability',check_stability(xi,F2),flush=True)
json.dump({'xi':xi,'modulus':[20,0,1]},open(ROOT/'data/example_F625.json','w'),indent=2)
