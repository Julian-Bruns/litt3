# Proof: orbifold canonical torsion, hyperelliptic parity and a cube fiber

Version2. [Statement](../../Theorems/cartier_and_spin/tame_high_degree_ordinary_spin_exclusion.md). The Version1 scope passed [independent whole-implication review](../../Research/audits/TAME_HIGH_DEGREE_ORDINARY_SPIN_AUDIT_2026_10_03.md). The newly added middle degree18 row(1,1,2), and the separately linked canonical degree18 theorem, passed the [whole ordinary degree18 audit](../../Research/audits/ORDINARY_DEGREE_EIGHTEEN_SPIN_EXCLUSION_AUDIT_2026_10_03.md). Canonical degree24 passed its [separate audit](../../Research/audits/CANONICAL_OCTAVIC_TRIANGLE_ORDINARY_SPIN_AUDIT_2026_10_03.md). All source maps, different sections, characteristic polynomials and quotient fibers below are ACTUAL. We use the accepted [tame signature classification](tame_ramified_spin_degree_classification.md), [different primitivity](tame_spin_different_primitivity.md), and the general primitive-even-polynomial/tangent obstruction in the [sextic proof](sextic_ramified_spin_spectral_reduction.md).

Write \(\mathcal B=[\Gamma/G]\), with coarse curve B=P¹. Because the action is effective and tame, this is the three-root stack of its cone orders. The actual map f:Y→\(\mathcal B\) is representable, is étale except for the ONE index-two point P over an ordinary coarse value, and has degree κ. The canonical different line N on the stack has degree1/κ; its canonical pulled section has divisor P. Consequently
\[
f^*N=\mathcal O_Y(P),\qquad \omega_Y=f^*\omega_{\mathcal B}\otimes\mathcal O_Y(P).
\]
The second identity is the actual stack Hurwitz formula: its only different is P. No X atlas is claimed.

## All three degrees force a Weierstrass distinguished point

A root-stack line is specified by its coarse degree and reduced weights w_i modulo the cone orders m_i. Its degree is the coarse degree plus Σw_i/m_i. A degree-zero line with all weights killed by ℓ is ℓ-torsion: its ℓth power has zero weights and degree zero on P¹, hence is trivial. The canonical root-stack weights are m_i−1.

Integrality of the coarse degree for degree1/κ gives exactly the following weights:

|κ|signature|weights of N|order of N⊗ω_stack^-1 divides|
|---|---|---|---|
|18|(2,3,9)|(1,0,5),(1,1,2),(1,2,8)|3,3,1|
|24|(2,3,8)|(0,2,3),(1,2,7)|2,1|
|42|(2,3,7)|(1,2,6)|1|

For example, the first congruence is9w2+6w3+2w9≡1(mod18), forcing w2=1 and w9≡5−3w3(mod9). The other two congruences are12w2+8w3+3w8≡1(mod24) and21w2+14w3+6w7≡1(mod42); they give the displayed rows directly. The canonical stack line has the SAME degree1/κ. Pulling its difference from N gives respectively3(2P−K_Y)=0,2(2P−K_Y)=0, or2P−K_Y=0.

For a Weierstrass origin O, K_Y∼2O. Therefore6[P−O]=0 or4[P−O]=0 in the first two degrees. The accepted [six-torsion Abel exclusion](../jacobians/torsion/family_six_torsion_abel_exclusion.md) and [eight-torsion specialization](../jacobians/torsion/family_small_torsion_specialization.md) exclude non-Weierstrass P on MAIN; FOUR-torsion is contained in EIGHT-torsion. The accepted [backup arithmetic](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md) excludes them on BACKUP via W1[24]. Thus P is Weierstrass in EVERY row. Forκ42 this conclusion needs no endpoint-specific torsion input.

Fix a hyperelliptic coordinate z with sole pole2P. Every function with sole pole of EVEN order below the first odd function has no automatic parity; the arguments below instead use exact divisors or algebraic relations. Whenever explicitly used, polynomiality follows from a square relation or from the root-stack canonical ring structure stated below; this point requires justification in the subsequent paragraphs.

## A conditional parity lemma for the remaining degree42 row

For an invariant section of N^j, its coarse degree is
\[
d_j=j/\kappa-\sum_i\{jw_i/m_i\}.
\]
For j<κ, a nonzero section requires d_j=0 and its zeros are exactly the forced cone zeros; its invariant space then has dimension ONE. Products with the same total weight and forced zeros differ by a nonzero scalar.

Forκ42 choose t6,t14,t21; the even weights below42 are6a+14b, and the odd ones are21+6a+14b≤41. H0(N42)^G is spanned by t6⁷,t14³. These assertions follow directly from the displayed formula for d_j; alternatively reduce j modulo the three cone orders. In each listed weight the indicated monomial has the required forced zeros.

Normalize generators by the different section s: F=t6/s6,G=t14/s14,H=t21/s21. Their sole poles at P have EXACT orders6,14,21, since the distinguished coarse point is ordinary. In particular H is not in k(z), because a rational function of z with no other pole has even pole order.

Polynomiality of F,G in z is NOT proved here. Their even leading pole orders allow lower odd terms. The subsequent accepted [canonical degree42 reduction](canonical_septic_triangle_ordinary_spin_reduction.md) proves that invariant F would force invariant G and thereby excludes that entire case; its remaining noninvariant F case is still open. Consequently the following criterion is only conditional within the direct argument of this proof.

CONDITIONAL LEMMA: If F,G∈k(z), evaluation of the primitive characteristic polynomial gives A(F,G)+H Q(F,G)=0, where A lies in k(z), and Q has support{1,F,F²,F³,G,FG}. Their pole orders are pairwise distinct. If Q≠0 then H∈k(z), impossible. If Q=0, distinct pole orders force every odd characteristic coefficient to vanish, contradicting the primitive-even-polynomial obstruction. Thus the displayed polynomiality condition excludes the degree42 row.

The noncanonicalκ24 row has d3=0, so an invariant N3 generator has sole pole3P, impossible at Weierstrass P. This row is unconditionally excluded.

The canonicalκ24 row is now excluded by the subsequent [exact Cartier and differential theorem](canonical_octavic_triangle_ordinary_spin_exclusion.md). That proof justifies every necessary generator form and covers the possible lower odd terms; no even-pole shortcut is used.

## A degree18 row with a genuine degree-two generator

Weights(1,0,5) give invariant generators t2,t9. Every j<18 invariant section is a monomial in them; H0(N18)^G is spanned by t2⁹,t9². Put z=t2/s², h=t9/s9. The first function has sole pole2P, so it is a genuine hyperelliptic coordinate; h has sole pole9P and is not in k(z). The ratio β=h²/z9 is a coarse coordinate: its divisor is the difference of the complete order-two and order-nine cone fibers. The remaining order-three cone is β=a with a≠0,∞. The ordinary distinguished coarse value is another value b≠a.

Characteristic evaluation yields
\[
hR(z)+Q(z)+C h^2+D z^9=0,
\quad R\in k[z],\ \deg R\le4,\ \deg Q\le8,\ Q(0)=1,\ C,D\ne0.
\]
The constants C,D are nonzero because the norm section vanishes at an ordinary coarse point, whereas either individual N18 basis vector vanishes only at a cone. If R=0, the primitive characteristic polynomial is even, impossible. Thus R≠0. Since h is not rational in z, this is its quadratic minimal equation, and the characteristic identity recovers h from z andβ. Hence k(Y)=k(z,β).

At β=a, the ACTUAL minimal polynomial of z over k(B) specializes, up to a nonzero scalar, to
\[
P_a(Z)=A(Z)^2-aZ^9R(Z)^2,
\qquad A(Z)=Q(Z)+(Ca+D)Z^9.
\]
Here degA=9 because a≠b=−D/C. Every actual point in this fiber has index THREE and z is finite, so P_a is a cube polynomial. Its degree is18, and A(0)=1.

Substitute Z=X² and factor
\[
P_a(X^2)=F_+(X)F_-(X),\qquad
F_\pm(X)=A(X^2)\pm\sqrt a\,X^9R(X^2).
\]
Each factor is individually a cube. At a root not shared with the other, its multiplicity is divisible by three because P_a is a cube and X≠0. At a shared root, both A and R vanish. The two h values there are DISTINCT, nonzero and opposite: the quadratic equation with R=0 has h²=a z9≠0. Thus this is not a hyperelliptic branch point. Both actual Y points belong to the complete order-three fiber. In their local z parameters, h∓sqrt(a)z^(9/2) vanish to EXACT order three, while h±sqrt(a)z^(9/2) are units. Substituting either choice into the quadratic minimal equation identifies the corresponding F factor with that order-three zero times a unit. Each shared root therefore has multiplicity exactly three in EACH factor.

Write F_+(X)=U(X)³, degU=6, absorbing its leading scalar. Reflection gives F_-(X)=U(−X)³. Since U(0)≠0 and char=5, the factor U(X)²+U(X)U(−X)+U(−X)² is a unit at zero. Therefore
\[
\operatorname{ord}_0\bigl(U(X)^3-U(-X)^3\bigr)=\operatorname{ord}_0\bigl(U(X)-U(-X)\bigr)\le5
\]
unless the difference is identically zero. But F_+−F_-=2sqrt(a)X9R(X²) is nonzero and has order at least NINE. This contradiction unconditionally excludes weights(1,0,5).

## Remaining scope requiring completion

The canonicalκ42 row requires a justified hyperelliptic polynomiality or a replacement argument. It is FALSE in general that an even sole pole at a Weierstrass point makes a function invariant: y times a polynomial can have lower odd pole mixed with the leading even pole. No degree42 closure is claimed here. The subsequent [canonical degree18 theorem](canonical_nonic_triangle_ordinary_spin_exclusion.md) closes weights(1,2,8); the next argument closes weights(1,1,2).

## Degree18 weights(1,1,2) force genuine hyperelliptic polynomiality

The invariant generators below18 have weights6,9,10,12,14,15,16. Put F=t6/s6,G=t10/s10,H=t9/s9,J=t14/s14; their exact poles are6,10,9,14. Forced divisors give divF=3D−6P, divG=2D+E−10P, divH equal to the complete order-two fiber minus9P, and J a nonzero scalar multiple of G²/F. Here D is the TWO distinct order-nine fiber points and E the SIX distinct order-three fiber points. Invariant N30 sections give
\[
G^3=F^2(\alpha F^3+\beta H^2),\qquad \alpha\beta\ne0.
\]
The differential ν=dG/H is regular away from P. At H=0, F,G are units; differentiating the identity makes dG divisible by H because d(F5)=0 in characteristic FIVE. At D, G has order TWO and H is a unit, so ν has a zero of exact order ONE. At P, G has pole TEN and H pole NINE; its leading derivative term vanishes in characteristic five, so ν has at worst a SIMPLE pole. This is its only possible pole, and the residue theorem removes it. Thus ν is regular. It is nonzero because G has SIMPLE zeros at E.

Its divisor already contains the TWO distinct D points, consuming the canonical degree TWO. Consequently D is canonical, hence a hyperelliptic pair because P is Weierstrass. Choose z with divz=D−2P; then F is a constant times z³, and scale it to this form. The ratio G/z² has sole pole SIX at P, so
\[
G=z^2\bigl(U_3(z)+v y\bigr),\quad \deg U_3=3,\quad v\in k.
\]
The regular ν with zero divisor D is a nonzero constant times zσ, σ=dz/y. Solving H=dG/(c zσ) gives
\[
cH=y(2U_3+zU_3')+v(2\Phi+z\Phi'/2).
\]
The second summand has exact degree FIVE if v≠0, since Φ is monic degree five and2+5/2=2≠0. This would give H pole TEN, contradicting its exact pole NINE. The first summand is anti-invariant and cannot cancel an even polynomial pole. Thus v=0: F,G,J are all polynomials in z, and H is anti-invariant. The norm N18 coefficient is a combination of F³,H², so it too is invariant. The only odd characteristic coefficients are constant multiples of H,FH. Evaluation and hyperelliptic parity force both zero, giving the forbidden even primitive polynomial. The entire middle degree18 row is excluded on BOTH endpoints.

## Extension: ordinary signature(2,3,12)

The congruence6w2+4w3+w12≡1(mod12) gives six rows. Row(0,0,1) has an invariant N section and is excluded by H0(Y,O(P))=k and the different section's mixed fiber. Relative to canonical weights(1,2,11), the five other rows have the following torsion orders:

|weights|order of N/ω_stack divides|first useful invariant weights|
|---|---|---|
|(0,1,9)|6|3,4|
|(0,2,5)|2|3|
|(1,0,7)|3|2,7|
|(1,1,3)|3|4,6,9|
|(1,2,11)|1|6,8,9,10|

Thus all but(0,1,9) force P Weierstrass by the accepted FOUR/SIX Abel torsion inputs. Row(0,2,5) then contradicts its pole-three invariant generator. Row(0,1,9) forces12[P−O]=0 and has a pole-three generator, so P is non-Weierstrass. BACKUP excludes it by W1[24]; the new computation-free [twelve-torsion family bound](../jacobians/torsion/family_twelve_torsion_abel_exclusion.md) excludes it on MAIN, since the selected parameter degree exceeds153600.

For(1,0,7), use z=t2/s² and h=t7/s7. The degree12 norm section divided by t2⁶ is a coarse coordinate β. Exact root-stack divisors give
\[
h^2=c z^7(\beta-b),\qquad
hR(z)=\beta z^6+Q(z),\qquad c\ne0,\ \deg R\le2,\ \deg Q\le5,\ Q(0)\ne0.
\]
Here b is the order-two cone and the order-three cone is another finite value a≠b, both distinct from the distinguished norm-zero value. If R=0, all odd characteristic coefficients vanish, forbidden; otherwise z,β recover h and generate Y. Atβ=a the actual minimal z polynomial is
\[
(a z^6+Q(z))^2-c(a-b)z^7R(z)^2.
\]
It has degree12 and is a cube because the complete fiber has index three. The same shared-root argument as above shows that after z=X² both factors are individually cubes U(X)³,U(−X)³ of degree12, with degU=4. Their difference has order at least SEVEN at zero, while U(X)−U(−X) has degree at most THREE and the cubic cofactor is a unit. Contradiction.

For(1,1,3), put F=t4/s4,G=t6/s6,H=t9/s9. The norm space N12 has basis t4³,t6², and the only odd characteristic coefficient possibly surviving is e9. F has pole FOUR, hence is polynomial in a hyperelliptic coordinate z. Exact divisors give divG=6R−6P, where R is the single order-twelve fiber point. Since P is Weierstrass,6[R−O]=0, so the selected SIX-torsion input forces R Weierstrass too. Therefore G is a constant times(z−z(R))³. The norm ratio is consequently also in k(z). Evaluating the characteristic relation makes a nonzero constant multiple of H rational in z, impossible at its exact odd pole NINE; if that constant is zero, the primitive polynomial is even. Both alternatives are excluded.

For the canonical row(1,2,11), put F=t6/s6,G=t8/s8,H=t9/s9,J=t10/s10 and K=e12/s12. Again divF=6R−6P forces R Weierstrass, so scale F=(z−r)³. The exact divisor of G is4R+E−8P, where E is the COMPLETE order-three fiber of FOUR distinct points. Thus G/(z−r)² has sole pole FOUR at P and is a polynomial of degree at most two. In particular G∈k(z), and J is a nonzero scalar multiple of G²/F, hence also in k(z). Every point of E is non-Weierstrass: its G zero has order ONE, which is impossible for a polynomial in z at a Weierstrass point. The set E is therefore TWO hyperelliptic pairs.

The invariant N18 space is two-dimensional, with basis t6³,t6 e12; t9² has nonzero coefficient on the second basis vector because its coarse zero is the order-two cone, whereas t6³ vanishes at the order-twelve cone. Hence
\[
H^2=cFK+dF^3,\qquad c\ne0.
\]
The characteristic evaluation has only ONE odd term, a constant times H, and all its even terms except K lie in k(z). Eliminating K gives
\[
H^2+\epsilon F H+F Q(z)=0
\]
for a rational Q∈k(z). In fact FQ is a polynomial: its terms are constant multiples of F,F²,FG,FJ,F³. Complete the square V=H+epsilon F/2. Then V² is a polynomial in z and V has odd pole NINE, so V is anti-invariant under the hyperelliptic involution. Indeed an element A(z)+y B(z) has square in k(z) only if A=0 or B=0; the latter is excluded by its odd pole. Thus V=yS(z), degS≤2. At R, H has zero order THREE and F zero order SIX, so V has zero order THREE. Taking y with simple zero at every finite Weierstrass point gives
\[
V=y(z-r)S_1(z),\qquad \deg S_1\le1.
\]
The quotient β=K/F² is a coarse coordinate with sole pole12R, and β=H²/(cF³)−d/c. Both points in EACH of the two hyperelliptic pairs E lie over its order-three cone value a and have index THREE. Consequently β−ιβ vanishes to order at least THREE in their common local z parameter. But
\[
\beta-\iota\beta=-2\epsilon V/(cF^2).
\]
At E, F and y(z−r) are units, so if epsilon≠0 this forces S1 to have order at least THREE at each of TWO distinct z values, impossible for degree at most one. Thus epsilon=0. This kills the sole odd characteristic coefficient e9 and gives the forbidden even primitive polynomial. The canonical row is excluded.

## Extension: ordinary signature(2,4,6)

The congruence6w2+3w4+2w6≡1(mod12) gives exactly
\[
(0,1,5),\ (1,1,2),\ (0,3,2),\ (1,3,5).
\]
Relative to the canonical row(1,3,5), each other row differs by a degree-zero line of order at most TWO. The stack Hurwitz identity therefore forces4[P−O]=0, so the accepted EIGHT-torsion input makes P Weierstrass on MAIN; BACKUP uses W1[24]. The canonical row gives K_Y∼2P directly.

Row(0,3,2) has d3=0, providing a pole-three function at a Weierstrass point, impossible. In the canonical row(1,3,5), the ONLY odd weight j<12 with dj=0 is ELEVEN. The actual coefficient e11 vanishes at the ordinary distinguished point (each product of eleven source values includes one of the two zero values), whereas a nonzero invariant N11 generator can vanish only at cones. Thus e11=0, and the primitive polynomial is even, impossible.

For each remaining row(0,1,5),(1,1,2), let F=t4/s4 and G=t6/s6. Their pole orders are EXACTLY FOUR and SIX. The invariant N12 space is two-dimensional with basis t4³,t6²: their forced coarse zeros are the order-six and order-four cones respectively. The norm coefficient therefore has
\[
K=e_{12}/s^{12}=A F^3+B G^2,\qquad A,B\ne0.
\]
Both constants are nonzero because the norm section's zero is the ordinary distinguished coarse value. The actual norm ledger gives K sole pole of EXACT order TEN at P: its numerator vanishes to order TWO at the index-two point, and its denominator has order TWELVE.

With a hyperelliptic coordinate z of pole2P and y of pole5P, write F as a quadratic polynomial and
\[
G=U_3(z)+v y,\qquad v\in k,
\]
where U3 has degree exactly THREE. This expression includes the potentially nonzero LOWER odd term; it is not discarded by its even leading pole. If v≠0, the odd part of B G² is2B v U3 y, whose pole has exact order ELEVEN. The term A F³ is a polynomial in z and cannot cancel that odd order. This contradicts the pole-ten norm bound. Hence v=0 and BOTH F,G are in k(z), as is K.

The first row's odd characteristic coefficients below12 have weights5,9,11, with invariant generators H=t5/s5,FH,GH; e11=0 by the same ordinary-point argument. The second row has only the odd weight NINE. Thus characteristic evaluation is
\[
R(F,G)+H(a+bF)=0
\]
in the first row, or R(F,G)+aH=0 in the second, with R(F,G)∈k(z) and H of exact odd pole FIVE or NINE. A nonzero coefficient multiplying H would make it rational in z, impossible. Otherwise distinct pole orders of1,F force all odd characteristic coefficients zero. This is again the forbidden even primitive polynomial. Both remaining rows are excluded, completing ALL ordinary signature(2,4,6) cases on both endpoints.
