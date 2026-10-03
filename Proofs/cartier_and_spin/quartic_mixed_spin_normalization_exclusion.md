# Proof: canonical trace identities force an involution with fixed points

[Statement](../../Theorems/cartier_and_spin/quartic_mixed_spin_normalization_exclusion.md). [Independent whole-implication review: PASS](../../Research/audits/QUARTIC_MIXED_SPIN_NORMALIZATION_AUDIT_2026_10_02.md). The degree-four cover φ and BOTH actual endpoint maps remain on the SAME actual T. Write G=Gal(T/Y). The finite map φ is G-equivariant for the projective action onΓ.

## The genuine canonical discrepancy and its invariant section

Let N=M¹⁶⊗ωΓ^-1. The actual isomorphism α:φ*M¹⁶→ωT transports the natural canonical G action to a G linearization on M¹⁶. This works even for ramified φ: start with any projective lift on M, take its sixteenth power, and correct its pullback by the unique GLOBAL scalar comparing it with the canonical action on the proper connected T. The resulting downstairs isomorphisms satisfy the cocycle after faithful pullback, hence before pullback. This is the already established canonical-linearization mechanism, with no Galois hypothesis on φ.

Give N this genuine G linearization, using the natural one onωΓ. Under α its pullback is ωT⊗φ*ωΓ^-1. The canonical differential map φ*ωΓ→ωT therefore gives a section s of φ*N with divisor q*P. It is G-invariant because the differential map of the actual equivariant φ is equivariant. Both its zero divisor and its linearization are exact, not merely divisor-class data.

The module trace for the finite flat separating map φ sends s^j to τ_j=Tr_φ(s^j)∈H0(Γ,N^j). It is functorial for G, soτ_j is G-invariant. Consequently
\[
r_j=\frac{\varphi^*\tau_j}{s^j}
\]
is a G-invariant rational function onT, and descends to Y. Its only possible poles lie above P, with order at mostj. Thus r_1∈H0(Y,O(P))=k. If r_1 were a nonzero constant, s would descend to a section of N onΓ. Its zero at each ramified source point has order ONE, whereas a pulled-back zero there has even order. This is impossible. Henceτ_1=0.

## The third trace also vanishes

At any target point z under qP, trivialize N near z. The finite φ-fiber algebra has one length-two local factor and two reduced factors, by the EXACT profile(2,1,1). Modulo z, s is nilpotent on the length-two factor and has nonzero values b,c on the reduced factors. The equalityτ_1=0 therefore gives b+c=0. In characteristic five,
\[
\tau_3(z)=b^3+c^3=0.
\]
The nilpotent factor contributes zero to this trace. Thusτ_3 vanishes at every such target point. Pullback through the index-two branch has vanishing order at least TWO. Dividing by s³ leaves a pole of order at mostONE along qP. There are no other poles. Therefore r_3 descends to H0(Y,O(P))=k, rather than merely H0(Y,O(3P)).

If this constant were nonzero, s³ would descend to N³ onΓ, again contradicting its ODD zero order three at an index-two point. Thusτ_3=0. This argument applies to Weierstrass P as well; it does not require h0(O(2P))=1.

## An even polynomial gives a genuine deck involution

Choose a rational trivialization e of N and put a=s/φ*e∈k(T). The trace identities give Tr_φ(a)=Tr_φ(a³)=0. Newton's identities, with one and three invertible in characteristic five, show that its degree-four characteristic polynomial has the form
\[
Z^4+c_2Z^2+c_4.
\]
The element a generates k(T) over k(Γ). Indeed its minimal degree divides four. Degree one would mean s descends, already excluded. If its degree were two, its quadratic trace is half its degree-four trace and therefore zero; its quadratic polynomial would make a²∈k(Γ), hence s² descend to N². That is impossible on a mixed target fiber: a descended section which vanishes at the ramified point also vanishes at its two UNRAMIFIED companion points, while s² is a unit there. Thus its minimal degree is four.

The even characteristic polynomial is therefore its minimal polynomial. Sending a to−a defines an ACTUAL order-two k(Γ)-automorphism of k(T), hence an involution ι of the smooth proper T overΓ. It has fixed points. Choose e a unit at a ramified target point. There is exactly ONE source point in that fiber at which a vanishes; the two other values are units. Since ι sends a to−a and fixes the target, it preserves and hence fixes that unique zero point. No presumed Galois closure or abstract involution replaces this actual automorphism.

## Fixed points contradict the original étale X maps

The involution fixesΓ and all image-defining sections of M. Its natural action on φ*M¹⁶ transports through α to an action onωT which differs from the canonical action of ι by ONE global nonzero scalar, since T is proper and connected. Thus it scales EVERY original θ_i=u_i¹⁶ by the same scalar.

The accepted actual theta recognition gives h_iι=γh_i for the sameγ∈Aut(X)=C3. Applyingι twice and using surjectivity of the actual h_i showsγ²=1, henceγ=1. Thereforeι is an automorphism over the original finite étale X map. A nonidentity automorphism of a connected finite étale cover over its base acts freely. Its fixed points are the contradiction.

This proves the stated mixed quartic exclusion. The separate uniform-fiber obstruction supplies the other possible quartic profile(2,2); together they eliminate degree four in the single index-two-fiber branch. No global extraction in arbitrary larger degree is claimed.
