# Proof: exact stabilizer degree and the two exceptional four-value maps

Version1,3 October2026. Root focused review **PASS**; see [audit](../../Research/audits/TAME_ETALE_POSITIVE_FULL_REDUCTION_AUDIT_2026_10_03.md).

## The actual degree and signature identities

The inherited faithful target gives an actual coarse separating map Y→B of degree e. Every target stabilizer acts freely on the complete étale φ-fiber. Consequently each inertia order m_i divides e, and the coarse Y→B fibers have exactly e/m_i points, each of ramification index m_i. The actual completed local cover is uniform. Tameness is inherited by that map.

The accepted genuine determinant-character argument gives B=P¹ if e>ONE. Its TWO-primary character image has order e₂. Thus e>ONE is even; if e were odd the accepted odd-uniform endpoint theorem would force e=ONE. The genuinely descended determinant line M₁⁸ and Hilbert90 orbit degrees give
\[
\operatorname{lcm}(m_1,\ldots,m_r)=e.
\]
Tame Hurwitz, using g(Y)=TWO, now reads
\[
\sum_i(1-1/m_i)-2=2/e.
\tag{1}
\]
All m_i≥TWO are prime to FIVE. The e=ONE case has B=Y because k(T)=k(Y)k(Z) and T=Z then identify their faithful G-quotients.

## Complete elementary signature enumeration

If r≥SEVEN, the left side of (1) is at least3/2, incompatible with even e≥TWO. For r=SIX, (1) forces e=TWO and all m_i=TWO. For r=FIVE it forces e≤FOUR. The cases e=TWO orFOUR have orders TWO orFOUR; equality would require all FIVE orders TWO and e=FOUR, contradicting their lcm. Thus r is THREE,FOUR orSIX.

For FOUR cones, arrange m_1≤m_2≤b≤c. If m_1≥THREE then e≤THREE, impossible for even e and m_i|e. If m_1=TWO and m_2≥THREE, the bound e≤FOUR and divisibility leave no solution. Thus m_1=m_2=TWO. For b=TWO, equation (1) and the lcm identity give c−TWO=TWO gcd(TWO,c), whose only consistent c≥TWO is SIX, giving (2,2,2,6),e=SIX. For b=THREE they give TWO c−THREE=gcd(SIX,c), whose only consistent c≥THREE is THREE, giving (2,2,3,3),e=SIX. For b≥FOUR, e≤FOUR, so b=c=FOUR, giving (2,2,4,4),e=FOUR.

For THREE cones arrange a≤b≤c. If a≥FIVE, (1) forces e≤FIVE, incompatible with even e and prime-to-FIVE inertia. For a=FOUR,b=FOUR, combining (1) with the lcm gives c−TWO=gcd(FOUR,c); no consistent c≥FOUR exists. For a=FOUR,b≥FIVE the area bound and divisibility exclude the row.

For a=THREE,b=THREE, the corresponding equation is c−THREE=TWO gcd(THREE,c). Its solutions are c=FIVE andNINE, discarded respectively by tameness and even e. For a=THREE,b=FOUR it is FIVE c−TWELVE=TWO gcd(TWELVE,c), giving only c=FOUR,e=TWELVE. For a=THREE,b≥FIVE the area bound gives e≤SEVEN; prime-to-FIVE divisibility and evenness leave only b=c=SIX,e=SIX.

For a=TWO,b=THREE, the equation is c−SIX=TWO gcd(SIX,c), giving c=TEN orEIGHTEEN. TEN is wild in characteristic FIVE; EIGHTEEN gives e=EIGHTEEN. For a=TWO,b=FOUR it is c−FOUR=TWO gcd(FOUR,c), giving only c=TWELVE,e=TWELVE. The b=FIVE row is wild. For b=SIX the equation c−THREE=gcd(SIX,c) has no consistent c≥SIX. For b≥SEVEN, the area bound gives e≤EIGHT; divisibility leaves b=c=EIGHT,e=EIGHT. This proves exactly the displayed table.

## The degree-FOUR row contradicts the actual endpoint automorphism group

Suppose an actual genus-two endpoint map Y→P¹ has degree FOUR and signature (2,2,4,4). Its actual normal closure has transitive monodromy A⊂S₄. TWO inertia consists of double transpositions, and FOUR inertia of FOUR-cycles. The double transpositions lie in the normal Klein FOUR subgroup V⊂S₄. The quotient cover associated to A/(A∩V) is tame with only TWO possible branch values, both of order TWO. A connected tame cover of P¹ with at most TWO branch values is cyclic with equal inertia generators. Thus A/(A∩V) has order at mostTWO and A lies in a dihedral D₈. Transitivity and a FOUR-cycle force A=C₄ orD₈.

The C₄ case supplies an actual order-FOUR endpoint automorphism, contrary to the accepted Aut(Y)=C₂. In the D₈ case the source stabilizer is a reflection of order TWO. The central square of a FOUR-cycle induces an actual endpoint deck involution j. Each of the TWO total-FOUR-ramification fibers contributes ONE fixed point of j. A TWO-inertia value contributes TWO further fixed points exactly when its inertia is the central involution. Thus j has TWO,FOUR orSIX fixed points. Hurwitz for an involution of a genus-two curve excludes FOUR. SIX would mean BOTH TWO-inertia groups were central; their generators together with the two FOUR-cycle generators then lie in a single cyclic FOUR group, contradicting A=D₈. Hence j has TWO fixed points and its quotient is elliptic. It is not the hyperelliptic involution, contradicting the selected endpoint Aut(Y)=C₂. The row is impossible on BOTH endpoints.

## The degree-SIX (2,2,2,6) row contradicts the accepted elliptic-map bound

Take the actual degree-SIX endpoint map β:Y→P¹ with this signature. In its permutation monodromy each TWO inertia is (2,2,2) and the SIX inertia is a SIX-cycle. All have odd sign. The sign double cover E→P¹ is therefore branched at all FOUR values and is a smooth elliptic curve. Normalize the ACTUAL fiber product Y′=Y×P¹E. It is an étale double cover of Y, since every β ramification index at these four values is even. It is connected: if it split, E would embed in k(Y), giving an elliptic map Y→E of degree THREE, already excluded on BOTH endpoints.

Thus Y′ has genus THREE. The other actual fiber-product projection f:Y′→E is separating of degree SIX. Its only ramification is TWO points of index THREE over the original SIX-inertia value. The THREE TWO-inertia values become unramified.

Let σ be the free deck involution of Y′/Y. The accepted elementary genus-three geometry of an étale double of a genus-two hyperelliptic curve gives its hyperelliptic involution ι, commuting with σ, and τ=ισ with FOUR fixed points and elliptic degree-TWO quotient p:Y′→E₀. This is the same explicit double-cover geometry used in the [actual elliptic isogeny carrier proof](actual_elliptic_spin_isogeny_carrier.md): a nontrivial genus-two TWO-torsion class is a pair of Weierstrass points.

The elliptic-valued map f+fσ is σ-invariant, so descends to a map Y→E. The elliptic parallelogram degree identity gives
\[
\deg(f+f\sigma)+\deg(f-f\sigma)=4\deg f=24.
\]
If the descended map were nonconstant, its degree would be at most TWELVE, excluded by MAIN's accepted degree-SIXTEEN bound and BACKUP's geometric Jacobian simplicity. Consequently fσ=−f+constant. Hyperellipticity also gives fι=−f+constant. Hence fτ=f+constant; evaluating at a fixed point of τ makes the constant ZERO. Therefore f factors through p and a separating elliptic degree-THREE isogeny E₀→E. That isogeny is étale, so f has only index-TWO ramification. This contradicts its actual index-THREE points. No simplicity of the MAIN Jacobian or X-map on Y′ is assumed.

## Selected endpoint coverage

Each triangular row of the table gives an actual tame separating endpoint map of degree at mostEIGHTEEN with only THREE branch values. The accepted MAIN bounded three-branch exclusion deletes them. The two preceding arguments delete the indicated FOUR-value rows.

The remaining FOUR-value profile (2,2,3,3),degreeSIX is excluded by the accepted [quadrangular genus-two theorem](../../Theorems/quotient_geometry/tame_covers/quadrangular_genus_two_hecke_obstruction.md), whose FIRST assertion is universal for characteristic different fromTWO,THREE and Aut(Y)=C₂. It is not limited to BACKUP and does not import MAIN Jacobian simplicity. Its complete actual tame monodromy list consists of regular C₆, regular S₃, and the degree-SIX coset action S₄/C₄. The first two contradict the endpoint automorphism group. In the last, the normalizer D₈ of C₄ gives an actual degree-TWO endpoint map to a genus-ONE curve, again contradicting Aut(Y)=C₂. These established monodromy and geometric assertions retain their existing verification; no census is replayed.

Therefore MAIN leaves only six TWO cones with e=TWO. The complete BACKUP tame uniform-atlas theorem independently gives the same conclusion. Identity e=ONE remains in both cases.

No surviving signature has been excluded by arbitrary target ordinarity or a presumed second-leg descent. The original T and its actual two étale maps remain; the residual cases still require their own argument.
