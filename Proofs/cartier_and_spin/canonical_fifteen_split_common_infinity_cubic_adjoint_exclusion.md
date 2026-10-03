# Proof: a residual section cannot supply the actual common-branch conductor

Version1, 3 October2026. Frozen pending a fresh independent whole audit. No computation or numerical certificate replay is used.

## 1. Actual geometry, adjoint factors and the genus ledger

Retain BOTH actual finite étale maps, actual yᵢ³=P(xᵢ) and all split field/canonical identities. By étale Hurwitz g(C₀)=121. Use the actual conic image C with normalization C₀ and u=x₂+1,v=t³(x₁+1), as in [the conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md). Let J=J₊+J₋, c±=degJ±. Then
\[
CF=n=15-c,\quad CD_\pm=3c_\pm,\quad CL=45,
\quad K_SC=-30-c,\qquad c=c_++c_-.
\]
The surface has disjoint sections D±²=−3, K_S=−D−2F, D=D₊+D₋ and L=D+3F. The actual common-pole tensor jets, used in [the audited degree-fourteen common proof](canonical_fourteen_split_common_infinity_cubic_adjoint_exclusion.md), give ordₚ(t−t(p))=eₚ≥3, while the boundary normal coordinate has exact order3. Thus each common branch has self-delta at least3 and δ=p_a(C)−121≥3c.

The same actual normalization-duality section σ_C of C−D−18F has pullback Δ+16J, where Δ is the conductor. The same two fixed H¹ vanishings lift σ_C and σ_Cy₂; the latter retains the conductor and6J after its10F twist. The boundary restriction argument in the degree-fourteen proof applies unchanged: an affected count cᵢ in1…5 forces6−cᵢ copies of Dᵢ, and an unaffected section forces five. Removing these factors yields the effective actual residual divisor R with
\[
\begin{array}{c|c|c|c}
&RF&RD_\pm&\nu^*R\\
\text{one side, }D_+\text{ affected}&2&(3,0)&\Delta+(3c-2)J\\
\text{both sides}&1&(3,3)&\Delta+\sum_\pm(3c_\pm-2)J_\pm.
\end{array}
\]
Its actual defining section is ρ. In the one-sided case C=(7−c)D₊+6D₋+18F+R; in the both-sided case C=(7−c₊)D₊+(7−c₋)D₋+18F+R. No conductor or common-point zero is discarded.

Write B=D₋ and D₊=B+3F−ΣEᵢ in the accepted six-fiber blowup basis. In the one-sided case R=2B+6F−ΣbᵢEᵢ; in the both-sided case R=B+6F−ΣbᵢEᵢ. In both cases Σbᵢ=3. The basis generates Pic(S) integrally, so these numerical specifications are linear classes. Direct expansion and adjunction give
\[
\delta_{\rm one}=\frac{69-c-3c^2-\sum b_i^2}{2},\qquad
\delta_{\rm both}=\frac{69-c-3(c_+^2+c_-^2)-\sum b_i^2}{2}.
\]
Because bᵢ are integers of sum3, Σbᵢ²≥3. One-sided c=4 gives δ≤7<12 and c=5 gives δ<0. For both-sided c=5, the minimum squared-count sum is13 at counts2,3, giving δ≤11<15. These profiles are excluded. The remaining ones are one-sided c=1,2,3 and both-sided c=2,3,4.

## 2. Global cubic promotion in every remaining profile

The actual lift of σ_Cy₂, after its forced boundary factors, gives a with rational restriction a=ρy₂ on C. Its poles beyond R, the class of Q defining C beyond R, and the counterterm bundle are as follows, up to interchange of the two signs:

| Profile | a beyond R | Q beyond R | Counterterm bundle |
|---|---|---|---|
| One-sided c=1 |4D₊+3D₋+10F|6D₊+6D₋+18F|R−2D₋−6F|
| One-sided c=2 |4D₊+3D₋+10F|5D₊+6D₋+18F|R+2D₊−2D₋−6F|
| One-sided c=3 |3D₊+3D₋+10F|4D₊+6D₋+18F|R+2D₊−2D₋−6F|
| Both-sided c=2 |4D₊+4D₋+10F|6D₊+6D₋+18F|R−6F|
| Both-sided c=3, counts1,2 |4D₊+4D₋+10F|6D₊+5D₋+18F|R+2D₋−6F|
| Both-sided c=4, counts1,3 |4D₊+3D₋+10F|6D₊+4D₋+18F|R+2D₋−6F|
| Both-sided c=4, counts2,2 |4D₊+4D₋+10F|5D₊+5D₋+18F|R+2D−6F|

We use the exact global mechanism of the audited degree-fourteen common proof. The residue of Ω/Q, Ω=dt∧du/v, has precisely the divisor of θ₂/ρ: the boundary coefficient of Q minus one is exactly the σ factor removed. Therefore
\[
\mathcal DQ=\lambda\rho y_2^2=\lambda a^2/\rho\quad\text{on }C,
\qquad\lambda\in k^\times,
\quad\mathcal D(t)=v,\ \mathcal D(u)=0,\ \mathcal D(v)=-3dt^5.
\]
The multiplier is one global scalar on the actual smooth normalization. Frame derivatives are Q-multiples on C.

The actual cubic N=a³−P(u−1)ρ³ vanishes on the integral Cartier C; its global quotient W=N/Q is regular in its quotient bundle. The canonical O(2R)-valued form ρ da−a dρ cancels all R-frame derivatives. Its contraction Wr with 𝒟 raises boundary poles by at most one, because 𝒟(1/u)=0, and base poles by at most two, because s²𝒟 is regular and tangent to infinity. Differentiating the cubic on C gives W=(3/λ)Wr there. The global SECOND quotient by Q is therefore a regular section of the table's counterterm bundle.

Every such bundle has H⁰=0. For one-sided c=1 its fiber degree is0 and intersection with D₊ is−3, forcing a boundary component and negative residual fiber degree. For one-sided c=2,3 its fiber degree is2 and D₊ intersection−9, forcing at least3D₊. For both-sided c=2 its fiber degree is1 and both boundary intersections are−3, forcing at least two horizontal components. For both-sided c=3 or counts1,3 its fiber degree is3 and the D₋ intersection is−9; removing3D₋ leaves fiber degree0 but the other boundary intersection remains−3. For counts2,2 its fiber degree is5 and each boundary intersection−9 forces at least three copies, totaling six. The nef fiber class excludes effectivity in every case.

Consequently the WHOLE surface identity holds:
\[
a^3-P(u-1)\rho^3=\gamma Q(\rho\mathcal Da-a\mathcal D\rho),
\qquad\gamma=3/\lambda\ne0.
\]
No new cohomology vanishing or insufficient generic-fiber interpolation is used.

## 3. Every remaining residual contains the infinity fiber

Use s=t⁻¹,U=s³u,V=s³v. As in the audited degree-fourteen proof, the relative10F weight has zero derivative in characteristic5, and the regular scaled identity specializes to
\[
a_\infty^3-U^{10}\rho_\infty^3
=\gamma Q_\infty(\rho_\infty\delta a_\infty-a_\infty\delta\rho_\infty),
\qquad\delta=-3(UV\partial_U+U^2\partial_V).
\]
The two auxiliary P± with U=0 have Q∞ a unit, because every actual noncommon H₂-point has x₂ pole3 and t pole1. The actual C avoids P±. If ρ∞ is a unit at one P, the all-order local equation h³−U¹⁰=unit·δh, δ=U·unit·∂_U, is impossible as proved in the accepted degree-fourteen common argument.

Suppose F∞ is absent. In the both-sided case RF=1, the nonzero restriction of ρ cannot vanish at both P±, contradiction. In the one-sided case RF=2 it must vanish precisely and simply at P₊+P₋. Choose the balanced R frame, so ρ∞=αU. The identity forces a∞ to vanish at each P as well, because δρ∞ vanishes there; hence h=a∞/ρ∞ is regular on the affine conic. The pulled R has no actual infinity zero, so Δ is absent there: all n infinity images are smooth and DISTINCT.

With z=U+V the identity becomes
\[
h^3-U^{10}=\gamma' q(z)z h'(z),\qquad\gamma'\ne0.
\]
The poles of q are exactly(8−c,7) at the two boundary points. The bounds for h are(4,3) for c=1,2 and(3,3) for c=3. At the affected boundary, c=1 with h pole4 would give left pole12 versus right pole11, so h has poles at most3 at both ends. Here q has poles7/7 and fourteen distinct actual roots. The retained residue then gives zq′=βh² at all these roots, and the regular quotient(zq′−βh²)/q would have boundary values7 and−7, contrary to characteristic5. This is precisely the new implication independently audited in [the disjoint degree-fourteen residue proof](canonical_fourteen_split_disjoint_infinity_residue_exclusion.md), with the same balanced common frame and same actual root conditions.

For c=2 a pole4 of h gives12 versus10. If its pole is at most3 instead, the left pole is10 and the right at most9. For c=3 the left pole10 exceeds the right bound8. All are impossible. Thus F∞ occurs in every remaining R.

## 4. Residual horizontal section and actual infinity contacts

In the one-sided case RD₋=0 forces D₋ into R once F∞ occurs. Its horizontal degree2 then gives
\[
R=D_-+H+V,
\]
where H is a horizontal degree-one section and V is vertical. H may be D₋ again or D₊. In the both-sided case RF=1 gives R=H+V. The infinity multiplicity k is at most3. If H is not a boundary section this follows from VDaffected=3−HDaffected≤3; if it is a boundary section, use the OTHER boundary, whose vertical intersection is3. The same argument works in both-sided and one-sided cases.

Every actual infinity branch is smooth over s and avoids D. Away from the one point H∞ its exact conductor order is k; at H∞ it is k+hᵢ, where hᵢ is its contact with H. The actual infinity jet lemma from the audited degree-fourteen normal form applies unchanged: distinct projected branch contacts are1 or≥5, and there are at most three tangent directions. It uses BOTH actual endpoint cubics and θ₁, and only formal recursion through the fourth jet.

For a finite H∞ cluster of b branches, put m=minhᵢ. As smooth graphs over s, contacts satisfy Iᵢⱼ≥min(hᵢ,hⱼ). On a branch with hᵢ=m, the exact conductor is k+m, so
\[
(b-2)m\le k.
\]
If k=3, there can be no cluster away from H∞: conductor3 is impossible by the actual contact/tangent lemma. Thus all n≥11 branches would lie at H∞, contradicting(b−2)m≤3. If H∞ is a boundary point no actual branch meets H, and the same conductor3 impossibility is immediate. Hence k=3 never occurs.

## 5. Two local conductor-capacity lemmas

We record the local estimates needed below. At an actual common point the surface coordinate orders are ordh=3, ordτ=e≥3. Its self-conductor is at least2e−2. To see this, write e=3q+r. The q successive multiplicity-three centers contribute3q to self-delta. For r=0 this is e; for r=1 it is e−1; for r=2 the remaining coordinate orders3 and2 force one additional multiplicity-two center, contributing one and giving e−1. Total conductor adds nonnegative intersections with other branches. In particular
\[
\Delta_p\ge2e-2>e-1.
\]

Consider an effective local residual divisor Z with no component equal to this boundary. Its components near the point are vertical components and at most one coefficient-one horizontal SECTION H. Suppose its local boundary-intersection capacity is at most one. If a vertical component passes through the point it has coefficient one, H does not pass there, and ordν*Z=e. If H passes, it meets the boundary with intersection one and no vertical component passes. Let j=ordν*H. Locally H is h=f(τ), with ordτf=1. If e>3 then j=3 and Δ≥6. If e=3, the regular coordinates(τ,h−f(τ)) have orders3,j≥3, so the same estimate gives Δ≥2j−2>j−1. Thus in either allocation an equality
\[
\nu^*Z=\Delta+aJ\quad\text{at this branch},\qquad a\ge1,
\]
is impossible. If no component passes, its positive right side is already impossible. This is the CAPACITY-ONE lemma; it permits a complete smooth vertical fiber and a moving horizontal section.

If the capacity is at most two and a≥4, a vertical component without H has coefficient at most2, giving Δ≤2e−4<2e−2. If H passes with boundary intersection two, no vertical capacity remains, j=3 because e≥3, and Δ=j−a<0. If H passes with boundary intersection one, the vertical coefficient is at most1 and Δ≤e+j−4. For e>3, j=3 makes this at most e−1; for e=3 it is at most j−1, below2j−2. These contradictions give the CAPACITY-TWO lemma. The local H multiplicity is one because its global fiber degree is one. Both lemmas remain valid with multiple actual branches at the image.

## 6. Both-sided c=4 is wholly excluded

For counts1,3, Section1 gives2δ≤32. The common points already contribute at least6c=24 to total conductor, while F∞ contributes at leastkn≥11. Their supports are disjoint. Hence2δ≥35, impossible for ANY k≥1.

For counts2,2,2δ≤38. If k≥2, the common conductor24 and infinity conductor at least22 give2δ≥46. Thus only k=1 could remain. If H is a boundary section, every infinity branch has uniform conductor1, requiring ordinary pairs; n=11 is odd, impossible. If H is nonboundary, remove F∞. The remaining horizontal section H and vertical part have intersection capacity TWO with each boundary, and neither is that boundary. Every common point has extra coefficient3·2−2=4 in ν*R. The capacity-two lemma contradicts that exact pullback at any common point. Thus c=4 is entirely excluded.

This step does not assign a cubic value to a possible exceptional H∞ image. Such a value could be a 0/0 limit; the local conductor comparison avoids that mistake.

## 7. Multiplicity one at infinity is excluded in every remaining profile

The remaining profiles have n≥12. Suppose k=1. The whole regular infinity identity forces a to have at least one F∞ factor, and it has exactly one: otherwise the actual ratio a/ρ=s¹⁰y₂ would vanish on every branch away from H∞, contradicting its being a unit. There are such branches since(b−2)m≤1 allows at most three at a finite H∞. Divide the common factor; its derivatives cancel. Restriction then gives δh=0 for the leading ratio h.

If H∞ is finite, h has poles at most4 at either boundary and at most1 at H∞, and no other poles. In the one-sided case the single D₋ horizontal factor increases its allowed3 boundary pole to4; in the both-sided case the bounds were4 already. Therefore a fifth-power h is constant. At each NORMAL infinity image away from H∞ it equals the actual unit s¹⁰y₂, so h³=U¹⁰ there, permitting at most four points. The exceptional cluster has at most three branches. The remaining branches form ordinary pairs and give at least five normal image points: for n=12 or14 the exceptional size, if present, is even and at most2; for n=13 it is odd and at most3. This contradiction uses no value claim at the exceptional H point itself.

If H∞ is a boundary point, every actual branch is normal and the infinity points form ordinary pairs. h is a fifth power with a possible fifth-order pole at only ONE boundary and pole order at most4 at the other. Its fifth root is A+Bz or A+B/z, including the constant alternative. Taking fifth roots of h³=U¹⁰ gives(A+Bz)³=U², up to reversing z. After clearing z² the nonzero polynomial has degree at most5. Thus at most five actual image points are possible. If n is odd pair partition is impossible; if n is even n≥12 requires at least six node images. Again contradiction. Hence k=1 is excluded.

## 8. Multiplicity two and the final common-branch contradiction

Only k=2 remains. For one-sided c=3, Section1 gives2δ≤36. Its common conductor is at least18 and infinity conductor at least2n=24, already totaling42. This closes c=3.

The remaining profiles are one-sided c=1,2 and both-sided c=2,3. If H is nonboundary, remove2F∞. In the one-sided case the affected boundary is disjoint from the forced D₋, and the remaining H plus vertical part has boundary-intersection capacity ONE there. In the both-sided case it has capacity one at each affected boundary. All extra pullback coefficients3cᵢ−2 are positive. Applying the capacity-one lemma at any common point contradicts the EXACT normalization pullback of R.

If H is a boundary section, it meets no actual infinity image. All n branches have conductor2 and must form ordinary triples. This is impossible for one-sided c=1,n=14, one-sided c=2,n=13 and both-sided c=2,n=13. In both-sided c=3,n=12, choose the OTHER affected boundary, disjoint from H. Its remaining vertical divisor has capacity one after removal of2F∞, and its common-point extra coefficient is1 or4. The capacity-one lemma again gives the contradiction.

Every retained1≤c≤5 profile has now been covered. Both actual étale maps, actual yᵢ and the θ identity stay on their original C₀; any original endpoint maps stay on the SAME original T. The proof uses the actual source conductor and exact residue, not a source-free conic or Laurent model. The c=0 degree-fifteen sector, higher degrees, nonsplit comparisons and the original unmarked common-cover problem are not decided here.

The [self-contained companion note](../../Research/notes/oct03_ten_hour/split_fifteen_common_infinity_companion.md) records the general-degree class ledger and this new argument. The exact canonical pair passed the [independent whole audit](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_COMMON_INFINITY_CUBIC_ADJOINT_AUDIT_2026_10_03.md) with no required corrections.
