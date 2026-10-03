# Arithmetic torsion and the projected support of an admissible line

Version2,3October2026. Use X, O, R_X, lambda_X, P_X and the
actual witness h:S->X, E,G,T in
[admissible-line reconstruction](admissible_line_reconstruction.md).

Every degree-zero divisor on X supported on the thirteen points of
R_X is annihilated by the exact marked-group exponent m in
[the later lattice theorem](marked_divisor_relation_lattice.md).
In particular its order is prime to five. The same holds on X^(1).
This downstairs assertion does not apply to arbitrary selections
of individual points over R_X on another curve.
The actual determinant is det(P_X)=O(7O), with no torsion ambiguity.

Every admissible witness on ANY connected finite etale cover satisfies
\[
\#h(\operatorname{Supp}E)\ge7.
\]
Seven missed points define an actual degree-zero modification
containing all distinct conjugate degree-zero lines. Three such
lines already force a scalar splitting; its determinant would
have both prime-to-five order and exact order five.

On a Galois witness of degree N, let m_h>=4 be the number of actual
conjugate lines, e_P the number of selected points of E over P,
and g_(P,a) the number of points over P with G-multiplicity at least a.
The stabilizers of the actual line, E and the normalized primitive
agree. For distinct orbit members,
\[
\deg(E_i\wedge E_j)+\deg(G_i\wedge G_j)\le4N.
\]
Consequently, retaining nonreduced G,
\[
\sum_P e_P^2+\sum_{P,a}g_{P,a}^2\le(4+2/m_h)N^2,
\qquad \sum_P e_P^2\le(4+1/m_h)N^2.
\]
For r=#h(Supp E) and d=sum_P max_(Q/P)mult_Q(G),
one obtains25/r+1/d<=4+2/m_h.
In prime-to-five monodromy,5 does not divide m_h.

[Proof](../../Proofs/cartier_and_spin/admissible_line_support_arithmetic.md).
The cases r=7,...,13 remain open; no common-cover decision follows.
