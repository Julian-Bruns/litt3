"""Exact characteristic-five jet identities; no endpoint enumeration."""
R = PolynomialRing(GF(5), names=('a','b','c','d','e','h'))
a,b,c,d,e,h = R.gens()
K = R.fraction_field()
def D(f):
    f = K(f)
    return sum(f.derivative(x)*y for x,y in zip((a,b,c,d),(b,c,d,e)))
def E(r):
    return D(D(r))-3*r*r
r0 = c/a
jm = 3*a*a*e+4*a*b*d+3*a*c*c+b*b*c
assert 3*a**3*E(r0) == jm
assert 3*a**3*E(r0-a) == jm+a**5
assert E(r0+a) == E(r0-a)
assert E(r0+h*a)-E(r0) == -3*h*h*a*a
# D^4(sqrt(a))/sqrt(a), calculated without a radical extension.
vlog = K(b)/(2*a)
vder = K(1)
for _ in range(4):
    vder = D(vder)+vlog*vder
assert 2*vder == E(r0)
# The companion p-curvature identity is valid before imposing dormancy.
M = matrix(K, [[0,1],[a,0]])
Mn = identity_matrix(K,2)
for _ in range(5):
    Mn = matrix(K,2,2,[D(x) for x in Mn.list()])+Mn*M
ea = E(a)
assert Mn == matrix(K,[[D(ea),3*ea],[D(D(ea))+3*a*ea,-D(ea)]])
Bn = identity_matrix(K,2)
for _ in range(5):
    Bn = matrix(K,2,2,[D(x) for x in Bn.list()])-M*Bn
assert Bn == -Mn
detpsi = Mn.det()
assert D(detpsi) == 0
detpoly = R(detpsi)
assert detpoly.total_degree() == 5
assert sum(coef*R.monomial(*exps) for exps,coef in detpoly.dict().items() if sum(exps)==5) == 4*a**5
# Factoring the determinant on a common-connection line only needs a''=r0*a.
sq = K(a*a)
bracket = D(sq)**2+3*sq*(D(D(sq))+3*(r0+h*a)*sq)
assert bracket == 4*h*a**5
# Linearized nilpotent curvature splits into the two dormant Bol kernels.
J = PolynomialRing(GF(5), names=tuple('a'+str(i) for i in range(5))+tuple('u'+str(i) for i in range(5)))
ja = J.gens()[:5]; ju = J.gens()[5:]
JK = J.fraction_field()
def JD(f):
    f = JK(f)
    return sum(f.derivative(ja[i])*ja[i+1]+f.derivative(ju[i])*ju[i+1] for i in range(4))
aa,uu = ja[0],ju[0]
rr = JK(ja[2]/aa)
ee = JD(JD(rr))-3*rr**2-3*aa**2
def BolQuot(v):
    return (JD(JD(v))-rr*v)/aa
fourth = JK(aa**2*uu)
for _ in range(4): fourth = JD(fourth)
assert fourth == aa**4*(BolQuot(BolQuot(uu))-uu)+3*aa**2*uu*ee
curv = 3*aa**2
de = JD(JD(uu))-rr*uu
linear_det = -2*JD(curv)*JD(de)-3*de*JD(JD(curv))-3*curv*JD(JD(de))-9*uu*curv**2-18*rr*curv*de
assert linear_det-fourth == 2*aa**2*uu*ee
# A regular local active nilpotent connection can have higher curvature zeros.
# Keep this independent of any deformation-data extension convention.
P = PolynomialRing(GF(5), 't')
t = P.gen()
K1 = P.fraction_field()
a1 = K1(t**7/(1+t**11))
r1 = 3*a1.derivative(2)/a1+(a1.derivative()/a1)**2
e1 = r1.derivative(2)-3*r1**2
assert e1 == 3*a1
dinv = (1/a1).derivative(4)
# Sage may return an unreduced fraction and compare it falsely to a scalar.
assert dinv.numerator()+dinv.denominator() == 0
psi1 = -matrix(K1, [[e1.derivative(),3*e1],
                    [e1.derivative(2)+3*r1*e1,-e1.derivative()]])
assert psi1.det() == 0 and psi1 != 0
def vzero(f):
    return f.numerator().valuation(t)-f.denominator().valuation(t)
assert vzero(r1) == 9
assert sorted(vzero(f) for f in psi1.list()) == [5,6,6,7]
assert vzero(-e1.derivative()/(3*e1)) == -1
print('PASS: Cartier radicals, secants, tangents, horizontal determinant, fifth-power leading term, nilpotent line')
