"""Independent polynomial-arithmetic model for replaying the decisive survivors.
No logarithm tables, SIMD, factorization file, or optimized field code is used.
"""
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
from exact_fields import Field,F5,embed
S=Field(F5,[4,4,2,3,3,2,2,1],'S_reference')
KR=Field(S,[S(2),S(4),S(1)],'K_reference')
def c25(n):return KR.row([S(n%5),S(n//5)])
FR=Field(KR,[-c25(20),KR.zero,KR.zero,KR.zero,KR.one],'F_reference')
th=FR.gen
z=KR.row([S.row([2,2,3,2,1,0,2]),S.row([1,2,4,1,3,0,1])])
def evaluate(codes,x):
 out=x.field.zero
 for c in reversed(codes):out=out*x+embed(c25(c),x.field)
 return out
assert z**29==KR.one and z!=KR.one
assert evaluate([4,22,7,20,21,7,24,1],z)==KR.zero
assert z+z**28==KR.from_base(S.gen)
# h is irreducible: X^(5^7)=X mod h, no roots in F5, and 7 is prime.
assert S.gen**78125==S.gen
h=[4,4,2,3,3,2,2,1]
assert all(sum(c*pow(a,i,5)for i,c in enumerate(h))%5 for a in range(5))
alpha=embed(c25(7),FR)+embed(c25(21),FR)*th**2+4*th**3
assert evaluate([5,2,6,7,1],alpha)==FR.zero
assert evaluate([5,17,12,5],alpha)==th
assert evaluate([22,7,9,23],alpha)==FR.row(list(map(c25,[20,1,7,19])))
assert evaluate([1,3,8,15],alpha)==FR.row(list(map(c25,[8,1,15,0])))
zp=[z**j for j in range(29)];ie=c25(22).inverse();beta=c25(5)
cache={}
def endpoint(Q,name):
 row,m=([20,1,7,19],5)if name=='c'else([8,1,15,0],8)
 out=FR.zero
 for i,j in Q:
  key=i,j,name
  if key not in cache:cache[key]=FR.row([c25(c)*pow(2,i*k,5)*zp[(m*j)%29]*ie for k,c in enumerate(row)])
  out+=cache[key]
 return out
def unpackS(n):
 ds=[]
 for _ in range(7):ds.append(n%5);n//=5
 assert not n
 return S.row(ds)
def packS(a):return sum(c*5**j for j,c in enumerate(a.c))
def unpackK(p):return KR.row(list(map(unpackS,p)))
def packK(a):return [packS(t)for t in a.c]
def bar(a):return KR.row([a.c[0]+a.c[1],-a.c[1]])
def norm(a):return a.c[0]**2+a.c[0]*a.c[1]+2*a.c[1]**2
scalar=lambda z:embed(z,FR)
def original_determinant(A,B,C,D,x,y):
 return (A-scalar(bar(x)))*(D-scalar(x))-(B-scalar(y))*(C-scalar(bar(y)))
def moments_and_residuals(A,B,C,D):
 W=A*D-B*C
 dx=norm(A.c[1])-norm(D.c[1]);dy=norm(C.c[3])-norm(B.c[3]);assert dx and dy
 Xd=KR.from_base(dx);Yd=KR.from_base(dy);dd=Xd*Yd
 Y=B.c[3]*bar(W.c[3])-bar(C.c[3])*W.c[3]
 R=Yd*W.c[1]+B.c[1]*bar(Y)+C.c[1]*Y
 X=bar(A.c[1])*R-D.c[1]*bar(R)
 Z=dd*W.c[2]-A.c[2]*X-D.c[2]*bar(X)+Xd*(B.c[2]*bar(Y)+C.c[2]*Y)
 S0=dd*W.c[0]-A.c[0]*X-D.c[0]*bar(X)+Xd*(B.c[0]*bar(Y)+C.c[0]*Y)
 T=dd*S0+KR.from_base(norm(X)-dx*dx*norm(Y))
 x=X/dd;y=Y/Yd
 v=original_determinant(A,B,C,D,x,y)
 assert not v.c[1] and not v.c[3]
 assert v.c[2]*dd==Z and v.c[0]*dd**2==T
 return dx,dy,x,y,Z,T,v

def rank(matrix):
 a=[row[:]for row in matrix];r=0;cols=len(a[0])
 for j in range(cols):
  p=next((i for i in range(r,len(a))if a[i][j]),None)
  if p is None:continue
  a[p],a[r]=a[r],a[p];v=a[r][j]
  for i in range(r+1,len(a)):
   f=a[i][j]
   if f:
    for k in range(j+1,cols):a[i][k]=v*a[i][k]-f*a[r][k]
    a[i][j]=S.zero
  r+=1
 return r
