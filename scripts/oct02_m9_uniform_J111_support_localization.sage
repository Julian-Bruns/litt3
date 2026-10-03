#!/usr/bin/env sage
"""New J111 common norm support versus fixed two-row coefficient drop."""
import json,time,signal,argparse
from pathlib import Path
started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('J111 localization hard10s')));signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');data=json.loads((folder/'compact_norm_symbolic_prototype.json').read_text());R5=PolynomialRing(GF(5),'t');E=GF(5**8,'e',modulus=R5(data['field_modulus']));beta=E(data['beta']);R=PolynomialRing(E,'r');r=R.gen();F=R.fraction_field();S=PolynomialRing(F,'x');x=S.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1]);A=poly([1,21,14,22,13]);old=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text());aroots=[E(v['A_root']) for v in old['records']];pbase=P(aroots[0]);P/=pbase;Z/=pbase
ss=aroots[1:];ys=[(R.gen()**3-P(s)).roots(multiplicities=False)[0] for s in ss];ell=[1/prod(ss[i]-ss[j] for j in range(3) if j!=i) for i in range(3)];delta=S(q3.list())-q3(r)/q(r)*S(q.list());PS=S(P.list());ZS=S(Z.list());rd=(ZS*delta)%PS;rdx=(ZS*delta*x)%PS
a0=sum(ell[i]*ys[i]*rd(ss[i])/P(ss[i]) for i in range(3));a1=sum(ell[i]*ys[i]*rdx(ss[i])/P(ss[i]) for i in range(3));D=a0*rdx[9]-a1*rd[9]
d=json.loads((folder/'source_e_J111_case00_difference.json').read_text());g=R([E(v) for v in d['gcd']]);rad=prod(f for f,m in g.factor());Dnum=D.numerator();residual=rad//rad.gcd(Dnum)
out={'scope':'Necessary common norm support localization only. Different norm phase choices are not asserted compatible.','gcd_degree':int(g.degree()),'radical_degree':int(rad.degree()),'coefficient_drop_degree':int(Dnum.degree()),'coefficient_drop_identically_zero':not Dnum,'gap_shift_coefficients_zero':not rd[9] and not rdx[9],'residual_degree':int(residual.degree()),'factors':[(int(f.degree()),int(m)) for f,m in g.factor()], 'drop_factors':[(int(f.degree()),int(m)) for f,m in Dnum.factor()] if Dnum else [], 'seconds':time.monotonic()-started}
(folder/'source_e_J111_support_localization.json').write_text(json.dumps(out,indent=2)+'\n');print(out,flush=True);signal.setitimer(signal.ITIMER_REAL,0)
