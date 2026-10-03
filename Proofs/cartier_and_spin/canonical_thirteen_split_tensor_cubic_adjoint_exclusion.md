# Proof: the adjoint fiber degree closes every remaining overlap at degree thirteen

Version1, 3 October2026. [Independent focused audit PASS](../../Research/audits/CANONICAL_THIRTEEN_SPLIT_ALL_OVERLAP_CUBIC_ADJOINT_AUDIT_2026_10_03.md). Mathematical scope is unchanged by canonical metadata integration.

The independently audited [disjoint-infinity theorem](canonical_thirteen_split_disjoint_cubic_adjoint_exclusion.md) excludes c=0, and the independently audited [small-common companion](canonical_thirteen_split_common_infinity_cubic_adjoint_exclusion.md) excludes c=1,2,3. We retain those frozen proofs as accepted inputs. This proof establishes the new large-overlap implication, without replaying their cubic identity or local all-order obstruction.

## 1. Actual geometry and the retained adjoint

Let J=min(H₁,H₂), c=degJ. Since both infinity divisors are reduced of degree13 and t is nonconstant, c≤12. The accepted actual conic image C⊂S has normalization C₀, CF=13−c, CD±=3c± with c₊+c₋=c, K_SC=−26−c, and g(C₀)=105. The sections satisfy D±²=−3,D₊D₋=0, and K_S=−D−2F.

The original θ₂ has divisor16ν*F∞+16J. The exact normalization-duality construction, with the unchanged vanishing H¹(−D−18F)=0, therefore gives a nonzero section σ on S of class C−D−18F, satisfying
\[
\sigma F=11-c,\quad
\sigma D_\pm=3c_\pm-15,
\qquad\nu^*\operatorname{div}(\sigma_C)=\Delta+16J,
\]
where Δ is the actual conductor. These statements do not require a bound on c; they are the same actual section, not a numerical divisor chosen for this proof. If c=12 its fiber degree is already negative, contradicting effectivity.

For an affected boundary with1≤cᵢ≤5, the accepted extra-factor argument applies without change: its negative intersection first forces5−cᵢ copies; the remaining degree-zero restriction vanishes at a common branch because its pullback order is at least1+3cᵢ>0; it therefore forces one extra. Hence it has at least6−cᵢ copies. At cᵢ=6 this lower bound is zero and holds automatically. At cᵢ=0 the original negative intersection forces five copies.

## 2. Two affected boundaries are impossible for every overlap

If both positive counts are at most6, remove at least(6−c₊)D₊+(6−c₋)D₋. Its total fiber degree is12−c, leaving−1 from σF=11−c. This contradicts effectivity.

If one positive count c_large is at least7, the other is at most5 because their sum is at most12. Factoring6−c_other copies of the other boundary leaves fiber degree
\[
11-c_{\rm large}-c_{\rm other}-(6-c_{\rm other})
=5-c_{\rm large}<0,
\]
again impossible. Thus every common infinity point lies on just one boundary, call it D₊.

## 3. One-sided overlap at least seven is immediately impossible

The unaffected D₋ always occurs at least five times in σ. If c≥7, removing it leaves fiber degree6−c<0. This excludes all one-sided overlaps7,…,12 without any local index classification.

## 4. One-sided overlap four, five or six violates the actual genus

For4≤c≤6, factor at least(6−c)D₊+5D₋, with no D₊ factor needed at c=6. The residual effective divisor has class
\[
R=C-(7-c)D_+-6D_--18F,
\qquad RF=0,\quad RD_+=3,\quad RD_-=0.
\]
It is vertical. Nonnegative intersections with D₋ force it to consist only of the six degenerate components Eᵢ meeting D₊ and avoiding D₋. Write R=ΣkᵢEᵢ, kᵢ≥0,Σkᵢ=3. This argument includes c=6; it does not demand an extra factor on a boundary of positive intersection.

Use B=D₋ and D₊=B+3F−ΣEᵢ in the accepted six-fiber Hirzebruch blowup basis. The residual equality gives
\[
C=(13-c)B+3(13-c)F-\sum_i(7-c-k_i)E_i,
\]
and hence C²=255−3c²−Σkᵢ². Adjunction and the ACTUAL genus105 yield
\[
\delta=p_a(C)-105
=\frac{21-c-3c^2-\sum_i k_i^2}{2}<0
\qquad(4\le c\le6).
\]
This is impossible for an integral curve and its normalization. No arbitrary divisor class or one-leg genus is being substituted: the residual class came from the original canonical differential of an actual étale source.

These four steps exclude every new case c=4,…,12. The two independently audited antecedents exclude c=0,…,3. Therefore every nonconstant actual split cubic-index-one degree-thirteen comparison is impossible, with arbitrary common infinity. The [self-contained large-overlap note](../../Research/notes/oct03_ten_hour/split_thirteen_large_overlap_extension.md) records this changed-scope implication. No computation, certificate replay, Pro request or shared integration edit is used. Nonsplit comparisons, higher joint degrees and the unmarked common-cover problem remain open.
