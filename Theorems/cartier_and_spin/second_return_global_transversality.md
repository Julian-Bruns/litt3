# Actual quotient geometry and exact second-return conditions

Version2,3October2026. Use the nineteen-coordinate family R_xi and
fixed K of [rank-three geometry](rank_three_extension_return_geometry.md).
Put L=O(-O), E=F_abs^{2*}R_xi, z_j=xi_j^25 and let P_C be the
pure-v P5 on coordinates13,...,18. All maps below are actual regular
bundle maps, with both lattices retained.

1. The fixed positive line O(8O) in F^2*K defines
   \[
   0\to O(-25O)\to B_\xi\to O(8O)\to0,\qquad
   0\to B_\xi\to E\to O(17O)\to0.
   \]
   Outside P_C, Hom(L,B_xi)=0. Every stable strict second return
   gives an actual modification
   \[
   0\to B_\xi\to K\to O_D(17O)\to0,\qquad
   D=\operatorname{div}(\delta)+18O,
   \]
   where delta is nonzero in V18, spanned by y,xy,x^2y and the
   four ascending polynomial rows
   \[
   (1,0,0,0,17,2,1),\ (0,1,0,0,22,21,22),\
   (0,0,1,0,13,18,23),\ (0,0,0,1,16,1,15).
   \]
   Rows use F25 codes. D may be nonreduced or contain infinity.

2. For any nonzero phi:E->K, its cofactor w_phi is a section of
   E(O). Outside P_C, its determinant with the fixed filtration
   row is delta_phi in V18, zero exactly in generic rank one.
   In generic rank two, its zero divisor Z satisfies
   \[
   \ker\phi=L(Z),\qquad
   \operatorname{length}(\operatorname{coker}\phi)=\deg Z\le18.
   \]
   Surjectivity is exactly Z=0, including the infinity fiber.
   EVERY nonsurjective nonzero phi rules out every positive
   PROJECTIVE Frobenius period of R_xi, for arbitrary xi.

3. If Hom(E,L)=0 and phi has generic rank two, put
   \[
   V_\phi=\ker(\phi^*:\operatorname{Ext}^1(K,L)
                              \to\operatorname{Ext}^1(E,L)).
   \]
   Its dimension is1 for a surjection and d for torsion cokernel
   length d>0. At d=1 its unique projective target lies on the
   strictly semistable surface Sigma. A stable target spanning a
   one-dimensional V_phi therefore forces surjectivity.

4. On the exact window rank T(z)=34, rank Q(z)=16, the verified
   matrices A_phi=[M_phi|Q] of size43x35 and N_phi of size44x35
   satisfy
   \[
   \phi\text{ is a nonsplit surjection}
   \ \Longleftrightarrow\
   \operatorname{rank}A_\phi=34,\quad\operatorname{rank}N_\phi=35.
   \]
   The first nineteen coordinates of ker A_phi give the actual
   target extension eta. Stable strict second return is exactly
   eta proportional to xi with xi outside Sigma. On this
   surjective locus, injectivity of Q is equivalent to eta!=0.

These are complete geometric and matrix criteria, not a point search.
Their domain and the stable fixed-point locus remain undecided.
No return, higher-period exclusion for the whole family, or
unmarked common-cover decision is asserted.

[Proof and exact evidence](../../Proofs/cartier_and_spin/second_return_global_transversality.md).
