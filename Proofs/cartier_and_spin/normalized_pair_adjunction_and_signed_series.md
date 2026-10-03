# Proof: residual-diagonal adjunction retains the native sign

Version1, 3 October2026. Whole root focused review [PASS](../../Research/audits/OCT03_PAIR_AND_SOURCE_FLAG_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/normalized_pair_adjunction_and_signed_series.md). No computation or coefficient certificate is used.

## The residual ordered pair is smooth

The full fiber product T×ΓT is a Cartier divisor in T×T. Its dualizing line is pr₁*ωT⊗pr₂*ωT⊗π*ωΓ⁻¹, hence π*ωΓ³ under the retained identification. Away from the diagonal, at most one coordinate is ramified except at a selected simple fold. Ramified/unramified pairs have local equation x²=y with a smooth residual curve. At a selected fold the full equation is x²=y², and the residual to the diagonal x=y is the smooth branch x=−y. Its intersection with the diagonal is transverse and reduced. These are all local cases by the one-ramified-sheet hypothesis.

Thus the residual ordered off-diagonal curve is already smooth and equals W. Let D be its reduced selected-fold divisor. Adjunction for the two residual components gives the EXACT line comparison
\[
\omega_W\simeq\pi^*\omega_\Gamma^3\otimes O_W(-D).
\tag{1}
\]
All constructions are native under any retained G action: G preserves coordinate order, the diagonal, its ideal and the prescribed ωT comparison. This is not a comparison only of degrees.

Swap fixes exactly D and acts by −ONE on its tangent there. The quotient P is smooth, and ρ is double branched at D. If D_sel=ρ(D), then ρ*D_sel=TWO D. The anti-line Z in ρ*O_W has the multiplication relation Z²≅O_P(−D_sel). Its pullback evaluation has image the ideal of D, giving
\[
\rho^*Z\simeq O_W(-D).
\tag{2}
\]
This evaluation comparison is G-equivariant because G commutes with swap; no assertion about a trivial swap action on the ideal fiber is needed.

Hurwitz for ρ and(1),(2) now give
\[
\rho^*\omega_P\simeq\omega_W(-D)
\simeq\pi^*\omega_\Gamma^3(-2D)
\simeq\rho^*(p^*\omega_\Gamma^3 Z^2).
\tag{3}
\]
This descends to the exact comparison on P. If there are folds, pullback Pic for the ramified double cover is injective: a nontrivial line killed by ρ would have orderTWO and its connected étale double torsor would factor ρ, forcing ρ itself étale. Equivalently the usual double-cover eigensheaf proves injectivity directly. If there are no folds, (1) is the étale fiber-product comparison and the same identity follows directly from double-cover duality. The comparisons in(3) have their genuine G actions; once the underlying line is trivial, a pulled equivariant trivialization descends because both proper connected curves have only constant global units. Hence no character or degree-zero discrepancy is inserted.

## The exterior-square sheaf is the signed pair sheaf

Evaluate an elementary wedge by
\[
f\wedge g\longmapsto f(t_1)g(t_2)-g(t_1)f(t_2).
\tag{4}
\]
It is anti-invariant under swap, so it maps Λ²E to p*Z. Over an unramified fiber this is the usual alternating-functions identification. At a selected fold, use the local basis ONE,w of the ramified quadratic summand. The wedge ONE∧w evaluates to −TWO w on its selected ordered pair, precisely a generator of the anti-line; TWO is invertible. Wedges between this summand and each unramified summand identify the other pair summands, and wedges between two unramified summands are unchanged. This proves the isomorphism integrally, including the folds. Formula(4) also proves its native equivariance.

## The canonical degreeTEN pair stack

Now retain the faithful canonical degreeTEN setting, with weakC₅ wild inertia, tameC₂ inertia and the ordinary simple fold. Connectedness of W follows from actual S₁₀ two-transitivity, not a simultaneous Galois closure of the original endpoint maps. The unordered pair cover of the coarse base has degreeFORTY-FIVE. Its wild permutation has NINE cycles of lengthFIVE, each with differentEIGHT; its tame permutation has TWENTY transpositions; its ordinary permutation has EIGHT transpositions. Therefore its total different is SEVENTY-TWO+TWENTY+EIGHT=ONE HUNDRED, and
\[
2g(Y_2)-2=-90+100=10.
\]
The original G action is free on W, since an ordered pair fixed by g would give an original T point fixed by g. On P its only stabilizers are the FIVE tame selected pairs, each μ₂ swapping its two ordered entries. An orderFIVE element cannot preserve a two-element set of free original T points. The ordinary folds have no G stabilizer. Hence 𝒫=[P/G] has precisely the asserted five residual μ₂ points.

Write ω=p*ωΓ on 𝒫. Its stack degree is (FORTY-FIVE)(degωΓ)/|G|=NINE/TWO. The anti-line has stack degree−ONE/TWO: its square has exactly the reduced ordinary selected-fold divisor after dividing by the original free orbit size. At each of the five μ₂ points Z andω BOTH have negative fiber character. Consequently Zω has trivial character and coarse degreeFOUR, whereas Zω² has negative character at each of those points and coarse degree
\[
(-1/2+2\cdot9/2)-5/2=6.
\]
By the already proved native adjunction, (Zω)(Zω²)=ω𝒫. Coarse pushforward respects this product because the first factor has trivial stabilizer character. The coarse direct image of ω𝒫 is ωY₂, so L₁L₂≅ωY₂ exactly. Riemann–Roch and Serre duality on genusSIX give
\[
h^0(L_2)-h^0(L_1)=\deg L_2+1-g(Y_2)=1.
\]
Finally ONE∧s is a nonzero native section of Λ²EωΓ: the canonical different s is not a scalar unit on the generic degreeTEN fiber. Thus h⁰(L₁)≥ONE andh⁰(L₂)≥TWO.

## The remaining quotient obstruction

The rankTWO radical lives in Λ²(E°/OΓ), not Λ²E. One must still use BOTH actual exact sequences
\[
0\to\Lambda^2E^\circ\to\Lambda^2E\to E^\circ\otimes\omega_\Gamma^{-1}\to0,
\qquad
0\to E^\circ/O_\Gamma\to\Lambda^2E^\circ\to\Lambda^2(E^\circ/O_\Gamma)\to0.
\]
The first arrow to E°ωΓ⁻¹ is contraction by the weighted trace, and the second left arrow wedges with the unit. Neither taking native invariants nor lifting through the second sequence is assumed exact. In particular the mandatory additional degreeSIX signed section need not be unit-orthogonal, decomposable or isotropic; those are separate mathematical questions.
