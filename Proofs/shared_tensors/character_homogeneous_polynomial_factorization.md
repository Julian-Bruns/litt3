# Proof: characteristic-power factorization from character vanishing

Version1,2 October2026.
[Statement](../../Theorems/shared_tensors/character_homogeneous_polynomial_factorization.md).

Write uniquely
\[
F(Z)=\sum_{j=0}^{a}Z^{pj}R_j(Z),\qquad\deg R_j<p.
\]
Every coefficient of every R_j belongs to V. Formal differentiation
annihilates Z^(pj), so the original differential equation splits into
the independent equations
\[
dR_j=-eta\,(R_j)_Z+beta\bigl(sR_j-Z(R_j)_Z\bigr).
\]
If a nonzero R_j has degree t>s and leading coefficient b, its highest
coefficient equation is db=(s-t)beta*b. The nonzero residue s-t modulo p
and homogeneous-character vanishing forbid b. Thus all R_j have degree
at most s.

The top block R_a is monic of degree s. In any other block the Z^s
coefficient has differential zero, so it is a constant c_j in k. Subtract
c_j R_a. If the difference is nonzero of degree t<s, its leading
coefficient again satisfies db=(s-t)beta*b, now with a positive nonzero
residue, and is forbidden. Hence R_j=c_j R_a for every j, including
c_a=1. Summing gives F=R_a P(Z^p) with P in k[Z], monic of degree a.

If N>=p and s>0, both factors have positive degree, so F is reducible.
If N>=p and s=0, F=P(Z^p) has derivative zero, so is not separable.
This proves the degree bound.

For the actual-cover application, all conjugates of chi satisfy the
same affine differential equation. If F is their monic minimal
polynomial, the polynomial
\[
dF+(eta+beta Z)F_Z-N\,beta F
\]
has degree strictly less than N and vanishes at chi, hence is zero.
At a point P of C, etaleness splits the completed cover into unramified
sheets. Every elementary symmetric coefficient has pole order at most
the sum of the pole orders of chi over P, which is p(q_*G)(P).
Away from that divisor all conjugates are regular. Thus every coefficient
belongs to L_C(pq_*G), including when G has repeated points or several
points over the same P. No Galois hypothesis or assumed simultaneous
closure is needed.

The argument uses only polynomial blocks and exact differential
equations. It makes no claim that the homogeneous-character spaces
vanish for a degree-two or larger divisor; in genus two they generally
do not, explaining the genuine primitive-degree-sixteen gap.
