"""Exact geometric boundary tests, implemented by exhaustive roots-of-unity evaluation.
This is NOT a bounded search for curve coefficients: the scalar curve parameters
have been eliminated and all boundary roots lie in explicit finite etale algebras.
"""
from ff25 import *
from genus2_boundary import boundary_data, kmul,kpow,ksub,MOD,as4
import numpy as np
import json,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

KONE=[1]
def kinv(x):
 if trim(x)==[0]:raise ZeroDivisionError
 return kpow(x,25**4-2)
def kdiv(a,b):return kmul(a,kinv(b))
def keval(p,x):
 r=[0]
 for c in reversed(p):r=padd(kmul(r,x),[c])
 return r

def locdata():
 data=boundary_data();P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13]
 alpha=[0,1]
 ap=keval(pder(A),alpha);app=keval(pder(pder(A)),alpha)
 pp=kdiv(keval(pder(P),alpha),keval(P,alpha));aa=kdiv(app,ap)
 J=psub(pp,aa);KK=padd(pscale(pp,4),pscale(aa,3))
 h=data['h'];f=kdiv(pscale(kpow(h,4),A[4]),ap);gg=kmul(kmul(h,f),J)
 data.update(f_roots=[kpow(f,25**i) for i in range(4)],g_roots=[kpow(gg,25**i) for i in range(4)],K_roots=[kpow(KK,25**i) for i in range(4)],J=J,K=KK)
 return data

# Sparse polynomials in u,t,v with coefficients in K=F25[alpha]/A.
def pa(a,b):
 c={e:list(x) for e,x in a.items()}
 for e,x in b.items():
  c[e]=padd(c.get(e,[0]),x)
  if c[e]==[0]:del c[e]
 return c
def pn(a):return {e:pneg(x) for e,x in a.items()}
def ps(a,b):return pa(a,pn(b))
def pm(a,b):
 c={}
 for e,x in a.items():
  for f,y in b.items():
   ef=tuple(i+j for i,j in zip(e,f));c[ef]=padd(c.get(ef,[0]),kmul(x,y))
 return {e:x for e,x in c.items() if x!=[0]}
def pc(x,e=(0,0,0)):return {} if trim(x)==[0] else {e:list(x)}
def scale(a,x):return pm(a,pc(x))

def case_polynomials(data,i,j,k,l):
 ar=data['roots'];h=data['h_roots'];f=data['f_roots'];gg=data['g_roots'];K=data['K_roots']
 da=psub(ar[i],ar[j]);dm=psub(ar[k],ar[l])
 F0=ps(pc(h[i]),pc(h[j],(1,0,0)))
 F1=ps(pc(f[i]),pc(f[j],(4,0,0)))
 F2=ps(pc(gg[i]),pc(gg[j],(5,0,0)))
 G0=ps(pc(h[k],(0,0,1)),pc(h[l],(0,1,1)))
 G1=ps(pc(f[k],(0,0,4)),pc(f[l],(0,4,4)))
 G2=ps(pc(gg[k],(0,0,5)),pc(gg[l],(0,5,5)))
 if i!=j:
  E=pa(pm(ps(scale(F2,da),pm(F0,F1)),ps(pm(G1,G0),scale(G2,dm))),pm(ps(pc(kmul(da,dm)),pm(F0,G0)),ps(pc(kmul(da,dm)),pm(F0,G0))))
  return [E]
 F3=ps(pc(kmul(kmul(f[i],f[i]),K[i])),pc(kmul(kmul(f[j],f[j]),K[j]),(8,0,0)))
 E1=ps(pm(ps(pm(F2,F1),pm(F0,F3)),G0),scale(pm(F1,F1),dm))
 E2=ps(pm(ps(pm(G1,G0),scale(G2,dm)),F1),pm(F0,pm(G0,G0)))
 return [E1,E2]

def setup_evaluator():
 factors=json.loads((ROOT/'data/cyclotomic29_factors.json').read_text());lm=factors[0]
 zeta=[[1]]
 for _ in range(28):zeta.append(pdivmod(pmul(zeta[-1],[0,1]),lm)[1])
 assert pdivmod(pmul(zeta[-1],[0,1]),lm)[1]==[1]
 zp=np.array([a+[0]*(7-len(a)) for a in zeta],dtype=np.uint8)
 tabadd=np.array([[add(i,j) for j in range(25)] for i in range(25)],dtype=np.uint8)
 tabmul=np.array([[mul(i,j) for j in range(25)] for i in range(25)],dtype=np.uint8)
 grid=np.array([(u,t,v) for u in range(29) for t in range(29) for v in range(29)],dtype=np.int16)
 return lm,zp,tabadd,tabmul,grid

def testpoly(poly,inds,zp,tabadd,tabmul,grid):
 # Expand in the disjoint bases 1,alpha,...,alpha^3 and 1,zeta,...,zeta^6.
 terms=[(np.array(e,dtype=np.int16),as4(c)) for e,c in sorted(poly.items())]
 counts=[]
 for a in range(4):
  active=[(e,c[a]) for e,c in terms if c[a]]
  for b in range(7):
   if not len(inds):return inds,counts
   rows=grid[inds]
   out=np.zeros(len(inds),dtype=np.uint8)
   for e,c in active:
    powers=(rows@e)%29
    out=tabadd[out,tabmul[c,zp[powers,b]]]
   inds=inds[out==0]
   counts.append(dict(K_coordinate=a,L_coordinate=b,survivors=int(len(inds))))
 return inds,counts

def run():
 data=locdata();lm,zp,ta,tm,grid=setup_evaluator();cases=[];start=time.monotonic()
 for j in range(4):
  for k in range(4):
   for l in range(4):
    polys=case_polynomials(data,0,j,k,l)
    mask=np.ones(len(grid),dtype=bool)
    if j==0:mask&=grid[:,0]!=0
    if k==l:mask&=grid[:,1]!=0
    ids=np.flatnonzero(mask);counts=[]
    for E in polys:
     ids,c=testpoly(E,ids,zp,ta,tm,grid);counts.append(c)
    survivors=grid[ids].tolist()
    case=dict(indices=[0,j,k,l],term_counts=[len(E) for E in polys],initial_candidates=int(mask.sum()),survivors=survivors,coordinate_logs=counts,polynomials=[[[*e],as4(c)] for E in [] for e,c in E.items()])
    case['polynomials']=[[[list(e),as4(c)] for e,c in sorted(E.items())] for E in polys]
    cases.append(case)
    print('case',case['indices'],'terms',case['term_counts'],'survivors',len(survivors),'time',round(time.monotonic()-start,2),flush=True)
 out=dict(field_K_modulus=MOD,field_L_modulus=lm,normalization='first alpha index=0 by Frobenius; first D root-of-unity=1 by rescaling delta',local_data={k:v for k,v in data.items() if k!='cases'},cases=cases,numpy_version=np.__version__,elapsed_seconds=time.monotonic()-start)
 (ROOT/'data/genus1_boundary_results.json').write_text(json.dumps(out,indent=2))
 print('TOTAL SURVIVORS',sum(len(c['survivors']) for c in cases),'seconds',time.monotonic()-start)

if __name__=='__main__':run()
