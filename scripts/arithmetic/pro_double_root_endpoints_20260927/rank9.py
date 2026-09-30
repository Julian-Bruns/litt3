"""Polynomial-only arithmetic in K[u,q]/g; no parameter localization.
Elements are nine ascending K[u] coefficient lists. Used as an independent,
small certificate checker rather than the interpolation evaluation kernel.
"""
import json
from exact import ROOT,pa,ps,pm,pc,trim
SRC=json.loads((ROOT/'evidence/global_source.json').read_text())
G=[[] for _ in range(10)]
for iq,iu,a in SRC['critical_monic']:
 while len(G[iq])<=iu:G[iq].append(0)
 G[iq][iu]=a
assert G[9]==[1]
def zero():return [[] for _ in range(9)]
def one():return [[1]]+[[] for _ in range(8)]
def plus(a,b):return [pa(x,y) for x,y in zip(a,b)]
def minus(a,b):return [ps(x,y) for x,y in zip(a,b)]
def scalar(a,c):return [pc(x,c) for x in a]
def times_poly(a,p):return [pm(x,p) for x in a]
def times(a,b):
 h=[[] for _ in range(17)]
 for i in range(9):
  for j in range(9):h[i+j]=pa(h[i+j],pm(a[i],b[j]))
 for j in range(16,8,-1):
  if h[j]:
   for l in range(9):h[j-9+l]=ps(h[j-9+l],pm(h[j],G[l]))
 return h[:9]
def from_flat(data,n,count,label):
 return [trim([data[(i*count+label)*9+j] for i in range(n)]) for j in range(9)]
def power(a,n):
 r=one()
 while n:
  if n&1:r=times(r,a)
  n//=2
  if n:a=times(a,a)
 return r
