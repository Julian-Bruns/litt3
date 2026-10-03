# Proof: the centered cubic Cartier gate

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/WILD140_CENTERED_CUBIC_EVEN_PART_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/wild140_centered_cubic_even_part_exclusion.md).

By the full ordinary [differential derivation](canonical_wild_degree_140_ordinary_spin_reduction.md), dG=cF³σ with σ=dw/y. Write A=a₃w³+a₂w²+a₁w+a₀. Exactness implies C(F³σ)=0. Its even polynomial part is (3A²w+Φw³)dw; its w⁴ coefficient is a₀a₃+a₁a₂. The highest odd Cartier row, the w¹⁹ coefficient of (A³+3AΦw²)Φ², is a₃³+3a₂+4qa₃. Thus
\[
a_2=a_3(3a_3^2+2q),\qquad a_0=-a_1a_2/a_3.
\]

Put a=a₃≠0 and scale w=a²X, y=a⁵Y. Set Q=q/a², S=s/a¹⁰ and B=a₁/a⁵. Then Q,S are nonzero and, after scaling F by a⁻⁷, its normalized even part and quintic are
\[
\mathcal A=X^3+(3+2Q)X^2+BX-(3+2Q)B,
\qquad\Psi=X^5+QX^4+S.
\]
The even and highest odd Cartier rows are already zero. Let r₁₄,r₉,r₄ be the remaining indicated coefficients of (𝒜³+3𝒜ΨX²)Ψ². The following exact ideal equality is the small new algebraic input:
\[
(r_{14},r_9,r_4,ZQS-1)
=(B^2,Q-1,SZ-1)
\quad\text{in }\mathbf F_5[Q,B,S,Z].
\]
The [source](../../scripts/genus_two/oct03_wild140_moving_cubic_cartier_gate.py) constructs the three rows from the displayed polynomials. Its [exact certificate](../../../litt3-computation-data/oct03_wild140_moving_cubic_cartier_gate/certificate.json) records the rows, the three target generators, and polynomial lift columns expressing EVERY target generator in the ORIGINAL four generators. It also checks the reverse inclusion. Run `sage -python scripts/genus_two/oct03_wild140_moving_cubic_cartier_gate.py --verify-only` to check the saved lift and reverse containment without recalculating the original Gröbner basis. The symbolic check took a few seconds on one core under a five-second internal bound; no endpoint census or older certificate was replayed. The first receipt serialization failed because Sage integers were not JSON-native; after that serialization-only fix, the same exact identities were saved successfully.

At a geometric point the ideal equality gives B=0 and Q=1. Consequently a₁=a₀=0, q=a², and a₂=a(3a²+2a²)=0. Thus A=aw³ and F=w(y+aw²).

Choose ρ with ρ⁵=−s; it is nonzero. The point w=ρ,y=−aρ² lies on the curve, and y−aρ² is a unit there. Since
\[
(y+aw^2)(y-aw^2)=\Phi-a^2w^4=w^5+s=(w-\rho)^5,
\]
the factor y+aw² has order five at that point. The function w is a unit there, so F also has order five. This contradicts the ACTUAL reduced seven-point wild fiber. The source and both original maps were retained; no coarse-map realization or new involution was inferred.

The proof relies on B=w in the centered quintic. Translating a GENERAL B=w−b to w changes the lower quintic coefficients. Its distinct Cartier equations are not covered by the ideal equality above.
