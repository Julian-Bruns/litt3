# Proof: canonical odd coefficients and the order-three hyperelliptic pairs

Version1. [Statement](../../Theorems/cartier_and_spin/faithful_canonical_small_spin_carrier_exclusion.md). [Independent whole review: PASS](../../Research/audits/FAITHFUL_CANONICAL_SMALL_SPIN_CARRIER_AUDIT_2026_10_03.md). Retain both actual maps onT. Use the accepted [general carrier obstruction](actual_spin_carrier_character_reduction.md). The [tame signature calculation](tame_ramified_spin_degree_classification.md) depends only on these retained map-level data: freeG, faithful target action, one index-two q-fiber, descending infinity sections, and the genus identity from L=φ*M and L^16=ωT. It gives coarseB=P¹ and the signatures used below; its derivation does not invoke thatΓ is a normalized projective image.

For cone ordersmi, N=ωΓ has orbifold degree1/κ and weightsmi−1. Its jth invariant section space has coarse degree d_j=j/κ−Σ{j(mi−1)/mi}. Let ej be the primitive characteristic coefficient and r_j=φ*ej/a^j the actual Y function. Its only possible pole isjP, reduced by twice any target vanishing order. For oddj this pole order is odd. The Weierstrass gaps are one and three; a resulting constant forces ej=0 whenever j<κ, since otherwise a^j∈Γ contradicts primitivity.

If the ramified target fiber has r ramified quadratic factors and κ−2r unit companions, elementary product coefficients give
\[
\operatorname{ord}(e_j)\ge\left\lceil\frac{j-(\kappa-2r)}2\right\rceil
\]
when positive. At an ordinary distinguished value r=1. At a distinguished cone of ordert, faithfulness and free transitivity give r=t. A d_j=0 generator has exact forced order−j modt at a cone and no ordinary zero.

## Degrees four and six

Forκ=4, e1=0 by the gap one. The local ramified quadratic forces e3 to vanish at least once at every ramified target value, so r3 has possible odd pole at most one and is constant. Thus e3=0, giving the forbidden even primitive polynomial.

Forκ=6, e1=e3=0 by the gaps one and three. The local coefficient e5 vanishes at least once because every linear-term product includes a coefficient of a ramified quadratic. Thus r5 has possible odd pole at most three. It is constant and e5=0. Again the primitive polynomial is even. These arguments need no additional coefficient-space or image-normalization assumptions.

## Canonical degree eight

The signature is(2,4,8). For j=1,3,5,7 its canonical coarse degrees are−2,−1,−1,0. Thus the only possible odd coefficient is e7. An ordinary distinguished fiber forces target order at least one, whereas the unique invariant generator has no ordinary zero. If distinguished at a cone, mixedness permits onlyt=2. The coefficient e7 then has target order at least two, while its forced order is−7 mod2=1. Thus e7=0 in either case and the primitive polynomial is even.

## Canonical degree twelve away from the last ordinary signature

The signatures are(3,3,4),(2,4,6),(2,3,12). Their distinguished-cone cases are all excluded by the new [complete canonical cone proof](canonical_degree_twelve_cone_carrier_exclusion.md), whose hypotheses are exactly these carrier hypotheses.

At an ordinary distinguished value in signature334, e10 must be the nonzero product of the ten unit companions. But d10=−1, so this coefficient cannot exist. At an ordinary value in signature246, the only possible odd coefficient is e11, with d11=0. Its required ordinary zero forces it zero, hence the primitive polynomial is even. It remains to treat ordinary signature2312 directly, using the selected six-torsion input.

## The last ordinary degree-twelve carrier

In canonical signature2312 the only possible odd coefficients are e9,e11, both with coarse degree zero. Ordinary vanishing forces e11=0. Choose generators t6,t8,t9,t10 and put F=t6/a6, G=t8/a8, H=t9/a9, J=t10/a10. LetR be the single order-twelve source fiber point and E the four distinct order-three fiber points. The exact forced divisors include
\[
\operatorname{div}(F)=6R-6P,\quad\operatorname{div}(G)=4R+E-8P,
\quad\operatorname{div}(J)=2R+2E-10P.
\]
The functionH has exact odd pole NINE. Six-torsion relative to the WeierstrassP forcesR Weierstrass on either selected endpoint. Choose hyperelliptic coordinatez with pole2P and zero2R. Scale F=z³. Then G=z²V2(z), degV2=2, becauseG/z² has pole at most four. Its four simple zeros E form TWO distinct non-Weierstrass hyperelliptic pairs. Also J is a nonzero constant timesG²/F and is polynomial in z.

Let h=e12/a12 be the actual norm ratio. The quotient β=h/F² is a coarseB coordinate with ordinary distinguished value zero and order-twelve value infinity. Exact forced weights give
\[
H^2=C F(h-bF^2),\qquad C\ne0,
\]
where b is the finite order-two cone position. This is the section identity t9²/t6³ proportional toβ−b. The complete characteristic identity has form
\[
h=\epsilon H-(1+c_6F+c_8G+c_{10}J).
\]
Ifε=0 the polynomial is even, so supposeε≠0. Substitution and square completion V=H−CεF/2 give V² a polynomial in z. Its exact odd pole nine makes V anti-invariant: V=yS(z), degS≤2. AtR the zero order ofH is THREE and F has zero order six, so S is divisible by z. ThusV=yzS1(z) with degS1≤1 and S1 nonzero.

At the TWO hyperelliptic pairs in E, β has the same order-three cone value at every point. ThereforeH² has the same value on each pair, since F is polynomial in z. At least one pair has V nonzero: y andz are units there and a nonzero polynomial S1 of degree at most one cannot vanish at both distinct z values. On this pair write H±=±V+dF, d=Cε/2. Equality of their squares gives4VdF=0. SinceV,F,C are nonzero, ε=0, a contradiction.

Thus the last ordinary case also has an even primitive polynomial and is excluded. All degrees4,6,8,12 and all their distinguished ordinary or cone profiles are impossible for the selected endpoints under the stated actual carrier hypotheses.
