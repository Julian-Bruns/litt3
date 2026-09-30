"""Direct verification of every original linear equation on all affine bases.
This checks the origin and seven independent affine directions for each v.
By linearity, it certifies every geometric coefficient specialization.
The exact pole-open conditions are applied separately through the top coordinate a.
"""
from reconstruct import *
from verify_original import cpole,ydivisible
import math,json

def check(vec,root):
 H,kap=unpack(vec)
 v=[1] if root is None else [neg(root),1]
 Ns={i:zero() for i in range(11)};Ns[0]=cone(v)
 for i in range(2,6):Ns[i]=H[i]
 Ns[5]=cadd(Ns[5],cone(pmul(v,Q)))
 for j in range(1,6):
  E=zero()
  for i in range(j+1):
   E=cadd(E,cscale(cxmul(Ns[i],ppow(pscale(B0,4),j-i)),math.comb(5-i,j-i)%5))
  assert ydivisible(E,j),('eq1',root,j)
 for j in range(5):
  E=zero()
  for i in range(6-j):
   E=cadd(E,cscale(cxmul(Ns[i],ppow(pscale(L0,4),5-i-j)),math.comb(5-i,j)%5))
  E=cxmul(E,psub(Q,ppow(L0,5)))
  if j==0:E=cadd(E,cscale(ty10,kap))
  assert all(not pmod(p,ppow(t,5-j)) for p in E),('eq2',root,j)
 for j in range(11):
  E=Ns[j]
  if j>=5:E=cadd(E,cxmul(Ns[j-5],Q))
  if j==10:E=cadd(E,cscale(ty10,kap))
  assert cpole(E)<=10+12*j-max(0,j-5),('eq3',root,j)
 for i,d in [(0,10),(1,22),(2,34),(3,46),(4,57),(5,70)]:assert cpole(Ns[i])<=d
 D2=zero()
 for (n,i,j),z in zip(slots,vec):
  if n==2:D2=cadd(D2,cscale(cmon(i,j),int(z)))
 assert Ns[2]==cmul(D2,cmon(0,2)) and cpole(D2)<=14
 if root is None:assert cpole(D2)<=12
 else:assert cpole(D2)<=13 and peval(D2[0],root)==0
 return True

def main():
 cases=json.loads((ROOT/'data/spaces.json').read_text())['cases']
 for case in cases:
  vectors=[[0]*len(slots)]+case['split']+case['kernel']
  assert len(vectors)==8
  for vec in vectors:check(vec,case['root'])
  rows=np.array(vectors[1:],np.int32)
  _,piv=rref(rows);assert len(piv)==7
  print('Direct original equations: root',case['root'],'origin + seven independent directions passed',flush=True)
 print('ALL 88 AFFINE BASIS POINTS VERIFIED; LINEARITY CERTIFIES ALL GEOMETRIC COEFFICIENTS.',flush=True)
if __name__=='__main__':main()
