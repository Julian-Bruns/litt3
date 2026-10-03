# Proof: the actual tame double has too many shared primitive critical points

Version1,3 October2026. Whole scoped review [PASS](../../Research/audits/RANK_THREE_SCALAR_TARGET_AND_TAME_IDENTITY_AUDIT_2026_10_03.md); see the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_rank_three_tame_etale_row_exclusion.md). No computation or finite-group classification is used.

## The genuine rank-three determinant supplies the full tame signature inputs

Write N=|R|, n=g(D)−ONE and e=deg(C→D), with en=N. The [native determinant theorem](rank_three_etale_row_native_determinant_constraints.md) gives actual ℓ=lcm|R_z|=e, e≤N/FORTY FOUR, and n≥FORTY FOUR. Every stabilizer divides e by freeness on the actual row fiber. Faithfulness on D gives C=Y D, so Y→D/R is the actual complete uniform coarse atlas of degree e.

If e>ONE, its coarse quotient is rational, using genus-two Hurwitz and the accepted selected elliptic-map exclusions. An odd e is excluded by the accepted odd-uniform atlas theorem. Thus e is even. These facts supply exactly the inputs to the elementary enumeration and selected-endpoint geometry of the [tame signature proof](tame_etale_positive_full_spin_signature_reduction.md), from its displayed uniform Hurwitz equation onward:
\[
\sum_i(1-1/m_i)-2=2/e,\qquad m_i\mid e,
\qquad\operatorname{lcm}(m_i)=e.
\]
Those sections use only actual uniform endpoint maps, evenness, lcm, Aut(Y)=C₂ and accepted selected elliptic/three-branch/quadrangular exclusions. They do not use a rankFOUR bundle, coefficient irreducibility, or a determinant character once these numerical inputs have been supplied. Consequently e=TWO is the only nonidentity tame case, with six index-TWO coarse values.

Then Y→D/R is its hyperelliptic double. Its actual base change C=Y D makes C→D a Galois double with deck σ. It fixes D, induces ι_Y on Y, and commutes with R on C because R fixes Y and σ fixes D. No lifting of an unrelated endpoint automorphism has been assumed.

## The two canonical maps have the same critical divisor

The [accepted higher-row quotient geometry](canonical_ten_higher_trace_row_geometry.md), which does not require rankFOUR, supplies an actual C→Γ_R of degreeTEN, full S10 monodromy, and different q_C*P₀ with N distinct index-TWO points. It also gives
\[
g(C)=N+1,\quad g(\Gamma_R)=N/20+1,
\qquad40\mid N.
\]
The distinguished P₀ is Weierstrass. Since σ induces ι_Y it preserves q_C*P₀. Hence φ_C and φ_Cσ have the SAME N index-TWO ramification points.

Their target fields cannot coincide. This is the rank-independent field calculation in the accepted [primitive row proof](canonical_ten_primitive_row_identity.md): if σk(Γ_R)=k(Γ_R), its commuting R-action normalizes the actual degree-TEN field k(β)⊂k(Y). Use the accepted canonical-ten normal form
\[
y^2=z^5+c_4z^4+c_0,\quad
\beta=(y+b)^2/z^5,\quad b^2=2c_0,
\quad b,c_4,c_0\ne0.
\]
The hyperelliptic involution preserves β's pole pair over z=ZERO. Any induced Möbius action therefore fixes infinity and is affine. Comparing the y coefficient forces slope−ONE, whereas
\[
\beta+\iota_Y\beta=2+2c_4/z+c_0/z^5
\]
is nonconstant. No such affine action exists. Thus the two embedded Γ_R-fields are distinct. Primitive S10 monodromy makes their compositum all k(C), because the intermediate extension above the first Γ_R field can only be that field or C.

## The common-ramification delta budget is too small

The product image C→Γ_R×Γ_R is therefore birational. The characteristic-independent Hodge-index/adjunction bound, as proved in the same accepted primitive-row record, gives
\[
p_a(\mathrm{image})\le20g(\Gamma_R)+81=N+101.
\]
Its normalization has genus N+ONE, so total delta is at mostONE HUNDRED. At each of the N common ramification points both local coordinate derivatives vanish; that normalized image branch is singular and contributes at leastONE to delta. Contributions remain additive if several branches meet at one image point. Thus N≤ONE HUNDRED.

But e=TWO gives N=2n≥EIGHTY EIGHT and FORTY divides N. Hence N≥ONE HUNDRED TWENTY, a contradiction. This deletes the nonidentity tame étale row using the actual original carrier rather than a presumed X-map downstairs.

The conclusion is e=ONE in the tame target scope. Wild étale rows and the identity-row branch remain open; no finite coefficient-rank bound or common-cover exclusion follows.
