"""Exact F_(5^8), K[x], and K[x,y]/(y^3-P); no third-party packages."""
from pathlib import Path
from array import array
import ctypes, subprocess, json, sys
ROOT=Path(__file__).resolve().parents[1]
BUILD=ROOT/'build'; BUILD.mkdir(exist_ok=True)
LIB=BUILD/'native.so'
if not LIB.exists() or LIB.stat().st_mtime < max((ROOT/'src/native.cpp').stat().st_mtime,(ROOT/'src/ff.hpp').stat().st_mtime):
 subprocess.run(['g++','-O3','-std=c++17','-shared','-fPIC',str(ROOT/'src/native.cpp'),'-o',str(LIB)],check=True)
lib=ctypes.CDLL(str(LIB)); lib.init_field.restype=ctypes.c_uint32
GENERATOR=lib.init_field(); lib.dump_field.argtypes=[ctypes.c_char_p];lib.dump_field(str(BUILD).encode())
def readarr(file,code):
 a=array(code);a.frombytes((BUILD/file).read_bytes());return a
ADD=readarr('add625.bin','H');NEG=readarr('neg.bin','I');LOG=readarr('log.bin','I');EXP=readarr('exp.bin','I')
QFIELD=390625;ORDER=390624
def add(a,b):return ADD[(a%625)*625+b%625]+625*ADD[(a//625)*625+b//625]
def neg(a):return NEG[a]
def sub(a,b):return add(a,NEG[b])
def mul(a,b):return EXP[LOG[a]+LOG[b]] if a and b else 0
def inv(a):
 if not a:raise ZeroDivisionError
 return EXP[ORDER-LOG[a]]
def div(a,b):return mul(a,inv(b))
def power(a,n):
 if n==0:return 1
 if a==0:
  if n<0:raise ZeroDivisionError
  return 0
 return EXP[(LOG[a]*n)%ORDER]
def scalar(n):return n%5

def trim(a):
 a=list(a)
 while a and a[-1]==0:a.pop()
 return a

def padd(a,b):return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def pneg(a):return [neg(c) for c in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([mul(x,c) for x in a])
def pmul(a,b):
 if not a or not b:return []
 aa=(ctypes.c_uint32*len(a))(*a);bb=(ctypes.c_uint32*len(b))(*b);oo=(ctypes.c_uint32*(len(a)+len(b)-1))()
 lib.polymul(aa,len(a),bb,len(b),oo)
 return trim(oo)
def ppow(a,n):
 if n<0:raise ValueError
 r=[1]
 while n:
  if n&1:r=pmul(r,a)
  a=pmul(a,a);n//=2
 return r

def pdivmod(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 q=[0]*max(0,len(a)-len(b)+1);ib=inv(b[-1])
 while len(a)>=len(b):
  j=len(a)-len(b);c=mul(a[-1],ib);q[j]=c
  for k,v in enumerate(b):a[k+j]=sub(a[k+j],mul(c,v))
  a=trim(a)
 return trim(q),a

def pquo(a,b):
 q,r=pdivmod(a,b)
 if r:raise ArithmeticError(f'nonzero remainder {r}')
 return q

def pmod(a,b):return pdivmod(a,b)[1]
def peval(a,v):
 r=0
 for c in reversed(a):r=add(mul(r,v),c)
 return r

def pder(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def pgcd(a,b):
 while b:a,b=b,pmod(a,b)
 return pscale(a,inv(a[-1])) if a else []

P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
B0=[8,14,19,2,10,19,3,24,18,16]
L0=[18,20,20,15]
alpha=25
t=pquo(A,pscale([neg(alpha),1],13))
EPS=add(add(24,mul(4,alpha)),mul(23,power(alpha,3)))
ETA=add(add(11,mul(18,power(alpha,2))),mul(20,power(alpha,3)))
CD=add(add(add(3,mul(10,alpha)),power(alpha,2)),mul(14,power(alpha,3)))
PSISCALE=299619
A0=[89654,311173,214299,163299,315361,33043,356725,245794]
A1=[0,299833,232505]
QEX=15383

ZERO=[[],[],[]]
def cp(a):return [list(v) for v in a]
def constant(a):return [[a] if a else [],[],[]]
def frompoly(a):return [list(a),[],[]]
def cadd(a,b):return [padd(a[i],b[i]) for i in range(3)]
def cneg(a):return [pneg(v) for v in a]
def csub(a,b):return cadd(a,cneg(b))
def cscale(a,b):return [pscale(v,b) for v in a]
def cmul(a,b):
 r=[[],[],[]]
 for i in range(3):
  for j in range(3):
   v=pmul(a[i],b[j])
   if i+j>=3:v=pmul(v,P)
   r[(i+j)%3]=padd(r[(i+j)%3],v)
 return r

def cpow(a,n):
 r=constant(1)
 while n:
  if n&1:r=cmul(r,a)
  a=cmul(a,a);n//=2
 return r

def monomial(i,j):
 r=[[],[],[]];r[j]=[0]*i+[1];return r

def cmulpoly(a,p):return [pmul(v,p) for v in a]
def cdiv_y(a,n):
 # a_j y^j / y^n; reduce j-n modulo 3, divide by needed P powers.
 r=[[],[],[]]
 for j in range(3):
  k=(j-n)%3;e=(j-n-k)//3
  r[k]=pmul(a[j],ppow(P,e)) if e>=0 else pquo(a[j],ppow(P,-e))
 return r

def crem_y(a,n):
 return [pmod(v,ppow(P,max(0,(n-j+2)//3))) for j,v in enumerate(a)]
def crem_poly(a,p):return [pmod(v,p) for v in a]
def pole(a):return max([3*(len(v)-1)+10*j for j,v in enumerate(a) if v] or [-10**9])
def coeff(a,i,j=0):return a[j][i] if i<len(a[j]) else 0

def basis(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def flatten(a,bounds):
 return [a[j][i] if i<len(a[j]) else 0 for j,n in enumerate(bounds) for i in range(n)]
def solve_affine(rows,ncols):
 mat=array('I',(x for row in rows for x in row));piv=(ctypes.c_int*min(len(rows),ncols+1))()
 ptr=(ctypes.c_uint32*len(mat)).from_buffer(mat)
 rank=lib.rref(ptr,len(rows),ncols+1,piv)
 piv=list(piv)[:rank]
 if ncols in piv:raise ArithmeticError('inconsistent affine system')
 free=[c for c in range(ncols) if c not in piv]; particular=[0]*ncols
 for i,c in enumerate(piv):particular[c]=mat[i*(ncols+1)+ncols]
 ker=[]
 for f in free:
  v=[0]*ncols;v[f]=1
  for i,c in enumerate(piv):v[c]=neg(mat[i*(ncols+1)+f])
  ker.append(v)
 return particular,ker,{'rank':rank,'free_columns':free,'pivot_columns':piv}
def dot(a,b):
 r=0
 for x,y in zip(a,b):r=add(r,mul(x,y))
 return r

def check_affine(rows,p,k):
 assert all(dot(row[:-1],p)==row[-1] for row in rows)
 assert all(all(dot(row[:-1],v)==0 for row in rows) for v in k)
