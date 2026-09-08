# Inverse-cup atlas equations for all eighteen representatives

Version2,2026-09-08: the author reformulation now includes nonacyclic opers.
Fix ANY geometric dormant oper on X, put V=W(8O), and let
r=h0(V)=0 or3. In coefficient-Frobenius coordinates use the audited
mixed matrix of `cohomological_bezout`, with n=24:

    D(U) = [ B(U)  q(U) ],       size n+r,
           [ a(U)     0  ]

where B is quadratic and q,a are linear. All six exceptional symmetry
representatives retain their three H0(V) and H1(V) directions.
Use beta and eta=i^-1(beta) from `compact_etale_atlas_system`; put
Gamma=K(eta)^[5], the n-square cup matrix in the same coordinates.

On the ENTIRE admissible open, the top-left block of D(U)^-1 is the
cup matrix of the normalized extension class, in these twisted coordinates.
Its rank is n-r:24 when r=0,
but21 when r=3. It is the augmented27-square matrix, NOT the exceptional
cup matrix, that must be invertible.

Introduce auxiliary blocks X,Y,Z of sizes n by r,r by n,r by r and set

    G = [ Gamma  X ].
        [     Y  Z ]

The following equations define a scheme isomorphic, by forgetting X,Y,Z,
to the complete untwisted atlas scheme:

    D(U) G = I_(n+r),
    beta_i + Tr(G partial_i D(U)) = 0,        i=1,...,32.          (1)

No extra nonvanishing condition or missing boundary chart is implicit:
the inverse equation forces admissibility and determines every auxiliary
block uniquely. This is a finite reduced scheme, possibly empty, and
U.beta=2 follows automatically. The gradient term includes

    Tr(Gamma partial_i B)+Tr(X partial_i a)+Tr(Y partial_i q).

Omitting the last two terms when r=3 is not this criterion. For r=0,
(1) is exactly B Gamma=I_24 and beta_i+Tr(Gamma partial_i B)=0,
the earlier degree7/degree6 system with symmetric B.

There is also an exact auxiliary-free formulation on an explicit cover.
Choose any invertible r-row minor q0 of q and r-column minor a0 of a;
after ordering those rows and columns last, put m=n-r and

    P = [ I_m; -a0^-1 a_left ],
    L = [ I_m, -q_top q0^-1 ],       Bbar=L B P.

Then D is invertible exactly when Bbar is invertible, and

    Gamma=P Bbar^-1 L,     det D=+-det(q0)det(a0)det(Bbar).       (2)

Equivalently impose a Gamma=0, Gamma q=0, L B Gamma=L. If Z0 is
the m-square submatrix of Gamma on the unselected rows and columns,
the remaining gradient equations are

    beta_i+Tr(Z0 partial_i Bbar)
      +partial_i det(q0)/det(q0)+partial_i det(a0)/det(a0)=0.     (3)

Every admissible direction lies on one of these patches. Thus the six
exceptional representatives have21-square patch equations with essential
3-square minors and their logarithmic derivative terms. Denominators are
units on the named patch; clearing them without retaining that open is
not equivalent. No matrix coefficients for these exceptional systems
have been computed here, and no runtime improvement is claimed.

Since det V=omega, Serre-dual bases further give a=q^T. One q minor q0
then suffices: L=P^T, Bbar=P^T B P is symmetric, and

    det D=(-1)^r det(q0)^2 det(Bbar).

Let Z0=Gamma_(I^c,I^c), where I selects q0. On det(q0)!=0, the complete
criterion in the ORIGINAL64 variables is precisely

    Gamma q=0,       Bbar Z0=I_(n-r),
    beta_i+Tr(Z0 partial_i Bbar)+2 partial_i det(q0)/det(q0)=0.   (S)

All such minor patches are retained; no preferred minor is assumed
nonzero. For r=3 this uses one3-square minor and a symmetric21-square
block, with no inverse-block auxiliary variables. For r=0 take
det(q0)=1 and P=I; it recovers the original acyclic equations.

In particular, for r=3 the necessary equation Gamma(beta)q(U)=0 is
a72 by32 linear system in U. Uniform full column rank on the rank21
cup stratum would be a sufficient atlas exclusion for that oper. This
condition is NOT proved; no rank-deficient stratum may be discarded.

There is a characteristic-free description of the invalid quotient strata.
Use `rank_two_extension_space`, with nonzero u and zero divisor D>0.
Then

    ker N_u = ker[H1(L^-2)->H1(L^-2(D))],                      (Bdy)

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
family, and(1) removes it through augmented-matrix invertibility for all18.
The jet family's cup rank is at most4, so even the necessary rank n-r
excludes that particular family. Rank21 alone is NOT a replacement for
the full nonacyclic inverse equations on all other boundary strata.

For the first new oper, the matrix H(gamma) defined by

    H(gamma)U = (Tr(K(i^-1 beta)^[5] partial_i B(U)))_i,
    gamma=beta^[5],

is symmetric and linear in gamma. Its singular locus cannot be discarded:
two exact projective-line computations give coprime det H and det Gamma,
of degrees32 and24. Thus even an invertible cup matrix does not ensure
that H can be inverted. These are matrix-chart counterexamples, not atlases.

Status: author proof,2026-09-07; version2 extension2026-09-08. Uses audited
Bezout, gradient and compact-atlas inputs; the combined reformulation,
mixed inverse-block lemma and minor-patch reduction are not independently
audited. No whole representative, other twist, or common-cover branch
is excluded by this theorem.
[Proof](../Solutions/Sol_inverse_cup_atlas_system.md).
