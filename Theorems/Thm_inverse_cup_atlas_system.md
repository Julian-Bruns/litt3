# Inverse-cup atlas equations for all eighteen representatives

Version5,2026-09-08: adds the audited selected-column inverse criterion.
Nonacyclic opers and the exact negative rank diagnostic remain included;
no atlas equations have been weakened.
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
not equivalent. The q and cup matrices for invariant_0 have now been
computed; its full B/minor-patch system has not. No runtime improvement
is claimed.

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
a72 by32 linear system in U. The proposed uniform full-column-rank
shortcut is FALSE: an exact invariant_0 cup matrix has rank21 while
this linear system has rank29; its three-dimensional kernel contains
directions with rank q=3. Thus even these two necessary ranks do not
give an exclusion. The full inverse and gradient equations in(S) remain
essential. The diagnostic does not assert that an atlas exists.

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

## Start with the full inverse constraint in degree three

Let Dtilde(v) be D with coefficient fifth roots and U replaced by v.
Let Gtilde have top-left block Gammatilde(b), the coefficient fifth root
of the LINEAR map beta^[5] -> Gamma, applied to b. Its other blocks
Xtilde,Ytilde,Ztilde are independent auxiliary variables. Define

    t_i=-Tr(Gtilde partial_i Dtilde).

Then the following is another EXACT finite reduced atlas scheme:

    Dtilde(v) Gtilde=I,       b_i=t_i^[5], i=1,...,32.          (R)

The isomorphism to(1) sends U=v^[5], beta=b and each auxiliary block
to its entrywise fifth power. The inverse equations have degree at most
three and t has degree at most two. No N-incidence equations, extra
normalization, or inverse variables are needed: v.t=2 follows from the
weighted Euler identity. For r=0 this is64 variables and

    Btilde(v)Gammatilde(b)=I_24,
    b_i=(-Tr(Gammatilde(b) partial_i Btilde(v)))^5.

This is the FULL normalized scheme, not an old projective chart with
b_j=s_j=1. Adding only a few inverse equations is not a replacement
for the whole inverse matrix. Lower equation degree is not a runtime
bound; no whole representative is excluded by this reformulation.

## Only three columns are needed, including the exceptional representatives

Under the full inherited Bezout hypotheses, choose a fixed subspace
S subset H0(M) such that S*H0(M)=H0(M²), and let Q be its basis-column
matrix. Introduce only r*dim(S) auxiliary entries Z. Then

    D(U) [Gamma Q; Z] = [Q;0]                            (C)

is SCHEME-THEORETICALLY the entire inverse-cup incidence. It forces
det D invertible, including on every invalid-quotient boundary; Z is
uniquely the indicated part of D^-1. No other inverse columns or
nonvanishing condition need be imposed.

For the fixed curve a single choice works for EVERY oper:

    S=<y,x^10,x^4*y²> subset L32.

Its products span all56 dimensions of L64, by an exact nonzero minor.
These are columns(4,21,23) in the pole-ordered basis. Hence the rooted
version of(C), plus ALL32 original projected-R Frobenius equations,
is the full finite reduced atlas scheme with the following sizes:

    r=0:72 inverse equations +32 R equations in64 variables;
    r=3:81 inverse equations +32 R equations in73 variables.

For r=3 retain ALL9 entries of Z. The inverse equations have degree
at most3. Write n(v,b),s(v,b) for coefficient fifth roots of the ENTIRE
compact N/R tensors; the R equations here are exactly b=s(v,b)^[5].
Weak n equations and a separate normalization are redundant and omitted.
All normal pencil-corank strata remain; R9 is not needed for this test.

The selected-column argument passed a fresh bounded audit: /root/
audit_inverse_column_compression,2026-09-08, PASS. No blocking objections.
[Audit reference](../Research/audits/INVERSE_COLUMN_COMPRESSION_AUDIT_2026_09_08.md).
The twelve acyclic cases also admit a six-section matrix-polynomial
construction of B; the full first-oper coefficient replay is recorded
in the proof. No solver speed or atlas exclusion has yet been established.

Status: earlier mixed-inverse reformulations are author proofs,2026-09-07/08;
the selected-column extension in version5 is independently audited. Uses audited
Bezout, gradient and compact-atlas inputs; the combined reformulation,
mixed inverse-block lemma and minor-patch reduction are not independently
audited. No whole representative, other twist, or common-cover branch
is excluded by this theorem.
[Proof](../Solutions/Sol_inverse_cup_atlas_system.md).
