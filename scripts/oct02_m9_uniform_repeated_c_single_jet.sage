#!/usr/bin/env sage
"""New parameter-free repeated critical C-single jet obstruction, hard5s."""
import json,time,signal
from pathlib import Path
started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('repeat singleton jet hard5s')));signal.setitimer(signal.ITIMER_REAL,5)
E=GF(25,'b',modulus=PolynomialRing(GF(5),'t')([2,4,1]));b=E.gen();R=PolynomialRing(E,'r');r=R.gen();F=R.fraction_field();S=PolynomialRing(F,'x');x=S.gen()
def code(c):return E(c%5)+E(c//5)*b
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1]);lam=-q3/q;delta=S(q3.list())+lam*S(q.list());K=(S(Z.list())*delta).quo_rem(S(P.list()))[0];G=K**3*S(P.list())
repeat=q3.derivative()*q-q3*q.derivative();condition=G.derivative()(r).numerator();g,aa,bb=repeat.xgcd(condition);assert g.degree()==0
def encode(g):return [[int(c) for c in v.polynomial().list()] for v in g.list()]
out={'scope':'A repeated ordinary critical fiber with C-single ACTUAL pole support is impossible. Also excluded is C-single maximal support when b has BOTH complementary maximal sheets. Tied b-single/c-single maximal support is NOT excluded. Complete c regularity on both complementary sheets gives gamma^3=K^3P modulo repeated factor, hence partial-x derivative condition. No selected or annihilator hypotheses.','repeat_polynomial':encode(repeat),'jet_polynomial':encode(condition),'gcd_degree':int(g.degree()),'bezout_repeat':encode(aa/g[0]),'bezout_jet':encode(bb/g[0]),'seconds':time.monotonic()-started}
Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/repeated_c_single_jet_obstruction.json').write_text(json.dumps(out,indent=2)+'\n');print('REPEAT Csingle gcd',g.degree(),'degrees',repeat.degree(),condition.degree(),'seconds',out['seconds'],flush=True);signal.setitimer(signal.ITIMER_REAL,0)
