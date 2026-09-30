# Proof of faithful minimal-quotient coordinates

Use the [statement](../../Theorems/cartier_and_spin/minimal_quotient_return_coordinates.md).
The only bundle inputs are the actual saturated O(-4O),O(5O)
presentation of K, shifted first-Frobenius vanishing for all geometric
twists, and the actual saturated O(8O),O(17O) presentation of F^{2*}K.
No new bounded coefficient search is used.

## Maps from the pulled-back quotient

Since K has rank two and determinant O(O),
(F^*K)^vee=F^*K(-5O). Thus
\[
\operatorname{Hom}(F^*K,O(5O)\otimes T)
=H^0(F^*K\otimes T)=0.
\]
The final vanishing follows from the stronger
[shifted theorem](../../Theorems/cartier_and_spin/shifted_first_frobenius_vanishing.md)
by the inclusion O->O(O). The shift and the degree-zero twist are
retained; no torsion or field-of-definition restriction is needed.

For n>=2, pull the exact
[positive presentation](../../Theorems/cartier_and_spin/explicit_degree_one_etale_sections.md)
back n-2 further times:
\[
0\longrightarrow O(8\cdot5^{n-2}O)
\longrightarrow F^{n*}K
\longrightarrow O(17\cdot5^{n-2}O)\longrightarrow0.
\]
Frobenius is flat on the smooth curve, so exactness is preserved.
Both outer lines have degree strictly larger than five. Neither has
a nonzero map to O(5O) tensor T. The Hom sequence therefore gives
the asserted vanishing for every n>=2 as well.

## Faithfulness of the restricted projection

Put E=F^{n*}R. Suppose phi:E->K has zero composite
F^{n*}N->E->K->O(5O). Then q*phi factors through E/F^{n*}N=F^{n*}K.
The preceding vanishing forces q*phi=0. Consequently phi factors
through ker q=O(-4O), and the stated Hom hypothesis forces phi=0.
This proves injectivity. In particular two full maps with the same
restricted projection agree, even when the full Hom space has
dimension greater than one.

If E is semistable of degree zero, a nonzero map to the negative-degree
line O(-4O) would have a negative-degree rank-one image, which cannot be
a torsion-free quotient of E. Alternatively, the nonzero inclusion
O(-4O)->O(-O) shows that the fixed-line Hom vanishing used in the
current return window implies the required hypothesis.

The target line N^{-5^n}(5O) has degree5^n+5. For n>=2 this exceeds
2g(X)-2=16. Riemann--Roch therefore gives dimension5^n+5+1-9=5^n-3.
No analogous dimension formula is claimed at n=1 for arbitrary N.

## The actual middle-character formula

In the original rational splitting, the saturated O(-4O) generator is
(A_*,y), where A_*=(PE)_+. Therefore q is represented by the row
(-y,A_*), up to the fixed scalar normalization. The original kernel
restriction of a map is the section
\[
w=((ef)_++A,f)=((PEp)_++A,yp)
\]
of K(25O). Applying the actual quotient row gives
\[
q(w)=y\{A_*p-(PEp)_+-A\}
    =y\{-((PE)_-p)_+-A\}.
\]
The first term inside braces has degree at most six, because (PE)_-
has strictly negative x powers and deg p<=7. The correction A also
has degree at most six. Faithfulness proves that a nonzero actual map
has r!=0, and that r determines that map on its fixed source.

This is a faithful coordinate, not a construction of a lift. It does
not remove the source extension equations, the other Hom-rank tests,
stability, or the actual return condition. It also supplies no shared
object on two endpoint curves and does not resolve a common cover.
