# Proof: full constant-chart exact Cartier line and conditional pencil

Version1, 3 October2026. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_constant_cartier_gauge_pencil.md)
and [five-check scope audit](../../Research/audits/OCT03_GRAM_FOUR_FULL_CONSTANT_CARTIER_GAUGE_AND_CANONICAL_FIDELITY_AUDIT_2026_10_03.md).
Both actual étale legs, original scalar/action/connection and the
saturated degree-one constant-jet flags remain hypotheses throughout.

## The same annihilator and raw divisor

The actual horizontal E contains v,∇δv,∇δ²v. The accepted constant
osculation theorem makes them independent, so their paired annihilator
is the SAME F_Y*Q. This identification does not use a₁=b₄.

The accepted pole comparison uses only v=ζu_B for the regular O(P)
generator, ord(η/dζ)=2 and regular Wronskian order2. The exterior
triple order is3−6+2=−1; constant-P inversion after primitive-frame
change adds−10. Thus ξ has order−11. Since degF_Y*Q=−5, its
affine common-zero divisor has degree6.

Universal signed-minor expansion gives
\[
\xi_0=2\delta^2a+4\delta b+3a\delta a+2ab+3a^3.
\]
Its even leading term is3u³x⁶ and its odd coefficient is
2(b₄−a₁)a+4b₁+3b₂x. Hence ξ₀ has pole12 and ξ₀η pole10;
relative to ξ's pole11 the adjunction has a simple zero at P.
The affine divisor relation is div(ξ₀)=D+R with degR=6. Evenness
and a square norm are not imported from d-zero.

## Regular primitive coefficients preserve the actual connection

On the rational second-coordinate chart put f=1/w and ε=x_second−x.
The primitive ψ has expansion
\[
\psi=f\varepsilon+f'\varepsilon^2/2
+f''\varepsilon^3/6+f'''\varepsilon^4/24.
\]
Compute ξ₀ψ+ξ₁ψ²+ξ₂ψ³+ξ₃ψ⁴ BEFORE removing constants.
Multiplying its four ε coefficients by w⁵ gives exactly L₁,…,L₄.
For example f′=J₁/w³, f″=J₂/w⁵ and f‴=J₂′/w⁵;
the identities
\[
J_2'/24=2ABx^6+4B^2x^5+3Bx,\qquad
J_2/3+J_1^2/4=3Bx^2H
\]
give the regular L₄. Changing ε to x_second yields G₀,…,G₃.
All coefficients are affine polynomials, so every gauge vanishes
along D, including at w=0. This explicitly extends the rational
coordinate calculation at branch points; it assumes no global
splitting or multiplication on the quotient by constants.

The classes of x_second,…,x_second⁴ are rational flat coordinates
for the original inherited connection. On the actual horizontal
rank-one F_Y*Q their coefficients share one scalar connection factor.
Dividing ξ by a nonzero flat coefficient gives a horizontal section.
Since w⁵ is horizontal and G₃ is w⁵ times the highest coefficient,
ξ/G₃ and all G_j/G₃ are horizontal. Bare universal parameters are
not claimed to define such a horizontal line.

## Unit leading poles and exact Cartier calibration

The [universal polynomial source](../../scripts/genus_two/oct03_gram_four_full_constant_gauge_leading.sage)
works over F5[A,B,a₀,a₁,u,b₀,b₁,b₂,b₄] without ideal reduction.
It verifies the first-coordinate identity and the minor leading terms
\[
[x^7]\xi_{1,e}=3Au^2,\quad [x^6]\xi_{2,o}=2Au^2,
\quad [x^{10}]\xi_{3,e}=3A^2u^2,\quad
[x^8]\xi_{3,o}=2Au^3.
\]
Thus G₃ has even leading2A²u³x¹³ and odd degree≤10, giving
exact pole26. For G₀ the odd leading coefficient is−2A²u²x¹³
and the even degree≤15. With w leadingρζ⁻⁵ this gives exact
pole31 and coefficient−2ρA²u². Both are nonzero at every actual
A,u≠0 parameter.

The saved pair degrees are(15,13),(13,11),(13,10),(13,10), so
G₁ has ambient pole≤27 and G₂≤26. On an actual source the ratio
G₁/G₃ is horizontal; its leading Laurent order must be a multiple
of5. A numerator pole27 against denominator26 is impossible.
Therefore actual G₁,G₂ have pole≤26. This constrains LEADING
orders of ratios, not every exponent of individual gauges.

The horizontal ξ/G₃ has finite nonpositive divisor because G₃
vanishes on D. Its order at P is−11−(−26)=15. Exact Cartier
descent in the SAME Q consequently yields an effective affine C with
\[
\operatorname{div}(G_3)=D+F_Y^*C-26P,\quad\deg C=4,
\]
\[
\operatorname{div}_{F_Y^*Q}(\xi/G_3)
=15P-F_Y^*C=F_Y^*(3P_1-C).
\]
Descending this section fixes Q=O(3P₁−C), including its original
connection and fifth-torsion choice. It uses neither Nm(D)=U nor
a semireduced graph.

## Complete spaces only on verified independence charts

The finite poles of G_j/G₃ are bounded by F_Y*C. At P their orders
are at least−5, with exact−5 for G₀/G₃. Descending gives four
sections of O(C+P₁), which has h0=4 by Riemann–Roch. If they are
independent they give all of that space.

The unit pole31 removes the G₀ direction when a section must vanish
at P₁. The unit pole26 of G₃ removes a second direction. Cancelling
it in G₁,G₂ gives F₁,F₂. Their ratios are horizontal and leading
pole26 cancels; the next possible numerator pole is21. They descend
into H0(O(C−P₁)), of dimension2. The two unit eliminations preserve
independence, so this pair is the COMPLETE pencil when the original
four gauges are independent.

Its line is O(C−P₁)=ωY₁Q⁻¹. A base point S would make its
degree-two remainder have two sections, hence equal ωY₁; this is
equivalent to Q⁻¹=O(S). Thus the complete pencil is base-point-free
precisely when Q⁻¹ is ineffective.

A nonzero four-row minor of the coefficient matrix at31,26,21,16,11
proves independence. This is sufficient only: later rows could
detect a section below all five displayed rows. In particular the
trivial degree-zero line O(C−4P₁) can contribute such a section.
Vanishing truncated minors therefore does not prove dependence.

On a verified COMPLETE four-section chart, sections of Q⁻¹=O(C−3P₁)
are exactly combinations whose numerator pole is at most11. Killing
the coefficients at31,26,21,16 gives that condition: after each
leading cancellation, horizontal-ratio orders skip to the next
allowed pole. The first-four-row determinant is nonzero iff there
is no such section. If it vanishes, h0(Q⁻¹)=1 because a degree-one
line on a genus-two curve has at most one section. No completeness
or effectivity criterion is applied without the basis hypothesis.

The [executed summary](../../../litt3-computation-data/oct03_gram_four_full_constant_gauge_leading_2026_10_03/summary.json)
and [receipt](../../../litt3-computation-data/oct03_gram_four_full_constant_gauge_leading_2026_10_03/receipt.json)
record a one-thread PASS in0.041seconds Sage,3.352seconds inclusive,
hard15seconds/internal10seconds. Exact formulas and source hash are
preserved there. The independent audit was static and did no replay.
The loose summary bounds28,27 are conservative; the saved pair
degrees give the sharper bounds used above.

No nonempty/dense geometric rank open is inferred from a formal
nonzero normal form. Rank complements, original net incidence and
actual source compatibility remain unresolved. The d-zero norm,
pointwise conjugacy and tame conclusions remain in their separate
theorem. The additional later coefficient-elimination proof and
quadratic extension are not inputs to this Version1.
