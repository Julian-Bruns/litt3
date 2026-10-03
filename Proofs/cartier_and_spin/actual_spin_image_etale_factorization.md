# Proof: exact spin ramification and actual theta descent

Version2,2 October2026. The original contact-eight whole implication passed [independent review](../../Research/audits/CONTACT_EIGHT_SPIN_ETALE_EXTRACTION_AUDIT_2026_10_02.md); general hypothesis separation, quotient-stack clause and critical-divisor table passed [focused extension review](../../Research/audits/ACTUAL_SPIN_EXTRACTION_EXTENSIONS_REVIEW_2026_10_02.md). [Statement](../../Theorems/cartier_and_spin/actual_spin_image_etale_factorization.md). Preserve both actual finite étale maps throughout. The torsion discrepancy and field descent apply to ANY actual spin image map that is finite étale. The first section proves that hypothesis when D=2Q, using the exact raw first-jet divisor and the [elliptic spin-image exclusion](contact_eight_spin_image_not_elliptic.md).

## The image normalization map is itself étale

The chain-rule calculation gives R_W=R_φ+φ*R_Γ=2q*Q, whereφ is separating and R_Γ is the effective common critical divisor of its normalized image series. At everyz aboveQ,
\[
r_\varphi(z)+e_\varphi(z)r_\Gamma(\varphi z)=2.
\]
For a separating curve map, a tame local indexe has different exponente−1; a wild index divisible byfive has different at leastfive. The only integral possibilities in the displayed equation are e=1,r_φ=0,r_Γ=2, or e=3,r_φ=2,r_Γ=0. The casee=2would require1+2r_Γ=2, impossible. All larger indices exceedthe allowed different.

The actual deck action onT is transitive onq^-1(Q), andφ is equivariant for its projective action onΓ. Hence the same possibility occurs at EVERY point aboveQ. Away fromqQ both effective terms in the chain rule vanish. If the index-three possibility occurred, R_Γ would vanish everywhere; the degree identity degR_Γ=2g(Γ)−2would then makeΓ elliptic, already excluded. Thereforeφ is unramified everywhere and is finite étale.

It follows that R_Γ=2D_Γ with D_Γ reduced and φ*D_Γ=q*Q exactly. Thus degD_Γ=8d/κ=8δ, and degR_Γ=2g(Γ)−2givesg(Γ)=8δ+1.

## The torsion canonical discrepancy has an actual trivializer

For the GENERAL assertion now assumeφ finite étale, without using the contact hypothesis. Hurwitz givesg(Γ)−1=(g(T)−1)/κ=8d/κ=8δ. Let N=M¹⁶⊗ωΓ^-1. Its degree is16δ−(2g(Γ)−2)=0. The actual étale canonical identity andL=φ*M giveφ*N=O_T.

A degree-zero line trivialized by a finite étale cover has finite prime-to-five order: pass only for this assertion to an actual étale Galois closure ofφ, where its trivial line carries a finite character in k*, whose order is prime to the characteristic. Write b=ordN. Its canonical connected cyclic b-root trivializer π:Γ′→Γ is an actual finite étale cover. The selected trivializationφ*N onT can be rescaled to respect Nᵇ=O, because its bth power is a global nonzero constant. Henceφ factors throughπ. The remaining mapφ′:T→Γ′ is finite étale, as the intermediate map in an actual étale tower. This construction does not presume a simultaneous closure overX andY.

OnΓ′, M′=π*M satisfies M′¹⁶≅ωΓ′. Everyu_i descends first to a section ofM onΓ, then toM′ onΓ′. Comparing its descended sixteenth power with the originalθ_i onT gives one COMMON nonzero scalar: the two isomorphismsL¹⁶→ωT differ by a global constant. Thus all actualθ_i descend as regular rational differentials onΓ′.

## Actual X fields are recovered from those descended forms

The accepted [differential field reconstruction](../../../Theorems/shared_tensors/differential_ratio_joint_field.md) recovers the fixed X field from a descended theta form in every separating intermediate field. Explicitly C(θ)/θ and d(C(θ)/θ)/θ have function degrees13and30 onX, so their common field has index dividing both and is the whole k(X). Cartier commutes with the actual separating field inclusions. Therefore everyh_i*k(X) is contained in k(Γ′).

Eachh_i factors through a finite separating map H_i:Γ′→X. Since its composition with the actual étaleφ′ is the original étaleh_i, local ramification multiplicativity, or the different tower formula, makesH_i finite étale. Its degree is (g(Γ′)−1)/8=bδ. Both this descent and the degree refer to the original embedded source fields.

## Theta recognition reduces the trivializer degree to at most three

The deckμ_b ofΓ′→Γ fixes the sections descended fromM. Its tautological trivialization ofN gives a FAITHFUL scalar character on each descendedθ_i; its order isb. For anydeckσ, the two maps H_i∘σ andH_i are actual finite étale maps from the SAMEΓ′ toX, with proportional pulled theta forms. The accepted [theta recognition](../../../Theorems/cartier_and_spin/new_line_comparison_normal_form.md) gives H_iσ=γH_i forγ∈Aut(X)=C₃. Its theta character is faithful: y↦ζy scalesdx/y²byζ. Thus the faithfulμ_b character takes values inμ₃, forcingb|3.

Ifb=1, Γ′=Γ andH_i is an actual étale mapΓ→X of degreeδ. Ifb=3, the deckμ₃ acts onX through the faithful cubic automorphism group andH_i is equivariant. Quotient descent producesΓ→[X/C₃]. Its base change alongX→[X/C₃] is exactlyΓ′→X, finite étale of degree3δ, so the descended map is an actual representable finite étale atlas of that degree.

## The actual orbifold atlas on the Y side

The mapφ:T→Γ is G-equivariant, withG acting freely onT becauseq is the actual G-torsor. The quotient stack ofT isY. Passing to quotient stacks therefore givesY=[T/G]→[Γ/G]. Base change along the atlasΓ→[Γ/G] gives precisely the ACTUAL mapφ:T→Γ, finite étale of degreeκ. This proves representability, finiteness and étaleness of the atlasY→[Γ/G], even ifG has a nontrivial generic action kernelK onΓ.

For the effective actionH=G/K, the actual intermediate curveT/K is finite étale overY, withH-torsor structure. BecauseK acts trivially onΓ and freely onT, the mapT/K→Γ is finite étale of degreeκ/|K|. Passing to the quotient givesY→[Γ/H] of this degree. Thus the atlas diagram is actual; no presumed simultaneous Galois closure is involved.

This proves the claimed extraction. The genus-two field need not be contained inΓ′; all original maps still coexist onT, but no new Γ′→Y map or bounded original common-cover witness is asserted. In particular the two actual orbifold atlas maps out ofΓ do not by themselves makeX andY atlases of one common orbifold.

## General critical-divisor table and its actual limits

For EVERY actual spin refinement, the accepted raw first-jet theorem gives R_W=q*D with D effective of degree at mosttwo. The normalization mapφ is separating. At a point of a q-fiber with D coefficienta≤2, its chain-rule equation is r_φ+e_φ r_Γ=a. Wild ramification has different at leastfive and is impossible here. At coefficientone the only possibilities are e=1,r_Γ=1,r_φ=0 or e=2,r_Γ=0,r_φ=1. At coefficienttwo they are e=1,r_Γ=2,r_φ=0 or e=3,r_Γ=0,r_φ=2. Actual deck transitivity makes one choice uniform on each full q-fiber. Away from those fibers all ramification and critical contributions vanish.

If D=0, φ is immediately étale. If D=2Q, the index-three possibility gives R_Γ=0 and ellipticΓ; the generalized elliptic exclusion uses only this double-point antecedent. Thusφ is étale here too.

For one or two SIMPLE supports, let j be the number at which indextwo occurs. Then R_φ is the sum of thosej reduced q-fibers and has degree8dj. Hurwitz gives
\[
16d=\kappa(2g(\Gamma)-2)+8dj,
\qquad g(\Gamma)-1=(8-4j)\delta.
\]
This proves every row in the statement table. In the both-ramified two-support case, Γ is elliptic andφ has tame indextwo exactly at those two actual fibers. Its pulled invariant elliptic differential has divisorq*(P+Q), so the singleton root theorem does not apply; this case remains open.

For an unramified simple support, r_Γ is positive at its image. Every preimage of such an image point must therefore be critical forW and lie in the SAME actual q-fiber, yielding a full reduced preimage. For a ramification-only image point, r_Γ=0, and the chain rule permits other unramified preimages outside the designated q-fiber. No uniform ramification over the whole target-image fiber is proved in that case. Therefore one cannot replaceφ by an étale orbifold atlas merely by placing index-two structure at those image points.
