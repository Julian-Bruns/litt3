"""Exact tower-field and sparse Laurent arithmetic. No floating-point operations."""
from pathlib import Path
from array import array
import ctypes, subprocess
ROOT=Path(__file__).resolve().parents[1]
LIB=ROOT/'build'/'field.so';LIB.parent.mkdir(exist_ok=True)
if not LIB.exists() or LIB.stat().st_mtime<(ROOT/'src'/'field.cpp').stat().st_mtime:
 subprocess.run(['g++','-O3','-std=c++17','-shared','-fPIC',str(ROOT/'src'/'field.cpp'),'-o',str(LIB)],check=True)
lib=ctypes.CDLL(str(LIB));lib.initfield.argtypes=[ctypes.c_char_p];lib.initfield.restype=ctypes.c_uint32
TABLE=ROOT/'build'/'field.bin';primitive=lib.initfield(str(TABLE).encode())
v=array('I');v.frombytes(TABLE.read_bytes());v=v.tolist();assert v[0]==primitive
N=390625;ORD=N-1;p=1
ADD=v[p:p+N];p+=N;LOG=v[p:p+N];p+=N;EXP=v[p:p+2*ORD+1];p+=2*ORD+1;NEG=v[p:p+N];del v

def add(a,b):return ADD[(a%625)*625+b%625]+625*ADD[(a//625)*625+b//625]
def neg(a):return NEG[a]
def sub(a,b):return add(a,NEG[b])
def mul(a,b):return EXP[LOG[a]+LOG[b]] if a and b else 0
def inv(a):
 if not a:raise ZeroDivisionError
 return EXP[ORD-LOG[a]]
def div(a,b):return mul(a,inv(b))
def power(a,n):
 if not n:return 1
 if not a:
  if n<0:raise ZeroDivisionError
  return 0
 return EXP[(LOG[a]*n)%ORD]

def padd(a,b):
 c=a.copy()
 for m,u in b.items():
  t=add(c.get(m,0),u)
  if t:c[m]=t
  else:c.pop(m,None)
 return c
def pneg(a):return {m:NEG[u] for m,u in a.items()}
def psub(a,b):return padd(a,pneg(b))
def pscale(a,s):return {m:mul(u,s) for m,u in a.items()} if s else {}
def pmul(a,b):
 c={}
 for m,u in a.items():
  for n,v in b.items():
   k=tuple(x+y for x,y in zip(m,n));t=add(c.get(k,0),mul(u,v))
   if t:c[k]=t
   else:c.pop(k,None)
 return c
def pone(n):return {(0,)*n:1}
def ppow(a,k,n=None):
 if n is None:n=len(next(iter(a)))
 assert k>=0
 if k and k%5==0:return ppow({tuple(5*x for x in m):power(u,5) for m,u in a.items()},k//5,n)
 c=pone(n)
 while k:
  if k&1:c=pmul(c,a)
  k>>=1
  if k:a=pmul(a,a)
 return c
def pshift(a,sh):return {tuple(x+y for x,y in zip(m,sh)):c for m,c in a.items()}
def pderiv(a,i):return {m[:i]+(m[i]-1,)+m[i+1:]:mul(c,m[i]%5) for m,c in a.items() if m[i]%5}
def peval(a,vals):
 c={};inds=[i for i in range(len(next(iter(a)))) if i not in vals] if a else []
 for m,u in a.items():
  for i,t in vals.items():u=mul(u,power(t,m[i]))
  k=tuple(m[i] for i in inds);c[k]=add(c.get(k,0),u)
 return {m:u for m,u in c.items() if u}
def pdivide_univ(a,b,i=0,strict=True):
 if not a:return {},{}
 d=max(b);ilc=inv(b[d]);r=a.copy();q={}
 while r:
  ma=max(r,key=lambda m:m[i]);e=ma[i]
  if e<d:break
  coeff=mul(r[ma],ilc);m=list(ma);m[i]-=d;m=tuple(m);q[m]=add(q.get(m,0),coeff)
  for j,c in b.items():
   mb=list(m);mb[i]+=j;mb=tuple(mb);cc=sub(r.get(mb,0),mul(coeff,c))
   if cc:r[mb]=cc
   else:r.pop(mb,None)
 if strict:assert not r,('non-exact division',len(r),next(iter(r.items())))
 return q,r

def dumps(a):return [[*m,c] for m,c in sorted(a.items())]
def loads(a):return {tuple(row[:-1]):row[-1] for row in a}
def rref(rows):
 nc=len(rows[0]);nr=len(rows);A=(ctypes.c_uint32*(nr*nc))(*(c for row in rows for c in row));pv=(ctypes.c_int*min(nc,nr))()
 lib.rref.argtypes=[ctypes.POINTER(ctypes.c_uint32),ctypes.c_int,ctypes.c_int,ctypes.POINTER(ctypes.c_int)];lib.rref.restype=ctypes.c_int
 rank=lib.rref(A,nr,nc,pv);rr=[list(A[r*nc:(r+1)*nc]) for r in range(nr)]
 return rr,list(pv[:rank])
