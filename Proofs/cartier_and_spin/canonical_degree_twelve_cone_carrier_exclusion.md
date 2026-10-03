# Proof: exact canonical coefficients and the last hyperelliptic-pair obstruction

Version2. [Statement](../../Theorems/cartier_and_spin/canonical_degree_twelve_cone_carrier_exclusion.md). [Independent whole review: PASS](../../Research/audits/CANONICAL_DEGREE_TWELVE_CONE_CARRIER_AUDIT_2026_10_03.md). The accepted [general actual carrier obstruction](actual_spin_carrier_character_reduction.md) excludes a primitive even characteristic polynomial under precisely the retained carrier hypotheses. No projective normalization is assumed here. Use the accepted non-Weierstrass [six-torsion Abel exclusion](../jacobians/torsion/family_six_torsion_abel_exclusion.md) on both endpoints.

Put S=[Γ/G] with coarseB=P¹. The canonical line has weightsmi−1 at cone ordersmi and degree1/12. Its jth invariant section space has coarse degree
\[
d_j=j/12-\sum_i\{j(m_i-1)/m_i\}.
\]
Let s be the actual primitive different section and ej its characteristic coefficient sections inωΓ^j. Write t for the distinguished cone order. The ramified points in a φ target fiber form a free transitive stabilizer orbit, hence numbert; the remaining twelve−2t points are unramified. Thus mixedness bounds t≤4, giving exactly the cone orders in the statement's table.

## Local order bound

At a ramified target value the local degree-twelve polynomial is the product of t ramified quadratic factors and twelve−2t unit companion factors. Every ramified quadratic's linear and constant coefficients have target valuation at least ONE. Selecting j roots therefore contributes at least j−(12−2t) root degrees from the ramified factors. A coefficient of ramified degree one costs at least one valuation, and degree two costs at least one. Consequently
\[
\operatorname{ord}(e_j)\ge\left\lceil\frac{j-(12-2t)}2\right\rceil
\]
when the right side is positive. This is an elementary product-coefficient bound, not a Newton identity.

An invariant canonical coefficient with d_j=0 has only forced cone zeros: at the distinguished cone its exact permitted vanishing order is the residue of−j modulo t, between zero and t−1. A greater required local order forces the coefficient zero. If d_j<0, the coefficient is already zero.

Also e3=0 in every case where d3≥0: the actual function e3/s³ descends toY and has pole at most3P. Its possible positive pole order is odd, since the target coefficient order pulls back with index two. The Weierstrass gaps are one and three. Thus it is constant; a nonzero constant gives s³∈Γ, contrary to degree-twelve primitivity. This uses neither the false assertion that five is a Weierstrass gap nor an even-pole polynomiality shortcut.

## Complete odd-coefficient coverage

For signature(3,3,4), the d_j values for odd j=1,3,5,7,9,11 are respectively−2,0,−1,−1,0,0. At distinguished t=3, e9 requires local order at least ceil((9−6)/2)=2, exceeding its forced residue zero. The coefficient e11 requires order at least three, exceeding forced residue one. Thus e9=e11=0, and e3=0 by the gap argument. All odd coefficients vanish.

At distinguished t=4, the coefficient e4 is the product of the FOUR unit companion values and is nonzero at the target. But d4=−1 for this signature, so no such invariant coefficient exists. This excludes the second334 case directly.

For signature(2,4,6), the odd degrees d_j are−2,−1,−1,−1,−1,0. Thus the only possible odd coefficient is e11. For t=2or4 its order must be at leastt, while its forced residue is−11 modt=1. Hence e11=0 and all odd coefficients vanish.

For signature(2,3,12), the odd degrees d_j are−2,−1,−1,−1,0,0. At distinguished t=3, e9 requires order at least two versus forced residue zero, and e11 requires order at least three versus forced residue one. Both vanish, so again the polynomial is even.

The actual primitive-even-polynomial obstruction excludes each even case, proving all five deletions.

It remains to exclude distinguished t=2 in signature2312, where e11=0 but e9 can meet its forced order one.

## The remaining order-two case has a pole-seven ninth coefficient

The canonical weights are(1,2,11). The invariant generator spaces of orders six, eight, nine and ten are one-dimensional. Choose nonzero generators t6,t8,t9,t10 and put F=t6/s6, G=t8/s8, H=t9/s9, J=t10/s10. Let R be the single point in the order-twelve Y fiber and E the four DISTINCT points of the order-three Y fiber. The distinguished order-two fiber is4P+2Q1+...+2Q4. Exact forced weights give
\[
\operatorname{div}(F)=6R-6P,\quad
\operatorname{div}(G)=4R+E-8P,\quad
\operatorname{div}(H)=3R+\sum_{i=1}^4Q_i-7P,
\quad\operatorname{div}(J)=2R+2E-10P.
\]
Every ratio is an actual Y function from the primitive same-source coefficient line. In particularH has an exact ODD pole seven; it is not assumed anti-invariant at this stage.

SinceP is Weierstrass and6(R−P)=0, the selected six-torsion input makesR Weierstrass too. Choose a hyperelliptic coordinate z with sole pole2P and z(R)=0. ThenF is a nonzero constant times z³; rescale its generator to makeF=z³. DividingG by z² removes4R and leaves pole4P. All functions of pole at most four at a Weierstrass point are polynomials in z, soG=z²V2(z), degV2≤2. The exact four simple zerosE imply degV2=2 with two distinct roots, neither a Weierstrass z value nor zero. ThereforeE consists of TWO hyperelliptic pairs. The one-dimensional generator identities also give J a nonzero constant timesG²/F, hence polynomial in z.

Let h=e12/s12 be the actual norm ratio. Its exact divisor is
\[
\operatorname{div}(h)=2\sum_{i=1}^4Q_i-8P.
\]
The invariant norm space has dimension two. Exact divisor comparison shows thatβ=h/F² is a coarse quotient coordinate, with zero at the distinguished order-two value and pole at the order-twelve value. Likewise t9²/t6³ has exactly one coarse zero at the order-two cone and one pole at the order-twelve cone. Thus for a nonzero constant C,
\[
H^2=C Fh.
\]

The only possible odd characteristic coefficient is e9=εt9; if ε=0 the primitive polynomial is already even and impossible. Write the complete characteristic identity as
\[
h=\epsilon H-(1+aF+bG+cJ).
\]
The norm h has pole EIGHT; H has pole seven, F six, G eight and J ten. The pole ten cannot cancel, so c=0. All remaining even terms are polynomials in z. Consequently
\[
H^2-C\epsilon FH=-CF(1+aF+bG).
\]
Complete the square V=H−CεF/2. Its square is a polynomial in z. Write Y in Weierstrass form y²=Φ(z), degΦ=5. An element A(z)+yB(z) with square in k(z) has either A=0 or B=0, since characteristic is not two. The exact odd pole seven excludesB=0. ThusV is anti-invariant, V=yS(z), with degS≤1. It is regular away fromP. AtR, H has zero order THREE whileF has order six, soV has zero order three. As y has simple zero atR and z has order two there, S must be a nonzero scalar timesz. We obtain
\[
H=c_0yz+dF,\qquad c_0\ne0,\quad d=C\epsilon/2.
\]

Take either hyperelliptic pair inE. Both points have the SAME β value, namely the order-three cone position. At themF is a nonzero common value, y is nonzero with opposite signs, and z is a common nonzero value. The identityβ=H²/(CF³) therefore gives
\[
(c_0yz+dF)^2=(-c_0yz+dF)^2,
\qquad4c_0yz\,dF=0.
\]
All factors other than d are nonzero, so d=0 andε=0. This contradicts the required nonzero ninth coefficient. Equivalently all odd coefficients vanish and the accepted actual primitive-minus obstruction applies.

The last case is excluded. All six distinguished-cone profiles in the three canonical degree-twelve signatures are now closed on BOTH selected endpoints, with the SAME actual source and maps retained.
