# Proof: doubled area, tame kernel and the actual exact differential

Version1,3 October2026. Author proof, pending whole-scope review. See the [statement](../../Theorems/cartier_and_spin/wild_cyclic_five_etale_positive_full_reduction.md). No numerical enumeration is run; the eight small h rows below are an explicit hand calculation. BOTH original maps from T remain actual finite étale maps.

## The actual quotient has one wild and one tame value

The accepted determinant-character theorem gives B=Z/G=P¹, e even, and |χ₂(G)|=e₂. Stabilizer orders divide e, and the genuinely linearized M₁⁸ gives their least common multiple e.

For ANY wild inertia I of order i, its first ramification group has order at leastFIVE. The local different therefore satisfies δ≥(i−ONE)+(FIVE−ONE)=i+THREE. Its contribution to the quotient Hurwitz area is at leastONE+THREE/i. A tame inertia contributes at leastONE/TWO. If there were a wild value and TWO other values, the area would be at leastTHREE/i≥THREE/e, contradicting its actual value TWO/e. If there were TWO wild values, the area would be at leastSIX/e, again contradictory. Thus there are at mostTWO values and exactlyONE wild value.

There cannot be just that wild value. Its inertia order would equal e by the stabilizer-lcm identity, and Hurwitz would give δ=2e+TWO. But e is even, its zeroth ramification term e−ONE is odd, and all positive ramification groups are FIVE-groups of odd order, giving even further terms. The different δ must be odd, contradictory. Thus there are exactlyTWO values, the other tame of order j≥TWO.

The cyclic χ₂ quotient is branched at BOTH values and totally ramified at each. Consequently the TWO-parts of i,j are identical and equal e₂.

## The cyclic-five local constraints and a finite bound

Write the wild inertia order i=FIVE h, where its normal first ramification group is cyclic FIVE and the tame quotient is cyclic h, prime toFIVE. Its only positive jump is an integer b>ZERO prime toFIVE. Hence
\[
\delta=5h-1+4b.
\]
Conjugating a local wild generator t↦t+a t^(b+1)+… by a tame generator with derivative ζ_h multiplies the leading coefficient by ζ_h to the power ±b. The induced automorphism of C₅ belongs to F₅×, of order dividingFOUR. Therefore h dividesFOUR b. A central tame kernel is allowed; one must NOT incorrectly assume h dividesFOUR.

Put g=gcd(i,j)=gcd(h,j), using FIVE∤j. The actual lcm identity gives e=ij/g. Hurwitz gives
\[
\frac{\delta}{i}+1-\frac1j-2=\frac2e,
\qquad j(4b-1)=5h+2g.
\tag{1}
\]
Since h₂=j₂=e₂, h and j are even. Put FOUR b=h v for a positive integer v. Equation(1) rearranges as
\[
h(jv-5)=j+2g\le3j.
\]
The factor jv−FIVE is positive. For j=TWO it is at leastONE and h≤SIX. For j=FOUR it is at leastTHREE and h≤FOUR. For even j≥SIX it is at least j−FIVE, giving h≤3j/(j−FIVE)≤EIGHTEEN. Thus h≤EIGHTEEN in all cases.

Also (1) and g≤h,j≥TWO give b≤floor((SEVEN h+TWO)/EIGHT). The complete even h, prime-to-FIVE candidates and their possible b with h|FOUR b are

| h | possible b before equation(1) | solutions of(1) with h₂=j₂ and g=gcd(h,j) |
|---|---|---|
| TWO | ONE,TWO | b=TWO,j=TWO |
| FOUR | ONE,TWO,THREE | b=TWO,j=FOUR |
| SIX | THREE | none |
| EIGHT | TWO,FOUR,SIX | b=TWO,j=EIGHT |
| TWELVE | THREE,SIX,NINE | none |
| FOURTEEN | SEVEN | none |
| SIXTEEN | FOUR,EIGHT,TWELVE | none |
| EIGHTEEN | NINE | none |

Each final-column test is the displayed linear equation j(FOUR b−ONE)=FIVE h+TWO g with g an actual divisor of h having its full TWO-part. For example h=SIX leaves ELEVEN j=THIRTY+TWO g with g=TWO orSIX, neither divisible byELEVEN; h=TWELVE leaves ELEVEN j=SIXTY+TWO g for b=THREE,g=FOUR orTWELVE, again impossible, and larger b already give a left side too large for j≥FOUR. The other rows are equally direct. The surviving cases have b=TWO,j=h,g=h,e=FIVE h and δ=FIVE h+SEVEN.

The tame conjugation image has order h/gcd(h,b)=h/TWO for h=TWO,FOUR,EIGHT. Thus only the first inertia group is cyclic; the central tame kernel has orderTWO in all three rows.

## The determinant character supplies an actual cyclic endpoint cover

For a surviving row χ₂ has order h. On both inertia groups it is faithful on the tame quotient, and it kills the wild C₅. Its actual quotient C=Z/kerχ₂→B is a cyclic degree-h cover of P¹ branched at precisely TWO values, both totally ramified. Thus C is rational; choose a coordinate t with a sole pole at its point above the wild value.

INSIDE the ORIGINAL k(T), form k(Y_h)=k(Y)k(C). Because k(C)=k(Z)^kerχ₂ and the original q is G-Galois, this compositum is exactly k(T)^kerχ₂. Therefore Y_h→Y is an ACTUAL connected cyclic degree-h étale cover. It is not an arbitrary one-leg replacement and no X-map is asserted on Y_h.

The separating map Y_h→C has degree e=FIVE h. Local base change by C→B removes the entire tame quotient of the wild inertia, leaving the C₅ extension with breakTWO and differentTWELVE. It removes the tame j=h inertia completely. Its complete pole fiber over t=∞ has h points, each of indexFIVE; there is no other ramification. At each pole the local differential order is
\[
\operatorname{ord}_{P_\nu}(dt)=\delta_{C_5}-2\cdot5=12-10=2.
\]
At all other points dt is a unit. Its divisor is exactly TWICE those h pole points, of degree2h=2g(Y_h)−TWO. In particular dt is NONZERO, REGULAR and EXACT. Cartier kills it, so Y_h is nonordinary.

For h=TWO orFOUR this contradicts the selected cyclic-cover ordinarity theorem. For h=EIGHT no such ordinarity input is supplied. The FORTY row remains as the actual necessary nonordinary cyclic EIGHT-cover condition. Larger wild first ramification groups remain outside this reduction.
