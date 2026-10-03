# Proof: the positive different has incompatible residue modulo four

Version3,3 October2026. [Independent whole-scope review PASS](../../Research/audits/RANK_THREE_ETALE_ROW_DEPTH_FREE_WILD_AUDIT_2026_10_03.md). See the [exact retained-source statement](../../Theorems/cartier_and_spin/rank_three_etale_row_depth_free_wild_reduction.md). The unsaturated deletion was reached independently by the author and root. The Version3 whole exclusion uses the stronger endpoint Abel input and does not rely on that special case.

## Actual area, inertia and the first break

The [native determinant theorem](rank_three_etale_row_native_determinant_constraints.md) gives lcm of stabilizer orders equal to e. The [determinant torsor theorem](rank_three_etale_row_determinant_torsor_and_even_inertia.md) gives e even, quotient P¹, and exactly ONE wild and ONE tame branch value. Write their inertia orders as i=w h and j, where w=|I₁| is a power of FIVE and FIVE does not divide h j. Put g=gcd(i,j)=gcd(h,j). Then
\[
e=ij/g,\qquad \frac{\delta_i}{i}-1-\frac1j=\frac2e.
\]
Write
\[
\mathcal D=\sum_{r\ge1}(|I_r|-1),\qquad \delta_i=i-1+\mathcal D.
\]
Thus the area identity is
\[
j(\mathcal D-1)=w h+2g. \tag{1}
\]
The full TWO-parts of h and j agree. This follows already arithmetically: the positive different sum is even, so \mathcal D−ONE is odd, and (1) has TWO-adic valuation v₂(j)=v₂(h), because v₂(g)=min(v₂(h),v₂(j)) and w is odd. If the two valuations were unequal, the right side would have valuation equal to the smaller one, or would have valuation strictly larger than v₂(j) when j had the smaller valuation, both contradictory. Consequently write h=gH and j=gJ with coprime ODD positive H,J.

The general actual local [tame ramification constraint](../../Theorems/quotient_geometry/local_actions/ramification_constraints.md) gives h dividing \mathcal D. Equation(1), divided by g, gives
\[
\mathcal D=wH/J+1+2/J,\qquad H\mid J+2. \tag{2}
\]
The [proper evaluating Cartier-image gate](proper_cartier_image_excludes_first_wild_break_one.md) excludes first lower break ONE. Hence the first positive break b is at least TWO and
\[
\mathcal D\ge2(w-1). \tag{3}
\]
Every summand |I_r|−ONE is divisible by FOUR, because every nontrivial I_r is a FIVE-group. In particular FOUR divides \mathcal D.

## No wild group of order at least twenty-five

If w≥TWENTY FIVE, (3) gives \mathcal D>w+THREE. Were H≤J, (2) would instead give \mathcal D≤w+THREE. Thus H>J. As H is an odd divisor of J+TWO, this forces H=J+TWO: every proper odd divisor is at most (J+TWO)/THREE≤J. Equation(2) now reads
\[
J\mathcal D=(w+1)(J+2).
\]
Modulo FOUR, w is ONE and J,J+TWO are odd. The right side is therefore TWO modulo FOUR. The left side is ZERO modulo FOUR. Contradiction. This proves w=FIVE without bounding subsequent breaks or assuming I₁ abelian beforehand.

## The cyclic-five case

For w=FIVE there is just one positive break b, prime to FIVE, and \mathcal D=FOUR b. If b≥THREE, then \mathcal D≥TWELVE>w+THREE and precisely the same modulo-FOUR contradiction applies. Hence b=TWO and \mathcal D=EIGHT. Equation(2) becomes SEVEN J=FIVE H+TWO. If H>J the same contradiction applies; if H<J, oddness gives H≤J−TWO, making SEVEN J≤FIVE J−EIGHT impossible. Thus H=J=ONE. Consequently h=j=g and e=FIVE h. The local tame constraint h dividing b(w−ONE) gives h dividing EIGHT. Since e is even, h is TWO,FOUR or EIGHT. The wild different is FIVE h+SEVEN, giving the stated table. The tame action on C₅ has order h/gcd(h,TWO); its central tame kernel of order TWO is retained.

## Actual cyclic endpoint covers and their exact differentials

Choose a coordinate β on the actual quotient P¹ with its pole at the wild value and its zero at the tame value. Because C→D is étale, the actual map Y→P¹ has a single wild pole Q of index FIVE h and FIVE tame zero points R₁,…,R₅, each of index h. Thus
\[
\operatorname{div}(\beta)=h\sum R_\nu-5hQ.
\]
The connected normalization Y_h of k(Y)(\beta^{1/h}) is an actual cyclic étale cover of Y, of degree d dividing h. It is connected by this field definition; it need not have degree exactly h for the ordinarity argument. The root v=\beta^{1/h} is separating because \beta is separating and h is prime to FIVE. Since this cover is étale, its differential orders follow from dv=d\beta/(h v^{h-1}): above Q they are
\[
(7-5h)+5(h-1)=TWO,
\]
and above each R_ν they are (h−ONE)−(h−ONE)=ZERO. Elsewhere dv is a unit. Hence dv is a NONZERO REGULAR EXACT differential on Y_h. The cover is nonordinary.

For h=TWO orFOUR, every connected cyclic étale cover of exponent dividing FOUR of either selected Y is ordinary. This is the prescribed-family specialization of [the ordinary abelian-cover theorem](../../Theorems/jacobians/ordinary_covers/genus_two_abelian_cover_families.md) for MAIN and [the complete small abelian ordinarity input](../../Theorems/jacobians/ordinary_covers/backup_small_abelian_ordinarity.md) for BACKUP. Even d=ONE contradicts ordinarity of Y. Therefore these rows are excluded. For h=EIGHT, the same construction is a necessary nonordinary cyclic cover of degree dividing EIGHT; if its degree divided FOUR it too would be excluded, so its degree is exactly EIGHT.

## The remaining exact divisor descends to the ordinary endpoint

In the remaining h=EIGHT case, f:Y₈→Y is an actual cyclic étale map of degree EIGHT, and the calculation above gives the EXACT equality
\[
\operatorname{div}(dv)=2f^*Q.
\]
Since ω_{Y₈}=f*ω_Y, this implies f*(ω_Y(-TWO Q))=O. Norm along f gives
\[
(\omega_Y(-2Q))^8=O_Y.
\]
The original reference point O is Weierstrass, so ω_Y=O_Y(TWO O), and therefore SIXTEEN[Q−O]=ZERO in J(Y). On MAIN, the accepted [thirty-two Abel theorem](../../Theorems/jacobians/torsion/family_thirty_two_torsion_specialization.md) includes all sixteen-torsion points and applies to its selected high-degree parameter. On BACKUP, [the established entire two-primary Abel classification](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md) supplies the same consequence. Thus Q is Weierstrass on BOTH endpoints.

Choose a nonzero regular differential η_Q on Y with divisor TWO Q. Its pullback and dv have the SAME divisor, so their quotient is a regular invertible function on the proper connected Y₈ and hence a nonzero constant. Consequently
\[
dv=c\,f^*\eta_Q,\qquad c\ne0.
\]
Cartier kills dv because it is exact. Cartier commutes with étale pullback, and its inverse-Frobenius action on the nonzero scalar does not affect vanishing. Pullback on rational differentials is injective for the finite separating f, so Cartier kills η_Q. This contradicts the accepted ordinarity of the original Y. The FORTY row is impossible, completing the entire wild exclusion.

These are actual covers of the original Y and can, if needed, be composited with the original T to retain BOTH étale endpoint maps on one actual refined source. They are used only for the endpoint obstruction; no X-map is asserted on Y₈ or D.

## The unsaturated original lattice would omit every finite source branch

Now retain the additional original rankTHREE trace hypotheses in the theorem. Write E_Y=Sat_{B_Y}(K_Y). Every saturated rankTHREE Cartier subbundle on the selected genus-two Y has degree at mostTWO, by the accepted annihilator-line bound cited in [the original rank-three proof](canonical_ten_rank_three_ramified_nonzero_quotient_exclusion.md). If K_Y were unsaturated, E_Y/K_Y would therefore have lengthONE. Étale pullback and saturation commute. Consequently, for E_D=Sat_{B_D}(K_D), its actual loss divisor has degree n and its annihilator A_D=E_D^⊥ has degreeZERO. Here E_D denotes this saturated Cartier lattice, not the earlier Grassmann quotient bearing the same letter in its own antecedent.

The loss divisor is R-invariant. In the FORTY profile the wild orbit has n points, the tame orbit has FIVE n, and every other orbit has FORTY n. A nonzero invariant effective divisor of degree n must therefore be EXACTLY the wild orbit, with multiplicityONE. At each wild point the K_D fiber image has rankTWO and still evaluates surjectively; E_D is saturated and has fiber rankTHREE.

Choose a parameter t linearizing the tame C₈ action. Its fourth power κ is the central involution of C₅⋊C₈, and κt=−t. A wild generator σ commutes with κ and has first breakTWO, so
\[
\sigma t=t+a t^3+O(t^5),\qquad a\ne0.
\]
On the Cartier fiber with basis dt,t dt,t²dt,t³dt, the nonzero leading transitions are dt↦dt+THREE a t²dt and t dt↦t dt+FOUR a t³dt. The tame C₈ weights ONE,TWO,THREE,FOUR are distinct. Any invariant fiber subspace which evaluates nontrivially contains dt and hence t²dt. Its rankTWO possibility is therefore precisely span(dt,t²dt); its rankTHREE possibility must add t³dt, because adding t dt would force FOUR dimensions. Thus
\[
\operatorname{im}(K_D)_z=\langle dt,t^2dt\rangle,
\qquad (E_D)_z=\langle dt,t^2dt,t^3dt\rangle.
\]
In particular the K-image omits the intrinsic highest exact-jet line F₄, spanned by t³dt.

The canonical alternating pairing pairs the first and fourth basis vectors and the second and third. Hence the annihilator A_D has fiber spanned by t²dt at each wild point. Its actual adjunction F_D*A_D→ω_D has exact zero orderTWO there. Since degA_D=ZERO, its total zero degree is TWO n, so these n wild points exhaust that divisor. At every other point the A-adjunction is nonzero, and its orthogonal rankTHREE lattice E_D omits F₄. This is the intrinsic pairing/third-Wronskian criterion already proved in [the original rank-three proof](canonical_ten_rank_three_ramified_nonzero_quotient_exclusion.md). Thus the actual K_D image omits F₄ EVERYWHERE, and this conclusion pulls back étale to the original common source T.

The actual constant quotient J_Y/K_Y=O_Y gives one fixed kernel plane W in the original three-section net I=O_X³. Its original saturation has degree at mostFOUR. The accepted actual source calculation gives at mostTWO finite cubic X-points where W has deficient rank: if ℓ(q1)≠ZERO this is the TWO-point bound in [the nonzero-quotient proof](canonical_ten_rank_three_ramified_nonzero_quotient_exclusion.md), and if ℓ(q1)=ZERO it is the stronger ONE-point bound in [the zero-quotient proof](canonical_ten_rank_three_ramified_zero_quotient_exclusion.md). On any retained degree-d étale original X-leg these account for at mostTWO d points.

Every other actual finite cubic source branch has I-fiber rankTWO, contains the intrinsic F₄, and has W-fiber rankTWO, so the two fiber images agree. But W maps integrally into q*K_Y, whose actual B-image omits F₄ everywhere. Such a branch is impossible. This bounds all finite cubic source branches by TWO d, whereas the original degree-d étale X-map has exactly TEN d such points. Contradiction.

Thus the unsaturated attempted FORTY row is also impossible by this independent original-source argument. Version3 already excludes its saturated complement by the preceding exact-divisor descent. The identity row remains unresolved; both original maps remain on T throughout.
