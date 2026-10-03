# The joint-spin kernel has only four squared characters in a full positive trace

Version1,3 October2026. New scoped character bound; focused review pending. It leaves a possibly large elementary abelian TWO-kernel and does not bound the original spin rank.

Retain the actual joint-spin Kummer source of [the joint-field theorem](actual_spin_joint_field_kummer_reduction.md), all original actual maps h_i:T→X, and the common infinity line L with its sections u_i. Put E=the compositum of all actual conjugate X-fields and assume H=Gal(T/E) is contained in the original Galois Y-group G; write N=H. Thus N is normal abelian of exponent dividingSIXTEEN, fixes EVERY original X-field, and the spin ratios u_i/u_0 generate k(T) over E.

Assume an ACTUAL rank-r coefficient bundle J_Y on Y has the retained identification
\[
q^*J_Y\simeq L^2\otimes_k V,\qquad \dim_k V=r,
\]
and that the original embedded positive q0 lines are represented by NONZERO constant directions v_i∈V. More precisely, their canonical pulled-back lines h_i*O_X(2∞) map into q*J_Y; under the identification h_i*O_X(∞)≅L supplied by u_i, each map is the constant direction v_i. These are the original equivariant inclusions, not arbitrary replacement directions. If the directions span V, retain that as an additional hypothesis for the coefficient-kernel identification below.

There is a linearization of L for N fixing u_0. Write χ_i∈Hom(N,μ16) for the resulting character of u_i, so χ_0=ONE. Then N acts LINEARLY on V, and each v_i has character χ_i^(-2). Consequently there are at most r distinct squared characters χ_i². Put
\[
C=\bigcap_i\ker(\chi_i^2)\subset N.
\]
The subgroup C is elementary abelian TWO, and
\[
|N/C|\le 8^{r-1}.
\]
If the v_i span V, C is exactly the kernel of this linear coefficient representation. It is also its PROJECTIVE kernel: the nonzero vector v_0 is fixed, so any scalar in the image is the identity.

For the retained positive full rank-FOUR degree-ONE trace this gives |N/C|≤512. It does not bound |C|, centralize C or N, or identify an X atlas. Equal-character spaces of original spin sections can have arbitrarily many sections; their dimension is not the number of coefficient directions.

[Proof](../../Proofs/cartier_and_spin/actual_joint_spin_kernel_positive_trace_weights.md).
