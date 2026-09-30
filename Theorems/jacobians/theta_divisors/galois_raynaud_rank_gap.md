# A representation gap for inherited Raynaud defect

Version1. Independently audited, including the parity lemma.

Let \(q:Z\to X\) be a connected finite étale Galois cover of smooth
projective hyperbolic curves over an algebraically closed field of
characteristic \(p>0\), with group \(G\). No restriction on \(|G|\)
is imposed. For \(e\ge1\), put
\[
\delta_e=\operatorname{generic}_{L\in J(X^{(e)})}
h^0(Z^{(e)},B_{e,Z}\otimes q^{(e)*}L),\qquad
Q=J(Z)/\operatorname{im}q^*.
\]
Let \(d_p(G)\) be the least dimension greater than one of a simple
\(k[G]\)-module, with \(d_p(G)=\infty\) if no such module exists.
Then
\[
\boxed{\delta_e=0\quad\text{or}\quad d_p(G)\le\delta_e\le a_e(Q).}
\]
More precisely, the generic section representation has no
one-dimensional subrepresentation. In particular, inherited generic
defect exactly one is impossible for a Galois cover, in every degree
and at every finite Frobenius height. If \(a_e(Q)<d_p(G)\), the
inherited family has generic defect zero.

If \(G\) has a normal p-subgroup with abelian quotient, then
\(\delta_e=0\) for every finite \(e\), without an a-number bound.

For an actual same-source span \(X\leftarrow Z\to Y\) whose first
map is \(q\), vanishing on the inherited \(X\)-family implies
generic vanishing on the full mixed parameter family. Thus if
\(p\nmid\deg q\), \(q\) is Galois, and \(a(Z)-a(X)\le1\),
the mixed first defect is zero. This applies to the excess-one
case for the fixed genus-nine endpoint whenever its actual leg
is Galois; it does not resolve the non-Galois case.

The proof uses the action of the actual deck group and descent of
characters, rather than a positivity or first-order calculation.
It does not introduce a simultaneous Galois closure, and generic
vanishing alone does not exclude a common cover.

There is an exact representation test for the remaining non-Galois
case when the Galois closure has order prime to \(p\). Let
\(\widetilde Z\to X\) be that actual closure, with group \(G\),
and write \(Z=\widetilde Z/H\). For a simple representation \(S\),
let \(E_S\) be its associated degree-zero bundle on \(X^{(1)}\),
and put
\[
t_S=\dim S^H,\quad
b_S=h^0(X^{(1)},B_X\otimes E_S),\quad
r_S=\operatorname{generic}_{L\in J(X^{(1)})}
h^0(X^{(1)},B_X\otimes E_S\otimes L).
\]
Then
\[
a(Z)-a(X)=\sum_{S\ne1}t_Sb_S,\qquad
\delta_1=\sum_{S\ne1}t_Sr_S,\qquad 0\le r_S\le b_S.
\]
If \(a(Z)-a(X)=1\) and an actual mixed family has positive generic
defect, exactly one contributing representation \(S\) occurs. It
is nontrivial and self-dual, has dimension at least two, and satisfies
\(t_S=b_S=r_S=1\). Thus \(B_X\otimes E_S\) has no theta divisor,
despite having only one section at the trivial twist.

In odd characteristic this representation is of orthogonal type.
The proof uses a general parity lemma: if \(E\) has a nondegenerate
alternating \(\mathcal O_{X^{(1)}}\)-valued form, then
\(h^0(X^{(1)},B_X\otimes E)\) is even. Thus a self-dual
representation of symplectic type cannot contribute this single
extra section. The lemma does not require finite-group monodromy.

In odd characteristic, a prime-to-\(p\) Galois closure of odd order
always makes \(a(Z)-a(X)\) even. This rules out excess one in that
monodromy class, independently of any second map. These statements
do not assume that a prime-to-\(p\) degree implies a prime-to-\(p\)
Galois closure.

[Proof](../../../Proofs/jacobians/theta_divisors/galois_raynaud_rank_gap.md).
