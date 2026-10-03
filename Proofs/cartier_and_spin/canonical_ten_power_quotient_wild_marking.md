# Proof: the unique weak extension is detected by the wild hyperelliptic fiber

Version1, 3 October2026. Focused root review PASS, added to Research/audits/OCT03_PAIR_AND_SOURCE_FLAG_AUDIT_2026_10_03.md; the native power-flag antecedent has independently passed whole review. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_power_quotient_wild_marking.md). No computation is used.

At the weakC₅ point put u=ONE/t, σu=u+ONE and du=−dt/t². The local module ωΓ⁻¹ in its invariant frame du⁻¹ is t⁻²k[[t]]. Additive Hilbert90 identifies its H¹ with invariant principal parts modulo this module and modulo invariant rational functions. Remove invariant polynomials in u⁵−u. Every remaining leading term (u⁵−u)ⁿuʲ, ONE≤j≤FOUR, of degree greater thanTHREE has a nonzero difference of degreeONE less, still greater thanTWO. It cannot be invariant modulo the allowed module. The remaining class is u³, whose difference has degreeTWO. Hence local H¹ is one-dimensional, represented by
\[
\xi=u^3du^{-1}=-\frac1{t\,dt}.
\]
The coarse invariant line π_*ωΓ⁻¹ has degree−ONE, and its H¹ on P¹ is ZERO. Tame local cohomology is ZERO. Degree-one Leray therefore proves H¹(S,ωΓ⁻¹)=kξ, and every native nonsplit extension has this class up to scale.

For completeness the native power flag gives a NONSPLIT extension for EACH r=ONE,TWO,THREE. In the local notation of that flag the top degree-r coefficients are (h₊ʳ,h₋ʳ), whereas the preceding degree-(r−ONE) top direction has coefficients (h₊ʳ⁻¹,h₋ʳ⁻¹). Translating the orbit label gives a nonzero factorr times the former in degree r−ONE. It is not proportional to the latter since h₊≠h₋. Thus Δ acts nontrivially on F₂ᵣ/F₂ᵣ₋₂, so its native extension cannot split. By the preceding one-dimensional cohomology these THREE quotients are all isomorphic as native extensions up to rescaling their subline or quotient. Only the already established flag is used, with no direct-sum assertion.

At the TWO actual wild points of Y write s=a±dt in a COMMON regular Γ frame. Divide ξ by the canonical rational section s⁻¹ of O_Y(−P₀): the boundary principal parts are −a±/t. The retained native differential identity gives η=c a±dt. Serre duality pairs the pulled class with η by the SAME-constant sum
\[
-c(a_+^2+a_-^2).
\]
The accepted normal form b²=2c₀ gives a₊/a₋ primitive SIX: its fifth power has sum with its inverse equalONE, so the ratio itself satisfies r²−r+ONE=ZERO. Therefore a₊²+a₋²=a₊a₋≠ZERO. The pulled extension is nontrivial.

In the moving-point coordinate z, BOTH wild points have z=ZERO. The differential η has divisor TWO P₀, while η₀=zη has divisor R₊+R₋. Pairing the same principal parts with η₀ gives ZERO at BOTH points. Since H⁰(ωY(P₀))=H⁰(ωY)=span(η,η₀), this determines the pulled class exactly as the functional selected by the wild hyperelliptic fiber.

For R=R₊ orR₋ pull the extension through O_Y(−R)→O_Y. Its class maps to H¹(O_Y(R−P₀)). By Serre duality this is ZERO precisely when the original functional kills H⁰(ωY(P₀−R)), the ONE-dimensional span of η₀. Therefore O_Y(−R) lifts to f*D. The lift is unique up to its prescribed scalar because H⁰(O_Y(R−P₀))=ZERO. It is saturated: if the entire lifted fiber vanished at R, the map would factor through O_Y and split the original extension. Its quotient is consequently O_Y(R−P₀).

Finally the actual commutative square φ:T→Γ, q:T→Y pulls f*D back to φ*D. The scalar row twist is φ*M⁶=L⁶. Thus its original-source bundle is exactly L⁶q*(f*D). The global-generation assertion is the quotient assertion of the separately established M⁶F₆ flag theorem; it is not inferred from the genusTWO marking alone.

The evaluation E→O_T does NOT factor through F₆/F₄ because it is nonzero on F₄. Accordingly the quotient does not produce an original adjunction map to B_Y without a further argument. This is the precise gap in turning the marked quotient into a positive Cartier plane.
