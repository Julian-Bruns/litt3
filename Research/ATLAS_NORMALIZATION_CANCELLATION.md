# Normalization identities: one restricted success and the global boundaries

## Sept9: exact boundary support and a negative inverse-span test

For the three saved orbit_0000 weak points (charts0,1,4), exact arithmetic
in F25[x,y] gives

    (y^3-F, U, delta U) = (y^3-F, x^20).

Each U has pole112 at O. Since F(0)!=0 and the horizontal scalar
realization is a Frobenius pullback, the descended section has zero divisor
four times the reduced three-point fiber over x=0, of degree12. The affine
quotient above has length60. Groebner calculations took0.015--0.036s per
point after startup. This identifies these saved false points; it does NOT
classify all weak points or exclude an additional atlas. A proposed local
classification of all boundary fixed points still lacks control of global
coboundaries. Do not send that as a Pro target without a demonstrated
algorithmic benefit: the full inverse equations already remove the boundary.

The528 coefficient matrices of the first oper's quadratic Bezout matrix
span the entire300-dimensional symmetric24-square matrix space (in the
Serre-compatible bases). Thus there are no extra constant linear equations
on B beyond symmetry. The rank calculation took0.147s after startup.
Three sampled U had rank(B)=24 and rank(dB)=32; those samples are NOT a
global smoothness statement. No speedup follows from either diagnostic.
Temporary scripts: /tmp/litt3-inverse-linear-span-p3YHq1; no extra large
artifact was added to the repository.

The full72 selected-column cubic coefficient rows have rank72 as well.
The original hash-bound loader built their72-by16897 coefficient matrix
in0.61s and finished the rank test at0.64s. Thus none of these72 equations
can be removed by a CONSTANT linear combination of the others. This says
nothing about polynomial syzygies, local generators, or different
presentations. Temporary script cubic_rank.sage in the same directory.

## Two further bounded tests, neither a new computational advance

2026-09-09. Trailing flags beta_0=...=beta_(j-1)=0 were tested for a
constant identity U.R=sum L_ar U_a T_r, allowing T=[N;R_0,...,R_(j-1)].
The j=16,23,24 systems are inconsistent. The j=27 system has an identity
whose2640 original coefficient conditions all replay, in0.683s; that
tail lies in the previously easy region, so no new useful exclusion is
claimed. Temporary prototype /tmp/litt3-normalized-flag-DwBlpV. Do not
treat this diagnostic as a new independently exported certificate.

An all-row homogeneous-pencil subspace relaxation also failed completely.
For (M0+sum b_i Mi)w=0 start S=k^33 and iterate
S <- {w in S: M0w in sum Mi S}. On charts0,8,16,21,22,23,27,28 the
tail images already fill the target, so the first step leaves S=k^33.
All eight exact tests took0.493s after Sage startup, production paused
and resumed. Prototype /tmp/litt3-pencil-subspaces-CluUX9. This relaxation
forgets the common commuting parameters; no point or exclusion follows.

## Complete first syzygies add no lower equations

2026-09-09 11:16, original orbit0 tensor T=[N;R]. All constant-coefficient
syzygies with multipliers linear in U were computed from16896 coefficient
conditions on3072 unknowns: rank3063, dimension9. Each of the nine uses
ONLY N rows, so replacing R by R-beta gives no new quadratic constraint.
All nine were replayed against every original coefficient condition.
The analogous linear-in-beta^5 test has rank3072 and zero kernel.
One-core native runtimes12.70s and14.92s, with production paused/resumed.
These tests exclude only their stated multiplier forms, not all syzygies
or all low-degree consequences. No atlas exclusion follows. Failed
prototype kept out of the repository, /tmp/litt3-first-syzygies-K0d7OZ.

## Exact exclusion of a whole beta subspace

2026-09-09, orbit_0000. Write the ORIGINAL compact tensors N(U,beta^5),
R(U,beta^5), with normalization U.beta=2. An explicit32-by64 constant
matrix L gives the polynomial identity

    U.R(U,beta^5) = sum_(a,r) L[a,r] U_a N_r(U,beta^5)

whenever beta_12=...=beta_31=0. Consequently N=0 and R=beta would
force U.beta=0, contradicting the normalization. Thus this entire
12-dimensional affine beta subspace (projectively P11) is excluded,
not merely its coordinate points or F25-rational points.

The2048-byte coefficient matrix and original tensor hash are in
computations/atlas_normalization_subspace.json. Independent stdlib replay:

    python3 scripts/verify_atlas_normalization_subspace.py

It checks all6336 quadratic-in-U, linear-in-beta^5 coefficient identities
against the original tensor, not the search matrix. Discovery took1.082s
in a temporary native program at /tmp/litt3-normalization-identity-HlpkXz.
The same global constant-L ansatz is inconsistent when coordinate12 is
added (native diagnostic; not needed for the positive certificate).

Uniform mechanism: find a coefficient subspace S on which this identity
holds. Every normalized solution must have beta^[5] outside S. For the
coordinate subspace here beta and beta^[5] have the same support. This is
an exact additional saturation condition, not a whole-representative
exclusion or a claim that it improves the current weak-chart queue.
No generalization to the other17 representatives has been verified.

## The seven weak points lie in entire invalid affine families

The original-tensor checker now also certifies the full fixed-b fibers,
not merely the seven saved points. In the rooted coordinates write
n_b v=N^[1/5](v,b), s_b v=R^[1/5](v,b). At fixed b the reduced weak
fixed-point fiber is the affine linear system

    n_b v=0, s_b v=b^[1/5].

The saved point proves consistency. Exact ranks give:

| Representative / charts | rank n_b | rank [n_b;s_b] | affine dimension |
| --- | ---: | ---: | ---: |
| orbit_0000 / 0,1,4 | 24 | 30 | 2 |
| invariant_0 / 0,2 | 23 | 27 | 5 |
| invariant_1 / 0,2 | 23 | 27 | 5 |

In every case ell=b^[1/5] lies in the ROW space of n_b. Therefore
v.ell=0 on the entire n_b kernel, and U.b=(v.ell)^5=0, contradicting
the required value2. These are complete affine-family exclusions at the
specified b, over the algebraic closure, not just finite-field samples.
They do NOT exclude all varying b in any of the seven projective charts.

There is also a useful scheme warning. If one keeps the equations
b=(s_b v)^5 instead of replacing them by their reduced equations, this
fixed-b rooted weak fiber is

    A^(32-rank[n_b;s_b]) x Spec k[e_1,...,e_c]/(e_1^5,...,e_c^5),
    c=rank[n_b;s_b]-rank(n_b).

Indeed translate by the saved point, use the independent n_b rows as
linear coordinates, and then use the c independent residual s_b rows.
Here c=6 or4. This thickness belongs to the WEAK ROOTED scheme; it is
not multiplicity in the finite reduced actual-atlas scheme. No weak
unit certificate exists on these charts at any degree. Their runtime
skips were already deployed; the new ranks explain the obstruction but
do not supply additional chart exclusions.

Reproduce all ranks, consistency, and row-space tests with
`python3 scripts/verify_atlas_weak_points.py`; the test uses the original
hash-bound tensors and takes less than a second. No search algorithm or
extra large data file is needed.

## Earlier b-linear cancellation test

For the first oper in the cached genus-nine atlas tensor, the ansatz

\[
 \sum_{i,r}\lambda_{i,r}b_iT_r(U,b^5)
   +\left(\sum_jh_jb_j^5\right)(U\cdot b)=0,
 \qquad T=[N;R],
\]

has only the zero coefficient solution. This includes the normalization
term omitted by the earlier U-linear multiplier test.

Flatten the coefficient rows of T into a 96 by 1024 matrix, with column
32k+j corresponding to U_k b_j^5. Its rank is 96. Since the monomials
b_i b_j^5 are distinct for ordered pairs (i,j), the displayed identity is
equivalent to e_i tensor h lying in its row span for each i, with the
negative of that row representation giving lambda_i.

The saved certificate gives 32 vectors w annihilating all original tensor
rows. For each saved index i, their restrictions w[32i:32i+32] impose a
linear equation on h. The resulting 32 by 32 matrix has determinant
2a+2 in F5[a]/(a^2+4a+2). Thus h=0, and tensor row independence then gives
lambda=0. These assertions remain true after extending the coefficient
field. All annihilator identities were checked against the original
tensor, and the certificate stores the original source SHA256.

Substituting the original generators N, R-b, U.b-2 into a hypothetical
identity of this form would give the degree-at-most-five consequence

\[
 -\sum_{i,j}\lambda_{i,64+j}b_i b_j-2\sum_j h_jb_j^5.
\]

The test therefore produces no nonzero consequence. It does not exclude
other multiplier forms, all consequences of degree at most five, any
atlas solution, or any whole oper. No Groebner basis was computed.

Reproduce with `sage scripts/atlas_normalization_cancellation.sage`.
The complete rank certificate is in
`computations/atlas_normalization_cancellation.json`; runtime was about
0.47 seconds with peak process RSS about 279 MB.
