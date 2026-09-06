# Hermitian bundle criterion: major audit

Verdict: PASS (all four assertions; one wording clarification below).
Auditor: independent bounded agent `/root/hermitian_bundle_major_audit`.
Date: 2026-09-06.

Scope: `Def_frobenius_form_atlases`, `Thm_hermitian_atlas_extension_criterion`,
and its proof. No earlier audit bodies or claimed downstream exclusions
were used. This is a mathematical prose audit, not formal verification.

No material mathematical objection found.

- The frame construction works over rings, not only pointwise: the
  displayed GL map is surjective etale and its self-fiber-product is
  U times GL, by the formula for the ratio of two matrices. Thus it is
  a torsor; finiteness follows by descent from the finite group, not
  merely from finite geometric fibers. The standard stabilizer is
  finite constant (its equations imply entrywise 25th powers fix its
  matrices). The projective stabilizer is U/mu_6 after etale scalar
  normalization. The cited field input was checked directly in
  [Cheng, Corollary 2.7](https://chngr.github.io/assets/qbic-forms.pdf).
- Normalization removes the scalar action on Hom(L_0,V), L_0^-6,
  the form, and the inclusion section. Consequently descent produces
  actual vector-bundle data. Conversely the second fundamental map
  is precisely the derivative into the smooth plane Hermitian curve.
  Properness and etaleness of each component give the required actual
  finite etale map W -> H; quotient descent gives the atlas.
- Recomputing the Gram-matrix transformation gives the stated
  trace-free connection transformation; the line-valued form's
  dlog(u) term cancels. The differences of its derivatives of e are
  the stated scalar cocycle. Hence s epsilon = -c_1(det E)/3 with
  the displayed Cech convention. Since s is a global scalar and
  H^1(omega) is one-dimensional, nonzero degree modulo five forces
  everywhere transversality. The nonsplitting converse, determinant
  line identity, and extension-space dimension follow as stated.
- Equivariant adjunction gives omega_H=L_0^-3 tensor det(V)^-1;
  therefore tau has character det(V)^2. Scalars in U have determinants
  in mu_2, and determinant-square has kernel PSU in PGU. The Kummer
  argument detects the full induced mu_3-torsor because the only
  global units on C are k^*, whose cubes exhaust k^*.

Wording clarification: for fixed E and fixed nonzero q, the equation
beta(-,F^*e)=q is an affine linear constraint on the space of forms,
not a vector subspace condition. Calling the equation "linear" is
standard and does not affect the criterion, but "affine linear"
would avoid ambiguity.

This verdict establishes neither existence nor nonexistence of a
solution for the fixed genus-nine curve. The original two-map Litt3
problem remains unsolved; the audited criterion concerns the specified
Hermitian quotient cases only.
