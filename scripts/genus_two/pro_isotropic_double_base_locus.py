#!/usr/bin/env python3
"""Exact characteristic-five certificate for a Cartier-plane curve component.

Run: python cartier_double_point_certificate.py [--report output.json]
Requires Python 3 and NumPy. No network, Sage, or database is used.

Field encoding: [a0+5*a1+25*a2] = a0+a1*alpha+a2*alpha^2,
where alpha^3+alpha+1=0. All polynomial coefficient arrays are ascending.

This file verifies a specific embedded plane, its divisor and determinant,
a nonzero deformation Jacobian, and the first jet of its algebraic curve
component. It is NOT a bounded-field classification search. The exhaustive
geometric presentation and algebraic component equations are in README.txt.
"""
import numpy as np, itertools, time, json
p=5;q=125
co=np.array([[x%5,(x//5)%5,x//25] for x in range(q)],dtype=np.int16)
add=np.zeros((q,q),dtype=np.int16);mul=np.zeros_like(add)
for a in range(q):
 for b in range(q):
  c=(co[a]+co[b])%5;add[a,b]=int(c[0]+5*c[1]+25*c[2])
  z=np.convolve(co[a],co[b]).astype(int)
  for i in [4,3]:z[i-2]-=z[i];z[i-3]-=z[i]
  z%=5;mul[a,b]=int(z[0]+5*z[1]+25*z[2])
neg=np.array([next(b for b in range(q) if add[a,b]==0) for a in range(q)],dtype=np.int16)
inv=np.zeros(q,dtype=np.int16)
for a in range(1,q):inv[a]=np.nonzero(mul[a]==1)[0][0]
def ad(a,b):return int(add[a,b])
def mu(a,b):return int(mul[a,b])
def ne(a):return int(neg[a])
def pw(a,n):
 z=1
 while n:
  if n%2:z=mu(z,a)
  a=mu(a,a);n//=2
 return z
fifth=np.array([pw(a,5) for a in range(q)],dtype=np.int16)
def trim(a):
 a=list(map(int,a))
 while len(a)>1 and a[-1]==0:a.pop()
 return a
def padd(a,b):
 c=[0]*max(len(a),len(b))
 for i,x in enumerate(a):c[i]=ad(c[i],x)
 for i,x in enumerate(b):c[i]=ad(c[i],x)
 return trim(c)
def pneg(a):return [ne(x) for x in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([mu(x,c) for x in a])
def pmul(a,b):
 z=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  if not x:continue
  for j,y in enumerate(b):z[i+j]=ad(z[i+j],mu(x,y))
 return trim(z)
def pdiv(a,b):
 a=trim(a);b=trim(b)
 if b==[0]:raise ZeroDivisionError()
 out=[0]*max(1,len(a)-len(b)+1)
 bi=int(inv[b[-1]])
 for i in range(len(a)-len(b),-1,-1):
  c=mu(a[i+len(b)-1],bi);out[i]=c
  for j,x in enumerate(b):a[i+j]=ad(a[i+j],ne(mu(c,x)))
 return trim(out),trim(a)
def pmod(a,b):return pdiv(a,b)[1]
def pdiff(a):return trim([mu(i%5,a[i]) for i in range(1,len(a))] or [0])
def peval(a,x):
 z=0
 for c in a[::-1]:z=ad(mu(z,x),c)
 return z
def pgcd(a,b):
 while trim(b)!=[0]:a,b=b,pmod(a,b)
 return pscale(a,int(inv[a[-1]]))
def kernel(mat):
 a=np.array(mat,dtype=np.int16).copy();m,n=a.shape;r=0;piv=[]
 for j in range(n):
  nz=np.flatnonzero(a[r:,j])
  if not len(nz):continue
  k=r+int(nz[0]);a[[r,k]]=a[[k,r]]
  a[r]=mul[a[r],inv[a[r,j]]]
  for i in range(m):
   if i!=r and a[i,j]:a[i]=add[a[i],neg[mul[a[i,j],a[r]]]]
  piv.append(j);r+=1
  if r==m:break
 out=[]
 for j in range(n):
  if j not in piv:
   v=np.zeros(n,dtype=np.int16);v[j]=1
   for i,c in enumerate(piv):v[c]=neg[a[i,j]]
   out.append(v)
 return out
T=5
F=[1]
for x in [0,1,2,3,T]:F=pmul(F,[ne(x),1])
F2=pmul(F,F)
print('F',F,flush=True)
Hmat=[[F2[j-i] if 0<=j-i<len(F2) else 0 for i in range(8)] for j in [4,9,14]]
HB=kernel(Hmat)
print('Hbasis', [list(map(int,h)) for h in HB],flush=True)
raw=[]
for h in HB:raw.append((trim(h),[0],pmul(F2,h)))
for i in range(4):raw.append(([0],[0]*i+[1],None))

def solve(mat,b):
 a=np.column_stack([mat,b]).astype(np.int16);m,n1=a.shape;n=n1-1;r=0;piv=[]
 for j in range(n):
  nz=np.flatnonzero(a[r:,j])
  if not len(nz):continue
  k=r+int(nz[0]);a[[r,k]]=a[[k,r]];a[r]=mul[a[r],inv[a[r,j]]]
  for i in range(m):
   if i!=r and a[i,j]:a[i]=add[a[i],neg[mul[a[i,j],a[r]]]]
  piv.append(j);r+=1
 if any(not any(row[:n]) and row[n] for row in a):raise RuntimeError('Inconsistent')
 if len(piv)<n:raise RuntimeError('Underdetermined')
 z=np.zeros(n,dtype=np.int16)
 for i,j in enumerate(piv):z[j]=a[i,n]
 return z
hit=dict(d=[51,97,1], e=[44,24], H=[30,19,22,59,31,21,110,42], Ader=[48,9,28,1], q=[14,123,1], good=True)
d,e,H,A,qq=[hit[k] for k in ['d','e','H','Ader','q']]
Dpts=[(x,peval(e,x)) for x in range(q) if peval(d,x)==0]
Qpts=[(x,mu(ne(peval(H,x)),int(inv[peval(A,x)]))) for x in range(q) if peval(qq,x)==0]
print('D points',Dpts,'Q points',Qpts)
print('d1',[int(fifth[x]) for x in d], 'e1',[int(fifth[x]) for x in e])
print('D1points',[(int(fifth[x]),int(fifth[y])) for x,y in Dpts])
print('q1 polynomial',[int(fifth[x]) for x in qq])
# Polynomial primitive
BP=[]
for i in range(6):
 b=[0]*i+[1];BP.append(padd(pmul(F,pdiff(b)),pscale(pmul(pdiff(F),b),3)))
B=solve(np.array([b+[0]*(9-len(b)) for b in BP]).T,np.array(H+[0]*(9-len(H))))
AP=[0]+[mu(A[i],int(inv[(i+1)%5])) for i in range(len(A))]
print('primitive A',AP,'B',list(map(int,B)))
print('normN',psub(pmul(H,H),pmul(F,pmul(A,A))))
a=[int(fifth[d[0]])]+[0]*4+[int(fifth[d[1]])]+[0]*4+[1]
b=[int(fifth[e[0]])]+[0]*4+[int(fifth[e[1]])]
N=psub(pmul(H,H),pmul(F,pmul(A,A)));n,rem=pdiv(N,a);assert rem==[0]
print('a',a,'n',n,'lead',n[-1], 'lead H7 sq',mu(H[7],H[7]))
assert n==pscale(pmul(qq,qq),mu(H[7],H[7]))
# kernel coefficients
cols=[];quot=[]
for hh,aa,v in raw:
 v=v if v is not None else pmul(b,aa)
 quot0,rem=pdiv(v,a);cols.append(rem+[0]*(10-len(rem)));quot.append(quot0)
M=np.array(cols).T
k=kernel(M)[0];HH=[0];AA=[0]
for kk,(hh,aa,_) in zip(k,raw):HH=padd(HH,pscale(hh,int(kk)));AA=padd(AA,pscale(aa,int(kk)))
assert HH==H and AA==A
print('kernel',list(map(int,k)))
F1=[int(fifth[x]) for x in F]
(X1,Y1),(X2,Y2)=[(int(fifth[x]),int(fifth[y])) for x,y in Dpts]
E1=int(fifth[e[1]])
sl1=mu(peval(pdiff(F1),X1),int(inv[mu(2,Y1)]))
sl2=mu(peval(pdiff(F1),X2),int(inv[mu(2,Y2)]))
deninv=int(inv[ad(X1,ne(X2))])
J=[];ddata=[]
for which in [1,2]:
 if which==1:
  dd0=X2;dd1=4;de1=mu(ad(sl1,ne(E1)),deninv);de0=ad(ad(sl1,ne(mu(de1,X1))),ne(E1))
 else:
  dd0=X1;dd1=4;de1=mu(ad(E1,ne(sl2)),deninv);de0=ne(mu(de1,X1))
 da=[dd0]+[0]*4+[dd1];db=[de0]+[0]*4+[de1]
 Mder=[]
 for q0,(_,aa,v) in zip(quot,raw):
  dv=[0] if v is not None else pmul(db,aa)
  rr=pmod(psub(dv,pmul(q0,da)),a);Mder.append(rr+[0]*(10-len(rr)))
 Md=np.array(Mder).T
 rhs=np.zeros(10,dtype=np.int16)
 for i in range(10):
  for j in range(9):rhs[i]=add[rhs[i],neg[mul[Md[i,j],k[j]]]]
 kd=solve(np.vstack([M,[0]*8+[1]]),np.append(rhs,0))
 dH=[0];dA=[0]
 for kk,(hh,aa,_) in zip(kd,raw):dH=padd(dH,pscale(hh,int(kk)));dA=padd(dA,pscale(aa,int(kk)))
 dN=pscale(psub(pmul(H,dH),pmul(F,pmul(A,dA))),2)
 dn,rrem=pdiv(psub(dN,pmul(n,da)),a);assert rrem==[0]
 dn += [0]*(5-len(dn));nc=pscale(n,int(inv[n[-1]]))
 dnc=pscale(psub(dn,pscale(nc,dn[-1])),int(inv[n[-1]]));dnc += [0]*(5-len(dnc))
 dq1=mu(3,dnc[3]);dq0=mu(3,ad(dnc[2],ne(mu(2,mu(qq[1],dq1)))))
 dE1=ad(dnc[1],ne(mu(2,ad(mu(qq[0],dq1),mu(qq[1],dq0)))))
 dE0=ad(dnc[0],ne(mu(2,mu(qq[0],dq0))))
 J.append([dE0,dE1]);ddata.append(dict(da=da,db=db,dk=list(map(int,kd)),dH=dH,dA=dA,dn=dn,dnc=dnc,dE=[dE0,dE1]))
print('Jac columns',J)
det=ad(mu(J[0][0],J[1][1]),ne(mu(J[1][0],J[0][1])))
print('Jac determinant',det)
assert det!=0
out=dict(seed=hit,Dpoints=Dpts,Qpoints=Qpts,primitive_A=AP,primitive_B=list(map(int,B)),natural_D_poly=[int(fifth[x]) for x in d],natural_E_poly=[int(fifth[x]) for x in e],Jacobian_columns=J,Jacobian_determinant=det,derivative_data=ddata)

# residue v on Q and Mumford determinant
# Extended Euclidean inverse for polynomials
def pinv(a,m):
 r0,r1=m,pmod(a,m);t0,t1=[0],[1]
 while r1!=[0]:
  q0,r2=pdiv(r0,r1);r0,r1=r1,r2;t0,t1=t1,psub(t0,pmul(q0,t1))
 if len(r0)!=1:raise RuntimeError('not a unit')
 return pmod(pscale(t0,int(inv[r0[0]])),m)
eQ=pmod(pscale(pmul(H,pinv(A,qq)),4),qq)
print('eQ',eQ,'F-eQsq modq',pmod(psub(F,pmul(eQ,eQ)),qq))
disc=ad(mu(qq[1],qq[1]),ne(mu(4,qq[0])))
print('Q disc',disc,'Euler',pw(disc,62))
# natural Frobenius Q divisor
print('eQ1',[int(fifth[x]) for x in eQ])
# Full 12 dimensional exact-differential basis
HBF=kernel([[F2[j-i] if 0<=j-i<len(F2) else 0 for i in range(9)] for j in [4,9,14]])
RF=[(trim(h),[0],pmul(F2,h)) for h in HBF]+[([0],[0]*i+[1],None) for i in [0,1,2,3,5,6]]
print('full H basis',[list(map(int,h)) for h in HBF])
MC=[]
for hh,aa,vv in RF:
 rr=pmod(vv if vv is not None else pmul(b,aa),a);MC.append(rr+[0]*(10-len(rr)))
MF=np.array(MC).T
# rows J0, J1, J2, normalization A3
j0=np.array([aa[6] if len(aa)>6 else 0 for hh,aa,vv in RF],dtype=np.int16)
j1=np.array([hh[8] if len(hh)>8 else 0 for hh,aa,vv in RF],dtype=np.int16)
j2=np.array([mu(2,aa[5]) if len(aa)>5 else 0 for hh,aa,vv in RF],dtype=np.int16)
normal=np.array([aa[3] if len(aa)>3 else 0 for hh,aa,vv in RF],dtype=np.int16)
fullmat=np.vstack([MF,j0,j1,j2,normal]);rhs=np.array([0]*13+[1],dtype=np.int16)
kfull=solve(fullmat,rhs)
print('full k',list(map(int,kfull)))
# row pivot indices for explicit Cramer solution
chosen=[]
for i in range(14):
 cand=chosen+[i]
 if len(kernel(fullmat[cand,:].T))==0:chosen.append(i)
 if len(chosen)==12:break
print('independent rows (0 based)',chosen)
# partial z variation, fixing D1. J2_z at base = 6 H7 = H7.
rz=np.array([0]*14,dtype=np.int16);rz[12]=neg[H[7]]
kz=solve(fullmat,rz)
dHz=[0];dAz=[0]
for kk,(hh,aa,_) in zip(kz,RF):dHz=padd(dHz,pscale(hh,int(kk)));dAz=padd(dAz,pscale(aa,int(kk)))
dNz=pscale(psub(pmul(H,dHz),pmul(F,pmul(A,dAz))),2)
dnz,rem=pdiv(dNz,a);assert rem==[0];dnz += [0]*(5-len(dnz))
nc=pscale(n,int(inv[n[-1]]));dncz=pscale(psub(dnz,pscale(nc,dnz[-1])),int(inv[n[-1]]));dncz += [0]*(5-len(dncz))
dq1z=mu(3,dncz[3]);dq0z=mu(3,ad(dncz[2],ne(mu(2,mu(qq[1],dq1z)))))
ez1=ad(dncz[1],ne(mu(2,ad(mu(qq[0],dq1z),mu(qq[1],dq0z)))))
ez0=ad(dncz[0],ne(mu(2,mu(qq[0],dq0z))))
print('partial z dH',dHz,'dA',dAz,'dE',[ez0,ez1])
vel=solve(np.array(J).T,np.array([ne(ez0),ne(ez1)]))
print('X1 X2 velocities',list(map(int,vel)))
Yvel=[mu(sl1,int(vel[0])),mu(sl2,int(vel[1]))]
print('Y velocities',Yvel)
# total differential vector variation
dHt=dHz;dAt=dAz
for c,dat in zip(vel,ddata):dHt=padd(dHt,pscale(dat['dH'],int(c)));dAt=padd(dAt,pscale(dat['dA'],int(c)))
print('total dH',dHt,'dA',dAt)
# primitive variation
Bcols=[]
for i in range(6):
 pp=[0]*i+[1];Bcols.append(padd(pmul(F,pdiff(pp)),pscale(pmul(pdiff(F),pp),3)))
dBt=solve(np.array([bb+[0]*(9-len(bb)) for bb in Bcols]).T,np.array(dHt+[0]*(9-len(dHt))))
dAP=[0]+[0 if (i+1)%5==0 else mu(dAt[i],int(inv[(i+1)%5])) for i in range(len(dAt))]
print('total primitive delta A',dAP,'delta B',list(map(int,dBt)))
# derivative q after the D and z variations
da=[0]
for c,dat in zip(vel,ddata):da=padd(da,pscale(dat['da'],int(c)))
dNt=pscale(psub(pmul(H,dHt),pmul(F,pmul(A,dAt))),2)
dnt,rem=pdiv(psub(dNt,pmul(n,da)),a);assert rem==[0];dnt +=[0]*(5-len(dnt))
dnct=pscale(psub(dnt,pscale(nc,dnt[-1])),int(inv[n[-1]]));dnct +=[0]*(5-len(dnct))
dq1t=mu(3,dnct[3]);dq0t=mu(3,ad(dnct[2],ne(mu(2,mu(qq[1],dq1t)))))
print('q derivative',[dq0t,dq1t])
assert ad(dnct[0],ne(mu(2,mu(qq[0],dq0t))))==0
assert ad(dnct[1], ne(mu(2, ad(mu(qq[0],dq1t), mu(qq[1],dq0t))))) == 0
out.update(dict(eQ=eQ,Q_discriminant=disc,full_H_basis=[list(map(int,h)) for h in HBF],independent_rows=chosen,full_kernel=list(map(int,kfull)),partial_z_E=[ez0,ez1],X_velocity=list(map(int,vel)),Y_velocity=Yvel,primitive_delta_A=dAP,primitive_delta_B=list(map(int,dBt)),q_delta=[dq0t,dq1t]))

def pxgcd(a,b):
 r0,r1=trim(a),trim(b);s0,s1=[1],[0];t0,t1=[0],[1]
 while r1!=[0]:
  q0,r2=pdiv(r0,r1);r0,r1=r1,r2;s0,s1=s1,psub(s0,pmul(q0,s1));t0,t1=t1,psub(t0,pmul(q0,t1))
 c=int(inv[r0[-1]])
 return pscale(r0,c),pscale(s0,c),pscale(t0,c)
def exactdiv(a,b):
 q0,r=pdiv(a,b)
 assert r==[0]
 return q0
def jacadd(D,E,Fcurve):
 u1,v1=D;u2,v2=E
 d0,h1,h2=pxgcd(u1,u2)
 dd,l1,l2=pxgcd(d0,padd(v1,v2))
 s1=pmul(l1,h1);s2=pmul(l1,h2);s3=l2
 uu=exactdiv(pmul(u1,u2),pmul(dd,dd))
 numer=padd(padd(pmul(pmul(s1,u1),v2),pmul(pmul(s2,u2),v1)),pmul(s3,padd(pmul(v1,v2),Fcurve)))
 vv=pmod(exactdiv(numer,dd),uu)
 while len(uu)-1>2:
  uu=exactdiv(psub(Fcurve,pmul(vv,vv)),uu)
  uu=pscale(uu,int(inv[uu[-1]]));vv=pmod(pneg(vv),uu)
 assert pmod(psub(Fcurve,pmul(vv,vv)),uu)==[0]
 return uu,vv
def jacmul(n,D,Fcurve):
 z=([1],[0])
 while n:
  if n%2:z=jacadd(z,D,Fcurve)
  D=jacadd(D,D,Fcurve);n//=2
 return z
D1=([int(fifth[x]) for x in d],[int(fifth[x]) for x in e])
E1=([int(fifth[x]) for x in qq],[int(fifth[x]) for x in eQ])
L=jacadd(jacmul(3,D1,F1),E1,F1)
print('L Mumford on C',L)
# point count over q^2 via norm, beta^2=116
ns=116
chi=[0]+[1 if pw(x,62)==1 else -1 for x in range(1,125)]
def qm(a,b):
 x,y=a;z,w=b
 return ad(mu(x,z),mu(ns,mu(y,w))),ad(mu(x,w),mu(y,z))
def qa(a,b):return ad(a[0],b[0]),ad(a[1],b[1])
sm=0
for a0 in range(125):
 for a1 in range(125):
  z=(0,0)
  for c in F[::-1]:z=qa(qm(z,(a0,a1)),(c,0))
  norm=ad(mu(z[0],z[0]),ne(mu(ns,mu(z[1],z[1]))))
  sm+=chi[norm]
N2=125**2+1+sm;N1=118;t1=126-N1;t2=125**2+1-N2
c2=(t1*t1-t2)//2
Jorder=125**2+1-126*t1+c2
print('N2',N2,'Jac order',Jorder)
assert jacmul(Jorder,L,F1)==([1],[0])
fac=[];rest=Jorder
for x in range(2,Jorder+1):
 if rest%x==0:
  fac.append(x)
  while rest%x==0:rest//=x
 if rest==1:break
order=Jorder
for x in fac:
 while order%x==0 and jacmul(order//x,L,F1)==([1],[0]):order//=x
print('L order',order)
out.update(dict(L_mumford=L,L_order=order,Jacobian_order=Jorder,Y_points_degree2=N2))


# Direct exact divisor certificate. Here the norm is the hyperelliptic
# function-field norm; Cartier isotropy follows from span([f],[f^2]).
assert pgcd(F,pdiff(F)) == [1]
assert pgcd(d,pdiff(d)) == [1]
assert pgcd(qq,pdiff(qq)) == [1]
assert pgcd(d,qq) == [1]
assert pgcd(pmul(d,qq),pmul(F,A)) == [1]
assert pmod(padd(H,pmul(e,A)),d) == [0]
assert pmod(padd(H,pmul(eQ,A)),qq) == [0]
assert pdiff(AP) == A
assert padd(pmul(F,pdiff(list(map(int,B)))),pscale(pmul(pdiff(F),list(map(int,B))),3)) == H
assert N == pscale(pmul(a,pmul(qq,qq)),53)
assert L == ([89,25,1],[28,29])
assert order == 1850
assert jacmul(1850,L,F1) == ([1],[0])
for prime in (2,5,37):
    assert jacmul(1850//prime,L,F1) != ([1],[0])
assert out['Jacobian_determinant'] == 88
assert out['Q_discriminant'] == 116 and pw(116,62) == 4

# A concrete nonzero minor of the normalized linear system.
minor=fullmat[chosen,:].copy()
minor_det=1
for col in range(len(minor)):
    pivot=next(row for row in range(col,len(minor)) if minor[row,col])
    if pivot != col:
        minor[[col,pivot]]=minor[[pivot,col]]
        minor_det=ne(minor_det)
    pivot_value=int(minor[col,col])
    minor_det=mu(minor_det,pivot_value)
    minor[col]=mul[minor[col],inv[pivot_value]]
    for row in range(col+1,len(minor)):
        if minor[row,col]:
            minor[row]=add[minor[row],neg[mul[minor[row,col],minor[col]]]]
assert minor_det == 70
out['normalized_linear_minor_determinant']=minor_det

import argparse
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--report', help='Optional path for the verified JSON data.')
args=parser.parse_args()
if args.report:
    with open(args.report,'w',encoding='utf-8') as stream:
        json.dump(out,stream,indent=2)
        stream.write('\n')
print('ALL EXACT CHECKS PASSED')

