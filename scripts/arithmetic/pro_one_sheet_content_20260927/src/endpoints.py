"""Reconstruct the three sparse content curves and all four rational-scale branches."""
from reconstruct import *
ZETA=11;ENDPOINTS=[145049,211895,211959]
def load_hats():return [loads(g) for g in json.loads((ROOT/'data'/'normalized_source.json').read_text())['Ghat']]
def lift4(a):return {(i,j,0,0):c for (i,j),c in a.items()}
def evalx(f,r):
 ans=0
 for (i,j),c in f.items():assert not j;ans=add(ans,mul(c,power(r,i)))
 return ans
def evalmark(f,r,derivative=False):
 pr=evalx(P,r);pp=evalx(pderiv(P,0),r);tr=evalx(pderiv(t,0),r);out={}
 for (i,j,h,q),c in f.items():
  if derivative:
   xx=mul(i%5,power(r,i-1)) if i%5 else 0
   if j%5:xx=add(xx,mul(mul(j%5,power(r,i)),div(pp,mul(3,pr))))
   cc=mul(c,div(xx,tr))
  else:cc=mul(c,power(r,i))
  cc=mul(cc,power(pr,q));key=(j-3*q,h);out[key]=add(out.get(key,0),cc)
 return {m:c for m,c in out.items() if c}
def splitH(f):
 assert max(h for v,h in f)<=1
 return [{(v,0):c for (v,h),c in f.items() if h==k} for k in [0,1]]
def substH(f,num,den):
 a,b=splitH(f);return padd(pmul(a,den),pmul(b,num))
def phase(f,j):return {(v,h):mul(c,power(ZETA,j*v)) for (v,h),c in f.items()}
def main():
 G2,G3,G4,G5=load_hats();LL=lift4(L0);b=pscale(psub(G3,pscale(pmul(LL,G2),3)),2)
 c=padd(psub(G4,pscale(pmul(LL,G3),2)),pscale(pmul(ppow(LL,2),G2),3))
 d=psub(padd(psub(G5,pmul(LL,G4)),pmul(ppow(LL,2),G3)),pmul(ppow(LL,3),G2))
 c1=pdivide_univ(c,{i:u for (i,j),u in t.items()})[0]
 ell=pdivide_univ(padd(pmul(lift4(M),d),lift4(N)),{i:u for (i,j),u in t2.items()})[0];aa=pscale(G2,3);out=[]
 for r in ENDPOINTS:
  pr=evalx(P,r);m=evalx(M,r);m1=div(evalx(pderiv(M,0),r),evalx(pderiv(t,0),r));assert not evalx(t,r) and pr and m
  B,C,E,D=[evalmark(f,r) for f in [b,c1,ell,d]];assert D=={(1,0):neg(div(power(pr,3),m))};assert [len(f) for f in [B,C,E]]==[10,10,10]
  Bs=splitH(B);Cs=splitH(C);Es=splitH(E);delta=psub(pmul(Bs[1],Cs[0]),pmul(Bs[0],Cs[1]));zn={(0,1):1}
  num=psub(Cs[0],pmul(Bs[0],zn));den=psub(pmul(Bs[1],zn),Cs[1])
  g=padd(padd(psub(pscale(pmul(delta,ppow(zn,2)),mul(2,m)),pmul(pmul(D,Bs[1]),ppow(zn,6))),pmul(pmul(D,Cs[1]),ppow(zn,5))),padd(pmul(psub(pmul(Es[0],Bs[1]),pmul(Es[1],Bs[0])),zn),psub(pmul(Es[1],Cs[0]),pmul(Es[0],Cs[1]))))
  assert len(g)==34 and min(v for v,z in g)==-8 and max(v for v,z in g)==7
  j=padd(psub(pmul(ppow(B,5),E),pmul(D,ppow(C,5))),pscale(pmul(ppow(B,4),ppow(C,2)),mul(2,m)));assert len(j)==311
  hom={}
  for (vv,zz),cc in g.items():hom=padd(hom,pshift(pscale(pmul(ppow(C,zz),ppow(B,6-zz)),cc),(vv,0)))
  assert hom==pmul(delta,j)
  b1,c2,d1,l1=[evalmark(f,r,True) for f in [b,c1,d,ell]];Ap=evalmark(aa,r);assert substH(B,num,den)==delta
  kap=padd(substH(l1,num,den),pneg(pmul(substH(d1,num,den),ppow(zn,5))))
  kap=padd(kap,pmul(padd(pscale(delta,mul(2,m1)),pscale(substH(b1,num,den),mul(3,m))),ppow(zn,2)))
  kap=psub(kap,pscale(pmul(substH(Ap,num,den),ppow(zn,3)),mul(2,m)));kap=psub(kap,pscale(pmul(substH(c2,num,den),zn),m))
  branches=[{'name':'small','numerator':dumps(pneg(kap)),'denominator':dumps(pscale(den,power(m,2))),'extra_denominator_open':'none beyond den'}]
  for phase_index in range(3):
   aj,bj,dj=[phase(f,phase_index) for f in [Ap,B,D]];au,bu,du=[substH(f,num,den) for f in [aj,bj,dj]];dn=splitH(dj)[0]
   sn=padd(pmul(ppow(au,3),ppow(bu,3)),pmul(pmul(den,ppow(au,5)),dn));sd=pmul(den,ppow(bu,5))
   branches.append({'name':'large_'+str(phase_index),'numerator':dumps(sn),'denominator':dumps(sd),'B_numerator':dumps(bu)})
  out.append({'r':r,'P_r':pr,'M_r':m,'dM_dt_r':m1,'B':dumps(B),'C':dumps(C),'E':dumps(E),'D':dumps(D),'A':dumps(Ap),'b1':dumps(b1),'c2':dumps(c2),'d1':dumps(d1),'ell1':dumps(l1),'Delta':dumps(delta),'H_numerator':dumps(num),'H_denominator':dumps(den),'G':dumps(g),'branches':branches})
  print('endpoint',r,'curve_terms',len(g),'incidence_terms',len(j),'scale_term_counts',[(len(v['numerator']),len(v['denominator'])) for v in branches],flush=True)
 (ROOT/'data'/'endpoint_curves.json').write_text(json.dumps({'variables':['v','z'],'local_variables':['v','H'],'endpoints':out},separators=(',',':'))+'\n')
 checks={'endpoints':ENDPOINTS,'ten_term_local_values_verified':True,'each_curve_terms':34,'each_incidence_terms':311,'homogeneous_identity_verified_all_three':True,'scales':'constructed exactly; not square witnesses'}
 (ROOT/'evidence'/'endpoint_checks.json').write_text(json.dumps(checks,indent=2)+'\n')
if __name__=='__main__':main()
