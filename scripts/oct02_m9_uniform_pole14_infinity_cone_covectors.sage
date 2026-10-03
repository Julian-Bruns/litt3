#!/usr/bin/env sage
"""NEW exact two infinity-cone covectors at the stored necessary witness."""
import json,time,signal
from pathlib import Path
started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/'pole14_infinity_cone_covectors.json';stages=[];out={'scope':'NEW two all-rho infinity-cone covectors at the STORED necessary critical D witness. Both nonzero determinants would prove only proper necessary-D-model homogeneous-kernel supports, not an actual-source exclusion. No v dependence, no finite-origin equation.','stages':stages}
def save():out['seconds']=time.monotonic()-started;output.write_text(json.dumps(out,indent=2,default=int)+'\n')
def checkpoint(s):stages.append({'stage':s,'seconds':time.monotonic()-started});save();print(s,stages[-1]['seconds'],flush=True)
def expired(s,f):out['hard_timeout']=True;save();raise TimeoutError('combined rank hard10s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,15);stored=json.loads((folder/'pole14_combined_rank_prototype.json').read_text())
meta=json.loads((folder/'compact_norm_symbolic_prototype.json').read_text());old=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text());R5=PolynomialRing(GF(5),'t');E=GF(5**8,'e',modulus=R5(meta['field_modulus']));beta=E(meta['beta']);R=PolynomialRing(E,'x');x=R.gen();K=R.fraction_field()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1]);ell=x+code(12);aroots=[E(rec['A_root']) for rec in old['records']];pbase=P(aroots[0]);P/=pbase;Z/=pbase
def zero():return [K.zero()]*3
def add(*fs):return [sum((f[i] for f in fs),K.zero()) for i in range(3)]
def scale(f,c):return [K(c)*v for v in f]
def pi(f,j):
 ans=zero()
 for char,h in enumerate(f):
  power,target=divmod(char-j,3);raw=R(h)*Z**j;ans[target]+=raw*P**power if power>=0 else raw.quo_rem(P**(-power))[0]
 return ans
def aj(f,j):
 ans=zero()
 for char,h in enumerate(f):
  power,target=divmod(char-j,3);ans[target]+=h*Z**j*P**power
 return ans
def basis(N):
 ans=[]
 for char in range(3):
  for exponent in range((N-10*char)//3+1):
   f=zero();f[char]=x**exponent;ans.append(f)
 return ans
def ev(f,r,y):return sum((v(r)*y**char for char,v in enumerate(f)),E.zero())
def critical(e2,e1,e0,d3):
 f2=add(e2,scale(pi(d3,1),-3));cor1=add(scale(aj(f2,1),2),scale(aj(d3,2),3));p1=add(scale(pi(f2,1),2),scale(pi(d3,2),3));f1=add(e1,scale(p1,-1));cor0=add(aj(f1,1),aj(f2,2),aj(d3,3));p0=add(pi(f1,1),pi(f2,2),pi(d3,3));f0=add(e0,scale(p0,-1));return [f0,f1,f2,d3],add(e1,cor1,scale(p1,-1)),add(e0,cor0,scale(p0,-1))
def coeff_minus1(h):
 h=K(h)
 if not h:return E.zero()
 assert h.numerator().degree()-h.denominator().degree()<=-1
 return h.numerator().leading_coefficient()/h.denominator().leading_coefficient() if h.numerator().degree()-h.denominator().degree()==-1 else E.zero()
endpoints=[(r,y) for r in aroots[1:] for y in (x**3-P(r)).roots(multiplicities=False)];assert len(endpoints)==9
b2,b1,b0=basis(14),basis(16),basis(17);assert list(map(len,[b2,b1,b0]))==[7,9,9]
lam=E(stored['source_lambda']);d3=zero();d3[0]=q3+lam*q+ell;base,ds1,ds0=critical(zero(),zero(),zero(),d3)
sources=[]
for block,space in enumerate([b2,b1,b0]):
 for f in space:
  vals=[zero(),zero(),zero()];vals[block]=f;finite,s1,s0=critical(*vals,zero());sources.append((finite,s1,s0))
parameters=vector(E,[E(v) for v in stored['source_parameters']])
finite=[[base[j][c]+sum((parameters[i]*sources[i][0][j][c] for i in range(25)),K.zero()) for c in range(3)] for j in range(4)]
assert coeff_minus1(add(finite[1],scale(aj(finite[2],1),2),scale(aj(finite[3],2),3))[2])==0
assert all(ev(add(finite[0],aj(finite[1],1),aj(finite[2],2),aj(finite[3],3)),*pt)==0 for pt in endpoints)
out.update(source_constraint_rank=stored['source_constraint_rank'],source_affine_dimension=stored['source_affine_dimension'],source_lambda=[int(v) for v in lam.polynomial().list()],source_parameters=[[int(c) for c in v.polynomial().list()] for v in parameters],field_modulus=meta['field_modulus'],beta=meta['beta']);checkpoint('necessary_critical_source_constructed')
# Exact first-three moment family, eighteen ambient eta coefficients.
mb=[basis(10),basis(12),basis(14)];moment_ambient=[];gapcols=[]
for block,space in enumerate(mb):
 for f in space:
  es=[zero(),zero(),zero()];es[block]=f;n0=es[0];n1=add(pi(n0,1),es[1]);n2=add(scale(pi(es[1],1),2),scale(pi(pi(n0,1),1),2),scale(pi(n0,2),-1),es[2]);mu1=add(n1,scale(aj(n0,1),-1));mu2=add(n2,scale(aj(n1,1),-2),aj(n0,2));moment_ambient.append((n0,mu1,mu2));p=R(n0[0]);qq=R(es[1][0]);gamma=R(n0[1])[0];gapcols.append([((Z*p)%P)[9],((Z*p)%P)[8],(2*((Z*qq)%P)+gamma*((Z**2)%P))[9]])
G=matrix(E,gapcols).transpose();moment_basis=G.right_kernel().basis();assert len(moment_basis)==15
moments=[tuple([sum((v[i]*moment_ambient[i][j][c] for i in range(18)),K.zero()) for c in range(3)] for j in range(3)) for v in moment_basis]
short=[finite[0],finite[1],finite[2],finite[3]];short[0]=add(finite[0],aj(finite[1],1),aj(finite[2],2),aj(finite[3],3));short[1]=add(finite[1],scale(aj(finite[2],1),2),scale(aj(finite[3],2),3));short[2]=add(finite[2],scale(aj(finite[3],1),3))
def mul(f,g):
 ans=zero()
 for i,a in enumerate(f):
  for j,b in enumerate(g):
   power,c=divmod(i+j,3);ans[c]+=a*b*P**power
 return ans
selected=matrix(E,[[ev(scale(add(mul(short[3],mu2),mul(short[2],mu1),mul(short[1],n0)),-1),*pt) for n0,mu1,mu2 in moments] for pt in endpoints]);checkpoint('moment_and_selected_rows')
# Only a local Laurent computation; no critical algebra or field adjunction.
LS=LaurentSeriesRing(E,'tau',default_prec=90);tau=LS.gen();u=(tau**3*P[10]).add_bigoh(90)
for iteration in range(30):u=(tau**3*sum((P[10-j]*u**j for j in range(11)),LS.zero())).add_bigoh(90)
xs=1/u;ys=xs**3/tau;xp=[LS.one()]
for j in range(1,65):xp.append(xp[-1]*xs)
cache={}
def ps(p):
 key=tuple(p.list())
 if key not in cache:cache[key]=sum((c*xp[j] for j,c in enumerate(p.list())),LS.zero())
 return cache[key]
def rs(h):return ps(h.numerator())/ps(h.denominator())
def fs(f):return sum((rs(v)*ys**i for i,v in enumerate(f)),LS.zero())
assert (ys**3-ps(P)).valuation()>=40
d0s,d1s,d2s,d3s=map(fs,short);assert d3s.valuation()==-9 and d2s.valuation()==-14 and d1s.valuation()>=-16 and d0s.valuation()>=-17;zstar=-d3s/d2s-d1s*d3s**2/d2s**3


B=d2s[-14];C=d1s[-16];assert B
rowM=[];rowBMplusCN=[]
for n0,mu1,mu2 in moments:
 n,m1=map(fs,[n0,mu1]);rowM.append(m1[-12]);rowBMplusCN.append(B*m1[-12]+C*n[-10])
def coords(v):return [int(c) for c in v.polynomial().list()]
oldmatrix=matrix(E,[[E(c) for c in row] for row in stored['matrix']])
records=[]
for name,row in [('M',rowM),('B*M+C*N',rowBMplusCN)]:
 det=oldmatrix.stack(matrix(E,[row])).det()
 records.append({'factor':name,'row':[coords(c) for c in row],'determinant':coords(det),'nonzero':bool(det)})
out.update(complete=True,B=coords(B),C=coords(C),records=records,both_nonzero=all(r['nonzero'] for r in records),stored_witness_reused_without_rank_replay=True)
save();signal.setitimer(signal.ITIMER_REAL,0);print('NEW cone determinants',[r['nonzero'] for r in records],'seconds',out['seconds'],flush=True)

