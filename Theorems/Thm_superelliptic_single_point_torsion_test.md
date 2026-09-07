# A polynomial Hasse-jet certificate for single-point torsion

Let C be the smooth projective curve y^m=F(x) over an algebraically
closed field k, where m>=2 is prime to char(k), F is squarefree of
degree d, and gcd(m,d)=1. Let O be the unique point at infinity.
Fix N>=1 and put b=floor(N/m). Form H(S) modulo S^N by

    H(0)=1,       H(S)^m=F(x+F(x)S)/F(x).

Its coefficients are polynomials in x. For every pair (i,j) with
1<=j<m, i>=0, mi+dj<=N, include one column in the polynomial matrix

    J_N(n;(i,j))=[S^(n-i)] H(S)^j,      b+1<=n<N.

Let c be its number of columns. Then at a finite nonbranch point P,

    N[P-O]=0  if and only if  rank J_N(x(P))<c.

For c=0 the right side is false. Thus if maximal minors Delta_l admit
a polynomial identity

    sum_l A_l(x) Delta_l(x)=F(x)^e,        e>=0,

there are no nonbranch points of W1(C,O) killed by N. This test uses
Hasse coefficients and is valid even when N>=char(k) or char(k)|N.
It does not use an ordinary-derivative Wronskian.

Version2, author proof,2026-09-07. The fixed-X computational special case
was removed: its conclusion now follows immediately from the audited
nine-torsion bound in `cyclic_cubic_low_abel_torsion`.
This does not classify W2/W3, mixed-prime torsion, translated pairs of
arbitrary points, atlases, or common covers.
[Proof](../Solutions/Sol_superelliptic_single_point_torsion_test.md).
