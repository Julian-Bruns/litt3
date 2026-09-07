# Inverse-cup atlas equations and the boundary they remove

Fix any acyclic geometric oper on X, meaning H0(W(8O))=0. Let B(U) be
its symmetric24x24 quadratic matrix from `cohomological_bezout`. Use the
dual coordinates beta and eta=i^-1(beta) of `compact_etale_atlas_system`.
Write K(eta) for the24x24 cup matrix on H0(omega^2), and Gamma=K(eta)^[5].

The complete untwisted atlas scheme is equivalently given by

    B(U) Gamma = I_24,
    beta_i + Tr(Gamma partial_i B(U)) = 0,       i=1,...,32.       (1)

No determinant inverse, missing boundary chart, or nonvanishing condition
must be added to(1). It is a finite reduced scheme, possibly empty.
The first matrix equation has degree7 and the second group degree6.
Their structured form, not their raw equation count, is the potential
computational advantage. The normalization U.beta=2 follows automatically.

There is a characteristic-free description of the invalid quotient strata.
Use `rank_two_extension_space`, with nonzero u and zero divisor D>0.
Then

    ker N_u = ker[H1(L^-2)->H1(L^-2(D))],                        (2)

the dimension-deg D space of principal parts supported on D. For the
fixed curve its cup matrices have rank at most deg D<=23. Thus on the
acyclic branch an invertible cup matrix automatically removes all these
strata, including arbitrary multiplicities and zeros at infinity.

These strata cannot simply be omitted from the unsaturated N equations.
For EVERY oper, the restricted projective incidence

    N_U eta^[5]=0,       [U] in P31, [eta] in P(J)

contains a24-dimensional family of invalid quotients: for each P in X,
take U whose descended section vanishes at least to order4 at P, and a
nonzero order-three jet functional eta_P in J supported on4P. In particular
the N equations alone do not define a finite or generically well-behaved
candidate list. The normalization in the compact system removes this
family, and(1) removes it through matrix invertibility.

For the first new oper, the matrix H(gamma) defined by

    H(gamma)U = (Tr(K(i^-1 beta)^[5] partial_i B(U)))_i,
    gamma=beta^[5],

is symmetric and linear in gamma. Its singular locus cannot be discarded:
two exact projective-line computations give coprime det H and det Gamma,
of degrees32 and24. Thus even an invertible cup matrix does not ensure
that H can be inverted. These are matrix-chart counterexamples, not atlases.

Status: author proof,2026-09-07. Uses audited structural inputs; this
combined reformulation and boundary description is not independently audited.
[Proof](../Solutions/Sol_inverse_cup_atlas_system.md).
