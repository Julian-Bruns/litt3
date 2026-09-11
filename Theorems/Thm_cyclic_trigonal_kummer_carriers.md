# Complete norm coordinates and actual quartic Prym carriers

Version1,2026-09-11. Focused audit PASS,
/root/audit_degree2_kummer_dictionary; audited prose and exact arithmetic.

Let k be algebraically closed of characteristic5, let F be squarefree
of degree10, and let X be the smooth projective curve y^3=F(x).
Every connected etale double cover of X is represented by

    k(X)(sqrt(P+Qy)),  P^3+FQ^3=R^2,
    degP<=6, degQ<=2, degR<=9, Q!=0.

Conversely every such bounded norm solution is nontrivial. It is etale
if and only if the product of the roots of gcd(P,Q) having odd
multiplicity divides F. This includes all common-root and lower-pole
cases. In particular the norm equation alone is only a necessary system.

For an etale solution the smooth projective normalization of

    z^4+4Pz^2+2Rz+2P^2=0

is the actual genus8 carrier U/C3 of the associated A4 cover of P1.
It has eleven complete (3,1) branch fibers and its Jacobian is isogenous
to the Prym of the original double. No map from this carrier to the
backup curve is asserted.

All geometric points of the bounded norm system are covered by the
three charts in which Q has degree0,1,2 and leading coefficient1.
Alternatively write P=S^2 modF, R=S^3 modF, degS<10, impose that the
degree7,8,9 coefficients of S^2 modF vanish, and impose the full norm
identity. These residue coordinates are complete on geometric points;
they are not asserted to be a scheme isomorphism at cusp points, or a
finite/injective parametrization of the two-torsion classes.

This theorem constructs the degree2 search space and carrier models.
It does not enumerate the fixed-X carriers or exclude a common cover.

[Proof](../Solutions/Sol_cyclic_trigonal_kummer_carriers.md) ·
[Audit](../Research/audits/DEGREE2_KUMMER_DICTIONARY_AUDIT_2026_09_11.md) ·
[Exact checker](../scripts/check_degree2_kummer_carrier.py).
