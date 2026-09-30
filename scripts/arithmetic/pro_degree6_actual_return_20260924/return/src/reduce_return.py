"""Exact constant elimination for the entire return matrix, over F25.

The resulting 123x51 matrix is valid over any extension field, with the
source coordinates eta_i = xi_i^25.  No root search or decision is made.
"""
from negative_quotient import *
from geometry import combine,evaluate,full_column
from pathlib import Path
import time
WROOT=Path(__file__).resolve().parents[1]/"data"

def lower(aa,ff,g0,q0,U,V):
 pp=add(aa,neg(mul(e,ff)));uf=mul(U,ff);wt=tail(uf)
 chi=add(mul(e,g0),mul(e,wt),neg(mul(U,aa)))
 gg=add(g0,neg(pos(uf)));qq=add(q0,pos(chi))
 rb=add(mul(E,add(g0,wt)),mul(V,ff));hh=neg(pos(rb))
 ra=add(neg(mul(e,hh)),mul(E,add(q0,neg(tail(chi)))),mul(V,pp));rr=neg(pos(ra))
 return (gg,qq,hh,rr),np.concatenate((vec(rb,bm144),vec(ra,bm155)))

def negarr(a):return NEG[a]
def sumarr(*args):
 out=np.zeros_like(args[0])
 for a in args:out=ADD[out,a]
 return out

def build_reduced(output_dir=None):
 start=time.time()
 D=np.load(ROOT/'hom_tensor.npz');A,B,T=D['A'],D['B'],D['T']
 Ra,piv=rref(np.column_stack([A,np.eye(315,dtype=np.uint8)]),235);assert len(piv)==235
 SA,LA=Ra[:235,235:],Ra[235:,235:];assert np.array_equal(matmul(SA,A),np.eye(235,dtype=np.uint8));assert np.array_equal(LA,D['L'])
 Dlower=NEG[np.array([matmul(SA,Bj) for Bj in B])]
 N=np.load(WROOT/'negative_second.npz');AN,SN,LN,BN,QN=N['A'],N['S'],N['L'],N['B'],N['Q']
 assert np.array_equal(matmul(SN,AN),np.eye(116,dtype=np.uint8));assert not matmul(LN,AN).any()
 lowkeys=[(i,j) for j in range(3) for i in range(6)]
 negkeys=[(i,j) for j in range(3) for i in range(-6,0)]
 obs=bas1(-151);pstar=(5,14)
 ev=lambda p:evaluate(p,*pstar)
 evp=lambda p:ev(pos(p))
 # Scalar evaluation on Laurent polynomials, at a nonzero x.
 def evl(p):
  out=0
  for (i,j),c in p.items():
   xx=power(mono(c=5),i) if i>=0 else power(mono(c=int(INV[5])),-i)
   yy=power(mono(c=14),j)
   v=mul(xx,yy).get((0,0),0);out=int(ADD[out,MUL[c,v]])
  return out
 # g,q,h,r in that order; 18 low coefficients and one evaluation.
 def encode(H):return np.stack([np.append(vec(p,lowkeys),ev(p)) for p in H]).astype(np.uint8)
 Const=np.zeros((4,19,235),np.uint8)
 for l,m in enumerate(b131+b120):
  H,res=lower({},{},mono(*m) if l<123 else {},{} if l<123 else mono(*m),{},{})
  assert np.array_equal(res,A[:,l]);Const[:,:,l]=encode(H)
 print('constant lower matrix checked',round(time.time()-start,2),flush=True)
 source=[];powers=[]
 for j,m in enumerate(u_keys+v_keys):
  U,V=(power(mono(*m),25),{}) if j<6 else ({},power(mono(*m),25));powers.append((U,V))
  Z=np.zeros((4,19,35),np.uint8)
  for l,(aa,ff) in enumerate(sections):
   H,res=lower(aa,ff,{},{},U,V);assert np.array_equal(res,B[j,:,l]);Z[:,:,l]=encode(H)
  Z=ADD[Z,matmul(Const.reshape(76,235),Dlower[j]).reshape(4,19,35)]
  source.append(Z)
  print('lower source',j,round(time.time()-start,2),flush=True)
 source=np.array(source)
 # target monomial operators, all exact on polynomial inputs
 M=[];MP=[];Nop=[];NP=[];Tail=[];Vtarget=[];Wminus=[];Wplus=[]
 for i,m in enumerate(u_keys+v_keys):
  z=mono(*m);Vtarget.append(evl(z))
  Mp=[];Np=[];tailval=[];Mpval=[];Npval=[]
  for n in lowkeys:
   zz=mul(z,mono(*n));zzneg=tail(zz);Ez=mul(E,zzneg)
   Mp.append(vec(zz,obs));Np.append(vec(Ez,obs));tailval.append(evl(zzneg));Mpval.append(evp(zz));Npval.append(evp(Ez))
  M.append(np.array(Mp,np.uint8).T);Nop.append(np.array(Np,np.uint8).T);Tail.append(tailval);NP.append(Npval)
  wm=[];wp=[]
  for aa,ff in sections:
   w=mul(z,aa if i<6 else ff);assert all(n in negkeys for n in tail(w))
   wm.append(vec(w,negkeys));wp.append(evp(w))
  Wminus.append(np.array(wm,np.uint8).T);Wplus.append(wp)
 M=np.array(M);Nop=np.array(Nop);Tail=np.array(Tail,np.uint8);NP=np.array(NP,np.uint8)
 Wminus=np.array(Wminus);Wplus=np.array(Wplus,np.uint8);Vtarget=np.array(Vtarget,np.uint8)
 # The source cochain Gamma_j(b)= E*(U_j*b)_- + V_j*b, on the 18 negative monomials.
 Gamma=[];GammaP=[];UPneg=[]
 for j,(U,V) in enumerate(powers):
  GG=[];GP=[];UP=[]
  for m in negkeys:
   z=mono(*m);Uz=mul(U,z);g=add(mul(E,tail(Uz)),mul(V,z))
   GG.append(vec(g,obs));GP.append(evp(g));UP.append(evp(Uz))
  Gamma.append(np.array(GG,np.uint8).T);GammaP.append(GP);UPneg.append(UP)
  print('top source',j,round(time.time()-start,2),flush=True)
 Gamma=np.array(Gamma);GammaP=np.array(GammaP,np.uint8);UPneg=np.array(UPneg,np.uint8)
 tev=np.array([ev(mono(*m)) for m in bas0(124)],np.uint8)
 Etpos=np.array([evp(mul(E,mono(*m))) for m in bas0(124)],np.uint8)
 sev=np.array([ev(mono(*m)) for m in bas0(24)],np.uint8)
 # Scalar upper-row evaluation tensors and reduced regularity tensor.
 C=np.zeros((19,19,43,35),np.uint8)
 HC=np.zeros((19,19,2,35),np.uint8)
 TC=np.zeros((19,19,116,35),np.uint8)
 for i in range(19):
  for j in range(19):
   low=source[j];qr=1 if i<6 else 0;rh=3 if i<6 else 2
   raw=NEG[sumarr(matmul(M[i],low[rh,:18]),matmul(Nop[i],low[qr,:18]),matmul(Gamma[j],Wminus[i]))]
   C[i,j]=matmul(LN,raw);tc=NEG[matmul(SN,raw)];TC[i,j]=tc
   # (u*q or v*g)_+ + (U_j*w_i)_+ gives w1_+.
   w1p=sumarr(MUL[Vtarget[i],low[qr,18]][None,:],NEG[matmul(Tail[i][None,:],low[qr,:18])],matmul(UPneg[j][None,:],Wminus[i]))
   # raw = -u*r-v*h-E*(u*q+v*g)_- - Gamma_j(w_i)
   rawp=NEG[sumarr(MUL[Vtarget[i],low[rh,18]][None,:],NEG[matmul(Tail[i][None,:],low[rh,:18])],matmul(NP[i][None,:],low[qr,:18]),matmul(GammaP[j][None,:],Wminus[i]))]
   HC[i,j,0]=ADD[matmul(tev[None,:],tc),w1p][0]
   HC[i,j,1]=NEG[ADD[matmul(Etpos[None,:],tc),rawp]][0]
 print('all 361 mixed coefficient blocks built',round(time.time()-start,2),flush=True)
 HS=np.zeros((19,2,16),np.uint8);TS=NEG[np.array([matmul(SN,Bj) for Bj in BN])]
 for j,(U,V) in enumerate(powers):
  up=[];gp=[]
  for m in bas0(24):
   z=mono(*m);Uz=mul(U,z);g=add(mul(E,tail(Uz)),mul(V,z))
   up.append(evp(Uz));gp.append(evp(g))
  HS[j,0]=ADD[matmul(tev[None,:],TS[j]),NEG[np.array(up,np.uint8)][None,:]][0]
  HS[j,1]=NEG[ADD[matmul(Etpos[None,:],TS[j]),np.array(gp,np.uint8)[None,:]]][0]
 first=np.array([[ev(aa),ev(ff)] for aa,ff in sections],np.uint8).T
 out={'T':T,'Q':QN,'C':C,'lower_recovery':Dlower,'t_recovery_c':TC,'t_recovery_s':TS,'SA':SA,'LA':LA,'SN':SN,'LN':LN,
  'lower_at_point':source[:, :,18,:],'first_at_point':first,'top_first_c':Wplus,'top_first_s':sev,'top_other_c':HC,'top_other_s':HS}
 np.savez_compressed((Path(output_dir) if output_dir is not None else WROOT)/'reduced_return.npz',**out)
 print('saved reduced_return.npz; shape 123x51; no ideals solved',round(time.time()-start,2),flush=True)
 return out
if __name__=='__main__':build_reduced()
