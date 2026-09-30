"""Exact K arithmetic, using only the Python standard library and a C++ helper.
K codes are the user's base-25 alpha-basis codes; all polynomial lists ascend.
"""
import ctypes as ct, json, pathlib, array, random
HERE=pathlib.Path(__file__).resolve().parent
ROOT=HERE.parent
lib=ct.CDLL(str(HERE/'libfield.so'))
lib.ff_init.restype=ct.c_int
GEN=lib.ff_init()
lib.ff_logs.restype=ct.POINTER(ct.c_int);lib.ff_exps.restype=ct.POINTER(ct.c_int);lib.ff_adds.restype=ct.POINTER(ct.c_uint16)
LOG=array.array('i',ct.string_at(lib.ff_logs(),390625*4))
EXP=array.array('i',ct.string_at(lib.ff_exps(),(2*390624+1)*4))
ADD=array.array('H',ct.string_at(lib.ff_adds(),625*625*2))
MOD=390624
def add(a,b):return ADD[(a%625)*625+b%625]+625*ADD[(a//625)*625+b//625]
def neg(a):return EXP[LOG[a]+MOD//2] if a else 0
def sub(a,b):return add(a,neg(b))
def mul(a,b):return EXP[LOG[a]+LOG[b]] if a and b else 0
def inv(a):
 if not a:raise ZeroDivisionError('K inversion of zero')
 return EXP[MOD-LOG[a]]
def div(a,b):return mul(a,inv(b))
def power(a,n):
 if a:return EXP[(LOG[a]*n)%MOD]
 if n<0:raise ZeroDivisionError('negative power of zero')
 return int(n==0)
def code(row):return sum(v*25**i for i,v in enumerate(row))
def trim(a):
 while a and not a[-1]:a.pop()
 return a
def pa(a,b):
 c=a[:]+[0]*max(0,len(b)-len(a))
 for i,v in enumerate(b):c[i]=add(c[i],v)
 return trim(c)
def pn(a):return [neg(v) for v in a]
def ps(a,b):return pa(a,pn(b))
def pc(a,c):return trim([mul(v,c) for v in a])
def pm(a,b):
 if not a or not b:return []
 av=(ct.c_int*len(a))(*a);bv=(ct.c_int*len(b))(*b);cv=(ct.c_int*(len(a)+len(b)-1))()
 lib.ff_polymul(av,len(a),bv,len(b),cv)
 return trim(list(cv))
def pp(a,n):
 if n<0:raise ValueError('polynomial negative power')
 r=[1]
 while n:
  if n&1:r=pm(r,a)
  a=pm(a,a);n//=2
 return r
def pd(a,b):
 if not b:raise ZeroDivisionError('polynomial zero divisor')
 if len(a)<len(b):return [],a[:]
 av=(ct.c_int*len(a))(*a);bv=(ct.c_int*len(b))(*b);q=(ct.c_int*(len(a)-len(b)+1))();r=(ct.c_int*len(a))()
 assert lib.ff_polydiv(av,len(a),bv,len(b),q,r)==0
 return trim(list(q)),trim(list(r))
def prem(a,b):return pd(a,b)[1]
def pexact(a,b):
 q,r=pd(a,b)
 if r:raise ArithmeticError('inexact polynomial division')
 return q
def pgcd(a,b):
 while b:a,b=b,prem(a,b)
 return pc(a,inv(a[-1])) if a else []
def pxgcd(a,b):
 s0,s1=[1],[];t0,t1=[],[1]
 while b:
  q,r=pd(a,b);a,b=b,r;s0,s1=s1,ps(s0,pm(q,s1));t0,t1=t1,ps(t0,pm(q,t1))
 z=inv(a[-1]);return pc(a,z),pc(s0,z),pc(t0,z)
def peval(a,x):
 r=0
 for v in reversed(a):r=add(mul(r,x),v)
 return r
def pder(a):return trim([mul(a[i],i%5) for i in range(1,len(a))])
def pmodpow(a,n,m):
 r=[1]
 while n:
  if n&1:r=prem(pm(r,a),m)
  a=prem(pm(a,a),m);n//=2
 return r
def rref(rows,nvars):
 if not rows:return [],[]
 nr=len(rows);nc=len(rows[0]);assert all(len(r)==nc for r in rows)
 a=(ct.c_int*(nr*nc))(*(v for r in rows for v in r));pv=(ct.c_int*min(nr,nvars))()
 rank=lib.ff_rref(a,nr,nc,nvars,pv)
 return [list(a[i*nc:(i+1)*nc]) for i in range(nr)],list(pv[:rank])
DATA=json.loads((ROOT/'inputs/data.json').read_text())
P=DATA['P'];A=DATA['A'];Q=DATA['Q'];B0=DATA['B0'];L0=DATA['L0'];r=DATA['r']
t=pc(pexact(A,[neg(25),1]),inv(13))
v=[neg(r),1]
epsilon=code(DATA['epsilon']);eta=code(DATA['eta']);Ca=code(DATA['Ca']);Cd=code(DATA['Cd'])
def czero():return [[],[],[]]
def cp(a):return [a[:],[],[]]
def cmn(i,j,c=1):
 out=czero();q,j=divmod(j,3);out[j]=[0]*i+pc(pp(P,q),c);return out
def ca(a,b):return [pa(x,y) for x,y in zip(a,b)]
def cn(a):return [pn(x) for x in a]
def cs(a,b):return ca(a,cn(b))
def cc(a,z):return [pc(x,z) for x in a]
def cx(a,p):return [pm(x,p) for x in a]
def cm(a,b):
 c=czero()
 for i in range(3):
  for j in range(3):
   z=pm(a[i],b[j]);j0=i+j
   if j0>=3:z=pm(z,P);j0-=3
   c[j0]=pa(c[j0],z)
 return c

def run_checks():
 rng=random.Random(20260927)
 for i in range(10000):
  a,b,c=[rng.randrange(390625) for _ in range(3)]
  assert mul(a,b)==lib.ff_slowmul(a,b)
  assert mul(a,add(b,c))==add(mul(a,b),mul(a,c))
  assert sub(add(a,b),b)==a
  if a:assert mul(a,inv(a))==1
 assert peval(DATA['alpha_minpoly'],25)==0
 assert power(5,2)==add(5,3)
 assert pder(Q)==pm(P,pp(A,2))
 assert not prem(ps(Q,pp(B0,5)),pp(P,2))
 assert not prem(ps(Q,pp(L0,5)),pp(A,3))
 assert peval(P,r)==0
 b,c,e=[DATA[z] for z in ['b','c','e']]
 assert ps(pp(c,2),pc(pm(b,e),3))==DATA['C']
 assert pgcd(DATA['C'],pder(DATA['C']))==[1]
 assert pgcd(b,c)==[1]
 print('Exact field, 10,000 randomized algebra identities, original input identities and C verified.')
if __name__=='__main__':run_checks()
