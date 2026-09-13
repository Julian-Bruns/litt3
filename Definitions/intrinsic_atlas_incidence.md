# Intrinsic extension-incidence data

ID: `intrinsic_atlas_incidence_data`. Work over an algebraically closed
field of characteristic5. Let C be smooth projective, g>=2, with
5 not dividing2g-2. Put T=omega^-1 and choose the nonsplit extension

    kappa: 0 -> O --e--> K --r--> T ->0.

Thus kappa is a specified nonzero element of H1(omega), not merely an
unspecified isomorphism class. Fix tau^3=O, M=omega^2 tau, a stable
rank-two bundle V, an identification det V=T M, and an isomorphism

    j0: K -> (F_C^*V)^vee tensor M.

For the dormant-oper application V=W theta tau^2. The fixed j0 includes
its scalar normalization; the existence criterion will not depend on it.

Use the finite-dimensional spaces

    A=Hom(V,M)=H0(V tensor T^-1),
    B=Ext1(V,O)=H1(V^vee),
    H=Ext1(V,K),       Z=Ext1(M,K).

The displayed identification of A uses det V=T M: for p:V->M, let
u_p:T->V be the uniquely determined map such that

    p(v)=u_p wedge v.

In determinant-compatible local frames, p=(p1,p2) and
u_p=(p2,-p1)^t. Define the perfect bilinear pairing ell:A x B->k by

    u_p^*alpha = ell(p,alpha) kappa in Ext1(T,O)=H1(omega).

Let I:B->H be pushout along e. For alpha in B represented by
0->O->E_alpha->V->0, define D(alpha) in Z by the ACTUAL dual sequence

    0 -> K --j0--> (F_C^*E_alpha)^vee tensor M -> M ->0.

Here its kernel is identified using j0. D is additive and5-semilinear;
its dualization sign is fixed by this sequence. Finally define the
bilinear map L:A x Z->H by L(p,z)=p^*z. These conventions use ordinary
bundle extensions and require no scalar differential frame or symmetry.
