# The positive Cartier plane, its second line, and actual orbit restrictions

Version1,23September2026. Let X be the fixed genus-nine curve,
B_X its Cartier bundle, ell=U-perp=O(-3O), and
U/ell=O(6O)+O(10O). Define P as the inverse image of the degree-ten
HN summand. Then P is a canonical rank-two Lagrangian of degree7,
stable after every finite étale pullback. Its Frobenius evaluation is
\[
0\longrightarrow O(19O)\longrightarrow F_X^*P
\longrightarrow\omega_X\longrightarrow0.
\]
Its second fundamental divisor is the reduced degree13 divisor
\[
R_P=O+x^*\operatorname{div}_0 A,\qquad A=(1,21,14,22,13).
\]
The codes use F25 with a^2=a+3, in ascending order.

There is a canonical saturated line
\[
\lambda=(\det P)^2\omega_{X^{(1)}}^{-1}=O(-2O)\subset P.
\]
Its Frobenius evaluation is A^2 dx/y^2 and has zero divisor 2R_P.
The determinant of ell+lambda in P has reduced zero divisor
\[
\Delta=x^*\operatorname{div}_0 B_*,\qquad B_*=(10,22,11,13,20).
\]
It has degree12 and is disjoint from R_P and from the radical
evaluation divisor D of degree31. The line lambda determines P
as the inverse image of the unique HN line of lambda-perp/lambda.
This does not yet say that P determines the embedded X-field.

Retain an ACTUAL étale span through a common proper connected source,
its first genus-two-leg Galois closure q:T->Y, and all conjugate
h_i:T->X of degree d, with deg q=8d. Suppose the old radical orbit
spans all of B_T. Then:

- The trace images of the positive planes and hyperplanes have
  colength at most2 and1 in B_Y, respectively.
- With A_Y=ker(F_Y^*B_Y->omega_Y), the saturated span of the actual
  kernel lines K_i=h_i^*O(19O) is all q^*A_Y. Rank two is impossible.
  Its unsaturated trace image has colength at most10 in A_Y.
- There are at least eight distinct positive planes/new lines, and
  their number is divisible by8.
- For J_lambda=image(q_*lambda_0->B_Y) and S=Sat(J_lambda), the
  rank-two case forces J_lambda=S, degree0, semistable. If
  gcd_i h_i^*R_P=q^*C, then C is reduced of degree0 or1 and
\[
h_i^*R_P\le q^*(C+W_S),\qquad \deg W_S=6-4\deg C.
\]
  If deg C=1, S is strongly semistable.
- In rank three, 0<=deg J_lambda<=deg S<=2.
- In rank four, deg J_lambda>=-1. At equality its actual pullback
  to T splits as four orbit lines; there are at most four underlying
  line-bundle isomorphism classes among all lambda_i.

These restrictions do not exclude or realize the full rank-four
radical orbit. Neither original common-cover problem is solved.

[Proof](../../Proofs/cartier_and_spin/positive_cartier_plane_orbits.md).
