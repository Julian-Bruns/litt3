#!/usr/bin/env sage
"""Fixed affine 6x7 selected pencil: exact minors and finite-support witnesses."""
import json,time,signal,os
from pathlib import Path
from itertools import combinations
started=time.monotonic()
signal.signal(signal.SIGALRM,lambda s,f: (_ for _ in ()).throw(TimeoutError('selected rank support hard60s')))
signal.setitimer(signal.ITIMER_REAL,60)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
seed=json.loads((folder/'half_bzero_leading_pencil.json').read_text())
F5=GF(5); RF=PolynomialRing(F5,'z'); E=GF(5**8,'e',modulus=RF(seed['field_modulus'])); ee=E.gen()
def dec(v):return sum(E(c)*ee**i for i,c in enumerate(v))
beta=dec(seed['beta']); assert beta**2==beta+3
R=PolynomialRing(E,'x'); x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
def decp(cs):return R([dec(c) for c in cs])
def enc(a):return [int(c) for c in E(a).polynomial().list()]
def encp(f):return [enc(c) for c in f.list()]
P=poly([11,22,18,5,19,20,15,16,9,22,1]); Z=poly([15,19,24,12,10,19,3,24,18,16])
q=poly([13,18,24]); n=poly([1,22,9,1])
gap=matrix(E,1,5,[((Z*x**i)%P)[9] for i in range(5)])
basis=[R(v.list()) for v in gap.right_kernel().basis()]; assert len(basis)==4
T=PolynomialRing(E,('p','r')); p,r=T.gens(); TX=PolynomialRing(T,'X'); X=TX.gen()
def lift(f):return TX([T(c) for c in f.list()])
def enct(f):return [{'powers':list(mon),'coefficient':enc(c)} for mon,c in sorted(T(f).dict().items())]
def vec3(f):return [f[i] for i in range(3)]
def xgcd_list(fs,ring):
 g=ring.zero(); coeff=[]
 for f in fs:
  ng,a,b=g.xgcd(f); coeff=[c*a for c in coeff]+[b]; g=ng
  if g==1:
   coeff += [ring.zero()]*(len(fs)-len(coeff));break
 if g:
  lc=g.leading_coefficient();g=g/lc;coeff=[c/lc for c in coeff]
 assert sum((a*f for a,f in zip(coeff,fs)),ring.zero())==g
 return g,coeff
records=[]
for oi,s in enumerate(seed['records']):
 t=decp(s['t']); t2=t*t; ip=P.inverse_mod(t2)
 def cjet(c,b):
  Rc=(Z*c-Z**2*b)%P
  r1=((3*Z**2*c+Z**3*b)%P)*ip%t2
  return vector(E,[(Rc%t)[i] for i in range(3)]+[r1[i] for i in range(3,6)])
 MC=matrix(E,[cjet(x**i,R.zero()) for i in range(6)]).transpose(); assert MC.det()
 sol=MC.solve_right(-cjet(R.zero(),R.one())); Cstar=R(sol.list()); assert not cjet(Cstar,R.one())
 e=((Z*Cstar-Z**2)%P)[9]; c0=Cstar[5]
 Dbase=decp(s['Dbase']); D3=decp(s['Dq3']); Dq=decp(s['Dq'])
 C=T(Dbase[2])+p*T(D3[2])+r*T(Dq[2])
 d=p*lift(n)+r*lift(q); nt=lift(n); qt=lift(q); pt=lift(P); tt=lift(t)
 Rd=(lift(Z)*d)%lift(P); Rn=lift((Z*n)%P); Rq=lift((Z*q)%P)
 Ha=(2*d*Rq-3*qt*Rd)%tt; H3=(2*d*Rn-3*nt*Rd)%tt
 cols=[]; k_values=[]
 for W in basis:
  k=(-P.inverse_mod(t)*((Z**2*W)%P)%t)[2]; k_values.append(k)
  old=(C*(lift(W)*Rn-2*nt*lift((Z*W)%P))-T(k)*H3)%tt
  new=(-T(k)*nt-T(e)*lift(W))%tt
  cols.append(vec3(old)+vec3(new))
 cols += [vec3(Ha)+vec3(qt%tt),vec3((T(c0)*H3+pt*C)%tt)+vec3((T(c0)*nt)%tt),[T.zero()]*3+vec3(d%tt)]
 M=matrix(T,cols).transpose(); assert M.nrows()==6 and M.ncols()==7
 # Simultaneous exact last-row Laplace expansion; no parameter samples.
 prev={():T.one()}
 for i in range(6):
  curr={}
  for I in combinations(range(7),i+1):
   curr[I]=sum(((-1)**(i+j)*M[i,I[j]]*prev[I[:j]+I[j+1:]] for j in range(i+1)),T.zero())
  prev=curr
 subsets=list(combinations(range(7),6)); minors=[prev[I] for I in subsets]
 assert any(minors) and all(not f or f.total_degree()<=6 for f in minors)
 reduced=list(minors); removed=[]
 for name,F in [('p',p),('C',C)]:
  if F.total_degree()==0:continue
  count=0
  while all(not f or f.quo_rem(F)[1]==0 for f in reduced):
   reduced=[f.quo_rem(F)[0] for f in reduced];count+=1
  if count:removed.append({'factor':name,'power':count,'polynomial':enct(F)})
 G=T.zero()
 for f in reduced:
  G=G.gcd(f)
  if G and G.total_degree()==0:break
 if G:G=G/G.leading_coefficient()
 rec={'omission':oi+1,'t':encp(t),'Cstar':encp(Cstar),'e':enc(e),'c0':enc(c0),'C':enct(C),
      'k_on_gap_basis':[enc(v) for v in k_values],
      'matrix':[[enct(a) for a in row] for row in M.rows()],
      'minor_column_sets':[list(I) for I in subsets],'minors':[enct(f) for f in minors],
      'removed_allowed_factors':removed,'reduced_minors':[enct(f) for f in reduced],
      'remaining_common_factor':enct(G),'finite_exceptional_support':bool(G==1 and e)}
 if G==1 and e:
  U=PolynomialRing(E,'pp'); pp=U.gen(); K=U.fraction_field(); V=PolynomialRing(K,'rr'); rr=V.gen()
  def coeffs_r(f):
   dd=T(f).dict(); degree=max([m[1] for m in dd]+[0]);out=[]
   for j in range(degree+1):out.append(sum((U(c)*pp**m[0] for m,c in dd.items() if m[1]==j),U.zero()))
   return out
  coeffs=[coeffs_r(f) for f in reduced]
  univ=[V([K(c) for c in cs]) for cs in coeffs]
  gg,bb=xgcd_list(univ,V);assert gg==1
  den=U.one()
  for B in bb:
   for c in B.list():den=den.lcm(c.denominator())
  def back(B):
   out=T.zero()
   for j,c in enumerate(B.list()):
    cc=K(c*den);assert cc.denominator()==1
    out+=sum((T(a)*p**i*r**j for i,a in enumerate(cc.numerator().list())),T.zero())
   return out
  witness=[back(B) for B in bb]; delta=sum((T(c)*p**i for i,c in enumerate(den.list())),T.zero())
  assert sum((A*f for A,f in zip(witness,reduced)),T.zero())==delta and delta
  coefficient_list=[];addresses=[]
  for i,cs in enumerate(coeffs):
   for j,c in enumerate(cs):coefficient_list.append(c);addresses.append([i,j])
  cg,cb=xgcd_list(coefficient_list,U);assert cg==1
  rec.update(exceptional_p_polynomial=encp(den),fraction_field_bezout=[enct(a) for a in witness],
             content_coefficient_addresses=addresses,content_bezout=[encp(a) for a in cb],
             exceptional_p_degree=int(den.degree()),cardinality_bound=int(max(0,den.degree())*6))
 records.append(rec)
 print('SELECTED RANK',oi+1,'e nonzero',bool(e),'common degree',G.total_degree(),'finite',rec['finite_exceptional_support'],'p degree',rec.get('exceptional_p_degree'),flush=True)
 out={'scope':'Exact selected-pencil rank outside finite leading support on p*C*e!=0; no source A search or source exclusion.',
      'field_modulus':seed['field_modulus'],'beta':seed['beta'],'A_gap_basis':[encp(W) for W in basis],
      'records':records,'complete':len(records)==4,'seconds':time.monotonic()-started,'sage_version':version(),
      'thread_caps':{k:os.environ.get(k) for k in ['OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS']}}
 (folder/'half_nonzero_b_selected_rank_support.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('DONE selected rank support',round(out['seconds'],3),'seconds',flush=True)
