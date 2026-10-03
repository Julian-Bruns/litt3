# Proof: constant section factors and the single-tame-branch torsor

Version1,3 October2026. Whole scoped PASS in the [independent audit](../../Research/audits/CANONICAL_TEN_HIGHER_TRACE_SECTION_MODULE_AUDIT_2026_10_03.md); see the [actual-source statement](../../Theorems/cartier_and_spin/canonical_ten_higher_trace_section_module.md). No computation is used.

## The module belongs to the specified original source

Write Z₁=Z^(1), with relative Frobenius F_Z:Z→Z₁. The actual one-leg Galois presentation of the complete trace K⊂B_{1,Y} on Y₁ is the sum of its conjugate saturated positive lines O_{T₁}(2H_i^(1)). Each H_i^(1) is the divisor of u_i^(1) in the SAME L^(1), so each of these lines is (L^(1))². Their maps to q₁*K are everywhere defined and their sum is surjective as sheaves by the definition of the complete trace and flat base change. Identify their source lines using the specified (u_i^(1))²; their maps are global sections of q₁*K⊗(L^(1))⁻². Their constant k-span V therefore supplies the claimed integral surjection. No further étale cover or quotient has been chosen. The [relative scalar calibration](actual_positive_source_relative_scalar_calibration.md) records these same columns and phases explicitly.

The G-action on q₁*K is genuine, whereas the invariant (L^(1))² has its inherited projective line action. Consequently V is G-stable with the inverse scalar cocycle. Pullback from Γ and scalar twisting preserve the order of this SAME line obstruction. The free original G action on T₁ and deg(L^(1))²=TWO d give the Schur lower divisibility FOUR from |G|/gcd(|G|,TWO d)=FOUR. The canonical identity M16=ω_Γ² gives upper divisibilityEIGHT for the M² obstruction. Its exact order is therefore FOUR orEIGHT. The proof does NOT assume that M8=ω_Γ before a composition factor supplies a linearization.

Frobenius adjunction of the actual map (L^(1))²⊗V→q₁*K→B_{1,T} is injective on the space of maps, and under the retained coefficient calibration identifies it with L10⊗V^[5]→ω_T=L16. Relative k-linearity alone is not a fifth-power rule for an unlabelled representation. Thus V^[5] injects into H0(T,L⁶). The original raw section is (u_i^(1))² times its positive direction; its pulled differential evaluation is q0(x_i)θ_i=q0(x_i)u_i16 with the original normalized phases. Dividing by u_i10 gives exactly b_i=q0(x_i)u_i⁶. This uses the given embedded source inclusion, without claiming it descends along φ.

## A genuinely equivariant TWO-torsion line is trivial here

We use a short auxiliary fact about the ACTUAL target Γ. If a TWO-torsion line S on Γ has a genuine G-linearization and a genuinely equivariant trivialization S²=O_Γ, its associated étale double torsor Γ_hat→Γ has a genuine G-action commuting with its deck C2. Suppose S were nontrivial, so Γ_hat is connected. The connected quotient Γ_hat/G→Γ/G=P¹ has degreeTWO. Away from the original TWO branch values it is unramified. The wild C5 cannot act nontrivially on the TWO torsor sheets, so that value creates no branch in the quotient. At the tame C2 value it can create at most ONE branch. A connected separable double cover of P¹ in odd characteristic cannot have ZERO orONE branch point, by tame Hurwitz. Thus S is trivial.

This is a constructed torsor from a genuinely linearized line, not a presumed lift of arbitrary automorphisms or a simultaneous Galois closure. With Hom(G,k×)=ZERO its trivial line also has the trivial G-linearization. When S² is merely known isomorphic to O as an underlying line, the same character vanishing makes any such isomorphism equivariant: the difference is a global character. We will use exactly this justified equivariant version.

## Determinant-normalized factors create the necessary target line action

For this group paragraph work on Γ₁ with the paired literal coefficient factor of V, M^(1) and ω_{Γ₁}; suppress these scalar-twist superscripts in the formulas below. Equivalently one may use the corresponding coefficient-UNTWISTED factor on Γ with M and ωΓ, transporting its paired lifts together. This convention does not pair an untransported T₁ factor with unrelated M² lifts. Scalar twisting preserves factor dimensions, centralizer dimensions and tame plus/minus multiplicities, so all stated group conclusions are unchanged.

Let W be any irreducible composition factor of V, of dimension n. Projective composition factors inherit the SAME scalar cocycle. Taking determinants shows that n times its obstruction is ZERO, hence FOUR divides n. Normalize its projective lifts A_g to have determinantONE. Their scalar cocycle is now valued in μ_n. Rescale the original M² lifts B_g oppositely so that W⊗M² has a genuine G-action. Then B_g^n gives a genuine G-linearization on M^(2n).

Write n=FOUR a. The ratio S=M^(8a)ω_Γ^(−a) has square O because M16=ω_Γ². It has a genuine G-linearization supplied by B_g^n and the canonical line. The genuinely linearized square equals the canonical trivial one: comparison is a character, and G has none. The auxiliary torsor fact therefore gives
\[
M^{8a}=\omega_\Gamma^a
\]
GENUINELY for this determinant normalization. For a=ONE this is a newly supplied M8=ω_Γ identity. It is derived from the existence of W; it is not a hidden higher-trace hypothesis.

Choose the original tame element g fixing p∈Γ. Its lift A_g has square cI and eigenvalues ±√c, with one multiplicity j. The paired line lift satisfies B_g²=c⁻¹, so its fiber b has b²=c⁻¹. The n-th line power just identified has canonical fiber (−ONE)^a because tame g has tangent multiplier−ONE. Thus
\[
c^{-n/2}=b^n=(-1)^a.
\]
The determinantONE normalization of A_g gives ONE=c^(n/TWO)(−ONE)^j, proving j≡a moduloTWO. If the projective tame image were trivial, the prescribed generating (FIVE,FIVE,TWO) tuple would generate only a cyclic projective image; a projective cyclic group in characteristicFIVE has an invariant line. This contradicts irreducibility in n>ONE. Both tame eigenspaces are therefore nonzero.

## Scott constrains the actual composition factors

The prescribed local lift and opposite tuple used in the [reviewed general reflection theorem](../quotient_geometry/local_actions/weak_cyclic_reflection_representation_obstruction.md) give generators a,b,c of the SAME original G, independently of W. Take the unique unipotent lifts A,B of its p-generators and C=(AB)⁻¹. This scalar normalization does not change tame eigenspace multiplicities. Apply Scott on End(W); irreducibility and trace duality make the common invariant dimensions ONE each, so its THREE centralizer dimensions sum to at most n²+TWO.

Every unipotent of order dividingFIVE has Jordan blocks of size at mostFIVE. For n=FIVE s+t, ZERO≤t<FIVE, the least possible centralizer dimension is m₅(n)=FIVE s²+TWO st+t: its column lengths are s+ONE for t columns and s for FIVE−t columns. The sum of their squares is minimal by convexity; the partition with s blocks of sizeFIVE and one block of size t attains it. This bound includes a killed p-generator, whose larger centralizer only strengthens Scott. The tame centralizer has dimension j²+(n−j)². Therefore
\[
2m_5(n)+j^2+(n-j)^2\le n^2+2,
\]
equivalently the stated squared-imbalance bound.

For n=FOUR, determinant parity forces j odd and nonzero, so j=ONE orTHREE. This is exactly the irreducible tame reflection pattern excluded by the reviewed weak cyclic rank-FOUR obstruction, even if this factor's representation has kernel. Thus no dimension-FOUR composition factor exists.

For n=EIGHT, m₅(EIGHT)=FOURTEEN and determinant parity makes j even. The squared imbalance is at mostTWELVE. The options j=TWO orSIX have squared imbalanceSIXTEEN and are excluded; the only remaining nonzero option is j=FOUR. Every other composition factor has dimension divisibleFOUR and at leastEIGHT, proving dimV≥EIGHT.

No implication about Γ-linear independence is used. A constant module of dimensionEIGHT or higher can evaluate onto a rank-TWO,THREE orFOUR bundle; this is precisely why the new module bridge does not on its own close higher raw or saturated trace degrees. The original T, q and h_i remain in place throughout.
