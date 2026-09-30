# Proof of the finite commutator criterion

Use the [statement](../../Theorems/cartier_and_spin/middle_finite_commutator_criterion.md).
This is a characteristic-free algebraic version of the common-eigenvector
criterion investigated in the literature review, with an additional
normal-ordering compression. No Hermitian form or positivity is used.

## The power-commutator criterion

Let K be the intersection of ker[U^i,V^j] for 1<=i,j<=n-1.
Cayley–Hamilton expresses every higher power in the preceding n powers.
Consequently every x in K satisfies [U^i,V^j]x=0 for all i,j>=0.
For such x,
\[
[U^i,V^j]Ux=[U^{i+1},V^j]x=0,
\qquad [U^i,V^j]Vx=[U^i,V^{j+1}]x=0.
\]
For the first equality use V^j Ux=U V^j x, and for the second use
U^i Vx=V U^i x. Thus K is invariant under both matrices, and their
restrictions commute. If K is nonzero, choose an eigenspace of U|K;
it is nonzero and invariant under V. An eigenvector for V in that
space is a common eigenvector. Conversely every common eigenvector
lies in K. For n=1 the result is immediate.

## A finite word bound

Set W0=ker C and recursively
\[
W_{d+1}=W_d\cap U^{-1}W_d\cap V^{-1}W_d.
\]
Equivalently Wd is the common kernel of Cw for all words of length
at most d. If Wd=Wd+1, this space is invariant under U and V.
The restrictions commute because Wd is contained in ker C.
A nonzero equality therefore supplies a common eigenvector, and
every common eigenvector lies in every Wd.

If C=0, U,V commute on the entire space and the result follows.
Otherwise dim W0<=n-1. If Wn-1 is nonzero, the n-1 transitions
cannot all be strict decreases, so some equality supplies a common
eigenvector. Hence the all-word stack through length n-1 is exact.

## Normal ordering over an arbitrary coefficient ring

The assertion is an equality of row modules over the original ring,
not merely an equality after passing to a fraction field.
Induct on word length, and at fixed length on the number of pairs
in which V precedes U. Replace an adjacent VU by UV-C. The identity
\[
Cw_1(VU)w_2=Cw_1(UV)w_2-(Cw_1)(Cw_2)
\]
reduces the inversion count in the first term. Every row of the
second term is a linear combination of rows of Cw2, with coefficients
in the original commutative ring. The length of w2 is at most two less
than the original word, so these rows belong to the shorter-word
module by induction. Repeating gives the normal-ordered generators
C U^a V^b. The reverse inclusion is immediate.

This identity survives all specializations. Combining it with the
word bound proves the stated120-block criterion for n=15.

## Application to H and exact limitations

For fixed z, H(b)s=0 says Us=-b0*s and Vs=-b1*s. Thus its existence
with arbitrary b0,b1 is precisely the common-eigenvector condition.
The normalization of nonzero z does not restrict these eigenvalues:
scaling z scales U,V and their eigenvalues together.

There are (15*16)/2=120 ordered pairs (a,b) with a+b<=14, and each
block has15 rows. Its degree is at most2+a+b<=16 because U,V are
linear in z. The rectangular power criterion uses14^2 blocks and
maximum degree28.

This criterion concerns the matrix of each actual geometric fiber.
Kernel computation over the rational function field can lose exceptional
fibers. A degree bound on matrix entries is not a degree bound on
polynomial Bezout identities. Neither an arbitrary nonzero kernel of
this necessary subsystem nor its numerical rank establishes the J
equations, the full Hom conditions, stability or target-extension lifting.

[Focused proof review](../../Research/audits/MIDDLE_FINITE_COMMUTATOR_2026_09_26.md).
