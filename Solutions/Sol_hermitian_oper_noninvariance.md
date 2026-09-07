# Proof: an involution changes the quotient potential

[Statement](../Theorems/Thm_hermitian_oper_noninvariance.md).
The exact quotient and Schwarzian computation in
`hermitian_genus_two_test` give h:H->C, Galois and etale with group C3^2,
and a projective oper P_+ on C whose pullback is P_H. Its potential is

    r_+=4t^4/(t^6+3)^2+t/(t^6+3).

The actual involution sigma(t,v)=(-t,v) preserves C. Its Schwarzian is
zero and its derivative has square1. Thus sigma^*P_+=P_- with

    r_-=4t^4/(t^6+3)^2-t/(t^6+3).

Their difference is the nonzero regular quadratic differential
2t(dt)^2/(t^6+3). Regularity also follows because both are regular
projective connections; directly dt has a simple zero at each branch
point and the displayed expression is regular at both infinities.

The fiber product of h and sigma h is finite etale over H by either
projection, hence smooth and projective. Any connected component Z maps
surjectively to H, since its image is nonempty, open and closed. Base
change of a Galois torsor is a Galois torsor, possibly disconnected;
the stabilizer of a component acts simply transitively on its fibers.
Thus each restricted projection f,g is Galois with group a subgroup of
C3^2, and its degree divides9. Riemann--Hurwitz gives equality of the
two degrees. The common map q=h f=sigma h g exhibits a nonconstant
subfield q^*k(C) in the intersection, so the span is cored.

Finally

    f^*P_H=q^*P_+,       g^*P_H=q^*(sigma^*P_+)=q^*P_-.

The difference remains nonzero: pullback of a nonzero rational quadratic
differential by a separating map is nonzero. Equivalently its local
coefficient is multiplied by the nonzero square of the derivative.
The maps here are actually finite etale. Hence the two projective opers
are distinct. No assumption about their equality after passage to a
common source or a simultaneous Galois closure is used.
