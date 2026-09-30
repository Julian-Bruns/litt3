"""Exact Laurent infinity normalization through F6."""
from reconstruct import *
def sc(a,c):return [pscale(p,c) for p in a]
def sa(a,b):return [padd(p,q) for p,q in zip(a,b)]
def sm(a,b):
 n=len(a);c=[{} for _ in range(n)]
 for i,p in enumerate(a):
  for j,q in enumerate(b[:n-i]):
   if p and q:c[i+j]=padd(c[i+j],pmul(p,q))
 return c
def sp(a,k):
 n=len(a);b=[pone(4)]+[{} for _ in range(n-1)]
 while k:
  if k&1:b=sm(b,a)
  k//=2
  if k:a=sm(a,a)
 return b
def ss(a,k):return [{} for _ in range(k)]+a[:len(a)-k]
def extract_linear(p):
 a=[{}, {}, {}]
 for (h,w,u,v),c in p.items():
  assert u+v<=1;j=1 if u else 2 if v else 0;a[j][(h,w)]=c
 return a
def substitute_uv(p,U,V):
 ans={}
 for (h,w,u,v),c in p.items():
  term={(h,w):c}
  if u:term=pmul(term,ppow(U,u,2))
  if v:term=pmul(term,ppow(V,v,2))
  ans=padd(ans,term)
 return ans
def main():
 data=json.loads((ROOT/'data'/'affine_source.json').read_text())
 const=pone(4);h={(1,0,0,0):1};w={(0,1,0,0):1};u={(0,0,1,0):1};v={(0,0,0,1):1};zz=div(2,EPS)
 ecoef={(0,2,0,0):neg(mul(CD,zz)),(0,-1,0,0):neg(div(ETA,mul(24,zz)))}
 fcoef={(0,2,0,0):neg(inv(EPS)),(0,5,0,0):neg(mul(div(8,24),power(zz,5)))}
 parameters=[const,h,w,ecoef,fcoef,u,v];gs=[{} for _ in range(4)]
 for (g,i,j),row in zip(data['columns'],data['affine_source']):
  cp={}
  for a,b in zip(row,parameters):cp=padd(cp,pscale(b,a))
  mono=red({(i,j+2):1}) if g==0 else {(i,j):1}
  for (ix,jy),cc in mono.items():
   for hp,c in cp.items():
    key=(ix,jy,*hp);gs[g][key]=add(gs[g].get(key,0),mul(c,cc))
 gs=[{m:c for m,c in g.items() if c} for g in gs];prec=7
 Y=[pone(4)]+[{} for _ in range(prec-1)];Y[3]={(0,)*4:div(Prow[9],3)};Y[6]={(0,)*4:div(sub(Prow[8],mul(3,power(div(Prow[9],3),2))),3)}
 yp=[[pone(4)]+[{} for _ in range(prec-1)],Y,sm(Y,Y)]
 def infinity(g,pole):
  out=[{} for _ in range(prec)]
  for (i,j,*hp),c in g.items():
   n=pole-3*i-10*j;assert n>=0,(pole,i,j)
   for k in range(max(0,prec-n)):
    if yp[j][k]:out[n+k]=padd(out[n+k],pmul({tuple(hp):c},yp[j][k]))
  return out
 aas=sc(infinity(gs[0],35),3);bbs=sc(infinity(gs[1],46),2);ccs=infinity(gs[2],57)
 assert not aas[0] and bbs[0]=={(0,)*4:mul(2,EPS)}
 rho=[{} for _ in range(prec)]
 for n in range(prec):rho[n]=pscale(sa(sa(sm(aas,sm(rho,rho)),sm(bbs,rho)),ccs)[n],neg(inv(mul(2,EPS))))
 assert rho[0]=={(0,1,0,0):zz};assert all(not f for f in sa(sa(sm(aas,sm(rho,rho)),sm(bbs,rho)),ccs))
 def lift_numeric(g):return {(i,j,0,0,0,0):c for (i,j),c in g.items()}
 F=sa(sm(sa(infinity(lift_numeric(Q),57),ss(sp(rho,5),2)),sa(infinity(gs[3],70),ss(sa(sm(aas,sp(rho,3)),sc(sm(bbs,sp(rho,2)),2)),2))),infinity(lift_numeric(cmul(t3,N)),127))
 assert all(not z for z in F[:4])
 a,aU,aV=extract_linear(F[4]);b,bU,bV=extract_linear(F[5]);det=psub(pmul(aU,bV),pmul(aV,bU));assert len(det)==1 and next(iter(det))[0]==0
 dm,dc=next(iter(det.items()));U=pscale(pshift(psub(pmul(aV,b),pmul(a,bV)),tuple(-k for k in dm)),inv(dc));V=pscale(pshift(psub(pmul(a,bU),pmul(aU,b)),tuple(-k for k in dm)),inv(dc))
 assert not substitute_uv(F[4],U,V) and not substitute_uv(F[5],U,V)
 Fn=substitute_uv(F[6],U,V);an=[89654,311173,214299,163299,315361,33043,356725,245794]
 expected={(0,3*i-3):mul(a,inv(power(299619,2))) for i,a in enumerate(an)}
 for m,c in [((1,1),299833),((1,4),232505)]:expected[m]=mul(c,inv(power(299619,2)))
 assert Fn==expected
 hats=[];normalized=[]
 for g in gs:
  out={}
  for (i,j,hp,wp,up,vp),c in g.items():
   for (hh,ww),cc in substitute_uv({(hp,wp,up,vp):c},U,V).items():
    key=(i,j,hh,ww);out[key]=add(out.get(key,0),cc)
  out={m:c for m,c in out.items() if c};normalized.append(out);hat={}
  for (i,j,hh,ww),c in out.items():
   wexp=ww-hh+j-1;assert wexp%3==0
   key=(i,j,hh,wexp//3);hat[key]=add(hat.get(key,0),c)
  hats.append({m:c for m,c in hat.items() if c})
 result={'variables':['x','z_c','H','q'],'field_codes':'K tower codes','Ghat':[dumps(g) for g in hats],'normalized_variables':['x','y','h','w'],'normalized_G':[dumps(g) for g in normalized],'kernel_variables':['h','w'],'kernel_u':dumps(U),'kernel_v':dumps(V),'F6':dumps(Fn),'infinity_F4':dumps(F[4]),'infinity_F5':dumps(F[5]),'kernel_determinant':dumps(det)}
 (ROOT/'data'/'normalized_source.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
 evidence={'F0_to_F5_zero':True,'F6_matches_given_Psi':True,'kernel_determinant':dumps(det),'kernel_term_counts':[len(U),len(V)],'Ghat_term_counts':list(map(len,hats)),'cube_root_invariance_all_terms':True}
 (ROOT/'evidence'/'normalization_checks.json').write_text(json.dumps(evidence,indent=2)+'\n');print(json.dumps(evidence),flush=True)
if __name__=='__main__':main()
