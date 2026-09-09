# A coreless span with a genus-two endpoint has at most one curve tangent

Version1, 2026-09-09. Fresh medium audit PASS,
/root/audit_joint_tangent_conic; no blocking objection. Prose, not Lean.
Let k=bar(F5), and retain an ACTUAL coreless finite etale span
X<-f-Z-g->Y of smooth projective connected hyperbolic curves, with g(Y)=2.
Use the [marked deformation conventions](../Definitions/Def_marked_curve_deformations.md).

Under the injective endpoint projection, the joint tangent space

    T_joint=f*H^1(X,T_X) intersect g*H^1(Y,T_Y)

is a linear subspace of H^1(Y,T_Y). Its projectivization is disjoint from
the smooth bicanonical conic

    Y -> P H^0(Y,omega_Y^2)^*=P H^1(Y,T_Y)=P^2.

Consequently dim T_joint<=1, without a no-clump, ordinariness, connection,
Jacobian-orthogonality, or map-degree assumption. If it has dimension one,
its unique projective tangent lies OFF that conic. The stronger existing
no-clump/ALL-active vanishing remains intact.

The joint marked deformation ring is therefore a quotient of W(k)[[z]].
For the selected main pair it has nilpotent5, by the existing intrinsic
nonliftability theorem. This does NOT bound its length, the nilpotence
exponent, or exclude a positive-dimensional characteristic-five component.

The key explicit exclusion is that a bicanonical evaluation tangent has
a pointed extension which, after normalization, is an extension of two
degree-zero lines. It is strongly semistable at EVERY Frobenius stage;
the two-leg finite-projective-monodromy theorem then forces a core.

[Proof](../Solutions/Sol_genus_two_joint_tangent_conic.md) ·
[Scoped audit](../Research/audits/JOINT_TANGENT_CONIC_AUDIT_2026_09_09.md).
