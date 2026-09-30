"""Exact F_25 arithmetic and the input polynomials; ascending rows."""
import itertools, math, json, time
ADD=[[((a%5+b%5)%5)+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
NEG=[((-a%5)%5)+5*((-(a//5))%5) for a in range(25)]
MUL=[[((a%5*(b%5)+3*(a//5)*(b//5))%5)+5*((a%5*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)]
INV=[0]+[next(b for b in range(1,25) if MUL[a][b]==1) for a in range(1,25)]
def fpow(a,n):
 r=1
 while n:
  if n&1:r=MUL[r][a]
  a=MUL[a][a]; n//=2
 return r
def trim(a):
 a=list(a)
 while a and a[-1]==0:a.pop()
 return a
def padd(a,b):
 return trim([ADD[a[i] if i<len(a) else 0][b[i] if i<len(b) else 0] for i in range(max(len(a),len(b)))])
def pneg(a):return [NEG[t] for t in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([MUL[t][c] for t in a])
def pmul(a,b):
 if not a or not b:return []
 o=[0]*(len(a)+len(b)-1)
 for i,t in enumerate(a):
  if t:
   for j,u in enumerate(b):o[i+j]=ADD[o[i+j]][MUL[t][u]]
 return trim(o)
def ppow(a,n):
 o=[1]
 while n:
  if n&1:o=pmul(o,a)
  a=pmul(a,a);n//=2
 return o
def pdivmod(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 o=[0]*max(0,len(a)-len(b)+1)
 while a and len(a)>=len(b):
  i=len(a)-len(b);t=MUL[a[-1]][INV[b[-1]]];o[i]=t
  for j,u in enumerate(b):a[i+j]=ADD[a[i+j]][NEG[MUL[t][u]]]
  a=trim(a)
 return trim(o),a
def pmod(a,b):return pdivmod(a,b)[1]
def pder(a):return trim([MUL[i%5][a[i]] for i in range(1,len(a))])
def peval(a,t):
 o=0
 for c in reversed(a):o=ADD[MUL[o][t]][c]
 return o
def pgcd(a,b):
 while b:a,b=b,pmod(a,b)
 return pscale(a,INV[a[-1]]) if a else []
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
B0=[8,14,19,2,10,19,3,24,18,16]
L=[18,20,20,15]
