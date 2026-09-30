"""Universal identities only. Does not search for actual S, t, u, v."""
import sympy as s
x,y,a,b,c,d,A,B,C,D=s.symbols('x y a b c d A B C D')
N=a*x*x+(b-a*d)*x+c-b*d
Den=x-d
R=N/Den
S=lambda z:A*z+B+C/(z-D)
Q=A*N*N+(B-A*D)*N*Den+(C-B*D)*Den*Den-x*Den*(N-D*Den)
assert s.cancel((S(R)-x)*Den*(N-D*Den)-Q)==0
assert s.Poly(Q,x).degree()==4
assert s.factor(s.Poly(Q,x).LC())==a*(A*a-1)
assert s.factor(Q.subs(x,d))==A*c*c
f=lambda z:a*z+b+c/(z-d)
assert s.factor((f(x)-f(y))/(x-y)-(a-c/((x-d)*(y-d))))==0
nu=A*c*c/(a*(a*A-1))
assert s.factor(c*c/nu-a*a+a/A)==0
phi=lambda z:(a*z-a/A)/(z-a)
assert s.factor(phi(phi(x))-x)==0
assert s.factor((x-a)*(phi(x)-a)-(a*a-a/A))==0
print('PASS: composed quartic, leading coefficient, norm evaluation, secant involution')
# Cubic resolvent check, valid integrally and hence in characteristic five.
r=s.symbols('r0:4'); e1=sum(r)
e2=sum(r[i]*r[j] for i in range(4) for j in range(i+1,4))
e3=sum(r[i]*r[j]*r[k] for i in range(4) for j in range(i+1,4) for k in range(j+1,4))
e4=s.prod(r)
pairs=[r[0]*r[1]+r[2]*r[3],r[0]*r[2]+r[1]*r[3],r[0]*r[3]+r[1]*r[2]]
res=x**3-e2*x**2+(e1*e3-4*e4)*x+4*e2*e4-e1*e1*e4-e3*e3
assert s.expand(res-s.prod(x-z for z in pairs))==0
print('PASS: quartic cubic-resolvent formula')
# Exponent identities in the group with epsilon^29=H^13/R^48.
relation=(29,48,-13); bvec=(7,11,-3)
def sub(v,w): return tuple(x-y for x,y in zip(v,w))
def scale(n,v): return tuple(n*x for x in v)
assert sub(scale(13,bvec),(4,-1,0))==scale(3,relation)
assert sub(scale(48,bvec),(17,0,-1))==scale(11,relation)
assert sub(scale(29,bvec),(0,-17,4))==scale(7,relation)
assert sub(tuple(x+y for x,y in zip((1,0,0),scale(4,bvec))),(0,-4,1))==relation
print('PASS: local epsilon and branch-value exponent identities')
print('SymPy',s.__version__)
print('No global existence/nonexistence computation executed.')
