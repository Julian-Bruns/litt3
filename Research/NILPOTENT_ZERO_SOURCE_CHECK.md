# Resolved source correction: nilpotent zeros and collisions

2026-09-07, root. The bounded independent check passed. Hoshi already
documents the failure of Bouw–Wewers Proposition3.6(iv) in
[AppendixA, RemarkA.3.1(ii)–(iii)](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1867revised.pdf).
The actual local/compact checks and exact divisor factorization have
[a scoped audit](audits/NILPOTENT_SPIKE_COLLISION_SOURCE_CHECK_2026_09_07.md),
by library_generalization_cleanup_max,2026-09-07. It is not a fresh or
whole-theorem audit. The common-cover problem remains UNSOLVED.

In F5(t) put a=t^7/(1+t^11) and

    r=3a''/a+(a'/a)^2=(t^20+4t^9)/(t^22+2t^11+1).

The exact short Sage checker gives E=r''−3r²=3a,
D^4(1/a)=−1, and det(psi)=0 for

    psi=−[[E',3E],[E''+3rE,−E']].

At t=0, r has order9, while the four entries of psi have orders6,7,5,6.
The kernel's slope is−E'/(3E), of order−1, so its saturated line meets
the oper line(0,1), although p-curvature vanishes to order5.

## Compact test — independent check passed

Set t=u^5−u and H=1+t^11. On P1_u the pullback quartic a(du)^4 has
orders7 at the five F5 points,−1 at the55 simple H-roots, and12 at infinity.
Take the connected cyclic-four cover

    C: w^4=H(u)^2 u(u−1).

Its inertia orders are2 at the55 H-roots and4 at0,1; infinity is
unramified because the right side has degree112. Riemann–Hurwitz gives
2g(C)−2=−8+110+6=108. Its pulled-back quartic has zero orders:

* 2 at110 points above H=0;
* 40 at the two points above0,1;
* 7 at12 points above2,3,4;
* 12 at four points above infinity.

The weighted sum is432=4(2g(C)−2). All orders are0 or2mod5, so the
direct scalar regularity test makes the pulled-back r regular everywhere.
The12 order-seven points retain simultaneous kernel collision and
p-curvature zero. There are no common-cover claims about this example.

## Resolution and its scope

Bouw–Wewers, arXiv math/0505275v2, Proposition3.6(iv) states that a
supersingular point has no p-curvature spike. Their Definitions3.3/3.5
and Theorem4.11 require an extension convention in this situation: the
fourth-root deformation datum has sigma=11/4 at an order-seven zero,
which their definition treats as marked. Their forward construction
chooses a different marked integral extension of the same rational
connection. Rational agreement does not identify these integral opers.
For the regular extension here, collision and spike overlap. The exact
identity div(square Hasse)=2D_collision+pR_spike allows that overlap.

Primary PDF: https://arxiv.org/pdf/math/0505275
The relevant definitions and proofs in Sections2–4 were read by root.
The source translation has been corrected and shortened to admissible
scope. Its two downstream ordinary-data applications remain within that
scope. The direct scalar identities and
Mochizuki's independent finite-flat nilpotent count do not use that comparison.

Fresh audit spawn was blocked by the retained-thread limit; the existing
library agent performed the bounded independent check. Do not promote
its scope to the entire scalar dictionary or infer source ordinariness.
