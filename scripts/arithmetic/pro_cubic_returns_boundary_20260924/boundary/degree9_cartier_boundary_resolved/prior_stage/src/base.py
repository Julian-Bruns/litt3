"""Exact F25 arithmetic and the finite-pole congruence matrix.
Only Python's standard library is used. Polynomials have ascending coefficients.
Matrix columns are (j,r,i), for the coefficient of x^i*y^r in N_j.
"""
from math import comb
from pathlib import Path
import json
ROOT = Path(__file__).resolve().parents[1]
INPUT = json.loads((ROOT / "inputs/input.json").read_text())
P, A, B0, Q = (INPUT[n] for n in ("P", "A", "B0", "Q"))

add=[[((a%5+b%5)%5)+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
neg=[((-a%5)%5)+5*((-(a//5))%5) for a in range(25)]
mul=[]
for a in range(25):
 row=[]
 for b in range(25):
  u,v=a%5,a//5;w,z=b%5,b//5
  row.append((u*w+3*v*z)%5+5*((u*z+v*w+v*z)%5))
 mul.append(row)
inv=[0]+[next(b for b in range(1,25) if mul[a][b]==1) for a in range(1,25)]
def powf(a,n):
 r=1
 while n:
  if n&1:r=mul[r][a]
  a=mul[a][a]; n//=2
 return r
def padd(a,b):
 c=[0]*max(len(a),len(b))
 for i in range(len(c)):c[i]=add[a[i] if i<len(a) else 0][b[i] if i<len(b) else 0]
 return trim(c)
def trim(a):
 while a and not a[-1]: a.pop()
 return a
def pscale(a,b):return trim([mul[x][b] for x in a])
def pmul(a,b):
 if not a or not b:return []
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):c[i+j]=add[c[i+j]][mul[x][y]]
 return trim(c)
def ppow(a,n):
 r=[1]
 while n:
  if n&1:r=pmul(r,a)
  a=pmul(a,a);n//=2
 return r
def pdiv(a,b):
 a=a[:];q=[0]*max(0,len(a)-len(b)+1)
 while len(a)>=len(b) and a:
  m=len(a)-len(b);c=mul[a[-1]][inv[b[-1]]];q[m]=c
  for i,x in enumerate(b):a[i+m]=add[a[i+m]][neg[mul[c][x]]]
  trim(a)
 return trim(q),a
def basis(m):return [(r,i) for r in range(3) for i in range(max(0,(m-10*r)//3+1))]
def rref(mat):
 mat=[x[:] for x in mat];nr=len(mat); nc=len(mat[0]) if nr else 0;piv=[];rr=0
 for c in range(nc):
  s=next((s for s in range(rr,nr) if mat[s][c]),None)
  if s is None:continue
  mat[rr],mat[s]=mat[s],mat[rr]
  scale=mul[inv[mat[rr][c]]];mat[rr]=[scale[x] for x in mat[rr]]
  for s in range(nr):
   v=mat[s][c]
   if s!=rr and v:
    scales=mul[neg[v]];mat[s]=[add[x][scales[y]] for x,y in zip(mat[s],mat[rr])]
  piv.append(c);rr+=1
  if rr==nr:break
 return mat,piv
def nullspace(mat):
 M,p=rref(mat);n=len(mat[0]);free=[i for i in range(n) if i not in p];res=[]
 for j in free:
  z=[0]*n;z[j]=1
  for i,c in enumerate(p):z[c]=neg[M[i][j]]
  res.append(z)
 return res

def matrix(depth):
 cols=[(j,r,i) for j in range(depth+1) for r,i in basis(9+12*j)]
 rows=[(j,r,i) for j in range(1,depth+1) for r in range(min(3,j)) for i in range(10*((j-r+2)//3))]
 M=[[0]*len(cols) for _ in rows];idx={v:k for k,v in enumerate(rows)}
 for c,(h,r,i) in enumerate(cols):
  for j in range(max(1,h),depth+1):
   if r>=j:continue
   mod=ppow(P,(j-r+2)//3)
   pol=pdiv([0]*i+ppow(B0,j-h),mod)[1]
   co=comb(j,h)%5
   for u,v in enumerate(pol):M[idx[(j,r,u)]][c]=mul[co][v]
 return cols,rows,M

