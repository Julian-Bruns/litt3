#!/usr/bin/env sage
"""NEW finite-pair source calculation: field degrees only, hard10s."""
import json,time,signal
from pathlib import Path
t=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('pair field hard10s')));signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text());fd=json.loads((folder/'four_zero_degree8_prototype.json').read_text())
R5=PolynomialRing(GF(5),'t');E8=GF(5**8,'v',modulus=R5(data['field_modulus']));E=GF(5**64,'u',modulus=R5(fd['absolute_field_modulus']));emb=E8.hom([E(fd['base_generator_image'])],E)
beta=emb(E8(data['beta_coordinates']));R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);A=poly([1,21,14,22,13]);q=poly([13,18,24]);q3=poly([1,22,9,1]);aroots=[emb(E8(d['A_root'])) for d in data['records']];pbase=P(aroots[0]);P/=pbase;Z/=pbase
record=data['records'][1];endpoint=R([emb(E8(v)) for v in record['endpoint_cubic_zero_factor']]).monic();results=[]
for f in record['factors']:
 factor=R([emb(E8(v)) for v in f['polynomial']]).monic()
 if factor==endpoint:continue
 lam=factor.roots(multiplicities=False)[0];delta=q3+lam*q;K,rem=(Z*delta).quo_rem(P)
 gamma=-rem(aroots[1])*(x**3-P(aroots[1])).roots(multiplicities=False)[0]/P(aroots[1]);g=delta.gcd(K**3*P-gamma**3);assert g.degree()==1
 roots=delta.roots(multiplicities=False)
 results.append({'parameter_factor_degree':f['degree'],'critical_factors':[(int(h.degree()),int(m)) for h,m in delta.factor()], 'rational_critical_roots':len(roots),'rational_sheet_counts':[(int((x**3-P(r)).roots(multiplicities=False).__len__())) for r in roots]})
out={'scope':'Only finite-field representation degrees for a NEW source-e extension of old pair parameter support; no source equations or settled quotient certificate replay.','records':results,'seconds':time.monotonic()-t}
(folder/'source_e_pair_field_probe.json').write_text(json.dumps(out,indent=2)+'\n');print(out,flush=True);signal.setitimer(signal.ITIMER_REAL,0)
