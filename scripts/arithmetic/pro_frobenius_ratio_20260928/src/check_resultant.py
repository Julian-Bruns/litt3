from ff import *
from resultant_formula import compact_resultant
import random,json
from pathlib import Path
class F:
 def __init__(self,a=0):self.a=a.a if isinstance(a,F) else a
 def __add__(self,b):return F(add(self.a,F(b).a))
 __radd__=__add__
 def __neg__(self):return F(neg(self.a))
 def __sub__(self,b):return self+-F(b)
 def __rsub__(self,b):return F(b)+-self
 def __mul__(self,b):return F(mul(self.a,F(b).a))
 __rmul__=__mul__
 def __pow__(self,n):return F(power(self.a,n))
 def __eq__(self,b):return self.a==F(b).a

def determinant(mat):
 n=len(mat);m=[list(row) for row in mat];det=1
 for j in range(n):
  p=next((i for i in range(j,n) if m[i][j]),None)
  if p is None:return 0
  if p!=j:m[j],m[p]=m[p],m[j];det=neg(det)
  z=m[j][j];det=mul(det,z);iz=inv(z)
  for i in range(j+1,n):
   t=mul(m[i][j],iz)
   for k in range(j+1,n):m[i][k]=sub(m[i][k],mul(t,m[j][k]))
 return det

def sylvester(f,g,m,n):
 fd=[f[m-i] for i in range(m+1)];gd=[g[n-i] for i in range(n+1)]
 mat=[]
 for i in range(n):mat.append([0]*i+fd+[0]*(n-i-1))
 for i in range(m):mat.append([0]*i+gd+[0]*(m-i-1))
 return determinant(mat)

def run_checks():
 rng=random.Random(20260927);checked=0
 for degcase in range(4):
  for _ in range(50):
   vals=[rng.randrange(390625) for i in range(8)]
   a,b,c,d,Q,t,v,lam=vals
   if degcase==1:a=0
   if degcase==2:a=b=0
   if degcase==3:a=b=c=0
   U=X**5+Q;S=div(a,3)*X**3+div(b,2)*X**2+c*X+d
   f=mul(lam,v)*U**2+U*S+t;g=a*X**2+b*X+c
   actual=sylvester(f,g,10,2)
   rc=compact_resultant(*map(F,[a,b,c,d,Q,t,v]))
   computed=sumf([mul(rc[i].a,power(lam,i)) for i in range(3)])
   assert actual==computed,(degcase,vals,actual,computed)
   checked+=1
 out={'seed':20260927,'exact_finite_tests':checked,'degree_drop_cases':['quadratic','linear','constant','zero'],'status':'checked; universal validity supplied by symbolic proof in REPORT.md'}
 return out
def main():
 out=run_checks();root=Path(__file__).resolve().parents[1];(root/'checks'/'resultant_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
if __name__=='__main__':main()
