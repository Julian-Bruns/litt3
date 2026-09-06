# Rank-three extension criterion for a Hermitian orbifold atlas

Let C/k be a smooth projective connected curve of genus g>=2 in
characteristic five, H: X_0^6+X_1^6+X_2^6=0, and S=[H/PGU_3(5)].
Use [Frobenius-form atlas conventions](../Definitions/Def_frobenius_form_atlases.md).

1. A finite etale curve atlas C -> S exists if and only if C admits
   transverse nonsingular Frobenius-form data (E,M,L). Both directions
   produce actual finite etale maps, not just ramification profiles.

2. After normalization L=O_C, every such datum satisfies

       0 -> O_C -> K -> omega_C^-1 -> 0,
       0 -> K -> E -> M -> 0,
       M = omega_C^2 tensor tau,       tau^3 = O_C,
       deg E = 2g-2.

   The first extension is nonsplit exactly when 5 does not divide 2g-2.

3. Suppose 5 does not divide 2g-2. Then the atlas exists if and only if,
   for some tau in Pic(C)[3], putting M=omega_C^2 tensor tau, there are
   an extension and a form

       0 -> K_C -> E --q--> M -> 0,
       beta:E tensor F_C^*E -> M

   such that beta is nonsingular and beta(-,F_C^*e)=q. Here e is the
   distinguished O_C section inside K_C. No separate differential or
   transversality condition is needed in this normalized criterion.

   For each tau, the extension space Ext^1(M,K_C) has dimension
   12(g-1). For a fixed extension, the displayed condition on beta is
   affine linear. Its determinant is a section of a trivial line bundle, so
   nonsingularity can be tested at one point.

4. The torsion line tau is the line associated to the determinant-square
   character PGU_3(5) -> mu_3 of the projective frame torsor. Consequently
   this atlas lifts to [H/PSU_3(5)] if and only if tau is trivial.

For genus nine this gives 3^18 possible torsion lines and a 96-dimensional
extension space for each. This is an exact finite-dimensional criterion,
NOT a computation of its solution set or an exclusion of the fixed X.
It addresses the two large cored quotient cases, not arbitrary coreless
common covers.

Audited PASS, /root/hermitian_bundle_major_audit, 2026-09-06.
No material objections; affine-linear wording clarified. Audit metadata
is in the library.
[Proof](../Solutions/Sol_hermitian_atlas_extension_criterion.md).
