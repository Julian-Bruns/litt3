# Proof: the summed auxiliary order closes the two-ordinary-section cubic gap

Version1, 3 October2026. [Fresh independent whole audit PASS](../../Research/notes/oct03_ten_hour/split_two_ordinary_section_cubic_gap_exclusion_audit.md), no corrections; canonical extraction fidelity pending. No computation is used. The [statement](../../Theorems/cartier_and_spin/canonical_split_two_ordinary_conductor_sections_cubic_gap_exclusion.md) retains TWO actual finite étale X maps on their SAME original smooth source, both original cubics, canonical identity and faithful joint field.

## 1. The only case to exclude has both missing factors active

Use the SAME exact effective conductor R, original sections and proper frames of the [paired cubic theorem](canonical_split_paired_cubic_adjoint_counterterms.md). If both Nᵢ divide a, the conclusion holds. If exactly one does, the accepted [single ordinary section theorem](canonical_split_single_ordinary_conductor_section_cubic_gap_exclusion.md) forces the other too: its complete common factor includes the first Nᵢ. Thus suppose neither Nᵢ divides a. Put A=N₁+N₂,H=R−A and h=a/ρ.

The original whole identity is
\[
a³-P₂ρ³=γQ(ρDa-aDρ)+Q²ε₂,
\quad P₂=P(u-1),\quad ε₂\in H⁰(C-8L),\quad γ\ne0.
\tag{1}
\]
The common H factor has cubic multiplicity3 on the left and multiplicity2 in the Wronskian; its derivative terms cancel. Since integral C and R share no component,2H divides ε₂. The residual error bundle is4L−C+2A with fiber degree12−r<0. Therefore the OWN original error is zero. No premise on the other error is used.

The exact complete-factor cancellation used in the audited one-section argument applies with A=N₁+N₂: after dividing by the common sectionσ_H², the residual Wronskian is divisible by the ENTIRE H because Q and H share no component. Hence
\[
h³-P₂=γQG,\qquad Dh=ρG,\quad G=Dh/ρ
\tag{2}
\]
has no hidden H denominator. The only extra poles of h are generic simple poles on N₁,N₂. At either generic Nᵢ, Q is a unit, P₂ is regular and h³ has exact pole3, so G has EXACT pole3 there. It is nonzero since the monic boundary pole10 of P₂ cannot be a cube.

Clearing these exact3A poles gives a nonzero effective ZERO divisor Z_G, with no artificial Nᵢ component, in
\[
4D+12F∞-R+3A,
\quad Z_GF=26-r\in\{6,7,8,9\},\quad Z_GD±=0.
\tag{3}
\]
This uses RF=r−12 and RD±=NᵢD±=0. All common-factor multiplicities have been retained.

## 2. Monicity removes boundary and vertical zero components

The original h has pole at most3 on each boundary, whereas P₂ has exact pole10. Thus h³−P₂ has a nonzero monic boundary coefficient in its pole-ten frame. Actual C avoids D, so Q's section is a unit there. As in the accepted one-section proof, the compatible G section therefore has no boundary zero component. Adding3A changes no boundary valuation since Nᵢ are boundary-disjoint.

Every other effective component has nonnegative boundary intersections. Equation(3) forces Z_G disjoint from both boundaries. Every vertical prime meets at least one of them, including components of the six reducible fibers. Consequently Z_G is entirely horizontal.

## 3. The SUM of auxiliary orders forces both infinity values to be units

Set s=t⁻¹,U=s³u,V=s³v. On the infinity conic U²−V²=d put z=U+V and δ=−3Uz∂z. At each auxiliary point P±, U is a parameter and δ=U·unit·∂U. The ACTUAL simple t poles and x₂ poles of exact order3 make C avoid these two points; Q's proper infinity coefficient q∞ is a unit. R has no F∞ component, so its restricted genuine coefficientρ∞ is nonzero, with orders m±≥1 from the all-degree quartet.

Using the SAME regular R,C frames as the one-section theorem and derivative coefficient10=0 gives EXACTLY
\[
h∞³-U^{10}=γq∞g∞,
\qquad δh∞=ρ∞g∞.
\tag{4}
\]
The rational h∞ has poles at most3 at each boundary and at most1 at each ordinary section's infinity point. Thus
\[
\deg\operatorname{poles}(δh∞)\le4+4+2+2=12.
\tag{5}
\]
If the two ordinary points coincide, their combined pole bound2 gives derivative pole at most3 rather than4, so(5) remains valid. The derivative is not zero: otherwiseρ∞≠0 makes g∞=0 and(4) would force the impossible rational identity h∞³=U¹⁰.

At an auxiliary point a positive h∞ zero of ordern1,2,3 has derivative ordern, while(4) requiresm+3n>n, a contradiction. For n≥4, the first expression in(4) has EXACT order10, so g∞ has order10 and δh∞ orderm+10. At the OTHER auxiliary point h∞ is regular, since both additional poles are ordinary. If it is a unit, g∞ is a unit and δh∞ has orderm_other. If it is another zero, its derivative order is larger; orders1,2,3 have already been excluded.

Therefore ANY positive h∞ auxiliary zero forces total derivative zero degree at least10+m₊+m₋≥13, contrary to(5). This uses the stipulated SUM condition; it does not require separate order3 at either point. Thus h∞ and g∞ are units at BOTH auxiliary points. Clearing3A does not affect their coefficients there. The genuine critical zero divisor Z_G avoids both auxiliaries.

## 4. All critical contributions are divisible by five

Let Z be an irreducible component of Z_G with multiplicityμ and f=ZF>0. Since it is horizontal, boundary-disjoint and its infinity intersections avoid U=0, the normalized restriction u=s⁻³U has exact pole degree3f and no other poles.

Differentiate(2), using DP₂=0 and Dh=ρG. At the generic point of Z,
\[
DG/G=(3/γ)ρh²/Q-DQ/Q.
\tag{6}
\]
The right side is regular. The extra h poles are only on the Nᵢ, which are not zero components. Also Q is a unit generically because Z_GF≤9<r=CF. Common regular frames alter only regular terms.

If5∤μ, the logarithmic leading pole μDz/z forces D tangency to Z. Its induced derivation is nonzero: Dt=v cannot vanish identically on an invariant horizontal curve because Dv=−3dt⁵ then gives a contradiction. Its constants on a one-variable field over perfect k are the fifth powers. Thus Du=0 makes u a fifth power on Z, forcing5|deg u=3f, hence5|f. If5|μ, its contributionμf is already divisible5. This handles ALL multiplicities, including wild multiples of five.

Every component contributes a multiple of five, so5 divides Z_GF=26−r. None of6,7,8,9 is divisible5. This contradiction excludes the case where both missing factors were active. Together with Section1 it proves ENTIREρ divisibility. Through19 that factor contradicts the accepted full-individual boundary theorem. Degree20's formal full boundary remains OPEN. The actual two-map swap supplies the precise first-leg version without replacing either endpoint map.

## 5. The unbalanced auxiliary-section corollary

Suppose r17,18,19 and R is reduced with respectively3,4,5 nonconstant auxiliary-BOTH sections and two distinct ordinary-at-BOTH-ends smooth boundary-disjoint sections, with no other part. The all-degree quartet forces R through BOTH auxiliary points at each end. The ordinary sections avoid them, so B-support covers the two points. Its TOTAL infinity order is respectively3,4,5, satisfying the sum condition, and no whole pole fiber is present.

Both original errors are zero through19 by the actual-source theorem. At each finite auxiliary point the B cluster has size at most5 and no other conductor component there. The accepted own-zero-error auxiliary cluster theorem forces each B factor into a. The actual endpoint swap gives the corresponding B factors for the other extension. Thus a already shares the COMPLETE complement of the two ordinary sections. The main theorem forces its ENTIRE conductor factor, impossible through19. No balanced linear class is needed.

At r20, six B sections can exceed the accepted size-five local cluster bound, so automatic B-factor forcing is not asserted. The conditional main theorem still applies whenever complete complement divisibility is independently supplied. Summed order2, higher-degree or multiple missing poles, an end-fiber component, other infinity patterns, nonsplit comparisons and arbitrary source extraction remain outside the theorem. Auxiliary components never receive original endpoint legs; the unmarked common-cover problem remains UNSOLVED.

## Audit provenance

The [frozen source](../../Research/notes/oct03_ten_hour/split_two_ordinary_section_cubic_gap_exclusion.md), SHA256 `59c6bb40fcb34b6cd60404c0696c3097d3ab6c8a89b2e1ff4cf5d15dc7cfc370`, has fresh independent [whole receipt](../../Research/notes/oct03_ten_hour/split_two_ordinary_section_cubic_gap_exclusion_audit.md), SHA256 `fa0f1761b7edc6e6537db8e881bf4fbb8905cd2fea536c21f717efd937f39e47`. The review checked exact complete cancellation, poles and no artificial zeros, infinity frame scaling, global summed-order argument, all critical multiplicities and the unbalanced section-family application. No arithmetic job or settled certificate was run.
