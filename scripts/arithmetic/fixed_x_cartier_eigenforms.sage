"""Exact nonzero-Cartier-eigenvalue norm-squarefreeness test; no sampling.

The univariate finite algebra exhausts all algebraic-closure eigenforms;
it is not a search over a selected finite field.
"""
import time
started = time.monotonic()
k0 = GF(5)
P0 = PolynomialRing(k0, 'z')
z = P0.gen()
k = GF(25, 'a', modulus=z^2+4*z+2)
a = k.gen()
P = PolynomialRing(k, 'x')
x = P.gen()
F = (x^10+(4*a+2)*x^9+(a+4)*x^8+(3*a+1)*x^7+3*a*x^6
     +4*a*x^5+(3*a+4)*x^4+a*x^3+(3*a+3)*x^2
     +(4*a+2)*x+(2*a+1))
assert gcd(F,F.derivative()) == 1
N = matrix(k, 3, 6, lambda i,j: F[5*i+4-j] if 5*i+4-j>=0 else 0)
F3 = F^3
M = matrix(k, 6, 3, lambda i,j: F3[5*i+4-j] if 5*i+4-j>=0 else 0)
Mr = M.apply_map(lambda z:z^5)

H = N*Mr
row = vector(k, [0,0,1])
Obs = matrix(k, [row, row*H, row*H^2])
print('Observability determinant:', Obs.det(), flush=True)
assert Obs.det() != 0
assert Obs.det() == a+4 and H.det() != 0
ObsInv = Obs.inverse()
Rc = PolynomialRing(k, 'cc')
cc = Rc.gen()
hc = H.charpoly()
Pc = H.det()*cc^1302-hc[1]*cc^1300+H.trace()*cc^1250-1
assert Pc.degree() == 1302 and Pc.derivative() == 2*H.det()*cc^1301
assert gcd(Pc,Pc.derivative()) == 1
factors = Pc.factor()
assert factors.unit()*prod(f^m for f,m in factors) == Pc
print('Univariate factor degrees:', [(f.degree(),m) for f,m in factors], flush=True)
assert sorted(f.degree() for f,m in factors) == [1,1,52,624,624]
bad = []
for number,(factor,multiplicity) in enumerate(factors):
    assert multiplicity == 1
    assert factor.is_irreducible()
    Kc = Rc.quotient(factor, 'gamma')
    gamma = Kc.gen()
    vec = ObsInv.change_ring(Kc)*vector(Kc,[1,gamma^(-2),gamma^(-52)])
    assert vector(Kc,[z^25 for z in vec]) == gamma^2*H.change_ring(Kc)*vec
    assert vec[2] == 1
    Lvec = Mr.change_ring(Kc)*vec
    Rx = PolynomialRing(Kc, 'xx')
    xxx = Rx.gen()
    ax = xxx^2+vec[1]^5*xxx+vec[0]^5
    lx = sum(Lvec[j]*xxx^j for j in range(6))
    fx = sum(Kc(F[j])*xxx^j for j in range(11))
    norm = gamma*lx^3+fx*ax^3
    assert norm.degree() == 16 and norm[16] == 1
    repeated = gcd(norm,norm.derivative())
    print('Factor',number,'degree',factor.degree(),'repeated-root gcd degree',
          repeated.degree(),'elapsed',time.monotonic()-started,flush=True)
    if repeated.degree()>0:
        bad.append((factor,repeated))
print('ALL NONZERO-EIGENVALUE FORM NORMS SQUAREFREE:',len(bad)==0,flush=True)
if bad:
    print('Residual factors:',[(f.degree(),g.degree()) for f,g in bad],flush=True)
assert not bad
