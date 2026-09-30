"""Complete degree-140 square scheme using exponent 13 and two auxiliaries.
The coefficient ring can be a polynomial ring over any characteristic-five
algebra. Only the original leading coefficient is inverted.

Output: 67 affine-linear forms in (a,b), five quadratics, and the normalized
candidate root. This is an equivalent full test, not just early square tails.
"""
from extension import E,Poly
from residual import sm,sf
N=141
LINEAR_INDICES=[n for n in range(71,141) if n not in (75,100,125)]
QUADRATIC_INDICES=[25,50,75,100,125]

def plus(a,b):return [x+y for x,y in zip(a,b)]
def scale(a,c):return [x*c for x in a]
def evaluate_linear(row,a,b):return row[0]+row[1]*a+row[2]*b

def build(A):
 """A is 141 ascending T coefficients, each a Poly in the original scale.
 A[0] must be a constant, invertible in the complete coefficient algebra.
 Quadratic coefficient order is 1,a,b,a^2,a*b,b^2.
 """
 assert len(A)==141 and A[0].degree()==0
 L=A[0][0];Li=L.inv();alpha=[p*Li for p in A]
 assert alpha[0]==Poly(1)
 a2=sm(alpha,alpha,N);a3=sm(a2,alpha,N)
 F=sm(a3,sf(a2,1,N),N) # 3+2*5=13
 z=Poly();one=Poly(1)
 D=[[one,z,z],[z,one,z],[z,z,one]]
 for j in range(3,6):
  row=[Poly(),Poly(),Poly()]
  for i in range(j):row=plus(row,scale(D[i],-F[25*(j-i)]))
  D.append(row)
 rows=[]
 for n in LINEAR_INDICES:
  row=[Poly(),Poly(),Poly()]
  for i in range(min(5,n//25)+1):row=plus(row,scale(D[i],F[n-25*i]))
  rows.append(row)
 Broot=[[F[n],F[n-25] if n>=25 else Poly(),F[n-50] if n>=50 else Poly()] for n in range(71)]
 quads=[]
 for n in QUADRATIC_INDICES:
  p=[Poly() for _ in range(6)]
  for i in range(max(0,n-70),min(70,n)+1):
   X,Y=Broot[i],Broot[n-i]
   for a,b,k in [(0,0,0),(0,1,1),(1,0,1),(0,2,2),(2,0,2),(1,1,3),(1,2,4),(2,1,4),(2,2,5)]:
    p[k]=p[k]+X[a]*Y[b]
  p[0]=p[0]-alpha[n];quads.append(p)
 assert len(rows)==67 and len(quads)==5
 # The first two quadratics solve the auxiliaries without a parameter pivot.
 p=alpha[1].frob(2);r=alpha[2].frob(2)
 aa=2*p;bb=p*p+2*r
 B=[evaluate_linear(row,aa,bb) for row in Broot]
 return {'alpha':alpha,'F':F,'D':D,'linear':rows,'quadratic':quads,'B_forms':Broot,
  'a_canonical':aa,'b_canonical':bb,'B':B}

def evaluate_quadratic(row,a,b):
 return row[0]+row[1]*a+row[2]*b+row[3]*(a*a)+row[4]*(a*b)+row[5]*(b*b)

def equations(model):
 a,b=model['a_canonical'],model['b_canonical']
 lin=[evaluate_linear(p,a,b) for p in model['linear']]
 qs=[evaluate_quadratic(p,a,b) for p in model['quadratic']]
 assert not qs[0] and not qs[1]
 return lin+qs[2:]

def check_identities(model):
 """Independent Frobenius-63 root and triangular auxiliary comparisons.
 These are polynomial identities in the unspecialized original scale.
 """
 al=model['alpha'];a2=sm(al,al,125);a3=sm(a2,al,125)
 c63=sm(sm(a3,sf(a2,1,125),125),sf(a2,2,125),125)
 assert model['B']==c63[:71]
 pp=al[1].frob(2);rr=al[2].frob(2)
 q0,q1=model['quadratic'][:2]
 assert q0==[pp,Poly(2),Poly(),Poly(),Poly(),Poly()]
 assert q1==[rr+al[25]*pp,2*(pp+al[25]),Poly(2),Poly(1),Poly(),Poly()]
 for j in (3,4,5):
  h=[Poly(),Poly(),Poly()]
  for i in range(j+1):h=plus(h,scale(model['D'][i],model['F'][25*(j-i)]))
  assert not any(h)
 fullres=sm(model['B'],model['B'],141)
 fullres=[fullres[n]-al[n] for n in range(141)]
 assert not any(fullres[:71])
 for n,p in zip(QUADRATIC_INDICES,model['quadratic']):
  assert evaluate_quadratic(p,model['a_canonical'],model['b_canonical'])==fullres[n]
 return fullres
