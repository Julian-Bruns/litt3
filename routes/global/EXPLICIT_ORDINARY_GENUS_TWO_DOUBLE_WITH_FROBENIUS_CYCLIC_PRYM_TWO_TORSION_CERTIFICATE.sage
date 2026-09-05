# Exact certificate; run with SageMath. No search or external data.
R = PolynomialRing(GF(5), 't')
t = R.gen()
f = t*(t-1)
c = t^3+t+1
g = (t-2)*c
F = f*g
assert c.is_irreducible()
assert F.is_squarefree() and F.degree() == 6
assert g == t^4+3*t^3+t^2+4*t+3
assert F == t^6+2*t^5+3*t^4+3*t^3+4*t^2+2*t

# Hyperelliptic Hasse--Witt matrices: entry (i,j) is [t^(5*i-j)]F^2.
H_Y = matrix(GF(5), 2, 2, lambda i,j: (F^2)[5*(i+1)-(j+1)])
H_E = (g^2)[4]
assert H_Y == matrix(GF(5), [[3,1],[3,4]])
assert H_Y.det() == 4 and H_E == 1
assert sorted(h.degree() for h,e in g.factor()) == [1,3]

# A (1,3) permutation of the four branch points cycles their three
# unordered partitions into two pairs, i.e. the nonzero elliptic 2-torsion.
parts = [frozenset((frozenset((0,i)), frozenset(set(range(4))-{0,i})))
         for i in range(1,4)]
fr = (0,2,3,1)
action = [parts.index(frozenset(frozenset(fr[j] for j in pair)
                              for pair in part)) for part in parts]
assert action == [1,2,0]

# Independent elementary check: the monic quartic has two rational
# points at infinity; its five rational points form an odd-order group.
E_points = 2 + sum(1 if g(a) == 0 else (2 if g(a).is_square() else 0)
                   for a in GF(5))
assert E_points == 5
assert gcd(f,g) == 1 and f.is_squarefree()
print('PASS: Y Hasse--Witt =', H_Y.list(), 'det =', H_Y.det())
print('PASS: E Hasse invariant =', H_E, '; #E(F5) =', E_points)
print('PASS: Frobenius on nonzero Prym 2-torsion is the 3-cycle', action)
