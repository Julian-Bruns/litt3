#!/usr/bin/env python3
"""Reproduce small polynomial certificates, using only the Python standard library.
No import of endpoint_probe or its arithmetic implementation.
"""
import argparse, json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
I=json.loads((ROOT/'inputs'/'exact_inputs.json').read_text())

def add(a,b):return ((a%5+b%5)%5)+5*((a//5+b//5)%5)
def neg(a):return (-(a%5)%5)+5*((-(a//5))%5)
def mul(a,b):
 x,y=a%5,a//5;z,w=b%5,b//5
 return (x*z+3*y*w)%5+5*((x*w+y*z+y*w)%5)
def power(a,n):
 r=1
 while n:
  if n&1:r=mul(r,a)
  a=mul(a,a);n//=2
 return r
def inv(a):
 assert a
 return power(a,23)
def trim(a):
 a=list(a)
 while a and a[-1]==0:a.pop()
 return a
def plus(a,b):
 c=[0]*max(len(a),len(b))
 for i,x in enumerate(a):c[i]=x
 for i,x in enumerate(b):c[i]=add(c[i],x)
 return trim(c)
def minus(a,b):return plus(a,[neg(x) for x in b])
def times(a,b):
 if not a or not b:return []
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
 return trim(c)
def divmod_poly(a,b):
 a=trim(a);b=trim(b);assert b
 q=[0]*max(0,len(a)-len(b)+1);bi=inv(b[-1])
 while len(a)>=len(b):
  d=len(a)-len(b);c=mul(a[-1],bi);q[d]=c
  a=minus(a,[0]*d+[mul(c,x) for x in b])
 return trim(q),a
def mod(a,b):return divmod_poly(a,b)[1]
def modpow(a,n,m):
 r=[1];a=mod(a,m)
 while n:
  if n&1:r=mod(times(r,a),m)
  a=mod(times(a,a),m);n//=2
 return r
def gcd(a,b):
 while b:a,b=b,mod(a,b)
 return [mul(x,inv(a[-1])) for x in a] if a else []
def diff(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def mono(c,n):return [0]*n+[c]
def rawmoment(h):
 r=[]
 for name,m in [('I2',2),('I3',3)]:
  for j in I[name]:r=plus(r,mono(m,(h*j)%29))
 return r

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument("--write",action="store_true",help="regenerate deterministic arithmetic evidence")
 args=parser.parse_args()
 f=I['zeta_minimal_polynomial'];A=I['A'];P=I['P'];X=[0,1]
 assert all((b*b-b-3)%5 for b in range(5))
 assert gcd(A,diff(A))==[1] and gcd(A,P)==[1]
 assert gcd(P,diff(P))==[1]
 assert modpow(X,25**4,A)==X
 assert gcd(A,minus(modpow(X,25**2,A),X))==[1]
 assert modpow(X,25**7,f)==X
 assert gcd(f,minus(modpow(X,25,f),X))==[1]
 assert mod(minus(mono(1,29),[1]),f)==[]
 assert 29*I['B_inverse_exponent']%(25**4-1)==1
 print('PASS: beta quadratic, A quartic, and zeta polynomial are irreducible')
 print('PASS: P is squarefree, gcd(P,A)=gcd(A,A\')=1, zeta has order 29')
 print('PASS: inverse of 29 modulo 25^4-1 is 67349')
 quotients={}
 for h,target in [(3,[1,0,0,4]),(-1,[8])]:
  q,r=divmod_poly(minus(rawmoment(h),target),f)
  assert r==[]
  assert minus(rawmoment(h),target)==times(f,q)
  quotients[str(h)]={'raw_moment':rawmoment(h),'reduced_moment':target,'quotient':q}
  print(f'PASS: M_{h} = {target}, with exact degree-{len(q)-1} quotient')
 def mom(h):return mod(rawmoment(h),f)
 eps=[0,0,23]
 assert mod(minus(times(eps,minus([1],mom(-2))),minus([17],mom(-6))),f)==[]
 assert mod(minus(times(eps,minus([17],mom(6))),minus([1],mom(2))),f)==[]
 print('PASS: both supplied moment equations hold')
 eta_over4=mul(I['eta'],4)
 endpoint_t1=plus(times([12],eps),[4])
 trace_t1=times([eta_over4],minus(times(eps,mom(3)),mom(-1)))
 H=minus(endpoint_t1,trace_t1)
 assert H==[11,0,19,0,0,21]
 assert 0<len(H)-1<len(f)-1 and H[0]!=0
 print('PASS: endpoint coefficient minus trace coefficient = [11]+[19]Z^2+[21]Z^5')
 print('PASS: nonzero degree 5 < irreducible degree 7; contradiction for every root zeta')
 zq,zr=divmod_poly(minus(mono(1,29),[1]),f);assert not zr
 out={'moment_division_witnesses':quotients,'zeta_order_quotient':zq,
      'eta_over_4':eta_over4,'endpoint_trace_t1':endpoint_t1,'prescribed_trace_t1':trace_t1,
      'obstruction_polynomial':H,'obstruction_degree':len(H)-1,
      'zeta_minimal_degree':len(f)-1,'status':'all exact checks passed; no search'}
 path=ROOT/'evidence'/'arithmetic.json'
 if args.write:path.write_text(json.dumps(out,indent=2)+'\n')
 else:assert json.loads(path.read_text())==out, 'saved arithmetic certificate differs'
 print('Arithmetic verification: ALL CHECKS PASSED')
if __name__=='__main__':main()
