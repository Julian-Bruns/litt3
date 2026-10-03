# Proof: all discrepancy weights and the quartic/cubic fiber contradictions

Version3. [Statement](../../Theorems/cartier_and_spin/kernel_three_effective_four_exclusion.md). [Independent whole-implication review: PASS](../../Research/audits/KERNEL_THREE_EFFECTIVE_FOUR_AUDIT_2026_10_03.md). Use the ACTUAL quotient U=T/K and its actual étale Y map, not a substitute cover. The effective mapφU:U→Γ has degree four and different one reduced qUP. Its distinguished coarse image is ordinary, since n=4=t(2+u) forces t=1. Write B=Γ/(G/K)=P¹. We first treat signature(4,4,4), where the actual Y→B map has degree four, three uniform fibers of index FOUR, and the distinguished fiber2P+Q1+Q2 with Q1,Q2 distinct.

The canonical N linearization and accepted actual theta recognition make K act on the rational different generator a by a FAITHFUL cubic character: an element fixing Γ scales all original theta pullbacks by its faithful C3 character. The accepted tame primitivity gives k(Γ)(a)=k(T). Therefore k(Γ)(a³)=k(T)^K=k(U), since its index inT is at most three and at least the order ofK. Invariance of the original primitive characteristic polynomial under a↦ζa shows that only coefficient indices divisible by THREE can survive.

Let b=a³ be this primitive degree-four different-cube generator; its coefficient sections are e3,e6,e9,e12 in Nu,Nu²,Nu³,Nu⁴. The canonical pulled section has zero order THREE along qUP. Thus the elementary linear coefficient e9 vanishes to Γ order at least TWO at the distinguished image: the one local ramified quadratic of b has trace divisible by the square of the target parameter and norm divisible by its cube, while the two companion factors are units. This is a local coefficient computation, not a Newton identity divisible by five.

## Complete weight coverage

Write the three Nu weights as wj∈{0,1,2,3}. Since its orbifold degree is3/4, their sum is congruent to THREE modulo four. Thus, up to permutation, the possibilities are(3,0,0),(2,1,0),(1,1,1),(3,3,1),(3,2,2). The last two have H0(Nu)=0 and their Nu³ invariant coarse degree is ONE. The required ordinary vanishing order at leastTWO therefore forces e9=0; e3 is already zero. The primitive original degree-twelve polynomial is then even, forbidden by the actual commuting-minus obstruction. The remaining possibilities are exactly the three sum-three weights.

Choose a nonzero invariant generator t ofNu and put f=t/s³. Its exact degree onY is THREE. Since Y→B has degree four, k(Y)=k(B)(f) by coprime indices. Thus the characteristic identity of the primitive degree-four cube generator gives the ACTUAL minimal polynomial of f overB, up to its leading coefficient:
\[
(e_{12}/t^4)f^4-(e_9/t^3)f^3+(e_6/t^2)f^2-(e_3/t)f+1=0.
\]
At a zero-weight order-four cone, all coefficients are finite, the leading coefficient is NONZERO, and f is a unit. The actual finite-flat norm polynomial specializes to a fourth power of one linear factor.

## Weights(2,1,0): a missing cubic coefficient is impossible

Here the invariant Nu³ coarse degree is ONE, so e9=0 by its ordinary vanishing order at leastTWO. At the zero-weight order-four cone, the preceding polynomial is a nonzero multiple of(f−r)⁴, with r≠0. Its cubic coefficient is−4 times its leading coefficient times r, and cannot vanish in characteristic five. This contradicts e9=0.

## Weights(3,0,0): two fourth-power fibers would coincide

The two zero-weight order-four cones first show that e3≠0: the linear coefficient of the fourth power with unit root is nonzero. Normalize f=e3/s³. Choose a coarse coordinate β with distinguished ordinary value zero and the weighted order-four cone infinity. Exact forced zeros and ordinary vanishing orders give
\[
e_6/e_3^2=\alpha\beta+B_0,\qquad
e_9/e_3^3=\lambda\beta^2,\qquad
e_{12}/e_3^4=\kappa_0\beta^3,
\quad\kappa_0\ne0.
\]
The scalar λ may initially be zero. At either of the TWO distinct zero-weight cones β=a, the polynomial
\[
\kappa_0a^3f^4-\lambda a^2f^3+(\alpha a+B_0)f^2-f+1
\]
must equalκ0a³(f−r)⁴. The constant and linear coefficients give r=4. The cubic coefficient then gives λ=κ0a, since4·4=16=1 in characteristic five. At the other distinct cone β=b the same argument gives λ=κ0b, impossible. This excludes(3,0,0), including λ=0.

## Weights(1,1,1): a cyclic cubic map would contradict the endpoint automorphisms

For weightsNu=(1,1,1), its orbifold degree is3/4 and the invariant section degrees are
\[
\deg_{\rm coarse}(\mathrm{Nu})=0,\quad
\deg_{\rm coarse}(\mathrm{Nu}^2)=0,\quad
\deg_{\rm coarse}(\mathrm{Nu}^3)=0.
\]
Each space is one-dimensional with all zeros forced at the cones. Therefore e9=0, since it would have to vanish at an ordinary value. The coefficient e6 is NONZERO there: it is the product of the six unit companion s values onT, equivalently the product of the two unit b values onU. If e3 also vanished, the original primitive degree-twelve polynomial of s would be even, contradicting the accepted actual commuting-minus obstruction. Thus e3≠0.

The forced zeros imply e6=C e3² with C≠0. Put f=e3/s³ and h=e12/s¹². The function f onY has sole pole3P and simple zeros at the three order-four fiber points, so degf=3. The norm ledger gives divh=3Q1+3Q2−6P. Evaluating the characteristic polynomial gives
\[
1-f+Cf^2+h=0,\qquad h=f-1-Cf^2.
\]
Consequently the rational function
\[
R(f)=h/f^4=(f-1-Cf^2)/f^4
\]
belongs to the actual coarse field k(B). As a function on the rational f-line it has degree FOUR, sole pole of order four at f=0, and a zero of order two at f=∞. Its two finite zeros are distinct and simple: a repeated quadratic root would make every zero order of h EVEN, contradicting its exact divisor3Q1+3Q2.

OnY the function R has degree twelve. Thus the map B→P¹_R has degree THREE. It is totally ramified over R=0: its zero divisor has degree three at the distinguished ordinary B point, because e12 has Γ zero order three there and e3 is a unit. Its pole divisor is the three distinct order-four B cone points, each simple. All these are actual field identities. The fields k(B) and k(f) generate k(Y), since their two source indices are coprime four and three. Thus Y is precisely the connected normalization of their degree-three/degree-four fiber product over k(R).

The derivative of the degree-four rational function is
\[
R'(f)=(2Cf^2+2f+4)/f^5
\]
in characteristic five. Its finite critical points are nonzero, and their values are not zero since the finite zeros of R are simple. If the two derivative roots are distinct, each has local index TWO. At a nonzero finite critical value v, the degree-three map B→P¹_R has a fiber whose indices sum to three, so at least one is ODD. At that B point the normalization fiber-product index is2/gcd(2,e_B)=2. This would create an additional index-two branch of Y→B away from its distinguished fiber, contrary to its complete branch list of three index-four fibers and2P+Q1+Q2. Thus the two derivative roots cannot be distinct.

They therefore coincide, giving one local index THREE critical point of R at a nonzero finite value v. To avoid an additional index-three branch of Y→B, every point of the B fiber over v must have index divisible by three. Its total degree is three, so B→P¹_R must be totally ramified of index THREE over v.

This cubic rational map is now totally ramified at TWO distinct values, zero and v. In characteristic five such a map is conjugate to z↦z³: choose the two ramified points and values as zero and infinity, so its divisor has one zero and one pole each of order three. It is Galois cyclic of order THREE. Its connected base change is the actual map Y→P¹_f, which therefore has a deck automorphism of order three. This contradicts the accepted Aut(Y)=C2 on BOTH selected endpoints.

Every possible weight in the signature(4,4,4) has now been excluded.

## Signature(2,2,2,4): complete weights and the missing cubic coefficient

Let S be the sum of the three order-two Nu weights, each zero or one, and let w be its order-four weight. The degree congruence gives exactly(w,S)=(3,0),(1,1),(3,2),(1,3). The invariant Nu coarse degree is zero in the first two and−1 in the last two. The invariant Nu³ coarse degrees are respectively2,1,1,0.

The local e9 vanishing order at leastTWO at the distinguished ordinary point therefore makes e9 zero except possibly in(w,S)=(3,0). The last two assignments have e3=e9=0 and give the forbidden even primitive original polynomial. It remains to exclude(1,1) and(3,0).

For(1,1), choose a nonzero invariant Nu generator t and put f=t/s³. Its forced zeros have total degree three onY, so degf=3 and k(Y)=k(B)(f). The coefficient e9 is zero, and e3 must be nonzero by the same even-polynomial obstruction. At either of the TWO zero-weight order-two cones, its actual quartic minimal polynomial
\[
R f^4+Q f^2-Af+1
\]
specializes to the SQUARE of a quadratic, up to a nonzero scalar, with R,A nonzero. In a quadratic square(V2 f²+V1 f+V0)², nonzero leading and constant coefficients mean V2,V0≠0. The missing cubic coefficient forces V1=0, so its linear coefficient is zero. This contradicts A≠0.

## The three remaining square fibers cannot have distinct positions

For(w,S)=(3,0), the three order-two weights are all zero. Choose a nonzero invariant Nu generator t, set f=t/s³ of degree three, and choose coarse coordinate β with the distinguished ordinary point zero and the weighted order-four cone infinity. As in the preceding(3,0,0) computation, the exact invariant coefficients have form
\[
e_6/t^2=\alpha\beta+B_0,\qquad
e_9/t^3=\lambda\beta^2,\qquad
e_{12}/t^4=\kappa_0\beta^3,\quad\kappa_0\ne0,
\]
and e3/t is a constant A. The quartic minimal polynomial is
\[
\kappa_0\beta^3f^4-\lambda\beta^2f^3+(\alpha\beta+B_0)f^2-Af+1.
\]
At each of the THREE distinct nonzero order-two cone positions it must be a square. If A=0, the square's constant coefficient is nonzero and its linear coefficient zero, forcing its quadratic middle coefficient V1 to be zero; its cubic coefficient is then zero, hence λ=0. This would make e3=e9=0 and the primitive original polynomial even. Therefore A≠0. Rescale t so that A=1 and use f=e3/s³.

At β=a write the specialized square as(v2 f²+v1 f+v0)², absorbing the nonzero scalar. Change its sign so that v0=1. Its linear coefficient−1 gives v1=2 in characteristic five. Its cubic coefficient gives4v2=−λa², hence v2=λa². Its leading coefficient then gives
\[
\lambda^2a^4=\kappa_0a^3,
\qquad\lambda^2a=\kappa_0.
\]
The leading coefficient is nonzero, so λ≠0. This equation fixes the cone position a uniquely, contrary to the THREE distinct order-two positions. Thus this final assignment is impossible.

Both signatures and every discrepancy weight in effective degree four with kernel three have now been excluded on BOTH selected endpoints. No simultaneous endpoint Galois closure or merely separable substitute source has been assumed. Higher degrees and the étale spin-image branch remain open.
