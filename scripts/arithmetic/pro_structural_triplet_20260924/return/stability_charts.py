"""Exact ideals of the excluded ten points, on all six projective charts.
Finite-algebra linear algebra proves these ideals; no root approximation or
field-of-definition restriction is used.
"""
from core import *
import json,heapq

def rem(a,q):return pdiv(a,q)[1]
def pinv(a,q):
 oldr,r=q,rem(a,q);oldt,t={},F.mono()
 while r:
  quotient,nr=pdiv(oldr,r);oldr,r=r,nr
  oldt,t=t,F.add(oldt,F.neg(F.mul(quotient,t)))
 assert set(oldr)=={(0,0)}
 return rem(F.scale(int(F.INV[oldr[(0,0)]]),oldt),q)

def linear_coordinates(B,value):
 if not B:return None
 A=np.column_stack(B)
 R,p=F.rref(np.column_stack((A,value[:,None])),len(B))
 assert len(p)==len(B)
 if R[len(p):,-1].any():return None
 return R[:len(B),-1]

def divides(a,b):return all(x<=y for x,y in zip(a,b))
def main():
 output={'coefficient_field':'F5[beta]/(beta^2-beta-3)','monomial_order':'graded lexicographic on the five retained v coordinates','charts':[]}
 for j in range(6):
  gcd=pgcd(F.P,BPOLYS[j]);q=pdiv(F.P,gcd)[0];N=max(i for i,_ in q)
  inv=pinv(BPOLYS[j],q)
  inds=[i for i in range(6) if i!=j]
  values=[rem(F.mul(BPOLYS[i],inv),q) for i in inds]
  z=(0,)*5;todo=[(0,z)];queued={z};B=[];cols=[];leaders=[];rels=[]
  while todo:
   _,m=heapq.heappop(todo)
   if any(divides(a,m) for a in leaders):continue
   val=F.mono()
   for i,p in enumerate(m):
    for _ in range(p):val=rem(F.mul(val,values[i]),q)
   vec=np.array([val.get((i,0),0) for i in range(N)],np.uint8)
   co=linear_coordinates(cols,vec)
   if co is None:
    assert len(B)<N;B.append(m);cols.append(vec)
    for i in range(5):
     n=list(m);n[i]+=1;n=tuple(n)
     if n not in queued:queued.add(n);heapq.heappush(todo,(sum(n),n))
   else:
    leaders.append(m)
    rel=[[list(m),1]]+[[list(mm),int(F.NEG[c])] for mm,c in zip(B,co) if c]
    rels.append(rel)
  assert len(B)==N and len(F.rref(np.column_stack(cols))[1])==N
  # Independently enumerate the standard monomials of the leading ideal.
  stack=[z];seen={z}
  for m in stack:
   for i in range(5):
    n=list(m);n[i]+=1;n=tuple(n)
    if n not in seen and not any(divides(a,n) for a in leaders):
     seen.add(n);stack.append(n);assert len(stack)<=N
  assert seen==set(B)
  for rel in rels:
   result={}
   for mon,coef in rel:
    p=F.mono(c=coef)
    for i,e in enumerate(mon):
     for _ in range(e):p=rem(F.mul(p,values[i]),q)
    result=F.add(result,p)
   assert not result
  output['charts'].append({'chart':j,'v_j':1,'retained_coordinates':inds,'root_algebra_modulus':poly_json(q),'number_of_excluded_points':N,
   'coordinate_images':{str(i):poly_json(p) for i,p in zip(inds,values)},'standard_monomials':[list(m) for m in B],
   'image_basis_matrix':np.column_stack(cols).tolist(),'generators':rels})
  print('chart',j,'excluded points',N,'ideal generators',len(rels),'max degree',max(sum(r[0][0]) for r in rels),'PASS',flush=True)
 (ROOT/'data'/'stability_charts.json').write_text(json.dumps(output,indent=2)+'\n')
if __name__=='__main__':main()

