# Proof: primitive secants and simultaneous quotient bounds

25 September2026. The [statement](../../Theorems/cartier_and_spin/klein_four_simultaneous_quotients.md)
retains both actual endpoints and the specified V4 field. The original
unmarked common-cover problem remains open.

## Returned inputs and verification

The self-contained incoming package is retained at
[klein_four_secants](../../../litt3-computation-data/nonzero_pivot_secant_replies_20260925/secant/klein_four_secants/).
Its full verifier passed, including both preserved predecessor packages.
The exact conventions and original hypotheses are in PROBLEM.md.
These are reusable completed results with the following precise scope.

1. The simultaneous numerator representation and Fourier rank theorem
   are proved in previous/prior/REPORT.md, Sections4--6. For e<=13 odd,
   the space of pairs of degree at most (e-1)/2 with
   E dividing V-epsilon*t^7*U is one-dimensional. The two entries of
   its nonzero vector are nonzero. Generally the minimum degree is
   max(floor(e/2),e-7). Coefficients may lie anywhere in k.
2. The absence of affine, quadratic-polynomial, and fractional-linear
   endpoint relations, and the degree-(2,1) rational normal forms,
   are proved in previous/REPORT.md, Sections4--8, with the preceding
   affine argument in previous/prior/REPORT.md. These are actual field
   statements, not arbitrary polynomial ansatz exclusions.
3. REPORT.md, Sections3--5, proves that a rational involution secant
   forces all four leading labels to coincide at each endpoint.
   This includes repeated-two-label cases and arbitrary contact orders.
   Its formal identities,435 divided differences,120 root-pattern
   ranks,174 transverse coefficients and four nonmembership checks passed.
   No unknown higher branch coefficient is restricted to a finite field.
4. REPORT.md, Sections6--9, proves the genus bounds and numerical
   equality profiles. Its1,623,160 relaxed profiles are necessary counts,
   not actual curves. The minimum cubic branch count is88.

Original archives, reports, manifests and complete logs remain outside
the repository. Source copies are byte-exact under
[pro_pivot_secant_20260925](../../scripts/arithmetic/pro_pivot_secant_20260925/).
The local extension below closes the fully coalesced rational-secant
case left open by the returned proof.

## Local input for the final coalesced case

The all-orders resonance lemma is now proved in
[quartic comparison secant fields](quartic_comparison_secant_fields.md).
It applies to four distinct formal solutions with a common nonzero label,
F_B=2, F_BB=0 at that label, and U=alpha+t*C*B^4+O(t^2).
Opposite secants cannot agree: implicit solving forces the third
Fourier coordinate to have the sum of the other two orders, while
the differential equation forces all three orders to be2 modulo5.
The proof does not require a V4 action or a contact-order bound.

## Application to every involution

Suppose rho_sigma belongs to K. By returned input3, the four labels
over t=0 coincide at b0 and all four u-values have the same A-root
alpha. Put B_l=t^3 v_l/epsilon. Primitivity L=K(v) makes these series
distinct. Their Hensel expression is
\[
u_l=U_\alpha(t,B_l),\quad
U_\alpha(t,B)=\alpha+t\frac{[13]}{A'(\alpha)}B^4+O(t^2).
\]
Section3 of the returned report derives their common equation tB'=F(t,B)
and proves exactly F_B(0,b0)=2 and F_{BB}(0,b0)=0. Pair the four
embeddings as 1,sigma,tau,tau*sigma. Rationality of rho_sigma is
precisely the opposite-secant equality forbidden by the lemma.
Hence no rho_sigma lies in K. It belongs to the quadratic fixed
field because sigma changes the signs of its numerator and
denominator, so it generates that field.

Only t=0 is needed after the repeated-label reduction. There is no
bound on n. The fully coalesced boundary itself is not excluded;
only a rational secant on that boundary has been ruled out.

## Consequences for numerator pairs and genus

For the involution whose anti-invariant directions are i,j, write
u_i=a_i z_i, v_i=b_i z_i, and similarly for j. Its denominator is
nonzero by primitivity. Rationality of its secant is equivalent to
a_i b_j-a_j b_i=0, including individual zero components. Substitution
gives U_iV_j-U_jV_i!=0. None of the three numerator pairs is zero.

The Fourier input gives h_i<=b(e)+c_i. If e<=13 is odd, two attained
caps would put their pairs in the same one-dimensional minimal
space, contradicting independence. The three nonnegative integral
deficits therefore sum to at least2. With sum(c_i)=2j and
sum(h_i)=g+3 this gives the stated genus inequality.

Let a count simple common-pole points and j2 count fibers with
two triple common poles. Put kappa=(a-s)+3j2>=0. Then
\[
n=12+e+2j+\kappa.
\]
Subtracting from the genus inequality gives g<=n, except possibly
at e=14,kappa=0, where g<=n+1. In that exception n=26+2j,
0<=j<=14. Combine this with the prior g<=85. The complete returned
necessary-profile optimization gives at least88 cubic branch points
in the specified degree interval; it does not search actual models.

This closes an exceptional logical branch, but does not improve
the returned numerical genus table, which already uses the cap
deficits. Compatibility of the remaining three primitive secants,
both nonlinear endpoint identities and the same-source reconstruction
is still unresolved.
