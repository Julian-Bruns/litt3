# Conditional global audit of the additive projective construction

Date: 2026-09-05. Auditor: `/root/additive_projective_counter_global_audit`.

**Verdict: FAIL as literally stated, owing to the local sign at the x-pole. PASS after pulling the x-endpoint cover back along x ↦ −x, conditional on the asserted endpoint-cover existence.** This audits the proposed strengthened Tango-core counterexample, not Litt itself. No endpoint existence construction is certified here.

## Necessary local correction

For x−y=(xy)^5, substituting x=t^4 and y=t^−5v gives

    v^5+v=t^9,

not v^5−v=−t^9. With a^4=−1, the actual normal closure over x=t^4 has y=a t^−5v and v^5−v=−a^−1t^9. Its Artin–Schreier class over k((t^−1)) is different from that of −t^9: their leading coefficients are not proportional over F_5. A Laurent series with pole order 9 cannot be an Artin–Schreier coboundary, whose negative leading pole order is divisible by 5. The degree-five normal extensions over the tame quartic field are therefore distinct. Changing the chosen fourth root of x only multiplies that coefficient by an element of F_5^*, and cannot fix this discrepancy. Consequently the literally specified x-endpoint local normal extension does not contain the seed degree-five completion, and the resulting map to that endpoint remains wildly ramified.

The y-endpoint formula is correct: y=t^4 and x=t^−5v yield v^5−v=−t^9.

Pulling the assumed x-endpoint cover back by x ↦ −x repairs the issue without any stronger existence assumption. Its local model is then

    x=−t^4,  v^5−v=−t^9,  y=−t^−5v.

This satisfies the seed equation exactly. The branch locations, tame index 16 at zero, index 20 and different 55 at infinity, connectedness, and abstract global Galois group are unchanged.

## Seed corelessness

The hyperelliptic model, divisors of x and y, and div(dx)=div(dy)=3P+3Q check directly. The separability argument for a hypothetical nonconstant intersection H is valid: an element whose fifth power is in H must lie in both rational endpoint fields, since the extensions from those fields are separable. Thus H is relatively fifth-root closed in the seed field; for these one-variable fields over perfect k this gives separability over H. The double-coset connected-fiber argument then justifies passage from the saturated connected clump {O,P,Q} to a common Laurent function.

There is a minor false bound in the first differentiation step of the source proof: differentiating an exponent −5a+1 can produce exponent −5a, so surviving exponents need not all lie strictly inside [−5a,4a]. The conclusion still follows. The derivative's upper exponent is at most 4a−1; every nonconstant common Laurent function necessarily has paired extremes [−5b,4b]. It would therefore have b<a, contradicting minimality. Hence the derivative is constant. This replaces the erroneous strict-interior assertion.

The subsequent integration, nonzero quadratic relation, third-derivative decomposition, coefficient identities, and descent bound R_new≤floor((R+2)/5) all check. In particular D²(z²)=2z^10+2z and D³(z²)=2(x+y) in characteristic five. The final R≤1 contradiction is valid. Seed corelessness passes with the preceding bound correction.

## Global fields and corrected local matching

The prime-degree linear-disjointness claim is valid but needs more than a generic intersection criterion. In a common finite Galois closure, the normal subgroup fixing K' acts on the five embeddings of the seed degree-five extension. Its orbits are equal-sized blocks, hence have size 1 or 5. Size 1 forces the seed extension into K'; size 5 gives linear disjointness. Containment would force its F20 normal closure into K', producing the prohibited F20 quotient. The same argument applies on the y-side, including after the x-base twist.

The compositum M'/M is finite Galois. Its automorphisms preserve K' and L' by their normality over K and L, respectively; restrictions are surjective by the established disjointness. For F=K'∩L', this gives F^Gal(M'/M)=K∩L=k. Every element of F is algebraic over this fixed field by the finite orbit polynomial. Since k is algebraically closed, F=k. All maps under discussion are separable.

After the sign correction, above P the x-endpoint normal closure contains the seed degree-five completion with relative tame degree 4. The y-endpoint tame extension of degree 16 over its base meets the seed tame degree-four completion, also giving relative tame degree 4. These are the same extension of the completed seed field because a complete discretely valued field with algebraically closed residue field has a unique tame extension of any specified prime-to-5 degree inside a separable closure. The argument reverses at Q. At O both extensions are the unique tame degree-16 extension. Elsewhere all relevant covers are unramified. Thus the compositum adds no ramification over either endpoint, and both maps from its normalization are finite étale.

## Differential and unique compatible Tango structure

At endpoint points over zero, ord(dx)=16−1=15. At infinity, ord(dx)=55−2·20=15. Elsewhere its order is zero; the x-base sign twist does not change these orders. The same holds for dy. Their pullbacks agree by the seed identity dx=dy, and they are nonzero exact regular forms. The canonical divisor is a multiple of five. In particular endpoint genus exceeds one: if the endpoint Galois degree is d, its canonical degree is 27d/16>0.

Declaring this rational exact form horizontal defines a regular dormant connection on the canonical line: locally its logarithmic derivative has residue equal to the zero multiplicity, which vanishes modulo five. Its horizontal forms are fifth-power multiples of an exact form, giving the Tango condition. The endpoint connections agree on the compositum.

Uniqueness can be checked without a stronger canonical-ring theorem. The difference of two compatible connections would be a shared regular one-form β. Its ratio to the shared exact form lies in K'∩L'=k, so β=cη. The difference of two dormant line connections is logarithmic, hence Cartier-fixed. But C(cη)=0, so β=0. Thus there is exactly one compatible Tango pair.

The corrected conditional construction therefore passes this global audit. The original untwisted formulation must not be cited as an étale counterexample.
