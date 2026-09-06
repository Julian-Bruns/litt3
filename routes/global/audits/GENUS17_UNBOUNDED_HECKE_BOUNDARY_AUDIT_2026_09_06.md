# Fixed genus-seventeen unbounded Hecke leaves: boundary audit

Date: 2026-09-06. Auditor: `/root/genus17_unbounded_hecke_boundary_audit`.

Verdict: **PASS**, relative to the retained audited Igusa construction.
No breaking concern was found. The new sign quotient, every prime-power
degree, joint minimality, and corelessness survive. This is a universal
degree-bound counterexample, not a realization on the fixed g9/g25 pair.

Audited file: [author proof](../UNBOUNDED_DOUBLE_ZERO_HECKE_LEAVES_ON_A_FIXED_GENUS17_CURVE.md).
Primary retained dependency: [Igusa construction](../IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md).
The earlier global audit was opened specifically to check its reversed
level-transport convention; its original monodromy proof was not redone.
[Buzzard](https://www.ma.imperial.ac.uk/~buzzard/maths/research/papers/shimura.pdf),
Theorem 2.1 and Propositions 2.4--2.5, were checked for smoothness,
geometric irreducibility, and etale level change. His construction of
the Hodge section in Theorem 5.2 was checked for its diamond character.

## New geometry and differential

The generator P defines its dual character phi_P on ker F. Replacing P
by cP multiplies the pulled-back logarithmic invariant differential by
c. Consequently sigma has character c (inverse under inverse-action
notation), and the polarized Kodaira--Spencer form has character c^2.
In particular -1 fixes eta. There is no sign obstruction to descent.

The degree-two quotient I -> P is tame, totally ramified at precisely
the sixteen supersingular points, and unramified elsewhere. Its descended
form has order (5-1)/2=2 at each of those points and no other zeros or
poles. Pullback compatibility with Cartier gives C(alpha)=alpha.
The remaining cover P -> C has degree two and those same sixteen
ramification points, so 2g(P)-2=2*8+16=32 and g(P)=17.

For every n, V1(7) intersect V0(11^n) satisfies the same smallness,
determinant-surjectivity, and discriminant-prime conditions. Its source
degree is the number of primitive rank-one direct summands in
(Z/11^n)^2, namely 12*11^(n-1). Duality is an automorphism of the
isogeny moduli, whose square is an invertible diamond action on tame
level; thus the target has the same degree and is etale as well.

Prime-to-five isogenies identify the entire generator schemes, commute
with sign, and therefore identify both complete P fiber products over
H_n. Both maps W_n -> P are etale, including over supersingular points.
This also makes W_n smooth. The one-point totally ramified fiber of
W_n -> H_n forces connectedness: every component of this finite flat
smooth cover dominates the connected base. There is no selected-component
loophole in the subsequent field argument.

The multiplier on the polarized height-two factor is the false degree
11^n, which is 1 modulo 5 for every n. The retained framed Kummer-class
calculation therefore applies unchanged at all n, proving equality of
the logarithmic forms upstairs and then of the descended forms.

## Joint minimality and explicit alternating paths

At the geometric generic point, the retained End^0_(O_D)=Q result
implies that two equal-degree isogenies with isomorphic targets differ
by a rational scalar of absolute value one. Their kernels coincide.
For fixed representatives of the marked source and target, -1 cannot
preserve the prescribed transported level-seven generator. Hence H_n
is generically injective into C times C. The same follows for W_n into
P times P, since its point is determined by the H_n point and its
source P point. Generic injectivity is sufficient here: each resulting
function-field extension over the joint image is separable, being an
intermediate extension of the etale source-map extension. Thus the
joint maps are birational onto their images, not merely radicial.

Here is an explicit completion of the compressed corelessness argument.
Fix n and a geometric generic source A_0. For arbitrarily large even m,
choose any cyclic false-degree-11^(mn) quotient of A_0. Its unique cyclic
filtration gives forward blocks psi_j:A_(j-1) -> A_j, each of false
degree 11^n. Put A_j alternately on the right and left of the bipartite
graph. On odd blocks transport the level by psi_j. On even blocks the
edge is represented by psi_j^t:A_j -> A_(j-1); to make it an actual
edge, label A_j by (psi_j^t)^(-1) of the preceding label. On prime-to-11
torsion this equals 11^(-n) psi_j. These are valid level-seven labels.
The endpoint is on the original side and its label is the total forward
transport scaled by 11^(-nm/2). The scaling does not identify distinct
underlying quotient targets. Those targets are distinct for the
12*11^(mn-1) cyclic kernels, by the same generic endomorphism argument.
Thus one actual alternating component has unbounded endpoint sets.

If working directly with Igusa labels, the reverse-block factor is
also legitimate and equals 1 modulo 5; sign quotienting introduces no
additional issue. Alternatively no Igusa graph argument is needed:
unboundedness first proves corelessness for H_n, and the retained full
Cartesian field lemma transfers it to W_n. The lemma applies because
both degree-two Cartesian products were proved connected above.

A nonconstant common rational function would be constant along these
alternating paths and put arbitrarily many distinct endpoints in a
finite fiber. This proves corelessness for every fixed n, including
even n; changing graph parity does not break the argument.

## Scope of the conclusion

Etale Riemann--Hurwitz gives g(W_n)=16*12*11^(n-1)+1. All W_n therefore
give jointly minimal coreless etale leaves on the same (P,alpha), with
unbounded projection degrees and prime support contained in {2,3,11}.
Distinct degrees also force distinct joint images.

Conditional on the separately stated double-zero quotient-surface
theorem, substituting t=16d_n gives exactly K_Q'.Gamma_n=17*16d_n/5
and 2g(Gamma_n^nu)-2=32d_n. The quotient construction depends only on
the fixed pair (P,alpha), so its surface is fixed across n. This audit
does not re-audit that surface theorem. The universal-bound obstruction
does not address Hom(JX,JY)=0, distinct endpoints, or the arithmetic
conditions on the actual g9/g25 pair.
