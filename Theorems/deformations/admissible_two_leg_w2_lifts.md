# Admissible common connections are exactly compatible canonical W2 lifts

Let k=bar(F_5). For a smooth projective connected curve C of genus>=2
and an admissible active regular nilpotent projective connection r,
let C_r^[2] be the marked W_2(k)-lifting of C^(1) associated to its
canonical FL-bundle. This convention retains the Frobenius twist;
inverse Witt-Frobenius base change gives the corresponding lift of C.

For EVERY actual finite etale map a:W→C, the unique finite etale lift
of a^(1) to C_r^[2] has source canonically isomorphic, with its special-
fiber marking, to W_(a^*r)^[2]. No ordinariness or degree restriction
is required.

Consequently, for two actual finite etale maps from the SAME W,
C←W→B, and admissible active connections r_C,r_B, the following are
equivalent:

1. a^*r_C=b^*r_B as projective connections on W.
2. The sources obtained by lifting a^(1) to C_(r_C)^[2] and b^(1) to
   B_(r_B)^[2] are isomorphic over W_2(k) by an isomorphism inducing
   the identity on W^(1).

Thus a matching admissible active span always lifts simultaneously
MODULO25, even when its common nilpotent connection is nonordinary.
Its first two-leg Witt obstruction vanishes. The datum being compared
is the canonical marked curve lift; no lift of the original connection
as a characteristic-zero connection is asserted.

This does NOT extend the simultaneous span to W_3(k) or W(k), and
does not give a finite partner set. Ordinary common-source finiteness
requires the separate stronger theorem. Dormant connections do not
satisfy the admissibility hypothesis here.

Version1,2026-09-09. Author source-checked corollary of Mochizuki II
Propositions1.2 and2.5 and the explicit Frobenius-obstruction construction.
No independent audit or Lean verification claimed.
[Proof](../../Solutions/deformations/admissible_two_leg_w2_lifts.md).
