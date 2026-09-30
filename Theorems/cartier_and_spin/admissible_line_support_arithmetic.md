# Arithmetic torsion and the projected support of an admissible line

Version 1, 24 September 2026. Use X, O, R_X, lambda_X, P_X and the
actual witness h:S->X, E,G,T in
[admissible-line reconstruction](admissible_line_reconstruction.md).

Every degree-zero divisor on X supported on the thirteen points of
R_X represents prime-to-five torsion. The same holds on X^(1).
This is a downstairs statement; it does not apply to arbitrary
selections of individual points over R_X on another curve.
The actual determinant is det(P_X)=O(7O), with no torsion ambiguity.

Every admissible witness on ANY connected finite etale cover satisfies
\[
\#h(\operatorname{Supp}E)\ge7.
\]
The proof does not assume prime-to-five monodromy. Seven missed points
would define a degree-zero modification Q0 of P_X containing at least
four distinct conjugate degree-zero lines. It would split as A+A;
its determinant would simultaneously have prime-to-five order and
exact order five, impossible.

On a Galois witness of degree N, let m>=4 be the number of actual
conjugate lines, e_P the number of selected points of E over P,
and g_{P,a} the number of points over P with G-multiplicity at least a.
The stabilizers of the actual line, E and the normalized primitive
agree. For distinct orbit members,
\[
\deg(E_i\wedge E_j)+\deg(G_i\wedge G_j)\le4N.
\]
Consequently
\[
\sum_P e_P^2+\sum_{P,a}g_{P,a}^2\le(4+2/m)N^2,
\qquad \sum_P e_P^2\le(4+1/m)N^2.
\]
These retain nonreduced G. For r=#h(Supp E) and
d=deg(sum_P max_{Q/P}mult_Q(G) P), one obtains
25/r+1/d<=4+2/m. In prime-to-five monodromy, 5 does not divide m.

[Proof and Cartier certificate](../../Proofs/cartier_and_spin/admissible_line_support_arithmetic.md).
The cases r=7,...,13, including prime-to-five monodromy, remain open.
