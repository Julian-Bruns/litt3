# Proof: the witness's descended pencil has seven distinct adjunction images

Version1, 3 October2026. See the
[statement](../../Theorems/cartier_and_spin/canonical_ten_explicit_cartier_witness_net_exclusion.md)
for all original-source and relative-model antecedents. The focused
[new static audit](../../Research/audits/OCT03_EXPLICIT_CARTIER_WITNESS_ACTUAL_NET_EXCLUSION_AUDIT_2026_10_03.md)
passed; it reviewed the executed producer data without replaying the
calculation. The separate global witness and inverse-effectivity inputs
are those of the [witness proof](genus_two_global_liftable_cartier_kernel_witness.md).

## The exact line and its complete horizontal pencil

Use the explicit cubic point, annihilator u and horizontal gauge g of
the witness proof. They are fixed embedded data, not merely a line class.
The meromorphic section u of L=F*Q has divisor D−11P, where D is reduced
of degree six, contains one sheet over each root of a squarefree monic
U(x), and u/g is horizontal. The first ψ coefficient of u is a nonzero
scalar multiple of U. The already audited descended-effectivity test
gives h⁰(Y₁,Q^-1)=0.

Put M=ω_Y₁Q^-1. The actual relative pullback is
F*M=ω_Y⁵L^-1. In the meromorphic frame e=η⁵/u one has
\[
\operatorname{div}(e)=21P-D,\qquad
H^0(Y,F^*M)=\{f e:f\in L(21P-D)\}.
\]
The full basis of L(21P) is
1,x,…,x¹⁰,w,xw,…,x⁸w. These twenty elements have distinct pole orders
at most twenty-one and span by the affine hyperelliptic coordinate ring.
Six vanishings on D leave a fourteen-dimensional space, as independently
predicted by Riemann–Roch for the degree-fifteen line F*M.

The frame η⁵ is horizontal for the canonical connection on F*ω_Y₁.
Since u/g is horizontal, f e is horizontal exactly when
\[
df-f\,dg/g=0.
\]
The executed exact coefficient matrix on this fourteen-space has rank
twelve. Its two-dimensional kernel therefore gives the **complete**
H⁰(Y₁,M), by Cartier descent. Riemann–Roch also gives h⁰(Y₁,M)=2.
Write the resulting two polynomial pairs as f₀,f₁. Their ratio has
derivative zero, a separately executed check. Since Q^-1 is ineffective,
the complete degree-three pencil is base-point-free by the accepted
unmarked net-incidence theorem. Hence [f₀:f₁] is precisely its composite
with relative Frobenius. Its projective values have the same coincidence
relations on geometric points as the descended pencil on Y₁.

## The exact seven-point support and the distinct values

Write D on the sheet w=s(x) modulo U. Because the first annihilator
coefficient is cU with c≠0,
\[
\operatorname{div}(U)=D+\iota D-12P,\qquad
R_Q=\operatorname{div}(u_1\eta)-\operatorname{div}(u)=\iota D+P.
\]
Thus the tested support consists of exactly the six conjugate points
w=−s(x) and P. In particular no arbitrary sample points replace the
adjunction divisor.

Substitute w=−s(x) into f₀,f₁ and reduce modulo U, obtaining i₀,i₁.
The exact checks give gcd(U,i₀)=1 and no common zero of i₀,i₁ on U.
These are genuine finite section evaluations: the points of ιD are
disjoint from D and e is a unit there. The monic resultant
\[
C(y)=\operatorname{Res}_x(U(x),\,i_0(x)y-i_1(x))
\]
has degree six and gcd(C,C′)=1. Up to its nonzero normalization,
it equals the product of y−i₁(r)/i₀(r) over all six geometric roots r
of U. Its squarefreeness proves that the six finite geometric pencil
images are pairwise distinct, including roots outside the coefficient
field.

At P the frame e has order twenty-one. Only x⁸w in the allowed basis
has pole twenty-one, so the projective value is
\[
[\sqrt A\,(f_0)_{w,8}:\sqrt A\,(f_1)_{w,8}].
\]
The common square-root and line-frame factors cancel in the ratio.
The recorded first coordinate is nonzero, and C evaluated at this
ratio is nonzero. Thus P shares no image with the six finite points.
All seven adjunction images are distinct.

## Apply the original net's two branches

Under the exact retained hypotheses in the statement, the
[unmarked saturated net theorem](canonical_ten_unmarked_saturated_net_annihilator_incidence.md)
applies to this embedded Q and K in any coefficient-source dimension.
If ℓ(q₁)≠0, its retained infinity support gives
D_J=R₊^(1)+R₋^(1)+S and therefore Q^-1=O(S), contrary to ineffectivity.
This branch uses the previously audited effectivity result and the
original support antecedent; it is not computed by the new resultant.

If ℓ(q₁)=0, the original source plane has at most one exceptional cubic
branch. At least 9d distinct original source points then lie over
suppD_J∩suppR_Q, while each actual étale q-fiber has 8d points. Thus at
least two distinct adjunction points are zeros of the same nonzero
σ∈H⁰(Y₁,M). They must have the same degree-three pencil image. The
seven distinct values contradict this. Both original maps are retained
throughout this counting argument; neither map is constructed or
replaced by an endpoint section.

## Executed evidence and reproducibility

Source: [oct03_gram_four_actual_net_incidence.sage](../../scripts/genus_two/oct03_gram_four_actual_net_incidence.sage).
The one-thread Sage10.9 run took 2.3922023749910295 seconds. Exact matrices,
sections, image polynomials and resultant are stored in the external
[producer directory](../../../litt3-computation-data/oct03_gram_four_actual_net_incidence/),
with a [small receipt](../../../litt3-computation-data/oct03_gram_four_actual_net_incidence/summary.json)
and [plaintext data](../../../litt3-computation-data/oct03_gram_four_actual_net_incidence/net_incidence.txt).
The audit records hashes of this source, receipt, plaintext and binary
certificate, and of the supplied point and gauge inputs.

To reproduce, use the script with --point pointing to
oct03_gram_four_constant_exact_point/point.sobj and --horizontal pointing
to oct03_gram_four_candidate_horizontal_gauge/horizontal.sobj in the
sibling computation store; supply a fresh --output directory. Set
OMP_NUM_THREADS=1 and OPENBLAS_NUM_THREADS=1. No discovery Gröbner system
is required for the test once those exact witness inputs are available.

The original receipt did not bind runtime input paths or hashes. Its
acceptance uses the explicit same-point and same-gauge provenance
reviewed in the audit; equality of coefficient fields or Mumford classes
alone would not suffice. The source's nonzero-q₁ exclusion flag imports
the earlier ineffectivity and original infinity-support implication.
Its zero-q₁ flag also imports the stated actual-net and saturation
hypotheses. These flags are not unconditional source decisions.

No claim is made about the entire determinant family, an unsaturated
original K, another embedded annihilator with the same line class, or
an original model lacking the specified Frobenius-compatible comparison.
