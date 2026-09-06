# Focused independent audit: generic two-leg trace reduction

Date: 2026-09-05. Auditor: `/root/generic_trace_reduction_check`.
Scope: Lemma 1.1, Theorem 2.1, and the intrinsic-parameter caveat in
`../GENERIC_TWO_LEG_THETA_FAILURE_FORCES_CARTIER_PETRI_TRACE_ORTHOGONALITY.md`.
Only that manuscript and its cited Tong paper were inspected. This audit
does not assess the proposed next implication or claim a solution of (R).

## Verdict

The rank-drop proof and simultaneous trace-orthogonality theorem are
correct over an algebraically closed field, with smooth projective curves
and relative Frobenius understood. No breaking mathematical flaw was
found under these intended hypotheses. The inseparability caveat is
correct, and the prime-to-p/Hom-zero sufficient condition is valid.

## Exact hypotheses and minor clarifications

1. **Missing base-field hypothesis: breaking under a literal arbitrary-field
   reading, repaired by one explicit assumption.** The lemma introduces
   `C/k` without declaring `k` algebraically closed, but its conclusion
   takes a minimum over `P(k)` and its proof invokes algebraic closedness.
   Over `k = F_3`, let `C` be the elliptic curve
   `y^2 = x^3 - x - 1`, let the vector bundle be `O_C`, and let
   `P = Pic^0(C)` carry the Poincare family. The curve has only its identity
   as an `F_3`-point: every finite `x` gives `y^2 = 2`. At the identity,
   `d_t = 1` and a nonzero Picard tangent direction gives a rank-one cup
   product, while `min_{u in P(F_3)} d_u = 1`, contradicting (2).
   State at the beginning that `k` is algebraically closed. Alternatively,
   replace the rational-point minimum by the geometric generic value
   (with the appropriate geometric hypotheses). The application should
   also explicitly retain smooth projective curves.

2. **Nonbreaking convention clarification.** Write
   `F_Z : Z -> Z_1` for relative Frobenius. Then the quotient
   `F_{Z*} O_Z / O_{Z_1}` is a bundle on `Z_1`; the derivation identifies it
   with the locally exact forms inside `F_{Z*} omega_Z`. Its pairing takes
   values in `omega_{Z_1}`, as required. Its Euler characteristic is zero
   directly from the defining sequence and invariance of genus under
   scalar twist. The cited source agrees with the stated convention and
   product: [Tong, Proposition 1.2.1.1 and Section 2.2](https://arxiv.org/pdf/0712.2046).

3. **Nonbreaking scheme-theoretic wording.** In the clean case of Section 4,
   the norm identities hold as homomorphisms of group schemes, so
   `ker(phi)` is a closed subgroup scheme of
   `J(X_1)[deg f] x J(Y_1)[deg g]`. This proves that the kernel is finite
   etale, not merely that its geometric points are finite. The reverse
   cross homomorphism vanishes as well: duality and the principal
   polarizations turn `Hom(JX,JY)=0` into `Hom(JY,JX)=0`; scalar twisting
   preserves these vanishing statements over the algebraically closed
   field. The manuscript's argument is sound when read this way.

## Checks of the central arguments

After splitting the invertible block, the derivative of the remaining
matrix is the obstruction to lifting sections. Smoothness lets every
tangent direction extend to a formal arc. A rank-`r` derivative minor
has nonzero leading coefficient along that arc, giving generic corank
at most `d_t-r`. Thus the lemma proves the claimed quantitative bound,
not merely singularity of tangent matrices.

Serre duality identifies `H^1(B_Z tensor N)^*` with
`H^0(B_Z tensor N^{-1})` through the displayed pairing. Consequently the
dual of cup product by `f_1^* xi + g_1^* eta` is precisely the scalar
Cartier--Petri pairing in (6), up to an immaterial global sign if the
self-duality identification is ordered oppositely. Pullback on
`H^1(O)` is dual to trace on regular differentials. Independent `xi` and
`eta` therefore force each trace to vanish. There is no division by a
cover degree and no separability assumption on `phi` in this argument.

The intrinsic statement uses the same generic minimum: the surjective
map `P -> H` reaches all geometric points and pulls back the same line
bundle family. At minimum points, all intrinsic tangent directions
annihilate the products. The differential of `phi` can indeed miss
directions. For example, ordinary elliptic Verschiebung is a finite
etale degree-`p` map, whereas its dual Picard pullback is Frobenius and
has zero differential. Thus etaleness of a cover does not remove the
stated source of blindness.

## Useful simplification

The theorem's qualitative assertion needs no formal arcs. On the
minimum locus, the two-term matrix has constant rank. Over the reduced
base, after splitting an invertible block the residual block is
identically zero. Hence kernel and cokernel are vector bundles and all
sections lift in every first-order direction; every cup obstruction
vanishes. This proves the generic trace conclusion directly. Keep
Lemma 1.1's arc argument for the useful quantitative estimate (8).

The resulting orthogonality remains only a necessary condition. Nothing
in this audit forces a nonzero trace pairing or excludes a positive
generic minimum.
