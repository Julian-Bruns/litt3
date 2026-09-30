"""Reconstruct the supplied necessary coefficient system. Not a cover test."""
import json,math,pathlib
import numpy as np
import field as F
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
B0=[8,14,19,2,10,19,3,24,18,16]
L0=[18,20,20,15]

def trim(a):
 a=np.array(a,dtype=np.int32)
 while len(a)>1 and a[-1]==0:a=a[:-1]
 return a

def padd(a,b):
 n=max(len(a),len(b));aa=np.zeros(n,dtype=np.int32);bb=aa.copy();aa[:len(a)]=a;bb[:len(b)]=b
 return trim(F.add(aa,bb))

def pmul(a,b):
 r=np.zeros(len(a)+len(b)-1,dtype=np.int32)
 for i,c in enumerate(a):
  if c:r[i:i+len(b)]=F.add(r[i:i+len(b)],F.mul(c,b))
 return trim(r)

def ppow(a,e):
 r=np.array([1],dtype=np.int32)
 while e:
  if e&1:r=pmul(r,a)
  a=pmul(a,a);e//=2
 return r

def pdiv(a,b):
 a=trim(a);b=trim(b);q=np.zeros(max(1,len(a)-len(b)+1),dtype=np.int32)
 iv=F.inv(b[-1]);a=a.copy()
 for i in range(len(a)-len(b),-1,-1):
  q[i]=F.mul(a[i+len(b)-1],iv)
  a[i:i+len(b)]=F.sub(a[i:i+len(b)],F.mul(q[i],b))
 return trim(q),trim(a[:max(1,len(b)-1)])

def peval(a,x):
 r=0
 for c in reversed(a):r=int(F.add(F.mul(r,x),c))
 return r

def pder(a):return trim([int(F.mul(i%5,a[i])) for i in range(1,len(a))] or [0])

def monomials(d):return [(a,j) for j in range(3) for a in range(max(0,(d-10*j)//3+1))]

VARS=[(i,a,j) for i in range(6) for a,j in monomials(10+12*i)]
NV=len(VARS)+1

def build():
 alpha=25
 assert peval(A,alpha)==0
 t,rem=pdiv(A,[int(F.neg(alpha)),1]);assert not np.any(rem)
 t=F.mul(t,F.inv(t[-1]))
 rows=[];blocks={}
 # Equation 4.
 for j in range(1,6):
  for r in range(min(j,3)):
   modulus=ppow(P,(j-r+2)//3);deg=len(modulus)-1
   block=np.zeros((deg,NV),dtype=np.int32)
   for col,(i,a,yexp) in enumerate(VARS):
    if i>j or yexp!=r:continue
    factor=math.comb(5-i,j-i)%5
    if not factor:continue
    pol=F.mul(ppow(F.neg(B0),j-i),factor)
    shifted=np.r_[np.zeros(a,dtype=np.int32),pol]
    rr=pdiv(shifted,modulus)[1];block[:len(rr),col]=rr
   rows.extend(block)
 blocks['branch_rows']=len(rows)
 # Equation 5, equivalent divisibility by product of the three distinct roots.
 ql=padd(Q,F.neg(ppow(L0,5)))
 for j in range(5):
  modulus=ppow(t,5-j);deg=len(modulus)-1
  block=np.zeros((3*deg,NV),dtype=np.int32)
  for col,(i,a,yexp) in enumerate(VARS):
   if 5-i<j:continue
   factor=math.comb(5-i,j)%5
   if not factor:continue
   pol=F.mul(pmul(ql,ppow(F.neg(L0),5-i-j)),factor)
   rr=pdiv(np.r_[np.zeros(a,dtype=np.int32),pol],modulus)[1]
   block[yexp*deg:yexp*deg+len(rr),col]=rr
  if j==0:
   rr=pdiv(pmul(ppow(t,3),ppow(P,3)),modulus)[1]
   block[deg:deg+len(rr),-1]=rr
  rows.extend(block)
 blocks['support_rows']=len(rows)-blocks['branch_rows']
 # Equation 6.
 inf={}
 for jj in range(1,11):
  bound=10+12*jj-max(0,jj-5)
  for col,(i,a,ye) in enumerate(VARS):
   pol=None
   if i==jj:pol=[1]
   if i==jj-5:pol=Q
   if pol is None:continue
   for aa,c in enumerate(pol):
    if not c or 3*(a+aa)+10*ye<=bound:continue
    key=(jj,a+aa,ye)
    if key not in inf:inf[key]=np.zeros(NV,dtype=np.int32)
    inf[key][col]=int(F.add(inf[key][col],c))
  if jj==10:
   pol=pmul(ppow(t,3),ppow(P,3))
   for aa,c in enumerate(pol):
    if not c or 3*aa+10<=bound:continue
    key=(jj,aa,1)
    if key not in inf:inf[key]=np.zeros(NV,dtype=np.int32)
    inf[key][-1]=int(F.add(inf[key][-1],c))
 rows.extend(inf[k] for k in sorted(inf));blocks['infinity_rows']=len(inf)
 return np.array(rows,dtype=np.int32),t,blocks

def equation(coordinates):
 row=np.zeros(NV,dtype=np.int32)
 for key,value in coordinates.items():row[VARS.index(key)]=value
 return row

def restricted_matrix(M):
 rows=[equation({key:1}) for key in VARS if key[0]==1 or (key[0]==0 and key[2]!=0)]
 return np.vstack([M,rows])

def check_kernel(M,K):
 out=np.zeros((M.shape[0],K.shape[1]),dtype=np.int32)
 for i in range(M.shape[1]):
  if np.any(K[i]):out=F.add(out,F.mul(M[:,i,None],K[i,None,:]))
 return not np.any(out)

def run(root):
 M,t,blocks=build(); print('variables',NV,'blocks',blocks,flush=True)
 _,p=F.rref(M[:blocks['branch_rows']]);print('branch rank',len(p),flush=True)
 K,piv=F.kernel(M);print('full dimension',K.shape[1],flush=True)
 tr=np.vstack([M,[equation({key:1}) for key in VARS if key[0]==1]])
 K1,_=F.kernel(tr);print('trace zero dimension',K1.shape[1],flush=True)
 Mr=restricted_matrix(M);Kr,_=F.kernel(Mr);print('polynomial v dimension',Kr.shape[1],flush=True)
 assert K.shape[1]==18 and K1.shape[1]==13 and Kr.shape[1]==12
 assert check_kernel(M,K) and check_kernel(Mr,Kr)
 data={'field':{'characteristic':5,'beta_relation':[2,4,1],'alpha_relation':[5,2,6,7,1],'integer_encoding':'sum_i d_i*25^i; d_i=a_i+5*b_i'},
       'P':P,'A':A,'Q':Q,'B0':B0,'L0':L0,'tB':[int(v) for v in t], 'variables':[list(t) for t in VARS]+[['kappa']],
       'blocks':blocks,'matrix':M.tolist(),'kernel':K.tolist(),'trace_kernel':K1.tolist(),'polynomial_v_kernel':Kr.tolist()}
 (root/'data'/'linear_system.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
 return Mr,Kr,t

if __name__=='__main__':
 import time
 root=pathlib.Path(__file__).resolve().parents[1];s=time.time();run(root);print('elapsed seconds',time.time()-s)
