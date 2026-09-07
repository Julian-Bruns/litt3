# Proof: eliminate the polynomial columns from a full Hasse-jet test

[Statement](../Theorems/Thm_superelliptic_single_point_torsion_test.md).
Author /root,2026-09-07. No independent audit claimed for this record.

## 1. The exact jet matrix

The affine curve is smooth: at a root of F its x-derivative is nonzero,
and away from those roots its y-derivative is nonzero. It is C minus O.
Its functions have the unique form sum_(0<=j<m) A_j(x)y^j. The monomial
pole orders mi+dj are pairwise distinct for 0<=j<m because gcd(m,d)=1.
Consequently the monomials with mi+dj<=N form a basis of L(NO).

Write a=x(P), z=y(P) at a nonbranch point. Both F(a) and z are nonzero.
The local coordinate S=(x-a)/F(a) is separating, and

    y=z H_a(S),       H_a(0)=1,
    H_a(S)^m=F(a+F(a)S)/F(a).

Since m is a unit, the coefficients of H are determined recursively.
For degree n>=1 the coefficient on the right is the n-th Hasse
coefficient of F at x, multiplied by F(x)^(n-1), hence is polynomial.
The unknown n-th coefficient of H occurs with coefficient m. Induction
therefore constructs H in k[x][[S]], without division by F(x).

For each j, replace the x^i basis by (x-a)^i/F(a)^i and absorb the unit
z^j in its coefficient. This is an invertible change of basis after
specializing at P. The jet columns become S^i H_a(S)^j. The columns
j=0 are exactly1,S,...,S^b. They eliminate the first b+1 coefficients
of a jet independently and contribute nothing in degrees b+1,...,N-1.
The remaining matrix is exactly J_N(a).

Thus a nonzero f in L(NO) vanishes to order at least N at P precisely
when J_N(a) has nonzero kernel. A kernel vector determines the removed
polynomial coefficients uniquely. It cannot have every j>0 coefficient
zero: a polynomial of degree at most b<N cannot vanish to order N.
Conversely every nonzero kernel vector gives a nonzero function, because
the original monomial family is a basis. The zero has degree at least N,
and the pole divisor has degree at most N. They must therefore be exactly
N P and N O. This proves both directions, not just necessity.

An identity sum A_l Delta_l=F^e ensures full column rank whenever F(a)!=0.
All other points are the finite branch points and O. This accounts for
infinity separately rather than silently omitting it from an affine test.

The general criterion is independent of the cyclic-cubic torsion bound.
The former fixed-X order27 computation has been removed: the audited
bound9 in `cyclic_cubic_low_abel_torsion` makes its one-point conclusion
immediate from L(9O)=span(1,x,x^2,x^3). No computational certificate is
needed for that specialization.
