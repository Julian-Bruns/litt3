# Audit: ordinary bounded-exponent abelian covers of generic hyperelliptic curves

**Verdict:** **PASS.** No breaking objection was found.

**Auditor:** `/root/x_elliptic_quotient_maps`

**Date:** 2026-09-05

**Revision checked (SHA-256):**
`b0574cf726be52eef8f4fba63c0f52bb086417ca1c87521b3b11323a1193e5ed`

## Scope

This audit checks
`GENERIC_HYPERELLIPTIC_BOUNDED_ABELIAN_COVERS_ORDINARY.md`: the maximal
exponent-`N` cover, its extension across the compact-type degeneration,
the Frobenius calculation on the nodal fiber, and descent to a nonempty
moduli open. It does not audit the separate local ramification
classification, arbitrary nonabelian covers, or any coreless-cover claim.

## Checks

1. Kummer theory gives a single connected maximal abelian exponent-`N`
   cover with group `mu_N^(2g)`. Its character summands are precisely the
   distinct elements of `Pic^0(C)[N]`; only the trivial summand has a
   global section. Every abelian cover of exponent dividing `N` is a
   quotient. Since all intermediate degrees are prime to `p`, trace makes
   pullback on `H^1(O)` injective, so ordinarity descends to every
   intermediate curve.

2. The chain of ordinary elliptic curves is a compact-type hyperelliptic
   boundary point. For a compact-type smoothing, the relative identity
   Picard is an abelian scheme and its prime-to-`p` `N`-torsion is finite
   etale and constant over the strictly henselian base. Rigidification by
   a smooth section supplies the required line bundles and `N`th-power
   trivializations.

3. The Kummer equations remain finite etale at a node: after locally
   trivializing the torsion line bundle they are `z^N=u` with `u` and
   `N z^(N-1)` units. The special cover is connected because a nonzero
   section of a multidegree-zero line bundle on a compact-type tree forces
   that line bundle to be globally trivial. Thus the construction really
   extends the whole maximal torsor, rather than extending its characters
   only on the normalization.

4. Every normalized component over an elliptic component is an ordinary
   elliptic curve. The normalization sequence gives the stated extension
   of their `H^1(O)` by `H^1` of the dual graph. Frobenius is bijective on
   both ends (coefficientwise on the graph over the perfect field), hence
   on the nodal curve. The relative Frobenius determinant then remains
   nonzero on the smooth generic fiber.

5. On the finite etale level chart with a marked Weierstrass point and an
   `N`-torsion frame, this determinant defines an open condition. The
   condition is constant on fibers of the level chart because the maximal
   cover is intrinsic, so it descends through the finite map. The formal
   smoothing makes the open nonempty; irreducibility of the
   hyperelliptic moduli stack gives dimension `2g-1` and the asserted
   finite-field points.

## Objections and limitations

**Breaking objections:** none.

**Non-breaking correction made during audit:** the relevant iterated
hyperelliptic clutching discussion in arXiv:0902.4637v2 is Section 2.4.4,
not Section 2.5. The citation pointer was corrected without changing the
argument.

**Prior-art attribution:** the degeneration mechanism is a hyperelliptic,
fixed-exponent adaptation of Bin Zhang,
[*Revêtements étales abéliens de courbes génériques et ordinarité*,
Theorem 3.1, Lemma 3.3, and Corollary 2.3](https://www.numdam.org/item/AFST_1992_6_1_1_133_0.pdf).
Zhang proves the corresponding generic-curve result on the full moduli
space by extending prime-to-characteristic abelian Kummer covers over an
ordinary elliptic-chain degeneration. The audited file's exact contribution
for this route is the direct restriction/adaptation to the hyperelliptic
clutching locus and the intrinsic open condition for all covers of one fixed
bounded exponent; the underlying ordinary-cover phenomenon should not be
presented as newly discovered.

The result fixes one prime-to-`p` exponent `N`; it does not produce a
curve controlling all exponents, nonabelian covers, or `p`-power covers.
It is an existence theorem for a nonempty generic locus and says nothing
about ordinarity of bounded covers of the fixed curve from file 76.
