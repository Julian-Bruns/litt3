# Proof: simultaneous cyclic section growth

[Statement](../../../Theorems/jacobians/ordinary_covers/prime_avoiding_section_growth.md).

The [Raynaud specialization](prime_avoiding_cyclic_defect.md) applies
this construction to the Cartier bundle after its geometric
generating condition has been verified.
This isolates the general argument from its Raynaud specialization.

Remove the origin from each \(T_i\). The result is a nonempty
irreducible locally closed subvariety with the same closure and
generating property in \(A_i\). Descend this finite collection
of data to a finite field. Poonen's
[Remark5.2 and Corollary5.3](https://math.mit.edu/~poonen/papers/multiples.pdf)
give, for every positive integer m,
\[
\bigcup_{n\ge1,\ n\equiv1\bmod m}[n](T_i\setminus\{0\})(k)=A_i(k).
\]
Apply this to the origin with m the product of p, the prescribed
primes, and all primes dividing earlier chosen orders. It yields
a nonzero point \(L_{i,j}\) killed by such an n. Its exact order
exceeds one and avoids every forbidden prime. Enumerate all
pairs \((i,j)\) sequentially. Their orders are pairwise coprime
across the entire family.

The subgroup \(\Lambda_j\) generated through stage j is the
direct product of these cyclic groups, hence cyclic. Its character
lines embed in \(\operatorname{Pic}^0(C)\). The corresponding
actual tame character cover \(q_j:C_j\to C\) is connected:
only the identity character line has global sections. Compatible
character algebras give nested covers. Projection formula gives
\[
q_{j*}\mathcal O_{C_j}=\bigoplus_{L\in\Lambda_j}L,\qquad
H^0(C_j,q_j^*E_i)=
\bigoplus_{L\in\Lambda_j}H^0(C,E_i\otimes L).
\tag{3}
\]
The identity summand supplies the old sections, and the j
distinct chosen characters for i supply at least j further
dimensions. This proves (1). Choosing only the first line for
each i gives the final direct-sum assertion.

For the actual second leg, put \(d=\deg(g)\) and include its
prime divisors among the forbidden primes. Pullback is injective
on \(\Lambda_j\), since its kernel is killed by d:
\(\operatorname{Nm}_g g^*=[d]\). Its actual character cover on Z
is precisely \(Z\times_C C_j\), and is connected by the same
global-section argument. Nonzero coefficient sections remain
nonzero under finite surjective pullback. Apply (3) on Z to get
(2), with its original section space as the identity summand.
The projections and original endpoint maps are retained throughout.

No semisimplicity of an unrelated monodromy representation or
simultaneous Galois closure of the original span is assumed.
The section theorem uses tame cyclic covers it actually constructs.
The prime support can grow indefinitely; no normalized growth
rate or joint minimality assertion follows.
