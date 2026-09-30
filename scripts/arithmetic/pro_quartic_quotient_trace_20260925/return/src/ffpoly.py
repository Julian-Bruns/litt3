"""Univariate polynomial arithmetic over the explicit field protocol."""
def trim(a):
 a=list(a)
 while a and a[-1]==0:a.pop()
 return a

def add(a,b,F):
 out=[0]*max(len(a),len(b))
 for i in range(len(out)):out[i]=F.add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0)
 return trim(out)
def neg(a,F):return [F.neg(c) for c in a]
def sub(a,b,F):return add(a,neg(b,F),F)
def scale(c,a,F):return trim([F.mul(c,b) for b in a])
def mul(a,b,F):
 if not a or not b:return []
 z=[0]*(len(a)+len(b)-1)
 for i,c in enumerate(a):
  if c:
   for j,d in enumerate(b):
    if d:z[i+j]=F.add(z[i+j],F.mul(c,d))
 return trim(z)
def divmod_poly(a,b,F):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 q=[0]*max(0,len(a)-len(b)+1);ib=F.inv(b[-1])
 while len(a)>=len(b):
  d=len(a)-len(b);c=F.mul(a[-1],ib);q[d]=c
  for j,e in enumerate(b):a[j+d]=F.sub(a[j+d],F.mul(c,e))
  a=trim(a)
 return trim(q),a

def gcd(a,b,F):
 a=trim(a);b=trim(b)
 while b:a,b=b,divmod_poly(a,b,F)[1]
 return scale(F.inv(a[-1]),a,F) if a else []
