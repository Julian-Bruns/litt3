import sympy as s
u,z=s.symbols('u z')
r=s.Function('r')(u); h=s.Function('h')(u)
A=s.Matrix([[0,r],[1,0]])
H=s.Matrix([1,z*h]); V=H.diff(u)+A*H; VV=V.diff(u)+A*V
D=s.det(s.Matrix.hstack(H,V))
rs=s.det(s.Matrix.hstack(VV,V))/D-s.diff(D,u,2)/(2*D)+3*s.diff(D,u)**2/(4*D**2)
lin=r.diff(u)*h+2*r*h.diff(u)-h.diff(u,3)/2
quad=r.diff(u,2)*h**2/2+2*r.diff(u)*h*h.diff(u)+r*h.diff(u)**2+h.diff(u)*h.diff(u,3)/2+s.Rational(3,4)*h.diff(u,2)**2
assert s.simplify(rs.subs(z,0)-r)==0
assert s.simplify(s.diff(rs,z).subs(z,0)-lin)==0
assert s.simplify(s.diff(rs,z,2).subs(z,0)/2-quad)==0
print('Wronskian normalization: linear and full quadratic graph variations verified')
B=s.Matrix([[0,25*r],[1,0]])
K=s.eye(2)
for j in range(5): K=s.simplify(5*K.diff(u)+B*K)
assert s.simplify(K[1,0]-5**4*(r*r+3*r.diff(u,2)))==0
print('K5 lower-left entry verified exactly')

# A second calculation: normalized cyclic-vector gauge over O4(F25)[u].
a=s.symbols('a'); modulus=625

def reduce(expr):
    poly=s.Poly(s.expand(expr),u,a)
    terms={}
    for (i,j), c in poly.terms():
        c=s.Rational(c)
        v=(int(c.p)*pow(int(c.q),-1,modulus)*pow(2,j//2,modulus))%modulus
        key=(i,j%2)
        terms[key]=(terms.get(key,0)+v)%modulus
    return sum(v*u**i*a**j for (i,j),v in terms.items())

def matred(M): return M.applyfunc(reduce)
def prod(X,Y): return matred(X*Y)
def derivative(X): return matred(X.diff(u))

rr=a*u**2+(a+1)*u+1
ss=5*(a*u**3+(a+1)*u**2+2*u+a)
AA=s.Matrix([[0,rr],[1,0]])
HH=s.Matrix([1,ss])
VV=matred(HH.diff(u)+AA*HH)
DD=reduce(s.det(s.Matrix.hstack(HH,VV)))
d=reduce(DD-1)
f=0; power=1
for n in range(4):
    f=reduce(f+s.binomial(s.Rational(-1,2),n)*power)
    power=reduce(power*d)
HHn=matred(f*HH)
VVn=matred(HHn.diff(u)+AA*HHn)
G=matred(s.Matrix.hstack(HHn,VVn))
assert reduce(G.det()-1)==0
conn=prod(G.adjugate(),matred(G.diff(u)+AA*G))
assert conn[0,0]==0 and conn[1,1]==0 and reduce(conn[1,0]-1)==0
invD=0; power=1
for n in range(4):
    invD=reduce(invD+(-1)**n*power); power=reduce(power*d)
V2=matred(VV.diff(u)+AA*VV)
formula=reduce(s.det(s.Matrix.hstack(V2,VV))*invD-s.Rational(1,2)*DD.diff(u,2)*invD+s.Rational(3,4)*DD.diff(u)**2*invD**2)
assert reduce(conn[0,1]-formula)==0
print('Independent cyclic-vector gauge and Wronskian formula agree over (Z/625)[a]/(a^2-2), with non-F5 coefficients')
print('ALL CHECKS PASSED')
