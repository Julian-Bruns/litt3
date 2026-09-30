# Imported from the user-supplied Pro certificate, 23 September 2026.
# Original bytes and provenance are retained in litt3-computation-data.
"""Exact F25 certificate for the new line in the positive Cartier plane."""
P=5
def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return (-a%5)%5+5*((-(a//5))%5)
def sub(a,b): return add(a,neg(b))
def mul(a,b):
 a0,a1=a%5,a//5; b0,b1=b%5,b//5
 return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
def power(a,n):
 r=1
 while n:
  if n&1:r=mul(r,a)
  a=mul(a,a);n//=2
 return r
def inv(a):
 if not a:raise ZeroDivisionError
 return power(a,23)
def trim(a):
 a=list(a)
 while a and a[-1]==0:a.pop()
 return a
def pa(a,b): return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def pn(a):return [neg(x) for x in a]
def ps(a,b):return pa(a,pn(b))
def pm(a,b):
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
 return trim(c)
def sc(a,s):return trim([mul(x,s) for x in a])
def pd(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def pdiv(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 q=[0]*max(0,len(a)-len(b)+1)
 while a and len(a)>=len(b):
  n=len(a)-len(b);t=mul(a[-1],inv(b[-1]));q[n]=t
  a=ps(a,[0]*n+sc(b,t))
 return trim(q),a
def gcd(a,b):
 a=trim(a);b=trim(b)
 while b:a,b=b,pdiv(a,b)[1]
 return sc(a,inv(a[-1])) if a else []
def ppow(a,n):
 r=[1]
 while n:
  if n&1:r=pm(r,a)
  a=pm(a,a);n//=2
 return r

# Codes n0 + 5*n1 represent n0 + n1*a, where a^2 = a + 3.
def cartier_polynomial(p):
    """C(p(x) dx): retain exponents 4 mod 5, then take fifth roots."""
    return trim([power(p[j], 5) for j in range(4, len(p), 5)])

P_curve = [11,22,18,5,19,20,15,16,9,22,1]
A = [1,21,14,22,13]
W = [3,1,13,11,8,17,9,3]
q = [[24,2,1], [5,16,0,1], [5,20,0,0,8,1]]
r2 = [[19,1], [neg(16),4], [20,14,15]]
v = [[10,13], [0,22], [8]]

# The displayed vector is in the kernel of the quotient row.
row_check = []
evaluation_check = []
for vi, ri, qi in zip(v, r2, q):
    row_check = pa(row_check, pm(vi, ri))
    evaluation_check = pa(evaluation_check, pm(ppow(vi,5), qi))
assert row_check == []
assert evaluation_check == ppow(A,2)
assert cartier_polynomial(pm(P_curve,ppow(A,2))) == []

# The intersection divisor of the original radical and the new line.
B = [10,22,11,13,20]
wronskian_factor = ps(
    sc(pm(pm(P_curve,W),pd(A)),2),
    pm(A,pa(sc(pm(pd(P_curve),W),2),pm(P_curve,pd(W))))
)
assert wronskian_factor == ppow(B,5)
assert gcd(B,pd(B)) == [1]
for polynomial in [P_curve, W, A]:
    assert gcd(B,polynomial) == [1]

print('Verified: r2 dot v = 0.')
print('Verified: sum(v_i^5 q_i) = A^2.')
print('Verified: Cartier(A^2 dx/y^2) = 0.')
print('Verified: 2 P W A\' - A(P\' W/3 + P W\') = B^5.')
print('B, ascending coefficient codes:', B)
print('Verified: B is squarefree and coprime to P, W, and A.')
