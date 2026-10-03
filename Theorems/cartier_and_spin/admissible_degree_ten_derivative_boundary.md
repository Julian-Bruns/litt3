# The linear-derivative boundary and trace restrictions in degree ten

Version 2, 25 September 2026. In the full affine17 necessary family of
[degree-ten admissible primitives](admissible_degree_ten_eleven_reduction.md),
write F_b=(W^5+f)H_5(W)+kappa t_B^3/v, with H_5 monic.
The whole six-dimensional locus a_1=a_2=0 is incompatible with
everywhere etaleness, on all four supports and over the algebraic closure.
Thus an actual candidate has deg H_5'=2 or3. The exclusion does not
use the order-five condition.

For every actual candidate, the integral infinity polynomial has jets
P_0(U)+t Q_0(U), where P_0=sU^5+alpha_2 U^2+alpha_1 U+alpha_0,
Q_0 has degree at most three, and s=[8]. At a repeated root u of
P_0 with alpha_2!=0, Q_0(u)=0. If alpha_2=alpha_1=0, Q_0=0.
These are necessary cluster conditions; the seven jet coefficients
range freely in the necessary family.

On the remaining a_1=0 locus, every finite fiber meeting G meets it
in at least two points. If v=V+c_y y with c_y!=0 and g=V/c_y,
then P+g^3 has no simple root and is necessarily
\[
P+g^3=H_5(x)^2\quad\text{or}\quad P+g^3=H_2(x)^2J_2(x)^3.
\]
Both alternatives are excluded by the existing
[constant and mixed norm theorem](../jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md),
whose mixed assertion has no trace or support assumptions.
Thus the entire nonzero-y sector is closed. If c_y=0, v cannot have degree three.
More precisely v is constant, a linear polynomial rooted at a root
of P, a product of two distinct linear factors rooted at roots of P,
or a scalar square of a linear polynomial. This last refinement is
a local consequence of the returned trace restriction.

For an actual primitive the remaining torsion condition is exactly
2E~10H, with nontriviality retained separately. Equivalently there
is a degree50 separating function with divisor E-E^c, where E^c
is the five-sheet complement over the ten selected base points.
Its norm is constant. This does not construct that function or a cover.

Subsequent status: the [trace-dual exclusion](admissible_degree_ten_trace_zero_exclusion.md)
now excludes every actual trace-zero source with this order-five requirement.
The original boundary and cluster statements above also apply without
that requirement; their relaxed loci are not excluded by the sequel.

[Proof, local extension and evidence](../../Proofs/cartier_and_spin/admissible_degree_ten_derivative_boundary.md).
