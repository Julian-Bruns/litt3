# Proof and sources: rank-two candidate classes

Canonical [statement](../Theorems/Thm_dormant_rank_two_candidates.md).

Choose theta^2=omega and N=theta tensor tau^2. Then N^2=omega tensor tau
and F_C^*N=theta^5 tensor tau. Thus W=V tensor N^-1 has trivial determinant
and its Frobenius pullback is K^vee tensor theta^-1, the nonsplit extension

    0 -> theta -> G_2(theta) -> theta^-1 -> 0.

This fixes the actual bundle, not merely its HN polygon. Its canonical
connection has zero p-curvature. The HN line theta cannot be horizontal
because its degree is nonzero in k. Its second fundamental map is therefore
an isomorphism theta -> theta^-1 tensor omega. Conversely Cartier descent
of a dormant fixed-theta oper gives W. The quotient to theta^-1 is unique
up to scalar, since Hom(G_2(theta),theta^-1)=k. Hence a W class determines
the Quot point, without additional gauge parameters.

Wakabayashi, [dormant indigenous bundles](https://arxiv.org/pdf/1411.1191),
Proposition 2.4 fixes the theta normalization; Theorem 3.3 gives finite
faithfully flat moduli over M_g for EVERY odd prime. Lemma 4.2 and
Proposition 4.3 identify the determinant-identity rank-two degree-zero
subsheaf Quot scheme of F_*(theta^-1) with this moduli scheme. Their proofs
identify the actual two-step quotient of F^*F_*(theta^-1), not just its
degrees. Main and source agent read the relevant proofs.

Joshi–Pauly, [Hitchin–Mochizuki morphism and opers](https://arxiv.org/pdf/0912.3602),
Section 3.2, identifies the same nonsplit bundle under p>rank and
p not dividing g-1. Its connection chart modulo gauge is H^0(omega^2)
in rank two. Dormancy means ZERO, not merely nilpotent, p-curvature.

## The all-odd-prime degree formula

Wakabayashi Corollary 5.4 assumes p>2(g-1); do not apply it directly at
p=5,g=9. Liu–Osserman, [indigenous bundles and Ehrhart polynomials](https://doi.org/10.1007/s10801-006-6920-x),
Theorem 2.1, Corollary 3.6 and Theorem 3.9, instead prove that the degree
for fixed g is ONE polynomial in every odd prime p, including small primes.
We checked the argument in Liu's primary thesis, Chapter III, Theorem
III.2.1, Corollary III.3.7 and Theorem III.3.11, printed pp.57,65,68-70.
The gluing count at totally degenerate curves applies at every odd prime,
and all odd Ehrhart arguments belong to a single polynomial.

Wakabayashi Section 6.2(2) proves polynomiality of the expression

    p^(g-1)/2^(2g-1) sum_(j=1)^(p-1) csc(pi*j/p)^(2g-2).

It agrees with Liu–Osserman's polynomial at infinitely many primes by
Corollary 5.4, hence identically. Evaluating at five gives the two powers
in the statement. They obey the stated recurrence, whose first values
are 2,5,15,50,175,625,2250,8125,29375. Finite flatness makes this the
scheme length on every curve, not the count of distinct special-fiber
points. This is a deduction combining sources, not extrapolation of
the restricted theorem.

None of these arguments gives the rank-three Hermitian lift.
