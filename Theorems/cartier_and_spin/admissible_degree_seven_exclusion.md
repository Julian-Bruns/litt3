# Degree-seven exclusion and the degree-nine admissible boundary

Version 1, 24 September 2026. In the actual admissible-line problem
of [reconstruction](admissible_line_reconstruction.md), no witness has
covering degree seven AND seven projected E-support points. This excludes
all six cases left by the norm-divisor theorem, for every monodromy group.

More generally, if an actual witness misses any finite point of R_X,
its covering degree is at least nine. At degree nine its projected support
is exactly three complete cubic fibers over roots of A, with O omitted.
There are four such supports. The primitive q generates the degree-nine
cover. Write b_3 for the monic cubic with those three roots. Then
\[
h_*G=\operatorname{div}(v)+9O,\qquad
v\in\langle1+[18]x^2+[20]x^3,
x+[15]x^2+[11]x^3\rangle-\{0\}.
\]
The fifth root of Norm(q), up to a constant and sign, is b_3^3/v.
These are the necessary degree-nine conditions supplied by this theorem.
The later [complete degree-nine exclusion](admissible_degree_nine_exclusion.md),
combined with [unrestricted norm vanishing](uniform_admissible_norm.md),
now excludes ALL admissible degrees at most nine, including the formerly
unaddressed all-finite-support case. The trace argument below remains
useful independently in higher degrees.

The trace calculation has an unbounded conditional form: whenever an
actual degree-n witness has h_*G~nO, take div(v)=h_*G-nO and s=-Tr(b).
Then yvs lies in L((n+12)O) and is congruent to nB_0v modulo(y), with
B_0=(8,14,19,2,10,19,3,24,18,16). Its finite-pole coefficient restrictions
survive in higher degrees, but an invertible matrix is not asserted there.

[Proof and exact trace determinant](../../Proofs/cartier_and_spin/admissible_degree_seven_exclusion.md).
