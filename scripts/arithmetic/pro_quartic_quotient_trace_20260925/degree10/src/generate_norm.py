"""Rebuild all coefficient equations P+g^3-H^2*J^3, without saturations.
Usage: python3 src/generate_norm.py OUTPUT_DIRECTORY
Standard library only; does not run an ideal-membership computation.
"""
import json,sys
from pathlib import Path
if len(sys.argv)!=2:
 raise SystemExit('usage: generate_norm.py OUTPUT_DIRECTORY')
out=Path(sys.argv[1]);out.mkdir(parents=True,exist_ok=True)
N=8
names=['g0','g1','g2','g3','h0','h1','j0','j1']
P=[11,22,18,5,19,20,15,16,9,22,1]
def add(a,b):return ((a%5+b%5)%5)+5*((a//5+b//5)%5)
def neg(a):return (-a%5)+5*((- (a//5))%5)
def mul(a,b):
 u,v=a%5,a//5;c,d=b%5,b//5
 return (u*c+3*v*d)%5+5*((u*d+v*c+v*d)%5)
z=(0,)*N
def const(a):return {z:a} if a else {}
def var(i):e=list(z);e[i]=1;return {tuple(e):1}
def padd(A,B):
 C=A.copy()
 for m,c in B.items():
  q=add(C.get(m,0),c)
  if q:C[m]=q
  elif m in C:del C[m]
 return C
def pneg(A):return {m:neg(c) for m,c in A.items()}
def pmul(A,B):
 C={}
 for a,c in A.items():
  for b,d in B.items():
   m=tuple(x+y for x,y in zip(a,b)); q=add(C.get(m,0),mul(c,d))
   if q:C[m]=q
   elif m in C:del C[m]
 return C
def conv(A,B):
 C=[{} for _ in range(len(A)+len(B)-1)]
 for i,a in enumerate(A):
  for j,b in enumerate(B):C[i+j]=padd(C[i+j],pmul(a,b))
 return C
g=[var(i) for i in range(4)];h=[var(4),var(5),const(1)];j=[var(6),var(7),const(1)]
g3=conv(conv(g,g),g);h2j3=conv(conv(h,h),conv(conv(j,j),j))
eq=[]
for i in range(11):
 p=padd(const(P[i]),g3[i] if i<len(g3) else {})
 p=padd(p,pneg(h2j3[i]))
 if p:eq.append(p)
assert len(eq)==10
(out/'norm_system.json').write_text(json.dumps({'field':{'p':5,'degree':2,'modulus_ascending':[2,4,1],'encoding':'a+5*b = a+b*beta'},'variables':names,'P':P,'equations':[{'x_coefficient':i,'terms':[[list(m),c] for m,c in sorted(p.items())]} for i,p in enumerate(eq)]},indent=2)+'\n')
with open(out/'norm_system.txt','w') as f:
 f.write(f'{N} {len(eq)}\n')
 for p in eq:
  f.write(str(len(p))+'\n')
  for m,c in sorted(p.items()):f.write(str(c)+' '+' '.join(map(str,m))+'\n')
print('Generated all 10 coefficient equations, 8 variables over F25, terms:',list(map(len,eq)))
