# Proof: the upper cyclic cubic bridge with five noncommon triple poles

Version2, 3 October2026. The original [seven-point whole audit](../../Research/audits/CANONICAL_TEN_INDEX_THREE_RESIDUAL_FIVE_AUDIT_2026_10_03.md) and new [six-check commuting-deck extension audit](../../Research/audits/CANONICAL_TEN_RESIDUAL_FIVE_COMMUTING_DECK_EXTENSION_AUDIT_2026_10_03.md) are **PASS**. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_index_three_residual_five_exclusion.md). The [degree-fifteen note](../../Research/notes/oct03_ten_hour/index_three_joint_fifteen_upper_cubic_exclusion.md), its [independent PASS audit](../../Research/notes/oct03_ten_hour/index_three_joint_fifteen_upper_cubic_audit.md), and the [new root extension note](../../Research/notes/oct03_ten_hour/index_three_residual_five_commuting_deck_extension.md) are original provenance. The proof includes common infinity points and d≤23. No computation or replay of accepted foundations is used.

## 1. Actual cubic quotient and overlap transfers

Use actual embedded function fields throughout, and write f_i:C₀→X for the descended projections of the original h_i. The [actual joint-root alternative](actual_q0_tensor_elliptic_joint_field_cubic_alternative.md) supplies a genuine simultaneous y-deck of C₀ and the quotient B, with C₀/B cyclic three. The projections f_i are genuinely finite étale: in T→C₀→X the local different exponents are nonnegative and their total is zero. Likewise T/C₀ is finite étale. Étale Hurwitz gives
\[
g(C_0)=8d+1.
\]
The inherited spin ratio and [cubic tower bound](actual_spin_ratio_cubic_tower_bound.md) give z∈B and t∈Γ, t²=z, with the actual identity z³=q₀(x₂)/q₀(x₁). On B the infinity indices of each x_i are one or three, and their simple infinity sets agree. Let R_i be the reduced divisor of the five NONCOMMON triple infinity points for x_i. Cancellation of common simple and triple infinity points gives
\[
\operatorname{div}_B(z)=2R_1-2R_2,\qquad \deg R_i=5.
\]
In particular common infinity points are z-units. A point of R₁ is not an infinity point of x₂: it is not a common triple point, and the shared-simple-set property rules out a simple infinity point of x₂. The analogous assertion holds for R₂.

We check the cubic transfer LOCALLY, without assuming C₀/B unramified everywhere. At any triple infinity point on B, P(x_i) has valuation −30. The tame cyclic root y_i³=P(x_i) is unramified there, with three distinct geometric preimages on C₀. This includes common triple points. At a common SIMPLE infinity point, P(x_i) instead has valuation −10; C₀/B has index three and only one preimage. Thus ramification at common simple infinity points is explicitly retained.

Let H_i=f_i*O be the reduced original infinity divisor on C₀, and J=min(H₁,H₂). The preceding counts give
\[
\deg H_i=d,\qquad \deg J=u+3c=d-15.
\]
Put D_i=H_i−J. These are exactly the reduced pullbacks of R_i, have degree fifteen, and satisfy
\[
\operatorname{div}_{C_0}(z)=2D_1-2D_2,\qquad D_1\cap H_2=D_2\cap H_1=\varnothing.
\]
The stronger support statement, not merely D₁∩D₂=∅, will make the opposite-leg norm finite. Points of J remain z-units. These assertions do not require the common simple or common triple count to vanish.

The actual quotient field can also be recovered as B=k(x₁,x₂,z), with no extra ratio required. Put F₀=k(x₁,x₂,z) and v=y₂/y₁. The original θ comparison gives v²∈F₀ via dx₂/dx₁, and v³=P(x₂)/P(x₁)∈F₀. Each x_i is separating on C₀ and therefore on the intermediate F₀, so the differential ratio belongs to F₀. Hence v=v³/v²∈F₀, and the actual joint generation gives C₀=F₀(y₁). The nontrivial simultaneous cubic deck fixes F₀ and scales y₁, proving B=F₀. This is an index-THREE quotient identity; it is not the false identity C₀=F₀.

## 2. The upper étale bridge and its exact genus ratios

Set B′=B(t) and E=C₀(t). The nonsplit class makes B′/B a connected étale double. Its quadratic class stays nontrivial under the odd-degree extension C₀/B, so E/C₀ is ALSO a connected étale double. It has the free involution σ fixing C₀ and sending t to −t. The coprime cubic and quadratic degrees give an actual connected cyclic cubic E/B′. All these fields already lie in the original T because t∈Γ and C₀⊂T.

The divisor of t on B′ has ten simple zeros and ten simple poles. Its divisor on E has thirty simple zeros and thirty simple poles, obtained above D₁,D₂. In particular t is separating despite degrees divisible by five. Put F=k(t). Degree and Hurwitz give
\[
[B':F]=10,\qquad [E:F]=30,\qquad g(E)=16d+1.
\]
The original intermediate map T/E is finite étale because T/C₀ is. Put m=[T:E]. The retained Γ·k(X_i)=T gives ΓE=T. The original canonical identity and degree-ten carrier yield
\[
g(T)=16dm+1,\qquad g(\Gamma)=\frac{4dm}{5}+1,\qquad [\Gamma:F]=3m.
\]
All towers over F are separable. Their normalized canonical degrees are therefore
\[
u_E=\frac{2g(E)-2}{30}=\frac{16d}{15}\ge16,\qquad
u_\Gamma=\frac{2g(\Gamma)-2}{[\Gamma:F]}=\frac{8d}{15}=\frac{u_E}{2}.
\]
For clarity the lower tensor product is whole too, but is not used as an étale lower bridge. If U₀=ΓB′, then [T:U₀] divides three by the cyclic E/B′ extension and divides ten because U₀ contains Γ. It is one, so ΓB′=T and B′⊗_FΓ is the whole connected degree-ten tensor product. T/B′ retains any actual E/B′ cubic ramification. No lower étaleness premise is inserted.

## 3. Actual S10 complement and exact ternary kernels

Let N/F be the normal closure of the SINGLE actual E/F extension, and M its faithful transitive group on thirty E-sheets. The intermediate B′ gives ten triples, with block kernel K. Restriction identifies H=Gal(NΓ/Γ) with a subgroup of M. The actual ΓE=T and S10 monodromy give a natural H-orbit Δ of ten sheets with induced group S10. Intersections with triples form a partition of this primitive action; Δ cannot fit within a triple. Thus Δ meets all ten triples once, and the block image is exactly S10.

Since E/B′ is cyclic Galois three, the FULL triple stabilizer induces C3 on its triple: its sheet stabilizer is normal of index three. Hence K acts by coordinate C3 translations. Each K-coordinate projection is nontrivial. Otherwise the full C3 image would factor through the block point stabilizer S9, impossible because A9 is perfect and its remaining quotient has order two.

An element of H acting trivially on Δ fixes one sheet in each triple and has trivial block action. It lies in K, and each coordinate C3 translation fixing a sheet is identity. Therefore H≅S10 is an ACTUAL complement and M=K⋊H. Label the selected Δ-sheet in each triple zero in F3. A block stabilizer in H fixes that sheet, so its C3 coordinate image is trivial. Transporting the entire labels by H is therefore well-defined and makes H the ordinary coordinate permutation group.

In these labels K is an ordinary S10-invariant nonzero-coordinate subspace V of W=F3^10. Put C=F3·1 and A={w:Σw_i=0}. The possibilities are exactly C,A,W. A constant-only nonzero subspace is C. Otherwise a transposition exchanging two unequal entries of some w∈V gives a nonzero multiple of e_i−e_j. S10 conjugation supplies every difference, which spans the codimension-one A. This direct argument uses the additional cyclic-cubic hypothesis and the actual ten-orbit; no signed complement, binary kernel, or unproved module classification is presumed.

## 4. Large kernels: the actual normal closure is étale over every sheet field

Suppose V=A or W. Let Ψ=MΔ. Its orbit is the zero-sum hyperplane or all complete transversal labels, respectively, so D=|Ψ| is 3^9 or 3^10. Put Z=N^{M_Δ}. The actual H fixes Δ, so Z⊂Γ and EZ⊂ΓE=T.

For a distinguished E-sheet p∈Δ, the M_p-action on its orbit of Δ is faithful. Augmentation translations with p-coordinate zero supply all zero-sum assignments on the other nine coordinates. For any outside sheet a, the intersection of these transversals containing a is exactly {p,a}: any other coordinate can vary with a compensating third coordinate. An element fixing each orbit member therefore fixes every sheet outside p's triple. It fixes p as well, and its coordinate image on p's triple is C3. Consequently it fixes that entire triple and is identity. This checks the full action kernel, including the potentially invisible two sheets of the distinguished triple.

The normal closure of EZ/E is therefore EXACTLY N/E. Since EZ⊂T and T/E is genuinely finite étale, EZ/E and its normal closure N/E are finite étale. Conjugating this actual extension gives N/E_a étale for EVERY E-sheet a. Any inertia subgroup I of N/F consequently intersects every sheet stabilizer trivially. Thus I, and every lower ramification subgroup, acts semiregularly on the thirty sheets. N/E is concluded only after the kernel check; it is not an initial premise.

## 5. Every lower conductor term gives the same strict gap

A nonidentity semiregular inertia element of order e has all sheet cycles of length e. If it fixes a complete transversal, every selected block cycle must also have length e: its selected sheet would otherwise have a smaller orbit. All ten blocks are selected, so e divides ten and there are at most 3^(10/e)≤3^5 fixed complete transversals. Restriction to the zero-sum hyperplane can only decrease the count. Since D≥3^9, the fixed fraction is at most 1/81. The order-five case fixes at most nine transversals and the order-ten case at most three, so wild-five inertia at thirty sheets is included.

Burnside gives, for every inertia subgroup B,
\[
1-\frac{\#(\Psi/B)}D\ge\frac{80}{81}\left(1-\frac1{|B|}\right).
\]
The original thirty-sheet normalized orbit-codimension is exactly 1−1/|B| by semiregularity. Applying this inequality to each lower group with its nonnegative permutation Artin-conductor weight |I_j|/|I_0|, in a characteristic-zero representation, gives the actual conductor–different comparison
\[
\frac{\deg\operatorname{Diff}(Z/F)}D\ge\frac{80}{81}\frac{\deg\operatorname{Diff}(E/F)}{30}.
\]
Since F is rational, the E/F normalized different is u_E+2. Therefore
\[
\frac{2g(Z)-2}D\ge-2+\frac{80}{81}(u_E+2).
\]
Its excess over u_Γ=u_E/2 is
\[
\left(\frac{80}{81}-\frac12\right)u_E-\frac2{81}
=\frac{79u_E-4}{162}\ge\frac{70}{9}>0.
\]
But Z⊂Γ is an ACTUAL separable field inclusion, so Hurwitz gives (2g(Z)−2)/D≤u_Γ. This excludes both large kernels for every d≥15 with r′=5, independently of overlap and without discarding any wild conductor term.

## 6. Constant kernel: the commuting cubic deck fixes all six end points

If V=C, global translations and ordinary coordinate permutations preserve the three horizontal ten-sheet blocks. For ANY system of three ten-sheet blocks, its intersection partition on the primitive H-orbit forces Δ to be one complete block. Its M-translates determine the whole system, so the system is unique. Its block stabilizer contains H and the distinguished E-sheet stabilizer, defining an actual cubic field R₀⊂E∩Γ with [E:R₀]=10. Every cubic F-subfield of E corresponds to such a system, proving uniqueness of R₀ as well. Degree equality makes E⊗_(R₀)Γ the actual whole connected T.

The constant line is centralized by the ordinary permutation complement, so M=C₃×S₁₀ and H is normal. Thus this SAME unique cubic field R₀=N^H is GALOIS cyclic three over F. Since [B′:F]=10, coprime degrees give R₀B′=E. The deck τ of E/B′ is the original simultaneous y-scaling on C₀, extended by fixing t; it restricts to the full cubic deck on R₀/F.

The free involution σ of E/C₀ fixes C₀ and sends t to −t. These specified actions commute on E=C₀(t), hence on R₀. Uniqueness gives σ(R₀)=R₀; its restriction is nontrivial because t∈R₀. Put Q=R₀^{σ}. Then Q⊂C₀, C₀R₀=E, R₀∩C₀=Q, and
\[
[R_0:Q]=2,\qquad [Q:k(z)]=3,\qquad [C_0:Q]=10.
\]
These are actual separable fields. The original Γ/R₀ degree is m. Hurwitz gives
\[
g(R_0)\le\left\lfloor\frac{4d}{5}+1\right\rfloor.
\]
All t-zeros and poles on E are simple, regardless of common infinity points. Thus R₀/F is unramified at zero and infinity, and each fiber has three distinct points, transitively permuted by τ. The σ permutation commutes with this three-cycle and has order dividing two. Its centralizer is C₃, so the permutation is identity: ALL THREE points of each end fiber are fixed. A fixed point must have t=−t, so there are no others. The tame involution has exactly six ramification points, and Hurwitz gives
\[
g(R_0)=2g(Q)+2,\qquad
g(Q)\le\left\lfloor\frac{2d}{5}-\frac12\right\rfloor\le8
\qquad(15\le d\le23).
\]
Common infinity points are t-units and do not enter these two fibers or alter this fixed-point argument.

## 7. The opposite original X-leg excludes the uniform double fiber

Choose a σ-fixed R₀-point above t=0 and its image a₀ on Q. The R₀/F index there is one and the F/k(z) index is two. The R₀/Q index is also two, so Q/k(z) is unramified at a₀. Every C₀-point over z=0 lies in D₁ with index two over k(z). Hence the ACTUAL π:C₀→Q has uniform fiber
\[
\pi^*a_0=2E_0,\qquad \deg E_0=5,
\]
with E₀ reduced and supported in D₁.

The accepted [fixed-pair arithmetic](../../Theorems/curve_arithmetic/fixed_pair_arithmetic.md) gives absolute simplicity of the nine-dimensional J(X), whereas g(Q)≤8. Hence Hom(J(Q),J(X))=0. The actual correspondence (f₂)_*π*:J(Q)→J(X) vanishes, so all degree-ten norms of Q-points are linearly equivalent. Any Q-point a_∞ over z=∞ has its entire C₀-fiber supported on D₂, giving (f₂)_*π*a_∞=10O. Common points J are z-units and cannot occur in that fiber. Moreover D₁∩H₂=∅, so E_X=(f₂)_*E₀ is an effective divisor of degree five disjoint from O, even with arbitrary allowed overlap. It follows that
\[
2E_X\sim10O.
\]
The accepted [fixed-X two-torsion theorem](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md) forces O_X(E_X−5O) to be trivial: its twist by 5O, hence by 7O, has a section. Thus E_X∼5O. A finite degree-five divisor in that class gives a function of exact pole order five at O, contradicting the fixed semigroup ⟨3,10⟩. This excludes the constant kernel through d=23. No replay of the fixed-X arithmetic or certificates is needed.

## Exact coverage and remaining boundaries

The three exact kernel possibilities exhaust the actual upper cyclic-cubic bridge. Thus all nonsplit index-THREE retained configurations with r′=5 and 15≤d≤23 are excluded, including every possible common-simple or common-triple infinity profile. Both original actual X-maps and the original finite étale BACKUP q-leg remain on the SAME original T. Only E/F is normally closed; no simultaneous endpoint Galois closure or replacement common source is used.

At d=15,16,17, d=u+3r and the accepted r′ lower bound force r=r′=5, c=0 and u=d−15 in the nonsplit class; the split class would need r′≥10 and cannot occur. This proves the stated full index-three exclusions at those degrees. It supplies the index-three input for a separate retained-source recognition synthesis through seventeen; the present theorem itself does not claim the other index-one inputs or that synthesis.

The first remaining constant-kernel genus boundary is d=24, where g(R₀)≤20 and g(Q)≤9. At d=25 the raw bound g(R₀)≤21 and its evenness still give g(Q)≤9. Absolute simplicity of J(X) then does not force the correspondence to vanish. These genus-nine possibilities remain unexcluded; no extension through d=24 is claimed.

The separate [upper cyclic-triple theorem](../../Theorems/cartier_and_spin/canonical_ten_upper_cyclic_triples_six_through_nine_exclusion.md) covers r′=6,…,9 in every supplied joint degree, using partial transversals. The present proof instead uses ten triples and complete transversals throughout. Full retained recognition through nineteen already combines these inputs with INDEX-ONE19; no new index-one exclusion is supplied by this Version2. The unrestricted unmarked common-cover problem remains open.
