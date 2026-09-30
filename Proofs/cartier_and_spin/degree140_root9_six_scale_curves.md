# Proof: the scale boundary after the full discriminant exclusion

[Statement](../../Theorems/cartier_and_spin/degree140_root9_six_scale_curves.md).
All source functions are the actual Cramer solutions; the scale is
never specialized in an exclusion.

## The highest scale coefficient

The two formal critical branches at infinity have leading terms
(2w/epsilon)tau^-11 and(epsilon/h)tau^-13. Their normalized critical
values have leading scale factors
\[
1+\frac{[24]^2\lambda}{s h^3}\tau^4,\qquad
1+\frac{3\epsilon^2\lambda}{h^3}\tau^4.
\]
The remaining terms have strictly positive excess of tau-order over
four times scale-degree. This expansion uses only the original graph
and F6=s h^3; it does not use either cubic discriminant equation.
Taking the cubic source norm, with T=tau^3 and lambda=w mu, gives
(1+U0 mu^3 T^4)(1+V0 mu^3 T^4). The weight inequality proves the
scale-degree bound. On its leading edge the exact binomial identity is
\[
\sum_{j=0}^{18}\binom{63}{j}\binom{63}{18-j}U_0^jV_0^{18-j}
=2(U_0V_0)^5(U_0-V_0)^2(U_0+V_0)^6.
\]
The constants U0,V0 are units and U0/V0=(sigma0/s)^3. The six
values follow. These are the same universal Newton-edge identities
used in the [finiteness proof](degree140_square_locus_finiteness.md),
now applied to the remaining discriminant-nonzero family.

## Geometry of the six ratio curves

The [exact Sage calculation](../../scripts/arithmetic/root9_six_scale_curves_20260928.sage)
proves f_sigma irreducible over K(q), and F_sigma squarefree of
degree24. It also checks pairwise coprimality of all six F_sigma,
and gcd(a_sigma,b)=gcd(a_sigma,F_sigma)=1. At q=0, u=0 is a
smooth K-point because e(0)=0 and c(0)!=0. The connected separable
function field therefore has constant field exactly K. Since K is
perfect, its curve is geometrically irreducible.

At a zero of a_sigma the root at infinity is simple because b is
nonzero. Every simple zero of F_sigma is a simple double-root
collision, with tame ramification index2; the third root is simple.
The normalizations have no other finite ramification. At q=infinity,
the coefficient degrees are(1,5,6,9). The Newton polygon gives two
branches with u/q^2 solving b5 z^2+e9=0, and one branch with
u/q^4=-b5/a1. Their nonzero leading roots are simple, so all three
branches are unramified. Hurwitz gives2g-2=-6+24, hence g=10.
The individual discriminant factor degrees are preserved in the exact
receipt; no K-rational-point enumeration substitutes for irreducibility.

## The leading cubic coefficient boundary

For the six sigmas, a_sigma=0 occurs at the K-values
\[
(340633,51793,33005,52163,296334,306848).
\]
In each fibre, the finite ratio algebra is the whole squarefree
quadratic b u^2+c u+e=0, with b,e nonzero. All original units and
the cubic discriminant remain nonzero. Thus these are exactly twelve
allowed finite ratios; the third projective root is at infinity and
is outside the original finite-u chart.

The original residual was reconstructed over each entire quadratic
algebra, retaining polynomial mu. Polynomial combinations of C71,C72
equal1. Independent Python quotient arithmetic checks all six identities,
all field conventions and the complete quadratic coverage. Therefore
(I,a_sigma)=(1) in each fixed-s chart.

## The zero constant coefficient boundary

Since q is already a unit, use ebar=e/q, squarefree of degree8.
Modulo ebar the selected nonzero root satisfies
\[
a_\sigma u^2+b u+c=0.
\]
The leading coefficient a_sigma and its discriminant are units in
K[q]/ebar for all six sigmas. Thus each complete algebra has rank16.
The [coordinate calculation](../../scripts/arithmetic/root9_six_scale_e_boundary_20260928.sage)
presents it as K[u]/m_sigma, with m_sigma squarefree of degree16,
and gives q as a polynomial in u. To certify that no solutions are
omitted, evaluate the original16 basis vectors q^i u^j,0<=i<8,
0<=j<2; their coefficient matrix has nonzero determinant. The two
defining equations hold in this quotient. These facts prove an
isomorphism of the complete algebras, rather than an embedding of
a selected subset.

The [native source calculation](../../scripts/arithmetic/root9_six_scale_boundaries_20260928.cpp)
reconstructs the actual residual and its tails in these six rank16
algebras. It produces all-scale Bezout identities1. The
[independent Python verifier](../../scripts/arithmetic/verify_root9_six_scale_boundaries_20260928.py)
checks them by multiplication, both defining equations, original units,
squarefreeness and invertibility of the16-by16 coverage matrix. All96
geometric ratios are therefore excluded, proving(I,e)=(1).

Both kinds of certificates hold in quotient rings, so infinitesimal
thickenings over their fibres cannot survive. After these exclusions,
the cubic is monic up to a unit, with unit constant coefficient and
unit discriminant by the preceding theorem. This proves the stated
finite etale rank-three formulation. The originally undecided whole
curve ideals are now settled by the following returned result.

Exact new witnesses and local commands are preserved in
[the evidence directory](../../../litt3-computation-data/root9_six_scale_local_20260928/).
See [the integration audit](../../Research/audits/COMPANION140_2026_09_28.md)
for recorded outcomes and the distinction from the received theorem.

## Whole-curve norm certificates, received29September

The complete reply is preserved, with its original source and evidence,
in [the six-exceptional archive tree](../../../litt3-computation-data/september29_replies/six_exceptional_final/six_exceptional/).
The algorithm and its scope were reviewed locally; its reported exact
computations are accepted without another wholesale replay, as requested
by the user. This is distinct from the earlier locally executed boundary
checks above. The provenance and focused review are recorded in
[the integration audit](../../Research/audits/THREE_REPLIES_2026_09_29.md).

Write Bn=q^(-n)Cn. For each of the six fixed sigmas the reply computes
these actual source tails in the WHOLE finite etale cubic algebra,
with mu still an indeterminate. For j=72,73 form the fixed-degree
Sylvester determinant
\[
z_j=\operatorname{Res}_{\mu}(B71,Bj).
\]
The Sylvester adjugate expresses z_j in (B71,Bj), including where
specialized degrees drop. Its rank-three algebra norm belongs to the
same ideal: Cayley--Hamilton writes the norm as z_j times a polynomial
in z_j with coefficients in the base ring. This step is an ideal
identity and is valid with nilpotents; it is not just a root-existence
test or a norm-zero test on one selected companion.

Multiplication by powers of original chart units clears the q-poles,
giving univariate polynomials M72,M73. Integral assignment duals bound
their degrees, including finite and infinite places. Exact interpolation
on two disjoint conjugate cosets in the quadratic extension of K,
with additional nodes when needed, uses more nodes than these proved
bounds. Therefore the full coefficient arrays represent the global
polynomials, not merely their values at a bounded collection of ratios.
All interpolation nodes and source-to-norm reconstruction are recorded
by the reply. The minus/plus curves are not identified by symmetry.

After removing only factors already invertible on the original chart,
the saved polynomials P,Q belong to J=(B71,B72,B73). In the delivered
certificates no Frobenius deflation is needed. Their exact identities are
\[
SP+TQ=1\quad(\sigma=112400,215500,164100),
\]
\[
SP+TQ=\Theta_\sigma^5\quad(\sigma=246025,360225,272625).
\]
Here each Theta_sigma is a degree49 polynomial whose ENTIRE cubic
boundary was separately excluded by exact finite-algebra identities.
In particular (B71,B72,Theta_sigma)=(1). Raising such a boundary
identity to the fifth power, and using Theta_sigma^5 in J, proves
1 in J also for every minus curve. Because q is a unit, this is the
asserted (C71,C72,C73)=(1). This accounts for all six curves, all cubic
companions, all geometric scales and every nonreduced specialization.

## Consequence on the remaining ratio surface

Let S be the original square coordinate ring. The preceding exclusions,
together with the already settled original boundaries, say that S/(s-sigma)
is the zero ring for each of the six distinct sigmas. Thus every s-sigma,
and their product s^6-sigma0^6, is a unit in S. The earlier leading-edge
formula now makes the degree54 coefficient of C72 a unit on the open
ratio base obtained by excluding these six curves. Divide C72 by it.
Its monic equation gives a free rank54 algebra before mu is inverted.
The full square quotient is obtained by imposing the other tails and
restricting to mu nonzero, so its geometric scale fibres have length
at most54. Localizing a finite algebra need not remain finite over the
base; no such stronger assertion is used here. The separate earlier
finiteness theorem for the full square locus remains available.
