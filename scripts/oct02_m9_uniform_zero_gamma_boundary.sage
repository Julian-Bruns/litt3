#!/usr/bin/env sage
"""Gamma-zero selected-fiber support against branch/repeated boundaries, hard5s."""
import json,time,signal
from pathlib import Path
started=time.monotonic()
def expired(signum,frame):raise TimeoutError('gamma0 boundary hard5-second budget')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,5)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text())
R5=PolynomialRing(GF(5),'t');F=GF(5**8,'e',modulus=R5(data['field_modulus']))
beta=F(data['beta_coordinates']);R=PolynomialRing(F,'x');x=R.gen()
def code(c):return F(c%5)+F(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16])
q3=poly([1,22,9,1]);q=poly([13,18,24]);K0,R0=(Z*q3).quo_rem(P);K1,R1=(Z*q).quo_rem(P)
L=PolynomialRing(F,'lam');lam=L.gen();support=L.one();lines=[]
for record in data['records']:
 s=F(record['A_root']);line=L(R0(s))+lam*R1(s);assert line and line[0]
 support*=line;lines.append(line)
def coords(v):return [int(c) for c in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
certificates={}
for name in ['discriminant','cubic_branch','Kummer_zero','selected_endpoint']:
 boundary=L([F(v) for v in data['boundary_polynomials'][name]])
 g,a,b=support.xgcd(boundary)
 certificates[name]={'gcd':encoded(g),'gcd_degree':int(g.degree()),'bezout':[encoded(a),encoded(b)]}
out={'scope':'Any surviving gamma0 canceled-pole3 root has all3 selected zeros in one xfiber, hence Rlambda(s)=0. Exact necessary selected-R support vs leading-cubic branch/repetition boundaries.',
    'field_modulus':data['field_modulus'],'support':encoded(support),'support_degree':int(support.degree()),
    'selected_R_lines':[encoded(f) for f in lines],'boundary_certificates':certificates,'seconds':time.monotonic()-started,'sage_version':version()}
(folder/'zero_gamma_selected_support_boundary_exclusion.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0);print('gamma0 supportdegree',support.degree(),'gcds',{k:v['gcd_degree'] for k,v in certificates.items()},'seconds',time.monotonic()-started)
