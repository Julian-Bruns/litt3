# Cyclic symmetry reduces twisted lines to determinant-twisted sections

Version3,3October2026. Let C be a smooth proper connected curve over
an algebraically closed field of characteristic different from three.
Let gamma have order three, with quotient C/<gamma>=P1, and let O be
a fixed point. Let E be a gamma-linearized rank-two bundle with
det E=O(delta O), delta>=0.

If the ramification points are \(R_1,\ldots,R_{r-1},O\), every
gamma-invariant degree-zero line is represented by
\[
\sum_{i=1}^{r-1}s_i(R_i-O),\qquad
s_i\in\{0,1,2\},\quad s_{r-1}=0.
\]
Here a Kummer relation with nonzero branch weights is used to eliminate
the final coefficient. Thus at most \(3^{r-2}\) representatives suffice;
for \(y^3=P(x)\) with squarefree P of degree10 there are19683.

If H0(C,E(delta O)) is isotypic for gamma (including the zero space),
then every saturated line M in E of nonnegative degree is preserved
as an EMBEDDED line by gamma. Consequently, if all invariant
degree-zero twists of E have no sections, every geometric degree-zero
twist has no sections. This requires only a section-space calculation
and invariant twists, not a discriminant-square classification.

There is an exact norm criterion without any stability assumption:
E contains a saturated line of nonnegative degree with three distinct
conjugate embedded lines if and only if there is a nonzero section
\(s\in H^0(E\otimes\det E)\), with nonzero wedge, satisfying
\[
N(s):=s\,\gamma(s)\,\gamma^2(s)
=(s\wedge\gamma(s))G,\qquad
G\in H^0(C,\operatorname{Sym}^3E).
\]
The line extracted from s has degree deg div(s) minus delta.
If E has no positive-degree line, this degree is zero.
The identity is global and retains all common zeros, repeated points
and O. Hence invariant-twist vanishing and exclusion of all such norm
identities prove all-twist vanishing directly, without first proving
stability or ruling out positive lines separately.

No finite etale trivialization, return or common-cover realization
is asserted.

[Proof](../../Proofs/cartier_and_spin/cyclic_determinant_section_reduction.md).
