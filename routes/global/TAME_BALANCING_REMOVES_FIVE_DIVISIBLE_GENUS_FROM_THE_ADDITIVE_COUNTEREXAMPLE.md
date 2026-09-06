# Tame balancing removes five-divisible genus from the additive counterexample

Author: /root, 2026-09-06. Status: author proof, not independently audited.
This is a counterexample boundary, NOT a counterexample to Litt3. It
shows that requiring endpoint genera not congruent to one modulo five
does not repair the shared-exact-form implication.

## Statement

There are actual coreless finite etale spans X <- Z -> Y over Fbar5
with a shared nonzero regular exact one-form alpha, such that every
zero of either endpoint form has order 31 and

    5 does not divide g(X)-1 or g(Y)-1.

The endpoints can be isomorphic. Their shared canonical ring is k[alpha]
by the existing coreless intersection theorem. Neither endpoint form
has five-divisible divisor, so this does not assert a Tango structure
on these endpoints. In particular these endpoints are nonordinary;
the result does not supply an ordinary second endpoint or the fixed
genus-nine/genus-twenty-five pair.

## Construction and proof

Use the A9 cover K/k(r) from Sections 1--2 of
[the exact local realization](A9_TWO_POINT_COVER_WITH_EXACT_WILD_LOCAL_FIELD.md).
It has degree q0=181440, is unramified over zero, and has exact inertia
extension of degree 20 and different 55 at infinity. Write B0,Binf
for its reduced fibers over zero and infinity. Thus

    deg(B0 + 16 Binf) = q0 + 16 q0/20 = 326592 = 32 * 10206.

Surjectivity of multiplication by 32 on the Jacobian gives a divisor
E with B0+16Binf linearly equivalent to 32E. Adjoin a thirty-second
root of a function with divisor B0+16Binf-32E, and take its Galois
closure over k(r). Denote the resulting curve by R and its degree
over P1 by q.

At zero this extension has tame index 32 over K; at infinity it has
tame index 2 over K. There is no other ramification. The same is true
after Galois closure: the conjugate local extensions are the unique
tame extensions of these degrees in the fixed separable local closure.
The group has a normal abelian 2-subgroup with quotient A9. Therefore
it has no AGL1(5) quotient, exactly as in Section 4 of the cited note,
and v5(q)=1.

Use the seed x-y=(xy)^5, with its degree-five rational legs and
divisors recorded in
[the projective additive construction](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md).
Take two copies of R with x=-r on the first and y=r on the second,
and form their compositum over the seed field. The sign remains
essential. The previous no-AGL1(5)-quotient proof gives linear
disjointness of each rational leg and then corelessness of the actual
endpoint fields.

At the seed's x-pole P, the x-endpoint extension is tame of degree
8 over the seed completion: the original degree-20 normal closure
was tame of degree 4 over the degree-five seed field, and its new
tame enlargement has degree 2. The y-endpoint extension over y=0
has index 32, while the seed has tame index 4; their compositum over
the seed is the SAME unique tame extension of degree 8. Reverse x,y
at Q. At the third distinguished point O both give the unique tame
degree-32 extension. Thus the local compositum adds no ramification
over either endpoint anywhere, proving that both actual maps are
finite etale.

The shared form is alpha_X=dx and alpha_Y=dy. At endpoint points
over zero its order is 32-1=31. At infinity different transitivity
for the tame quadratic enlargement gives

    different = 2*55 + (2-1) = 111,
    ramification index = 40,
    ord(dr) = 111 - 2*40 = 31.

It has no other zeros or poles, and dx=dy on the seed. Therefore

    2g(R)-2 = 31*(q/32 + q/40) = 279q/160,
    g(R)-1 = 279q/320.

As v5(q)=1 and neither 279 nor 320/5 is divisible by five,
v5(g(R)-1)=0. This proves all assertions.

## Parameter behind the construction

More generally, when a is prime to five and
16a divides deg(B0+16Binf), the same Kummer construction with degree
16a has endpoint indices 16a and 20a, and uniform differential
order 16a-1. Its two relative tame indices over the seed are both
4a, so the balance is unchanged. The choice a=2 above needs no
auxiliary existence argument and keeps the kernel a 2-group.
No claim is made that every a works on this fixed A9 cover.
