# Proof: the actual lattice restores its determinant action

Version2,3 October2026. [Root whole-scope review PASS](../../Research/audits/RANK_THREE_SCALAR_TARGET_AND_TAME_IDENTITY_AUDIT_2026_10_03.md). See the [exact original-source scope](../../Theorems/cartier_and_spin/rank_three_etale_row_native_determinant_constraints.md). No computation is used. The strict Clifford-boundary observation was supplied independently by `/root/tame_high_degree_power_fibers`.

The [projective row antecedent](canonical_ten_rank_three_projective_row_descent.md) gives the actual R-Galois étale C→Y, the equivariant étale ρ:C→D, a faithful action of R on D, and C=YD as embedded fields. Its projective Grassmann quotient E_D has rankTHREE, degree n/FOUR, a surjective presentation V⊗O→E_D and an injection V→H0(E_D). The [scalar descent](etale_frobenius_line_descent_prime_to_characteristic.md) gives the actual Cartier image
\[
K_D=Q\otimes E_D\hookrightarrow B_D,
\qquad \rho_1^*K_D=q_C^*K,
\qquad \deg K_D=n,
\qquad en=N.
\]
The original inclusion, not merely the abstract bundle, is retained by this identity.

## Native determinant action and stabilizers

The image K_D is preserved by the natural R-action on B_D. For every g∈R, pull the proposed image equality g*K_D=K_D along the equivariant ρ. It becomes the original equality g*q_C*K=q_C*K inside B_C. Faithfully flat pullback detects equality of subsheaves, so the equality holds on D. Restricting the canonical action on B_D gives an actual action on K_D and hence a genuine linearization on detK_D. No independent linearization of the scalar line Q or the Grassmann bundle E_D is chosen.

Let ℓ be the least common multiple of the actual stabilizer orders |R_z|. Each stabilizer acts freely on the complete ρ-fiber: a fixed source point would contradict the free action of R on C→Y. The fiber has e points because ρ is étale. Thus |R_z| divides e for every z, and ℓ divides e.

Use the genuine action on detK_D at the generic point. Hilbert90 for the faithful Galois function field k(D)/k(D)^R supplies an invariant nonzero rational section of this line. Its divisor is R-invariant. Every orbit has degree N/|R_z|, so its degree is divisible by the gcd of these orbit sizes, namely N/ℓ. Therefore
\[
N/\ell\mid\deg\det K_D=n=N/e.
\]
Equivalently ℓ/e is a positive integer. Combined with ℓ dividing e this forces ℓ=e. The argument includes wild stabilizers and does not divide by an inertia order in the coefficient field.

## The complete module forces a larger genus

The actual quotient makes E_D globally generated. Choose TWO sections from V which are everywhere independent. At a fixed point, surjectivity V→E_D(point) makes the dependent pairs in V×V a determinantal locus of codimension TWO. Its incidence with the one-dimensional proper curve has dimension at most TWO v−ONE. Its proper image therefore cannot fill V×V. An outside pair gives an honest rank-TWO subbundle O²⊂E_D and the exact sequence
\[
0\longrightarrow O^{\oplus2}\longrightarrow E_D\longrightarrow\det E_D\longrightarrow0.
\]
The kernel on global sections has dimension TWO, so h0(detE_D)≥v−TWO. The determinant has degree n/FOUR, while g(D)−ONE=n. It is special by Riemann–Roch. The classical line-bundle Clifford theorem, valid in the present characteristic, gives
\[
v-2\le h^0(\det E_D)\le n/8+1.
\]
The target D cannot be hyperelliptic. Otherwise let h be its degree-TWO pencil. The birational row supplies a ratio f outside k(h); since k(D)/k(h) has prime degree TWO, k(D)=k(h,f). Its pole degree is at most degM=THREE n/FOUR. Castelnuovo–Severi for the actual birational map to P¹×P¹ gives g(D)≤degf−ONE≤THREE n/FOUR−ONE, contrary to g(D)=n+ONE. This does not require the chosen ratio map to be separating: the birational product-image intersection proof bounds its normalization genus using its actual projection degrees.

Equality v=n/EIGHT+THREE in the displayed Clifford inequality would force equality in Clifford for detE_D. This line has positive degree n/FOUR strictly smaller than degω_D=TWO n, so it is neither O norω_D. The equality classification therefore makes D hyperelliptic, already excluded. Hence v<n/EIGHT+THREE, so n>EIGHT(v−THREE). Since FOUR divides n, we obtain n≥EIGHT(v−THREE)+FOUR≥FORTY FOUR. The earlier degree identities give g(D)≥FORTY FIVE, degM=THREE n/FOUR≥THIRTY THREE and e≤N/FORTY FOUR.

The argument does not require semistability of E_D or saturation of the original K. The actual Grassmann quotient is locally free even in the unsaturated case. Nothing here upgrades this rank-THREE presentation to a constant rank-FOUR tensor decomposition, and no original X-field descends to D by these numerical or determinant identities.
