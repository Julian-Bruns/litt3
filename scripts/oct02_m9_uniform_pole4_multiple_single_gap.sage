#!/usr/bin/env sage
"""NEW gap17 alone on multiple lower-b singleton boundary, hard5s."""
import json,time,signal
from pathlib import Path
started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('pole4 multiple single gap hard5s')));signal.setitimer(signal.ITIMER_REAL,5)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');fd=json.loads((folder/'source_e_repeated_prototype.json').read_text());data=json.loads((folder/'critical_G_collision_support.json').read_text());R5=PolynomialRing(GF(5),'t');E=GF(5**72,'e',modulus=R5(fd['field_modulus']));R=PolynomialRing(E,'x');x=R.gen();beta=E(fd['beta'])
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1]);records=[]
def coords(v):return [int(c) for c in v.polynomial().list()]
for stored in data['factors']:
 factor=R([E(v[0])+(E(v[1])*beta if len(v)>1 else 0) for v in stored['polynomial']]);lam=factor.roots(multiplicities=False)[0];delta=q3+lam*q;K=(Z*delta).quo_rem(P)[0];groups={}
 for r in delta.roots(multiplicities=False):groups.setdefault(K(r)**3*P(r),[]).append(r)
 assert sorted(map(len,groups.values()))==[1,2];pair=next(rs for rs in groups.values() if len(rs)==2);r2=next(rs[0] for rs in groups.values() if len(rs)==1);gamma=(x**3-K(pair[0])**3*P(pair[0])).roots(multiplicities=False)[0];bb=-2*gamma;ys=[gamma/K(r) for r in pair]
 for yc in (x**3-P(r2)).roots(multiplicities=False):
  B0=R.lagrange_polynomial([(r,-2*K(r)*y**2) for r,y in zip(pair,ys)]+[(r2,2*K(r2)*yc**2-bb*yc)]);value=((Z*B0)%P)[9]
  records.append({'parameter_factor_degree':stored['degree'],'lambda':coords(lam),'third_c_sheet':coords(yc),'gap17_value':coords(value),'nonzero':bool(value)})
out={'scope':'Pole4 source: two ordinary maximal lower-b singleton fibers force Gcollision. Their fixed B0, with arbitrary upper-c coefficient permitted, violates the universal gap17 for all six parameter/sheet representatives. No source e or selected contact equations used.','complete':len(records)==6,'all_nonzero':all(r['nonzero'] for r in records),'field_modulus':fd['field_modulus'],'beta':fd['beta'],'records':records,'seconds':time.monotonic()-started}
(folder/'pole4_multiple_single_gap.json').write_text(json.dumps(out,indent=2)+'\n');print('POLE4multiple gap',out['all_nonzero'],'cases',len(records),'seconds',out['seconds'],flush=True);signal.setitimer(signal.ITIMER_REAL,0)
