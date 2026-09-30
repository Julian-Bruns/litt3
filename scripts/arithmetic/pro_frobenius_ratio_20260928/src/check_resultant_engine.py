#!/usr/bin/env python3
"""Labelled arithmetic regressions for the exact whole-curve evaluator.
These checks alone make NO geometric square-locus exclusion.
"""
from pathlib import Path
import ctypes as C,json,time,itertools
import numpy as np
from ff import Poly,mul,add,neg,inv,div,power,vm,va,u32p
import ext
from ext import EP,Element as E
from residual import RATIO,Tails,peval
from residual_jet import residual_jet
ROOT=Path(__file__).resolve().parents[1]
lib=C.CDLL(str(ROOT/'src/fast_tails.so'));i32p=np.ctypeslib.ndpointer(dtype=np.int32,ndim=1,flags='C_CONTIGUOUS')
lib.ft_tails_at_q.argtypes=[u32p,C.c_int,C.c_uint32,u32p,C.c_int]
lib.ft_dual_at_q.argtypes=[u32p,C.c_int,C.c_uint32,u32p,C.c_int]
lib.ft_coset_model.argtypes=[u32p,C.c_int,C.c_uint32,u32p,u32p,u32p]
lib.ft_coset_resultants.argtypes=[u32p,C.c_uint32,u32p,C.c_int]
lib.ft_set_normalization.argtypes=[u32p,i32p,C.c_int,i32p,C.c_int]
lib.ft_scalar_dual_resultant.argtypes=[u32p,u32p,C.c_int,C.c_int,u32p]
lib.ft_field_evaluate.argtypes=[u32p,C.c_int,u32p]
lib.ft_field_interpolate.argtypes=[u32p,C.c_int,u32p]
lib.ft_field_hermite.argtypes=[u32p,u32p,C.c_int,u32p]

def ep_resultant(a,b):
 r=E(1)
 while b:
  n,m=a.degree(),b.degree()
  if not m:return r*b[0]**n
  if n<m:
   a,b=b,a
   if n*m%2:r=-r
   continue
  rem=a%b
  if not rem:return E()
  r=r*b[m]**(n-rem.degree())
  if n*m%2:r=-r
  a,b=b,rem
 return E()

def scalar_regressions():
 rng=np.random.default_rng(71934);cases=0;nonzero_nilpotent=0
 def prod(x,y):return(mul(x[0],y[0]),add(mul(x[0],y[1]),mul(x[1],y[0])))
 for n,m in [(1,1),(2,2),(3,2),(3,3)]:
  for mode in range(6):
   a=rng.integers(0,390625,(n+1,2),dtype=np.uint32);b=rng.integers(0,390625,(m+1,2),dtype=np.uint32)
   if mode>=1:a[-1]=0
   if mode>=2:b[-1]=0
   if mode>=3:a[-1,1]=2
   if mode>=4:a[-2]=0;b[-2]=0
   if mode>=5:b[-1,1]=3
   out=np.zeros(2,dtype=np.uint32);assert lib.ft_scalar_dual_resultant(a.ravel(),b.ravel(),n,m,out)
   N=n+m;M=[[(0,0)for _ in range(N)]for _ in range(N)]
   for i in range(m):
    for j in range(n+1):M[i][i+j]=tuple(map(int,a[j]))
   for i in range(n):
    for j in range(m+1):M[m+i][i+j]=tuple(map(int,b[j]))
   ans=(0,0)
   for perm in itertools.permutations(range(N)):
    term=(1,0)
    for i in range(N):term=prod(term,M[i][perm[i]])
    parity=(sum(perm[i]>perm[j]for i in range(N)for j in range(i+1,N))+n*m)%2
    if parity:term=tuple(neg(x)for x in term)
    ans=tuple(add(x,y)for x,y in zip(ans,term))
   assert list(ans)==out.tolist(),(n,m,mode,ans,out)
   cases+=1;nonzero_nilpotent+=ans[0]==0 and ans[1]!=0
 assert nonzero_nilpotent
 return {'fixtures':cases,'nonzero_nilpotent_resultants':nonzero_nilpotent,'reference':'direct Leibniz determinant, fixed Sylvester sizes at most 6'}

def source_regressions(G):
 qs=[1,2,3,25,27321]
 for q in qs:
  out=np.zeros(4*56*2,dtype=np.uint32);assert lib.ft_tails_at_q(G.ravel(),625,q,out,74)
  b,c,e=[Poly(RATIO[k]).eval(q)for k in ['b','c','e']];u=ext.context([mul(3,e),mul(2,c),b]);_,A=residual_jet(E(q),u,74);ts=Tails(A,max_n=74)
  for n in range(71,75):
   arr=out.reshape(4,56,2)[n-71].copy();arr[:,1]=vm(arr[:,1],np.uint32(b));assert EP(arr)==ts.tail(n)
 results=[]
 for qv in [1,2,3]:
  out=np.zeros(6,dtype=np.uint32);assert lib.ft_dual_at_q(G.ravel(),625,qv,out,74)
  b,c,e=[Poly(RATIO[k]).eval(qv)for k in ['b','c','e']];p=Poly([mul(3,e),mul(2,c),b]).monic();vv=ext.context(p*p);delta=sum((E(p[i])*vv**i for i in range(len(p))),E());assert delta and not delta**2
  q=E(qv)+delta;b,c,e=[peval(RATIO[k],q)for k in ['b','c','e']];u=vv-(b*vv*vv+2*c*vv+3*e)/(2*b*vv+2*c);assert b*u*u+2*c*u+3*e==0
  rs=[]
  for uu in [u,3*c/b-u]:
   _,A=residual_jet(q,uu,74);ts=Tails(A,max_n=74);rs.append([ep_resultant(ts.tail(71),ts.tail(n))for n in range(72,75)])
  for i in range(3):assert rs[0][i]*rs[1][i]==E(int(out[2*i]))+delta*int(out[2*i+1])
  results.append({'q':qv,'norms_and_derivatives':out.tolist()})
 return {'complete_quadratic_q_fixtures':qs,'tail_indices':[71,72,73,74],'nonreduced_reference':'legacy jet circuit in K[v]/g_q(v)^2','dual_fixtures':results}

def coset_regressions(G):
 rng=np.random.default_rng(842817)
 for off in [0,25]:
  cf=rng.integers(0,390625,size=(625,3),dtype=np.uint32);v=np.zeros((625,3),dtype=np.uint32);d=v.copy();ns=np.zeros(625,dtype=np.uint32);assert lib.ft_coset_model(cf.ravel(),3,off,v.ravel(),d.ravel(),ns)
  for j in range(3):
   p=Poly(cf[:,j]);dp=p.derivative()
   for i in range(625):assert v[i,j]==p.eval(int(ns[i]))and d[i,j]==dp.eval(int(ns[i]))
 factors=json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors'];bounds=json.loads((ROOT/'data/resultant_pole_bounds.json').read_text())['resultants'];exps=np.zeros((3,len(factors)),dtype=np.int32)
 for n in range(72,75):
  for k,v in bounds[str(n)]['finite_valuation_lower_bounds'].items():exps[n-72,int(k)]=-v
  for k,f in enumerate(factors):
   if len(f)==2:exps[n-72,k]+=2
 assert lib.ft_set_normalization(np.array(sum(factors,[]),dtype=np.uint32),np.array(list(map(len,factors)),dtype=np.int32),len(factors),exps.ravel(),3)
 pack=G[:,:75,:,:].transpose(3,0,1,2).copy();out=np.zeros((625,6),dtype=np.uint32);assert lib.ft_coset_resultants(pack.ravel(),25,out.ravel(),74)
 ns=[25]+[add(25,power(power(25,626),j))for j in range(624)]
 for i in [0,1,2,20,61,420,624]:
  q=ns[i];raw=np.zeros(6,dtype=np.uint32);assert lib.ft_dual_at_q(G.ravel(),625,q,raw,74)
  for n in range(3):
   m=1;ld=0
   for k,f in enumerate(factors):
    f=Poly(f);fv=f.eval(q);fd=f.derivative().eval(q);p=int(exps[n,k]);m=mul(m,power(fv,p));ld=add(ld,mul(p%5,div(fd,fv)))
   v,dv=map(int,raw[2*n:2*n+2]);assert [mul(m,v),mul(m,add(dv,mul(v,ld)))]==out[i,2*n:2*n+2].tolist()
 return {'scalar_cosets':[0,25],'scalar_polynomials_per_coset':3,'scalar_degree':624,'all_1250_nodes_checked_by_horner':True,'source_coset_offset':25,'independent_source_coset_indices':[0,1,2,20,61,420,624]}

def field_regressions():
 rng=np.random.default_rng(8294817);N=390625;c=rng.integers(0,N,size=N,dtype=np.uint32);v=np.zeros(N,dtype=np.uint32);r=v.copy();assert lib.ft_field_evaluate(c,1,v)
 for q in [0,1,2,4,25,84831]:assert v[q]==Poly(c).eval(q)
 assert lib.ft_field_interpolate(v,1,r)and np.array_equal(r,c)
 dc=np.zeros(N,dtype=np.uint32);dc[:N-1]=vm(c[1:],np.arange(1,N,dtype=np.uint32)%5);dv=np.zeros(N,dtype=np.uint32);assert lib.ft_field_evaluate(dc,1,dv)
 B=np.zeros(N,dtype=np.uint32);B[:1024]=rng.integers(0,N,1024,dtype=np.uint32);B[-1]=14;bv=np.zeros(N,dtype=np.uint32);assert lib.ft_field_evaluate(B,1,bv)
 derivs=va(dv,vm(bv,np.uint32(4)));out=np.zeros(2*N,dtype=np.uint32);assert lib.ft_field_hermite(v,derivs,1,out)
 expected=np.zeros(2*N,dtype=np.uint32);expected[:N]=c;expected[1:N+1]=va(expected[1:N+1],vm(B,np.uint32(4)));expected[N:]=va(expected[N:],B);assert np.array_equal(out,expected)
 return {'complete_field_roundtrip_degree':N-1,'complete_hermite_degree':2*N-1,'seed':8294817,'direct_horner_check_q':[0,1,2,4,25,84831]}

def run():
 t=time.time();G=np.load(ROOT/'data/global_residual.npz')['coefficients'];result={'status':'passed labelled arithmetic regressions; these alone do not exclude geometric squares'}
 for name,fun in [('fixed_degree_dual',scalar_regressions),('source',lambda:source_regressions(G)),('cosets',lambda:coset_regressions(G)),('full_field',field_regressions)]:
  result[name]=fun();print('RESULTANT_ENGINE_REGRESSION_PASSED',name,round(time.time()-t,3),flush=True)
 result['seconds']=round(time.time()-t,3);(ROOT/'checks/resultant_engine.json').write_text(json.dumps(result,indent=2)+'\n');print('RESULTANT_ENGINE_ALL_REGRESSIONS_PASSED',flush=True)
if __name__=='__main__':run()
