"""Exact bounded certificate; run with Sage 10.9 or compatible Sage.

No external programs, random choices, or floating-point root calculations.
All #E(F5)=5 short-Weierstrass models and all nonzero rational points
are checked. The coefficient of xy in the order-five function is one.
"""

from itertools import product

k = GF(5)
R.<x> = PolynomialRing(k)
S.<t> = PowerSeriesRing(k, default_prec=6)
Z.<T> = PolynomialRing(ZZ)
fields = {n: GF(5**n, name="a") for n in range(1, 8)}

models = [(a,b) for a,b in product(k,k)
          if 4*a**3+27*b**2 != 0
          and EllipticCurve(k,[a,b]).cardinality() == 5]
assert models == [(k(3),k(2)),(k(3),k(3))]

expected = {
    (2,1): ((2,44,158,572,3082,16574),(4,3,1,-4,0,0)),
    (2,2): ((2,68,158,572,3082,15638),(3,2,1,-2,0,0)),
    (3,3): ((8,68,122,572,2968,15638),(2,1,-2,-3,0,0)),
    (3,4): ((8,44,122,572,2968,16574),(4,1,-3,-4,0,0)),
}

def order_five_function(a,b,P):
    xp,yp = P[0],P[1]
    xs,ys = xp+t,S(yp)
    for _ in range(4):
        ys = (ys+(xs**3+a*xs+b)/ys)/2
    basis = [S(1),xs,ys,xs**2,xs*ys]
    M = matrix(k,5,5,lambda i,j:basis[j][i])
    K = M.right_kernel()
    assert K.dimension() == 1
    v = K.basis()[0]
    assert v[4] != 0
    v = v/v[4]
    A,B = v[0]+v[1]*x+v[3]*x**2, v[2]+x
    cubic = x**3+a*x+b
    assert A(xp)+B(xp)*yp == 0
    assert A(xp)-B(xp)*yp != 0
    # f=A+By: norm and pole order give div(f)=5P-5O exactly.
    assert A**2-B**2*cubic == -(x-xp)**5
    # Exact differential identity df/f=c dx/(2y).
    c = 4*v[3]
    assert c != 0
    assert 2*A.derivative() == c*B
    assert 2*B.derivative()*cubic+B*cubic.derivative() == c*A
    return A,B,v,c

def point_count(a,b,A,B,n):
    K = fields[n]
    m = gcd(6,K.cardinality()-1)
    exponent = (K.cardinality()-1)//m
    # Unique rational point over O on the smooth normalization.
    total = 1
    AK,BK = A.change_ring(K),B.change_ring(K)
    for xx in K:
        rhs = xx**3+K(a)*xx+K(b)
        if not rhs.is_square():
            continue
        for yy in rhs.sqrt(all=True):
            value = AK(xx)+BK(xx)*yy
            if value == 0:
                # Unique point above P, also after normalization.
                total += 1
            elif value**exponent == 1:
                total += m
    return ZZ(total)

def frobenius_from_counts(counts):
    power_sums = [5**n+1-counts[n-1] for n in range(1,7)]
    coeff = [ZZ(1)]
    for m in range(1,7):
        numerator = -sum(coeff[m-j]*power_sums[j-1]
                         for j in range(1,m+1))
        assert numerator % m == 0
        coeff.append(numerator//m)
    return (sum(coeff[j]*T**(12-j) for j in range(7))
            +sum(5**(6-j)*coeff[j]*T**j for j in range(6)))

checked = 0
for a,b in models:
    E = EllipticCurve(k,[a,b])
    for P in E.points():
        if P.is_zero():
            continue
        assert P.order() == 5
        A,B,v,c = order_five_function(a,b,P)
        counts = tuple(point_count(a,b,A,B,n) for n in range(1,7))
        required,traces = expected[(ZZ(b),ZZ(P[0]))]
        assert counts == required
        F = frobenius_from_counts(counts)
        assert F == prod(T**2-tr*T+5 for tr in traces)
        assert 12-F.change_ring(k).valuation() == 4
        print("E coefficients",a,b,"P",P,"f coefficients",tuple(v))
        print("counts",counts,"Frobenius",F.factor(),"p-rank",4)
        if b == 2 and P[0] == 1 and P[1] == 1:
            # Additional count not used in reconstruction.
            predicted_sum = 0
            for tr in traces:
                s0,s1 = ZZ(2),ZZ(tr)
                for n in range(2,8):
                    s0,s1 = s1,tr*s1-5*s0
                predicted_sum += s1
            n7 = point_count(a,b,A,B,7)
            assert n7 == 5**7+1-predicted_sum
            print("independent seventh count",n7)
        checked += 1
assert checked == 8
print("PASS: all eight marked F5 models have genus six and p-rank four.")
