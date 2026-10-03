# Proof: one remaining odd weight and a characteristic-five degree contradiction

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_two_order_seven_cone_exclusion.md). Whole-cone argument passed [independent review](../../Research/audits/CANONICAL_DEGREE_FORTY_TWO_ORDER_SEVEN_CONE_AUDIT_2026_10_03.md). Keep both original maps and all inherited spin data onT. Reuse the accepted canonical generator ring, actual carrier primitive-even obstruction, and local cone coefficient bound from the [high-degree cone proof](canonical_high_degree_cone_carrier_exclusion.md).

Canonical stack Hurwitz gives K_Y∼2P, so P is Weierstrass. Write Y:y²=Φ(z), Φ monic squarefree of degree FIVE, P=∞. For canonical signature(2,3,7), weights(1,2,6), put F=t6/s6, G=t14/s14, H=t21/s21. At the distinguished order-seven cone, their exact poles are4,14,21, because the forced target orders are1,0,0. Their disjoint zero divisors have respectively FOUR, FOURTEEN and TWENTY-ONE distinct simple points. Thus F is an invariant quadratic polynomial with TWO distinct nonbranch z-roots, and
\[
H^2=\alpha F^7+\beta G^3,\qquad\alpha\beta\ne0.
\]
The regular differential ν=d(FG)/H is regular at H=0 by
\[
3\beta G^2d(FG)=2H(F\,dH-H\,dF).
\]
It is regular at every other finite point. At P, d(FG) has pole at most19 while H has pole21, so ν vanishes at least twice. It is nonzero because FG has simple zeros. Hence
\[
d(FG)=cH\sigma,\qquad c\ne0,\qquad\sigma=dz/y.
\]

## Exact local coefficient deletions

At a ramified Γ fiber there are SEVEN quadratic ramified factors. The coefficient e42−ℓ therefore vanishes in the target to order at least max(0,7−floor(ℓ/2)). For a nonzero invariant weight below42, its coarse degree is ZERO, so its exact target order is its forced cone order. Any larger required order forces the coefficient identically zero.

For an even monomial F^aG^b of weight j=6a+14b<42, the forced target order is a. The required lower bound is max(0,3a+7b−14); it exceeds a exactly when2a+7b>14. This kills F4G, FG² and F²G². The surviving even terms are polynomials of degree at most SIX in F, G times polynomials of degree at most THREE in F, and G². In weight42 the norm basis is F7,G3; the required target order SEVEN deletes G3 and leaves a nonzero multiple of F7.

For an odd monomial H F^aG^b of weight21+6a+14b<42, its forced order is a and the bound is max(0,3a+7b−3). Thus only H and FH survive. Characteristic evaluation is therefore
\[
A(F)+B(F)G+\gamma G^2+H(d+eF)=0,
\]
where degA=7 with nonzero leading norm coefficient, degB≤3, and(d,e)≠(0,0) by the accepted primitive-even obstruction. The term A(F) has exact pole28. The terms BG and H(d+eF) have poles at most26 and25; hence γG² is the only possible leading cancellation and γ≠0.

## The last odd multiplier is F, and the G odd part is F times a linear polynomial

Write the FULL endpoint functions as
\[
G=U_7(z)+yV_4(z),\qquad\deg U_7=7,\quad\deg V_4\le4;
\qquad
H=C_{10}(z)+yD_8(z),\qquad\deg D_8=8.
\]
At each of the two nonbranch roots r of F, the differential identity gives cH=yF'G. Squaring and using H²=βG³ gives
\[
c^2\beta G=\Phi(r)F'(r)^2.
\]
Thus G has the SAME nonzero value at the two actual points over r, while H has OPPOSITE nonzero values. Evaluating and subtracting the characteristic identity at those points gives d=0. Therefore e≠0. The same G-value equality gives V4(r)=0 at both distinct roots, hence F divides V4.

The coefficient of y in the characteristic identity is
\[
(2\gamma U_7+B(F))V_4+eF D_8=0.
\]
The first parenthesis has exact degree SEVEN, because γ≠0 and B(F) has degree at most SIX. The second term has exact degree TEN. Hence V4 has exact degree THREE; writing V4=F C1, the polynomial C1 has exact degree ONE.

## The generator relation is now impossible

The differential identity gives
\[
cH=y(FU_7)' +\Phi(FV_4)' +\tfrac12\Phi'FV_4.
\]
Its even part is
\[
cC_{10}=\Phi(F^2C_1)' +\tfrac12\Phi'F^2C_1.
\]
The polynomial F²C1 has exact degree FIVE, so its derivative has degree at most THREE in characteristic five. The derivative of monic Φ also has degree at most THREE. Consequently C10 has degree at most EIGHT. The odd part of H² therefore has coefficient2C10D8 of degree at most SIXTEEN multiplying y.

But the odd part of βG³ has coefficient
\[
\beta\bigl(3U_7^2FC_1+\Phi F^3C_1^3\bigr)
\]
of exact degree SEVENTEEN: the first term has degree14+2+1=17 with nonzero coefficient, whereas the second has degree5+6+3=14. The term αF7 is invariant and cannot contribute. This contradicts H²=αF7+βG³. The entire distinguished order-seven cone case is therefore impossible on BOTH endpoints. No arithmetic or new numerical check is used.
