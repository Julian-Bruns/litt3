#!/usr/bin/env sage
"""Four selected-boundary first-jet obstruction scalars, hard5 seconds."""
import json,time,signal
from pathlib import Path
started=time.monotonic()
def expired(signum,frame):raise TimeoutError('selected-boundary hard5-second budget')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,5)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text())
R5=PolynomialRing(GF(5),'t');F=GF(5**8,'e',modulus=R5(data['field_modulus']))
beta=F(data['beta_coordinates']);R=PolynomialRing(F,'x');x=R.gen()
def code(c):return F(c%5)+F(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16])
q3=poly([1,22,9,1]);q=poly([13,18,24]);records=[]
def coords(v):return [int(c) for c in v.polynomial().list()]
for record in data['records']:
 s=F(record['A_root']);assert q(s) and P(s)
 lam=-q3(s)/q(s);delta=q3+lam*q;K,rem=(Z*delta).quo_rem(P)
 value=3*P(s)*rem.derivative()(s)-2*P.derivative()(s)*rem(s)
 assert delta(s)==0 and delta.derivative()(s) and value
 records.append({'A_root':coords(s),'lambda':coords(lam),'delta_derivative':coords(delta.derivative()(s)),
      'R_value':coords(rem(s)),'pair_first_jet_obstruction':coords(value)})
out={'scope':'At a selected A root with delta(s)=0, simultaneous short c zeros on two sheets force a first-jet scalar that is nonzero in all4 cases.',
     'field_modulus':data['field_modulus'],'records':records,'all_four_nonzero':True,'seconds':time.monotonic()-started,'sage_version':version()}
(folder/'endpoint_pair_first_jet_obstruction.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0);print('PASS4 selected-boundary scalars; seconds',time.monotonic()-started)
