# A unique extension candidate and a residual Hermitian obstruction

Assume the setup of `hermitian_atlas_extension_criterion`, with
5 not dividing 2g-2. Put T=omega^-1, K=K_C, M=omega^2 tensor tau,
and tau^3=O_C. Fix a rank-two extension and an isomorphism

    eta: 0 -> T -> V --pi--> M -> 0,
    j: K ~> (F_C^*V)^vee tensor M.

Every normalized Hermitian atlas supplies such data, by V=E/O_C.
For these FIXED data, the existence of a compatible rank-three lift
is decided by an explicit additive polynomial system.

Let U=Ext^1(M,K), A=Ext^1(M,O_C), and let i:A -> U be induced by
O_C -> K. Choose one lift xi_0 in U of eta, with middle bundle E_0;
let alpha_0 be its class in Ext^1(V,O_C). Define the additive,
5-semilinear operation D by Frobenius pullback followed by duality
and tensoring by M: D(alpha) is the extension

    0 -> (F_C^*V)^vee tensor M -> (F_C^*E)^vee tensor M -> M -> 0.

Push this extension's kernel through j^-1. Set

    b = j^-1_*D(alpha_0) - xi_0,
    T_j(lambda) = j^-1_*D(pi^*lambda).

A lift inducing j exists EXACTLY when

    i(lambda) - T_j(lambda) = b,          lambda in A.             (*)

Here dim A=5(g-1), dim U=12(g-1), and i is injective. Changing xi_0
translates the parameter; it does not change solvability. A solution
constructs an actual atlas, with no extra determinant or ramification test.

There is a distinguished DIFFERENTIAL retraction P_j:U -> A of i,
constructed from the canonical connection on F_C^*(V^vee), for which

    P_j T_j=0,       P_j j^-1_*D(alpha)=0 for EVERY alpha.

Consequently (*) has at most ONE candidate:

    lambda_* = P_j b = -P_j xi_0.                            (**)

A compatible lift exists exactly when

    b-i(lambda_*)+T_j(lambda_*)=0 in ker P_j.                 (***)

The residual space ker P_j has dimension7(g-1). No Frobenius-root
search and no rank assumption are needed. The construction includes
nontrivial tau with tau^3=O_C. It is for fixed marked data; no relative
claim over an arbitrary nonreduced parameter base is asserted here.

Explicitly put J=K tensor M^-1 and identify it with F_C^*(V^vee) via j.
Transport the canonical connection nabla. With N=M^-1 and
Q=omega^-1 tensor M^-1, its exact sequence is 0 -> N -> J --q--> Q -> 0,
and Q tensor omega=N. The second fundamental map
c=(q tensor1)nabla|N is a nonzero scalar. The k-linear sheaf operator

    c^-1(q tensor1)nabla:J -> N

induces P_j on H1. It is NOT O_C-linear; its action on cohomology uses
the underlying sheaves of k-vector spaces.

The full semilinear map T_j has rank at most4g-5: it factors through
pi*:H1(M^-1)->H1(V^vee), whose kernel has dimension g.
For genus nine there are40 extension coordinates, uniquely determined
by (**), and56 residual coordinates. Their equations need not be
independent or inconsistent. A solution determines a unique extension
class, not necessarily a uniquely marked form or atlas.

The necessary V is stable. Neither this theorem nor rank-two dormancy
asserts existence of a compatible rank-three lift. Choices of pi and j
are not a finite set merely because the underlying V classes are finite.

Author proof, /root, 2026-09-06. Differential retraction and strengthened
elimination audit: PASS, /root/horizontal_retraction_audit, 2026-09-06.
Non-breaking qualifications: fixed markings, k-vector-sheaf cohomology,
connection transported after canceling M, no arbitrary nonreduced-family
claim. The new proof supersedes the former finite-Frobenius-fiber step.
[Proof](../Solutions/Sol_semilinear_hermitian_lift.md).
[Audit](../Research/audits/HERMITIAN_HORIZONTAL_RETRACTION_AUDIT_2026_09_06.md),
reference-only; open its body only for a concrete mathematical doubt.
