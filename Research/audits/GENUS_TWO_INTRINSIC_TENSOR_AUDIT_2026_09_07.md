# Genus-two intrinsic coefficient implementation audit

- Verdict: PASS for the coefficient construction and stated finite bounds.
- Auditor: `/root/small_intrinsic_tensor_audit`, fresh bounded audit.
- Date: 2026-09-07.
- Target: [script](../../scripts/genus_two_intrinsic_tensor.sage),
  [coefficient export](../computations/genus_two_intrinsic_tensor.json),
  [implementation note](../GENUS_TWO_INTRINSIC_TENSOR.md).
- Theory checked: `Def_intrinsic_atlas_incidence` and
  `Sol_intrinsic_atlas_incidence`; no re-audit of historical Litt3 proofs.
- Remaining material objections: none to the coefficient construction.

The horizontal polynomial frame has determinant one. The explicit
integral, invertible comparison `Top^-1 q^5 H G0^[5]` proves that the
Cartier-projected frame descends the actual scalar local lattice.
This was a missing check in the first draft and is now asserted.
The determinant-normalized transition has `det G=q^-2`. Regularity
and unit determinant of `q^4 (G^[5])^t J GK`, with `J=H^t`, verify
the specified isomorphism `j0:K -> F*V^vee tensor M` at infinity;
its affine matrix and inverse are polynomial.

The Cech bounds are sufficient: for lattice pole bound a and inverse
pole bound b, columns multiplied by q^j with j>=a+b already lie in
q^b times the regular module. Affine subtraction leaves only the gaps
q^-1,q^-3 and powers q through q^(b-1). The bounds (a,b)=(5,7)
for B and (6,10) for H follow from the displayed transition matrices.
The A pole cutoff nine follows from `p=q^-4 (local p) G^-1`.
The export records dimensions 4,4,12, rank I=4 and perfect ell.

For the convention local splitting minus affine splitting, the K
extension class is `c/q^3`, the actual dual Frobenius cocycle is
`-J^-1 alpha^[5]`, and pullback along `u_p=(p2,-p1)` gives precisely
the exported ell. Thus the plus sign in the saved 192 coefficients
is correct for `I alpha-L(p,D alpha)=0`. Column-major flattening agrees
with the Kronecker transition `G^-t tensor GK`. These are actual
extension cocycle equalities, not numerical agreement on sample points.

All twelve reduced B coboundary generators are checked under I, every
contracted Frobenius tensor, and ell. The script also checks remaining
negative exponents and propagated absolute precision after reduction.
The precision-500 export reports maximum input pole 56 (allowance 160)
and minimum precision margin 75. Higher-precision agreement is useful
additional reproducibility evidence, not the basis for exactness.

Scope: this audit does not solve the eight-variable system, export an
atlas-coordinate witness, compare with the genus-nine scalar tensor,
or prove an exclusion. The known Hermitian quotient atlas makes this
genus-two example a positive test; no emptiness conclusion is licensed.
