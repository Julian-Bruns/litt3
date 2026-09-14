# The canonical extension candidate for a Hermitian atlas

Version3. Use the setup of
[the Hermitian atlas criterion](hermitian_atlas_extension_criterion.md),
with 5 not dividing2g-2. Put T=omega^-1, K=K_C and
M=omega^2 tensor tau, where tau^3=O_C. Fix

    eta: 0 -> T -> V --pi--> M -> 0,
    j: K ~> (F_C^*V)^vee tensor M.

These are necessary data for an atlas; they make V stable.
Write A=Ext^1(M,O_C), U=Ext^1(M,K). The inclusion O_C->K gives

    0 -> A --i--> U --h--> Ext^1(M,T) -> 0.

The canonical connection, transported through j after canceling M,
induces a distinguished k-linear retraction P_j:U->A. Its kernel maps
isomorphically under h onto Ext^1(M,T). Consequently eta has one
canonical lift

    xi_*=(h|ker P_j)^-1(eta)
        =xi_0-i(P_j xi_0)                                  (1)

for any lift xi_0. Let E_* be its middle bundle, and alpha_* its class
as an extension of V by O_C.

For an extension alpha of V by O_C, let D_j(alpha) be the class in U
of its Frobenius-pulled, dualized sequence, tensored by M and with kernel
identified through j^-1. This is additive and5-semilinear. Then

    D_j(alpha) belongs to ker P_j for every alpha.

A Hermitian atlas inducing eta and j exists exactly when the single
residual class

    D_j(alpha_*)-xi_* = 0 in ker P_j.                       (2)

Equality constructs the everywhere-etale atlas through the criterion.
The candidate extension class is unique; its marked form need not be.
The dimensions are

    dim A=5(g-1),    dim U=12(g-1),    dim ker P_j=7(g-1).

For the explicit operator, put J=K tensor M^-1=F_C^*(V^vee), N=M^-1
and Q=T tensor M^-1. In0->N->J --q-->Q->0 one has Q tensor omega=N.
The second fundamental map c=(q tensor1)nabla|N is a nonzero scalar,
and

    P_j=H1(c^-1(q tensor1)nabla).

This differential operator acts on sheaves of k-vector spaces; it is
not O_C-linear. The construction is for fixed geometric marked data,
including nontrivial tau, without an arbitrary nonreduced-base assertion.

In affine coordinates xi=xi_0+i(lambda), (1) is lambda=-P_j xi_0.
The5-semilinear map D_j is injective. Consequently its coefficient map
T_j=D_j pi^*:A->ker P_j has exact rank4g-5, with ker T_j=ker(pi^*)
the connecting copy of H0(omega). This follows from Joshi's stability
of B_1 and is uniform in eta and the torsion twist. For genus nine,
there are40 determined extension coordinates,56 residual coordinates,
and rank T_j=31 for every valid quotient.

The original [differential-retraction audit](../../Research/audits/HERMITIAN_HORIZONTAL_RETRACTION_AUDIT_2026_09_06.md)
is retained. Version2 gives the canonical candidate (1); Version3 replaces
the rank bound by equality using the published stability theorem and
a bounded medium check on2026-09-14.
[Proof](../../Proofs/atlases/semilinear_hermitian_lift.md).
