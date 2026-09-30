# Proof: finiteness of all eleven degree140 square loci

The inputs and the open parameter charts are those of
[the nonzero-pivot theorem](../../Theorems/cartier_and_spin/degree140_nonzero_pivot_reduction.md).
All parameters are geometric. Evidence for the three received replies
is preserved under `../../../litt3-computation-data/overnight_three_replies_20260926/`.
The source copies are in
`../../scripts/arithmetic/pro_finite_square_secant_20260926/`.

## A square-limit principle

Suppose a polynomial over a discrete valuation field becomes a square
over a finite extension. Extract the minimum coefficient valuation.
The nonzero residual polynomial is a scalar times a square over the
residue algebraic closure: this follows from the multiplicativity of
the Gauss valuation and reduction of a square root. Consequently an odd
degree, or an odd valuation at an x-place, excludes such a limit.

Square roots of fixed degree are finite over the square locus when the
leading coefficient is nonzero. A positive-dimensional square component
therefore lifts to a curve carrying its square root. We can apply the
principle at points of a proper normalization of this curve, including
points outside the original parameter chart.

## Constant family

For fixed q!=0, the normalized residual is polynomial in H and mu,
with total degree at most36 and mu-degree at most6. The complete
top homogeneous part, computed from the H-linear source, is
\[
H^{36}A_\infty(q,x)+H^{33}\mu^3B_\infty(q,x)
 +H^{30}\mu^6C_\infty(q,x).
\]
The x-degrees of these three polynomials are119,111,103, with leading
coefficients respectively <53870>q^7, <292517>q^6 and4q^5 in the exact
K-code of the input. Each is nonzero for every geometric q!=0.

The coefficient of mu^6 at any fixed H!=0 is nonzero and nonsquare.
Indeed it is a square divided by q^15*t^15; its valuation at a simple
root of t is odd. Nonvanishing follows because the degree-five polynomial
Z^5+Qbar is irreducible over k(X), whereas the critical polynomial has
degree two. Here dQbar!=0, so Qbar is not a fifth power.

If H were constant on a square curve, mu would be nonconstant and a
pole of mu would give this forbidden square limit. Hence H is nonconstant.
At a pole of H put e=-ord(H)>0 and m=-ord(mu). For m<e the unique
leading parameter monomial is H^36; for m=e its coefficient is
Ainf+l^3 Binf+l^6 Cinf, still of odd degree119. For m>e the unique
leading monomial is H^30 mu^6, of odd x-degree103. The total-degree
and mu-degree bounds show that no lower term can change these initials.
The case mu identically zero gives Ainf directly. Every alternative is
impossible. Thus every fixed-q square fiber is zero-dimensional.

The preceding nonzero-pivot theorem already gives a finite q-image for
this family. Finite type now implies that its full square locus is finite.

## Linear families: compactification in both ratio directions

For each root r of P use the actual Cramer chart and v=x-r. The following
boundary facts hold uniformly, with no omitted geometric specializations.
Their exact reconstruction is retained in `linear/REPORT.md`, Sections6--7,
and the71 regenerated data files in the same archive.

At H=infinity and any q different from zero and the Cramer pivot,
the source of highest H-degree is v*y^2 times a cubic S00 in Z.
For scale growing more slowly than H^2, the initial residual has
square class v*t*a*V*K0, with the exact polynomial factors defined
by the universal fixed-degree resultant. At x=r its valuation is
odd except at five explicitly algebraic ratios and one further ratio.
At the latter the valuation remains odd after its exact order-two
correction. In the degree-five etale algebra of the former ratios,
the reversed square error at degree49 is a unit. All leading
coefficients used here are units or are treated separately.

For scale comparable with H^2, the initial residual has odd valuation
13 at x=r, or21 at the exceptional ratio. For faster scale growth it
is a nonzero square multiple of t*v. These exclude every H-infinity
limit, including arcs with varying q approaching any allowed value.

Over the already excluded highest-coefficient ratio q_r, all remaining
finite-H limits are also excluded:

- At infinite scale the leading residual is a nonzero square multiple
  of t*v, even at H=0 or F6=0.
- At H=0 the residual has degree137, with nonzero leading coefficient
  independent of scale.
- At H!=0 and F6=0, a complete Bezout identity proves F7!=0, and the
  residual has degree139 independently of finite scale.
- At zero scale with H*F6!=0, the first two required square errors
  have gcd exactly H^375. Their retained Bezout identity excludes
  every point of this open part.
- The remaining finite nonzero-scale part is the previously excluded
  degree140 coefficient-boundary fiber.

If a square component had nonconstant q, a proper curve in it would
have a point over q_r. Every possible H and scale limit there has just
been excluded. Hence the q-image is finite. For a fixed allowed q,
the scale fibers are finite, since the nonzero scale-infinity coefficient
is nonsquare. A positive-dimensional component would therefore have
nonconstant H and a forbidden point at H=infinity. The full square
locus is consequently finite in every linear family.

These compactification arguments, rather than absence of selected
finite-field points, establish the geometric conclusion.

## The improved scale bound

Write the two critical-value jets in the notation of the received
linear continuation. Put a=gamma_big^3, b=gamma_small^3 and
k_big=3*gamma_big^2*beta_big, k_small=3*gamma_small^2*beta_small.
The leading scale coefficients of square errors72,80,74 give a
nonzero scale equation of degree at most60 except when
a=b and k_big=k_small. This exhaustive characteristic-five identity
is independently checked in `continuation/src/universal_edge.py`.

The exceptional case splits into three branches indexed by a cube
root zeta of1:
\[
F_6=c_\zeta h^3,\quad
F_7=\zeta c_\zeta h^3\beta_{\rm big},\qquad
c_\zeta=2\zeta^2[24]^2/\epsilon^2.
\]
For each r and zeta the exact H-resultant is a unit times
q^10*(q-q_pivot)^2*E(q), with E squarefree of degree49 and coprime
to every removed boundary. Over K[q]/(E), the H-gcd is H-H(q),
and every denominator has a recorded inverse. These give exactly147
geometric ratio pairs per family. In each of the30 etale algebras,
the complete first two necessary square errors have a verified
Bezout identity1. Thus every scale is excluded at these pairs,
including scale zero. Outside them one of the nonzero scale equations
has degree54,60 or55, giving the asserted global bound60.

## Verification and scope

Both linear replay programs passed locally:71 original and51 new
evidence files regenerated byte-for-byte, including all30 finite
algebra exclusions. The constant theorem-only replay passed, followed
by full regeneration of its2,308,247-term residual. Its SHA-256 is
`436fae7b0bb93fb03e40e2b6c66507440569ebd591bdf988acc40b47593fecf2`.
The full polynomial identities, independent evaluations and complete
54+16 square-equation circuit checks passed. The retained local driver
is `../../scripts/arithmetic/replay_constant140_continuation.py`.

These checks certify the stated polynomial identities and exclusions.
No full square ideal has been eliminated, and no isolated square point
has been enumerated. Neither finiteness nor a necessary equation of
bounded scale degree proves emptiness or an actual cover realization.
