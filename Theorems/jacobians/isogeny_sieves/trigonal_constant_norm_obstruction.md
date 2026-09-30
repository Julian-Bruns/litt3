# Constant-norm obstruction and unique two-torsion representatives

Version2,23September2026. The constant-norm criterion passed a focused
independent mathematical audit. The fixed-X uniqueness corollary below
is a direct Riemann--Roch consequence.

Let F in F25[x] be squarefree of degree10 and let X be the smooth
projective model of y^3=F. Suppose the Frobenius25 polynomial of J(X)
reduces modulo2 to an irreducible degree18 polynomial whose roots have
multiplicative order N, with Euler phi(N)>18. Then there are no rational
functions P,R in bar(F5)(x) satisfying

                            P^3+F=R^2.

For the fixed genus-nine X, the established polynomial has N=171 and
phi(N)=108. Consequently no bounded Kummer norm solution

                         P^3+FQ^3=R^2

has nonzero constant Q. All three Qdegree0 pole charts are therefore
excluded at once, including the open Pdegree6 and Pdegree4 charts.
The exclusion is over the full algebraic closure and does not depend
on a multiplier ansatz, coefficient-field search or newly computed
sixth-root zeta polynomial.

For this fixed \(X\), let \(O\) be its unique point at infinity.
Every nonzero \(L\in J(X)[2]\) satisfies
\[
h^0(L(7O))=0,\qquad h^0(L(8O))\le1,\qquad h^0(L(9O))=1.
\]
Hence \(L\) has a unique effective degree-nine representative \(D\).
The Kummer function with divisor \(2D-18O\) is unique up to scalar.
This concerns actual geometric representatives; it does not assert
reducedness of a polynomial norm scheme.

The mechanism uses the actual curve D:z^6=F. Its primitive-sixth
Jacobian factor has the same Frobenius polynomial modulo2 as J(X),
by equality of all unramified Euler factors and of the omitted local
factors. A norm solution gives an actual nonconstant primitive-sixth
map D->E:v^2=u^3+1. Since Frobenius25 on E is -5, the binary order
contradicts the degree of its required root-of-unity Weil eigenvalue.

For nonconstant Q, the fixed-X carriers and their backup-factor tests
are handled by the [complete sieve](backup_double_cover_exclusion.md).

[Proof](../../../Proofs/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md) · [Binary check](../../../scripts/arithmetic/check_degree2_frobenius_orbits.py).
