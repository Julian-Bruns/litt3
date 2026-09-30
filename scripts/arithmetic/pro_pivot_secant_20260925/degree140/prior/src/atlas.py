"""Reconstruct the full normalized affine atlas from the original equations."""
import argparse,json,time
from pathlib import Path
import numpy as np
import exact as E
Prow=[11,22,18,5,19,20,15,16,9,22,1]
Arow=[1,21,14,22,13]
Qrow=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
Brow=[8,14,19,2,10,19,3,24,18,16]
Lrow=[18,20,20,15]

def fixed_data():
 F=E.F;P=E.poly(Prow);A=E.poly(Arow);Q=E.poly(Qrow);B=E.poly(Brow);L=E.poly(Lrow)
 t=E.exactdiv(E.scale(A,F.I(13)),E.poly([F.N(25),1]))
 Ct=E.exactdiv(E.sub(Q,E.power(L,5)),E.power(t,3))
 assert not len(E.sub(E.derivative(Q),E.mul(P,E.power(A,2))))
 assert not len(E.rem(E.sub(Q,E.power(B,5)),E.power(P,2)))
 assert not len(E.rem(E.sub(Q,E.power(L,5)),E.power(A,3)))
 return P,A,Q,B,L,t,Ct

def constraints(H):
 H2,H3,H4,H5=H;P,A,Q,B,L,t,Ct=fixed_data()
 out=[]
 expressions=[(3,E.csub(H3,E.cpoly(H2,E.scale(B,3)))),
  (4,E.cadd(E.csub(H4,E.cpoly(H3,E.scale(B,2))),E.cpoly(H2,E.scale(E.power(B,2),3)))),
  (5,E.csub(E.cadd(E.csub(H5,E.cpoly(H4,B)),E.cpoly(H3,E.power(B,2))),E.cpoly(H2,E.power(B,3))))]
 for j,g in expressions:
  for k in range(3):
   modulus=E.power(P,(j-k+2)//3)
   remainder=E.rem(g[k],modulus);row=np.zeros(len(modulus)-1,dtype=np.int32);row[:len(remainder)]=remainder;out.extend(row)
 S=E.cadd(E.csub(E.cpoly(H3,E.power(L,2)),E.cpoly(H2,E.power(L,3))),E.csub(H5,E.cpoly(H4,L)))
 d=E.cadd(E.csub(E.cpoly(H2,E.scale(E.power(L,2),3)),E.cpoly(H3,E.scale(L,2))),H4)
 for g,modulus in [(E.cpoly(S,Ct),E.power(t,2)),(d,t)]:
  for k in range(3):
   r=E.rem(g[k],modulus);row=np.zeros(len(modulus)-1,dtype=np.int32);row[:len(r)]=r;out.extend(row)
 return np.array(out,dtype=np.int32)

def image_basis(r):
 F=E.F;P,*_=fixed_data();d2=[]
 if r is None:
  d2=[E.monomial(i,0) for i in range(5)]+[E.monomial(0,1)]
 else:
  d2=[E.csub(E.monomial(i,0),E.monomial(0,0,F.P(r,i))) for i in range(1,5)]+[E.monomial(0,1),E.monomial(1,1)]
 basis=[]
 for d in d2:basis.append((E.cmul(E.monomial(0,2),d,P),E.czero(),E.czero(),E.czero()))
 for k,degree in [(1,46),(2,57),(3,70)]:
  for i,j in E.Lbasis(degree):
   if k==3 and (i,j) in [(20,1),(23,0)]:continue
   col=[E.czero() for _ in range(4)];col[k]=E.monomial(i,j);basis.append(tuple(col))
 return basis

def reconstruct(r,outfile):
 start=time.time();F=E.F;P,A,Q,B,L,t,Ct=fixed_data();basis=image_basis(r);n=len(basis)
 base=[E.czero(),E.czero(),E.czero(),E.monomial(20,1,F.M(4,F.I(int(Q[-1]))))]
 mat=np.column_stack([constraints(g) for g in basis]);rhs=F.negtable[constraints(base)]
 # Add the affine constant +y^10=P^3*y in the support condition.
 tail=np.zeros(27,dtype=np.int32);rP=E.rem(E.power(P,3),E.power(t,2));tail[6:6+len(rP)]=rP
 rhs[-27:]=F.sub(rhs[-27:],tail)
 top=np.zeros((4,n),dtype=np.int32)
 # a is x^4 y^2 in H2 for constant v, and x P(x) in H2's y^0 component for linear v.
 # The prescribed d2 basis makes a a direct coordinate.
 top[0,4 if r is None else 5]=1
 for j,g in enumerate(basis):
  top[1,j]=E.coeff(g[2],19,0);top[2,j]=E.coeff(g[2],12,2);top[3,j]=E.coeff(g[3],16,2)
 full=np.vstack([mat,top]);rr=np.zeros((len(rhs)+4,5),dtype=np.int32);rr[:len(rhs),0]=rhs;rr[-4:,1:]=np.eye(4,dtype=np.int32)
 sol,piv,free=E.solve_affine(full,rr);assert sol.shape[1]==7
 assert np.all(F.sub(_matmul(mat,sol),np.column_stack([rhs,np.zeros((len(rhs),6),dtype=np.int32)]))==0)
 result=[]
 for k in range(7):
  H=base if k==0 else [E.czero() for _ in range(4)]
  H=list(H)
  for j,c in enumerate(sol[:,k]):
   if c:
    for z in range(4):H[z]=E.cadd(H[z],E.cscale(basis[j][z],int(c)))
  result.append([[p.tolist() for p in g] for g in H])
 data={'field':'F25(alpha); beta^2=beta+3; alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0',
  'encoding':'sum_{i=0}^3 (a_i+5*b_i)*25^i', 'root':r,'columns':['base','a','d','e','f','s','u'],'data':result,'matrix_shape':list(full.shape),'rank':len(piv),'free_columns':free}
 Path(outfile).write_text(json.dumps(data,separators=(',',':'))+'\n')
 print(f"atlas v={'1' if r is None else 'x-'+str(r)}: {full.shape}, rank {len(piv)}, two kernel columns {free}; exact reconstruction checked in {time.time()-start:.2f}s",flush=True)
 return data

def _matmul(A,B):
 out=np.zeros((A.shape[0],B.shape[1]),dtype=np.int32)
 for k in range(A.shape[1]):out=E.F.add(out,E.F.mul(A[:,k,None],B[None,k,:]))
 return out

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--tables',required=True);ap.add_argument('--out',required=True);ap.add_argument('--all',action='store_true');args=ap.parse_args();E.init(args.tables);Path(args.out).mkdir(exist_ok=True,parents=True)
 roots=np.flatnonzero(E.evaluate(E.poly(Prow),np.arange(E.SIZE,dtype=np.int32))==0).tolist();assert len(roots)==10
 Path(args.out,'fixed.json').write_text(json.dumps({'P':Prow,'A':Arow,'Q':Qrow,'B0':Brow,'L0':Lrow,'alpha':25,'roots_P':roots},indent=2)+'\n')
 print('P roots:',roots,flush=True)
 reconstruct(None,Path(args.out,'atlas_constant.json'))
 if args.all:
  for j,r in enumerate(roots):reconstruct(r,Path(args.out,f'atlas_linear_{j}.json'))
