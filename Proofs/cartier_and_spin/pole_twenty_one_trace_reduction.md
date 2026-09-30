# Proof: integer phase balance suffices for the direct trace comparison

27 September2026. The [bounded supported-function theorem](bounded_supported_norms.md)
makes the two actual norms of t and t^-1 polynomials of degree seven
in their respective x-coordinates, with zeros at the four roots of A.
Their integer multiplicities m_alpha sum to seven. Each of the three
cubic sheets above alpha contains exactly m_alpha simple endpoint
branches. The compositions on the two legs are independent.

## Integer, rather than merely characteristic-five, phase balance

Trace the regular forms x^j dx/y^2,0<=j<=5, and x^j dx/y,0<=j<=2,
through the separating t:T->P1. The traces are regular and hence zero.
At the simple zero fibre the two Vandermonde systems give exactly
the two cubic Fourier relations in Section2 of the
[pole18 endpoint proof](../../../litt3-computation-data/pole18_descent_reply_20260927/extracted/pole18_descent/REPORT.md).
The first holds separately at each of the four A-roots. The second
has a one-dimensional Vandermonde kernel. If a root is absent its
common scalar is zero. If all four are occupied, at least one has
m_alpha=1, since their sum is seven; independence of three distinct
mu29 phases makes both relations vanish there and the common scalar
again zero. Thus the three sheetwise phase sums agree at every root.

Equality of phase sums of length at most seven implies equality of
their multiplicities modulo five. This follows from the complete
exact length-seven check described below, together with the earlier
checks of lengths1,...,6. If an integer discrepancy remains, it
consists of a fivefold singleton on each sheet, with possibly different
phases. There can be only one such root, and after removing those
blocks the remaining at most two phases on each sheet match exactly.

At the opposite endpoint the leading pole residues of t^-1 therefore
have polynomial
\[
\prod_{s=0}^2(W-d_s)^5\,J(W^3),\qquad \deg J=2,
\]
up to omitting factors when fewer than two residual phases are used
at that root and adding the balanced factors from the other roots.
The full balanced residual degree is always six. Consequently the
coefficient of W^16 in the degree21 pole-residue polynomial is
-(d0+d1+d2)^5.

For a covering degree n>21, the rescaled full norm has leading
polynomial W^(n-21) times this degree21 factor. Thus its index-five
coefficient is still exactly the W^16 coefficient just calculated.
The coefficient of index five in the ACTUAL norm polynomial
Norm_(T/X2)(Z-t^-1) lies in L(5O)=span(1,x). It has no pole term
of order five, so that same leading residue coefficient vanishes.
The actual endpoint formula is d_s=constant*zeta^(2s)*xi_s^-10.
Independence of at most three mu29 phases over F25 therefore forces
xi0=xi1=xi2. The fivefold blocks also match as integers. Interchanging
the two actual maps proves the same conclusion at the other endpoint.
This proof uses the full norm polynomial; no minimality or Galois
closure of either map is needed.

## Scalar restriction before any cubic descent

Let H=F_(5^8)^*mu29 and choose gamma^3=epsilon. In the full-fibre norm
identity, the multiplicities are M_i=3m_i. For
g=gcd_i(m_i-m0)>0 the
[actual full-fibre lemma](comparison_root_fibre_scalar_bound.md)
therefore gives epsilon^g in H. If a root is absent, g divides seven.
If all four occur, their positive unordered compositions are
(4,1,1,1),(3,2,1,1),(2,2,2,1), giving g=3,1,1. Thus in all cases
epsilon^21 belongs to H.

The permitted change t->r t,epsilon->r^-4 epsilon with r29=1 removes
the mu29 part, since29 is prime to84. Hence epsilon^21 belongs to E8.
Writing q=5^8, one has q=4 modulo21, so21 divides q^2+q+1 and
21(q-1) divides q^3-1. This proves epsilon belongs to F_(5^24).

The [direct common-source trace lemma](direct_common_source_trace.md)
now applies, because the endpoint phases balance as integers.
Its second equation is
\[
\epsilon(C_0-\eta_0Y)=E_\infty-\eta_0X,
\qquad X,Y\in K_0=\mathbf F_{5^{14}},\quad\eta_0=[22].
\]
We claim C0 does not belong to K0. In the root Fourier basis of E8/B,
B=F25, all three nonconstant projections of c(alpha_i) are nonzero.
Their exact coefficient-rank check was already made in the
[sextic scalar proof](sextic_comparison_scalar_restriction.md).
The Fourier weights are2^(li), elements of F5. Thus C0 in K0 would
force the three weighted phase sums to vanish. Every at most seven
distinct phases is independent over F5, by the complete prime-field
rank certificate. Separating each phase and Fourier-inverting shows
that its four integer root counts agree modulo five. Its cardinality
has the form4a+5b, with a,b nonnegative. The total seven cannot have
that form. This proves the claim.

The denominator C0-eta0Y is consequently nonzero. All endpoint sums
and X,Y lie in E8 K0=F_(5^56), so the displayed equation puts epsilon
in that field. Intersecting F_(5^24) with F_(5^56) gives E8. This is
a restriction on the scalar only, not on the fields of the curves.

The direct trace lemma supplies the other three equations with these
SAME X,Y. This proves the reduction without eliminating the five
non-invariant coefficients of a degree21 minimal equation.

## Exact phase verification

The prior [absolute-field enumerator](../../scripts/arithmetic/pro_pole18_descent_20260927/source/phase_sums.cpp)
now accepts an optional maximum and minimum length, with its original
default unchanged. Running it with7,7 enumerates all6,724,520 sorted
seven-tuples from29 phases and compares sums with their full mod-five
multiplicity vectors in F_(5^14). There are6,712,340 sums,435 collision
classes, maximum class size29, and no non-Frobenius collision.

The [independent relative-field enumerator](../../scripts/arithmetic/phase_multisets_seven_relative.cpp)
uses seven coordinates over the separately specified F25 phase field,
reconstructs the whole domain, and checks the same counts and absence
of a multiplicity discrepancy. Both full runs passed. Their logs are
phase_sums_seven.log and phase_multisets_seven_relative.log in
[the phase evidence directory](../../../litt3-computation-data/prime_field_phases_20260927/).
The existing rank7.log separately verifies prime-field independence
of all376,740 normalized seven-subsets. Unknown curve coefficients
are not searched over a finite field.

The finite seven-label four-trace decision is separate from these
verified inputs. This document claims the exact necessary reduction,
not a completed exclusion or a realization.
