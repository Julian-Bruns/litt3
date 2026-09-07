# Eliminate the quotient variables on the correct cohomological open set

Use `intrinsic_atlas_incidence_data`, with n=g-1. For alpha in B, let

    V_alpha=((F_C^*E_alpha)^vee tensor M)/j0(e O).

It is the rank-two extension of M by T obtained by pushing D(alpha)
along K->T. Its cup matrix

    C_alpha:H0(M)->H1(T)

is square of size3n and linear in the fifth powers of alpha's coordinates.
Let U subset P(B) be the open set det C_alpha!=0, equivalently H0(V_alpha)=0.
The open set is permitted to be empty.

1. For EVERY alpha in U, the rectangular matrix

       L_alpha:A->H,      p |-> p^*D(alpha)

   has full column rank4n. This is a rank statement on the WHOLE open
   set, not a claim about one preferred square submatrix.

2. Suppose H0(V)=0. All actual atlases with this V are obtained by finding
   those [alpha] in U for which I(alpha) belongs to im L_alpha. For a
   chosen representative alpha, p is then UNIQUE. Its pairing ell is
   automatically nonzero; the cube normalization of `intrinsic_atlas_incidence`
   reconstructs the atlas. No valid p or alpha chart is discarded.

3. Intrinsically, on U form the vector-bundle cokernel

       0 -> A tensor O(-5) --L--> H tensor O -> Q ->0.

   It has rank8n and is the Frobenius pullback of the corresponding
   linear-coefficient quotient, after transporting constant coefficients.
   The fixed map I defines a section s_I of Q(1). Its zero scheme Z is
   finite and reduced, possibly empty. The normalized affine atlas
   scheme is a mu_3-torsor over Z.

For genus9 this replaces the64-variable incidence by a zero-locus problem
on an open subset of P31, with a rank64 vector bundle and unique recovery
of the32 quotient coordinates. Its boundary is specified by a24x24 cup
matrix; no symmetry is needed, including nontrivial tau.

This does NOT make an arbitrary32x32 polar matrix invertible. A scalar
implementation must cover all maximal-minor charts or use the vector-
bundle quotient, rather than select a single sampled pivot. Nor does
rank64>dimension31 prove that this particular section has no zero.
For H0(V)>0, the same projection need not cover actual atlases; they lie
outside this acyclic open set and remain in the full intrinsic system.

Status: author proof,2026-09-07; not independently audited.
[Proof](../Solutions/Sol_theta_open_atlas_projection.md).
