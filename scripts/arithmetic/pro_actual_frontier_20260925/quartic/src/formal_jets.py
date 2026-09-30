"""Bounded exact local-jet experiment at t=1, epsilon=2, simple common pole.
This is not a global curve reconstruction or a general jet classification.
"""
from finite_fields import ADD,NEG,MUL,inv,pow25,div
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
N=10
Z=[0]*(N+1)
def add(a,b):return [ADD[x][y] for x,y in zip(a,b)]
def neg(a):return [NEG[x] for x in a]
def sub(a,b):return add(a,neg(b))
def scale(a,c):return [MUL[x][c] for x in a]
def const(c):return [c]+[0]*N
def mul(a,b):
 r=Z.copy()
 for i,x in enumerate(a):
  if x:
   for j,y in enumerate(b[:N+1-i]):
    if y:r[i+j]=ADD[r[i+j]][MUL[x][y]]
 return r
def power(a,n):
 r=const(1)
 while n:
  if n&1:r=mul(r,a)
  a=mul(a,a);n>>=1
 return r
def pinv(a):
 r=const(inv(a[0]))
 for i in range(1,N+1):
  s=0
  for j in range(1,i+1):s=ADD[s][MUL[a[j]][r[i-j]]]
  r[i]=MUL[NEG[s]][r[0]]
 return r
def shift(a,k):return ([0]*k+a)[:N+1]
def homogenize(coeffs,U):
 r=Z.copy();d=len(coeffs)-1
 for j,c in enumerate(coeffs):r=add(r,scale(shift(power(U,j),d-j),c))
 return r
T=[1,1]+[0]*(N-1)
EPS=2
FAC=scale(power(pinv(T),13),pow25(EPS,4))
DFAC=scale(power(T,48),pow25(EPS,-17))
def makeV(U):
 V=const(MUL[EPS][U[0]])
 target=mul(FAC,homogenize(A,U))
 deriv=MUL[MUL[4][A[4]]][pow25(V[0],3)]
 for j in range(1,N+1):
  residual=sub(homogenize(A,V),target)[j]
  V[j]=div(NEG[residual],deriv)
 assert homogenize(A,V)==target
 return V

def residual(U):
 V=makeV(U)
 dU=[MUL[(j-1)%5][c] for j,c in enumerate(U)]
 dV=[MUL[(j-1)%5][c] for j,c in enumerate(V)]
 return sub(mul(power(dV,3),power(homogenize(P,U),2)),mul(DFAC,mul(power(dU,3),power(homogenize(P,V),2)))),V

def run_experiment():
 K=MUL[8][(1-pow25(2,-1))%5]
 U=const(K); trials=[]
 for r in range(1,7):
  allowed=[];values=[]
  for b in range(25):
   W=U.copy();W[r]=b
   R,V=residual(W)
   assert all(x==0 for x in R[:r+1]), (r,b,R)
   values.append(R[r+1])
   if R[r+1]==0:allowed.append(b)
  trials.append({'U_index':r,'tested_F25_coefficients':list(range(25)),
                 'residual_at_order_r_plus_1':values,'allowed':allowed})
  if not allowed:break
  U[r]=allowed[0]
  if len(allowed)>1:break
 R,V=residual(U)
 return {'scope':'Bounded formal-jet experiment only; not a full formal or global solution.',
         't':'1+w','epsilon_F25':EPS,'truncation':N,'K_F25':K,
         'trials':trials,'chosen_U':U,'resulting_V':V,'full_truncated_residual':R}

if __name__=='__main__':
 import json
 from pathlib import Path
 result=run_experiment()
 root=Path(__file__).resolve().parents[1]
 (root/'certificates/local_jet_example.json').write_text(json.dumps(result,indent=2)+'\n')
 print('Local only: t=1+w; epsilon=2; U=w*u; V=w*v; truncation',N)
 print('K',result['K_F25'])
 for trial in result['trials']:
  print('U coefficient',trial['U_index'],'allowed',trial['allowed'])
 print('No assertion that the displayed truncation solves the differential identity through order 10.')
