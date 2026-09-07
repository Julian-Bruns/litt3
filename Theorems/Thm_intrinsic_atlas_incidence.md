# One intrinsic atlas system for every cubic torsion choice

Use [intrinsic extension-incidence data](../Definitions/Def_intrinsic_atlas_incidence.md).
In particular V is stable, det V=omega tau, tau^3=O, and j0 is fixed.
Then a normalized Hermitian atlas with E/O isomorphic to V exists if
and only if the following affine polynomial system has a geometric solution:

    I(alpha)=L(p,D(alpha)),       ell(p,alpha)=1,             (1)
    p in A, alpha in B.

No surjectivity open set or determinant inverse is omitted: every solution
automatically makes p surjective and reconstructs an everywhere
nonsingular Frobenius form, hence an actual finite etale map
C -> [H/PGU_3(5)]. Its determinant character is the prescribed tau.
When tau=O the atlas lifts to [H/PSU_3(5)].

The spaces A and B both have dimension4(g-1), H has dimension12(g-1),
and I is injective. In bases, the first equations have the form

    I alpha = sum_(i,j) p_i alpha_j^5 c_ij,

with fixed vectors c_ij in H. Choosing a complement to I(B) splits them
into8(g-1) zero equations and4(g-1) fixed-point equations. The last
equation is a nondegenerate bilinear normalization. Thus for genus9,
this is97 equations in64 variables for EVERY tau, not just the trivial
one. Their highest total degree is6, and all coefficient data comes
from finite-dimensional pullback, pushout and Frobenius maps on Ext.

The solution scheme of(1) is finite and reduced, possibly empty. At
every geometric solution its Jacobian has full rank8(g-1). This assertion
does not assume H0(V)=0 and includes all quotient boundary strata.

Scope: a uniform exact formulation of the Hermitian atlas obstruction,
not proof that it is empty. It does not exclude the small cored or
coreless common-cover branches. Equality with the separately exported
untwisted coefficient tensor has not been asserted without a basis
comparison. No new enumeration of rank-two opers is needed for tau.

Independent major audit PASS, `/root/intrinsic_atlas_major_audit`,2026-09-07.
No material objections. Qualifications: stability and j0 are hypotheses;
no moduli-representability, old-tensor identification or emptiness claim.
[Audit metadata](../Research/audits/INTRINSIC_ATLAS_INCIDENCE_AUDIT_2026_09_07.md)
is reference-only; open the audit body only for a concrete doubt.
[Proof](../Solutions/Sol_intrinsic_atlas_incidence.md).
