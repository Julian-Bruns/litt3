# Proof: multiplier and Wronskian constraints on the actual coefficient row

Version5,3 October2026. The complete scoped argument passed [root whole review](../../Research/audits/POSITIVE_COEFFICIENT_ROW_GEOMETRY_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/positive_finite_coefficient_row_geometry.md). Both original étale maps stay on T throughout.

## The actual coefficient quotient

Write N=|R|. The quotient by the actual projective coefficient kernel gives q_C:C→Y étale of degree N. Its scalar action cancels the coefficient scalar in q*J_Y, yielding the descended line P and q_C*J_Y=P⊗V. Thus g(C)=N+1, degP=N/FOUR and degA=THREE N/FOUR. Irreducibility follows from integral degree: an invariant constant subspace of rank r between ONE andTHREE would descend to a subbundle of J_Y of degree r/FOUR.

The raw identities and the SIX/EIGHT zero-label count prove that the row has no base point, exactly as in the general opening of the [abelian exclusion](abelian_humbert_positive_trace_exclusion.md). Its constant kernel is invariant and therefore zero. The row spans a nondegenerate integral projective curve. An element of R acting identically on that curve must be scalar: the curve would otherwise lie in the finite union of its proper projective eigenspaces, hence in one of them. Consequently R acts faithfully on D.

The canonical horizontal Taylor isomorphism F*B_C≅J³ω_C gives the nonzero third Wronskian and
\[
\operatorname{div}(\mathrm{Wr}_C)=5D_C,
\qquad D_C=q_C^*\operatorname{div}(B_Y/J_Y),\qquad \deg D_C=3N.
\]
In particular the row is separating. Its image line M on D satisfies A=φ*M for φ:C→D, with the original four-dimensional row subspace in H⁰(D,M).

## Rational normalization is impossible

If D=P¹, then M=O(ℓ) for some positive ℓ. The actual R action on D is a homomorphism into PGL₂. Choose lifts to GL₂, with scalar cocycle β. Determinants show that 2[β]=0. The induced action on H⁰(P¹,O(ℓ)) has cocycle ℓβ (up to replacing the action by its dual). Its invariant four-dimensional row subspace has the same cocycle. Thus its multiplier has order at mostTWO, contradicting the actual coefficient multiplier of orderFOUR. This excludes rational images of ANY degree and uses no classification of finite subgroups of PGL₂.

## A complete elliptic quartic exhausts the different

Suppose g(D)=ONE and degM=FOUR. Riemann–Roch gives h⁰(M)=FOUR, so the row is the complete elliptic quartic series. In characteristic FIVE its vanishing sequence is(0,1,2,3) except at the SIXTEEN points satisfying M=O(4z); there it is(0,1,2,4). Multiplication byFOUR is étale, so those flexes are distinct and their third Wronskian weights are exactlyONE. There are no other Wronskian zeros, because degWr_D=4degM=SIXTEEN.

Put e=degφ. Degrees give e=3N/SIXTEEN. Since C→D is separating and D is elliptic, its total different has degree2N. For a point t over a flex z, write j=e_t(φ) and δ=δ_t(φ). The chain rule for the zero-through-third Hasse jet determinant gives
\[
\operatorname{ord}_t\mathrm{Wr}_C=j\operatorname{ord}_z\mathrm{Wr}_D+6\delta=j+6\delta.
\]
This is valid in the wild case as well: the diagonal factors in the jet chain rule are1,φ′,(φ′)²,(φ′)³. Since the actual Wronskian divisor is divisible byFIVE, j+δ=0 moduloFIVE.

Every such local type has δ/j≥TWO/THREE, with equality only j=THREE, δ=TWO. Indeed j=ONE is unramified and violates the congruence; j=TWO is tame with δ=ONE and again violates it. If j≥THREE is tame, δ=j−ONE and the ratio is at leastTWO/THREE, with equality only atTHREE. If it is wild, δ≥j, giving a still larger ratio.

Summing over each flex fiber gives total different at least(TWO/THREE)e. Over SIXTEEN flexes this is
\[
16\cdot\frac23e=2N,
\]
already the entire different. Hence equality holds everywhere: every point over a flex has tame indexTHREE, and there is no ramification elsewhere.

The raw local row orders are therefore(0,3,6,12). Their distinct residues moduloFIVE identify the actual J lattice with primitive orders(1,4,7,13); its Smith exponents in B are(0,0,1,2). The points over the flexes number16e/THREE=N. There are no other defects, and each has lengthTHREE. Since C→Y is an étale R-torsor and the defect descends to Y, these N points are one complete R-orbit. Thus B_Y/J_Y is supported at a single Q with Smith type(2,1).

## The original net determines the contact

Pull back to the retained original T. At an ordinary finite source point the original net I is a rank-three subbundle in B; it cannot lie in the rank-two defect fiber of J. At infinity the original exact net has differential orders(1,7,10), as proved in the [generated-source bundle proof](cartier_kernel_generated_subbundle.md). Its orderONE differential cannot lie in the target lattice of orders(0,3,6,12): the first available differential order congruent toONE moduloFIVE isSIX. Thus infinity sheets are impossible over q⁻¹(Q) as well. These assertions concern the intrinsic differential evaluations and survive all actual étale parameter changes and horizontal-frame changes.

Every source sheet over Q is consequently a finite cubic branch. Its original I has source Smith shape(0,0,1), so U/I has lengthONE. The target J fiber has rankTWO, while U is rankTHREE; therefore U is not contained in J and its contact has length exactlyONE. Away from Q the target J is B and contact isZERO. The reduced q-fiber has8d points, proving contact8d. No map from C or D to X has been inferred.

## Every elliptic row has a bounded cyclic endpoint carrier

Now suppose D is ANY elliptic normalized row image, and put ℓ=degM. Let A_R be the translation subgroup of R acting faithfully on D; translations preserving M lie in D[ℓ]. Its linear quotient is cyclic of order a∈{1,2,3,4,6}.

The FIVE-primary subgroup of A_R is trivial. To see this, lift the coefficient representation to the determinant-one central extension by μ₄. The inverse image of the normal FIVE-subgroup of A_R splits uniquely as its product with μ₄: central cohomology and homomorphisms from a FIVE-group to μ₄ vanish. Its unique FIVE-complement is normal in the whole lift. In characteristic FIVE a finite FIVE-group has a nonzero fixed vector; normality and irreducibility then make it act trivially on V. Projective faithfulness forces the subgroup to be trivial. Thus A_R has order prime toFIVE.

The line M defines the finite alternating commutator pairing on A_R. Its projective irreducibles have common dimension
\[
r=\sqrt{|A_R/\operatorname{rad}|}\le4,
\]
because the actual FOUR-dimensional row subspace is an A_R-module. A maximal isotropic subgroup I containing the radical has order |A_R|/r. Its line cocycle is trivial: on a finite abelian prime-to-FIVE group, a trivial alternating commutator allows the lifts to be rescaled into a genuine linearization. Since nontrivial translations act freely, M descends to a positive-degree line on D/I. Consequently
\[
|A_R|/r\le\ell.
\]
This uses the actual image line and free translation descent; it makes no completeness assumption on its four-section subseries.

The actual quotient Y′=C/A_R→Y is connected cyclic étale of degree a, and equivariance descends φ to a separating map
\[
f:Y'\longrightarrow E'=D/A_R,\qquad
\deg f=e=\frac{3|R|}{4\ell}=\frac{3a|A_R|}{4\ell}\le\frac{3ar}{4}\le3a.
\]
The action of the cyclic deck group on E′ has faithful linear order a, as can also be seen on invariant differentials through the étale isogeny D→E′. For a>ONE it has a fixed point after translating the elliptic origin. A fiber over a fixed point is a union of free deck orbits on Y′, with constant local multiplicity on each orbit, so a divides e. Thus e∈{a,2a,3a}.

Moreover the actual connected isogeny pullback is C=Y′×_{E′}D. Indeed C→Y′ is the A_R-torsor, D→E′ is the translation A_R-torsor, and equivariance gives a map between these torsors. It is an isomorphism; equivalently the action on the D field is faithful and the compositum Y′·D is C.

If a=ONE, f is a separating elliptic map of degree at mostTHREE from Y. This is excluded for MAIN by the accepted [degree-at-mostSIX elliptic-map theorem](../quotient_geometry/main_small_elliptic_map_exclusion.md), and for BACKUP by its accepted geometrically simple genus-two Jacobian.

If a=TWO, Y′ is the hyperelliptic genus-three étale double of Y. Write σ for its free deck involution, ι for its hyperelliptic involution, and τ=ισ. The involution τ has fixed points and elliptic quotient E₀. Equivariance gives fσ=−f+constant, while every elliptic morphism from a hyperelliptic curve satisfies fι=−f+constant. Thus fτ=f+constant; evaluating at a fixed point of τ makes that constant zero. Hence f factors through the degreeTWO map Y′→E₀ followed by a separating elliptic isogeny E₀→E′. This is the same intrinsic genus-three argument in the [elliptic carrier proof](actual_elliptic_spin_isogeny_carrier.md), and does not use an X-map on Y′.

Take the connected component E₁ of E₀×_{E′}D relevant to C. It is elliptic and étale over E₀ and D. The ramified quadratic extension Y′/E₀ is linearly disjoint from the étale isogeny E₁/E₀, so C→E₁ is still a degreeTWO ramified cover. Thus every local index of φ:C→D is ONE orTWO, and its ramification is tame.

Let w_z be the third Wronskian weight of the elliptic row subseries at z∈D. Its generic order sequence is(0,1,2,3), because its pullback Wronskian is nonzero. Its total Wronskian degree is4ℓ=3N/e. At an unramified sheet over z, the actual Wronskian divisibility gives w_z=ZERO moduloFIVE. At a ramified sheet of indexTWO, the chain rule gives 2w_z+SIX=ZERO moduloFIVE, or w_z=TWO moduloFIVE. Thus a target fiber cannot mix ramified and unramified sheets. Every ramified target fiber has e/TWO points, different degree e/TWO, and w_z≥TWO. The total different is2N, so the number of ramified target values is4N/e. Therefore
\[
4\ell=3N/e\ge2\cdot4N/e=8N/e,
\]
impossible. This deletes the orderTWO carrier for an arbitrary elliptic row subseries, not just for a complete quartic.

If a=THREE orSIX, E′ has j=ZERO and its invariant differential is nonzero Cartier-zero in characteristic FIVE. Both selected endpoints have accepted ordinary maximal exponentSIX covers, so their connected cyclic a-covers Y′ are ordinary. The separating pullback f would give a nonzero Cartier-zero regular differential on Y′, impossible. Use [MAIN exponent-six ordinarity](../../Theorems/jacobians/ordinary_covers/main_exponent_six_ordinarity.md) and its accepted BACKUP input; there is no new calculation.

If a=FOUR, f has degree at mostTWELVE and is equivariant for an elliptic automorphism of linear orderFOUR. The standalone cyclic-cover scope of the [MAIN order-four theorem](main_order_four_elliptic_spin_exclusion.md) excludes every such map of degree at mostTWENTY FOUR. For BACKUP, the reflection construction of that proof produces an actual elliptic reflection quotient of Y′ separating-isogenous to j=1728; this contradicts the [complete BACKUP reflection theorem](backup_order_four_elliptic_spin_exclusion.md). All cases are therefore excluded.

This whole elliptic-row exclusion has not converted the row image into an X endpoint. The actual original maps remain upstairs on T. Together with the rational-image argument, it proves genusD≥TWO for ANY finite entire coefficient image in the stated positive branch.

## Every remaining row-normalization map is étale

At a point t∈C write j=e_t(φ), δ=δ_t(φ), and w for the third row Wronskian weight at φ(t). The chain rule is
\[
5a_t=jw+6\delta,
\qquad a_t=\operatorname{length}(B_C/q_C^*J_Y)_t\in\{0,1,2,3\}.
\]
In particular δ≤TWO. Wild ramification is impossible, since a wild index is at leastFIVE and its different is at least that index. Any ramification is therefore tame of indexTWO orTHREE.

If j=TWO, then 5a=2w+SIX, forcing a=TWO and w=TWO. The vanishing sequence of the basepoint-free row on D is necessarily(0,1,3,4). Indeed its sum minusSIX is at mostTWO, since the leading jet determinant gives this lower bound on the actual Wronskian valuation. The possibilities of smaller weight(0,1,2,3)and(0,1,2,4)have nonzero Vandermonde leading coefficients and exact weightsZERO andONE. At weightTWO the alternative(0,1,2,5)has repeated residues moduloFIVE and its leading coefficient vanishes, giving weight strictly larger thanTWO. Only(0,1,3,4)remains.

Tame pullback of indexTWO gives actual row orders(0,2,6,8). Thus the actual J fiber has rankTWO and omits the intrinsic primitive F₄, the highest third-jet line. It also contains no differential of orderONE: its least available differential order congruent toONE moduloFIVE isSIX. Every actual source sheet over this point is impossible. An ordinary finite source sheet has a rankTHREE net fiber, which cannot fit. A finite cubic branch has F₄ in its original net fiber, which cannot fit. An infinity sheet has an original net differential of orderONE, which cannot fit. The complete original trace contains each original net integrally, so no indexTWO point can exist.

If j=THREE, then 5a=3w+TWELVE forces a=THREE and w=ONE. The actual free R-orbit of t contains N points, each with target Smith lengthTHREE, and thus exhausts the entire defect divisor of degree3N. Its ramification already contributes different2N. Hurwitz for φ gives
\[
2N=e(2g(D)-2)+\deg\operatorname{Diff}_\phi,
\]
forcing g(D)≤ONE. This contradicts the rational and elliptic exclusions above. Hence indexTHREE is also impossible.

There is no remaining ramification. The actual C→D and the composite T→C→D are finite étale. Neither original endpoint map has been replaced, and no downward X- or Y-map on D has been supplied.

## The actual scalar connection descends, not just its fifth-power line

Put N_D=ω_D⊗M⁻¹. Since φ is étale, the row-line identification A=φ*M gives an identification of underlying lines
\[
F_C^*P=\omega_C\otimes A^{-1}=\phi^*N_D.
\]
This by itself would not identify a Frobenius antecedent. We now descend the ACTUAL canonical Cartier connection on F_C*P.

Choose a separating rational parameter x in k(D), write ∂=d/dx, and choose a rational frame n of N_D. In this frame the four evaluation-row differentials are f_i dx/n, with f_i∈k(D). Their zero-through-third Wronskian is invertible at the generic point. Write a rational horizontal frame of F_C*P as w·φ*n, with w∈k(C)*. Since each constant coefficient vector is a rational section of the actual B_C embedding, its differential evaluation w f_i dx is locally exact. In characteristic FIVE this is equivalent to
\[
\partial^4(wf_i)=0\qquad(i=1,2,3,4).
\]
Indeed k(C)=k(C)^5(x), and ∂⁴ kills precisely the coefficient functions with no x⁴ component over k(C)^5, which are exactly the coefficients of locally exact differentials.

Expanding the four equations gives
\[
f_i\partial^4w+4(\partial f_i)\partial^3w+6(\partial^2f_i)\partial^2w
+4(\partial^3f_i)\partial w=-(\partial^4f_i)w.
\]
The coefficient matrix is the invertible zero-through-third Wronskian, multiplied by the nonzero constants1,4,6,4. Dividing by w therefore solves all four logarithmic derivative ratios in k(D), in particular (∂w)/w∈k(D). Thus the connection form −dlogw on the frame φ*n descends to a rational connection on N_D.

It is regular and has zero p-curvature: these properties hold for its actual pullback canonical connection, and are detected faithfully after the finite étale map φ. Cartier descent now supplies a UNIQUE line Q_D on D^(1), with its identified Frobenius pullback connection, and gives
\[
\phi^{(1)*}Q_D=P
\]
as the ACTUAL Cartier descent of the identified connections. A fifth-torsion ambiguity in a chosen abstract root has not been ignored.

The row evaluation map F_D*Q_D⊗V^[5]→ω_D adjoints to a map Q_D⊗V→F_{D*}ω_D. Its Cartier image is zero: its actual étale pullback is the original embedded P⊗V→B_C, and rational differential pullback is injective and commutes with Cartier. Hence it lands in B_D. Faithful flatness shows that it is injective of full rank and that its actual embedded pullback is q_C*J_Y. Define this embedded image as J_D. Its local Smith divisor D_D pulls to D_C.

The construction is R-equivariant. The descended connection is the unique one detected by its four row equations, and the actual embedding is the unique one whose étale pullback equals the retained embedding. Therefore both respect the actual coefficient action and the original R-linearization on J_C, without requiring a genuine R-linearization on Q_D separately.

## The actual quotient-stack atlas and genus bound

Equivariance of the finite étale φ gives
\[
Y=[C/R]\longrightarrow[D/R],
\]
a representable finite étale map of degree e. Base changing by the actual atlas D→[D/R] recovers C→D. This is actual quotient-stack descent from the same source, not a presumed simultaneous closure or an X-map on D.

Hurwitz and line degrees give
\[
e(g(D)-1)=N,\qquad
\deg M=\frac{3(g(D)-1)}4,\qquad
\deg Q_D=\frac{g(D)-1}4.
\]
Thus g(D)−ONE is divisible byFOUR. The only candidates belowSEVENTEEN are g(D)=FIVE,NINE,THIRTEEN, with row degreesTHREE,SIX,NINE respectively.

For clarity this small-degree exclusion uses the characteristic-free plane-section mechanism already accepted in the [smooth-row proof](abelian_humbert_row_smooth_embedding.md), not a characteristic-zero uniform-position assumption. A nondegenerate integral space curve has a noncollinear generic plane section: its potential linear equation would lift, since H¹(I_curve)=ZERO for a connected integral projective curve. Bonacini's decreasing-type result in arbitrary characteristic bounds its arithmetic genus by the largest decreasing-type plane h-vector of its degree. For degreesTHREE,SIX,NINE the maxima are respectivelyZERO,FOUR,TWELVE, realized by h-vectors(1,2),(1,2,2,1),(1,2,2,2,2). The genus of its normalization is no greater. Each is smaller than the corresponding candidate genusFIVE,NINE,THIRTEEN. Hence g(D)≥SEVENTEEN and degM≥TWELVE.

## Two representation constraints

If a nonzero bilinear form B on V is preserved up to scalar, its radical is invariant and irreducibility makes it nondegenerate. With coefficient lifts M_g of cocycle α, write M_gᵗBM_g=c_gB. Applying this to products gives α(g,h)²=c_gc_h/c_gh. Hence 2[α]=0, impossible. This includes both symmetric and alternating forms.

If V is a projective tensor product of two two-dimensional modules, their cocycles β₁,β₂ each satisfy 2[β_i]=0 by determinants. The tensor-product cocycle is β₁+β₂ and also has order at mostTWO. Again it cannot equal the actual orderFOUR multiplier. These constraints do not rule out general nonabelian primitive groups.
