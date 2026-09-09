# Full normalized atlas charts as Frobenius-sparse linear systems

2026-09-09. Algebraic reformulation of the audited compact system, not a
successful computation. Applies to ALL oper representatives and coefficient
fields; no finite-field constraint on geometric unknowns is imposed.

Write n=32, N(U,b^[5]) and R(U,b^[5]) for the ORIGINAL compact tensors.
Both are linear in U and in the displayed fifth powers. The exact system is

    N(U,b^[5])=0, R(U,b^[5])=b, U.b=2.                  (A)

On the projective chart with first nonzero b coordinate j, put b_i=0 for
i<j and b_j=1. Introduce two scalars lambda,z and impose

    N(U,b^[5])=0,                                      64 rows
    R(U,b^[5])=lambda b,                               32 rows
    U.b=2,                                             1 row
    lambda z=1.                                        1 row              (P)

For fixed b,z these are LINEAR equations in the33 unknowns (U,lambda).
All coefficient monomials belong to {1,b_i,b_i^5,z}; the right side has
only the two constants2,1. Thus the full condition, including normalization
and all Frobenius equations, is a sparse linear system over the polynomial
ring in the remaining b coordinates and z. This is not the old weak
coefficient-rooted pencil. Do not replace b_i^5 by independent variables.

## Exact equivalence

Given a point (U0,b0) of(A) with first nonzero coordinate c=b0_j, set

    b=b0/c, U=c U0, lambda=c^-3, z=c^3.

Bilinearity gives R(U,b^[5])=c^-4 b0=lambda b; all other equations follow.
Conversely, given(P), choose c with c^3=lambda^-1=z, possible since
lambda z=1. Set U0=U/c and b0=c b. Then

    R(U0,b0^[5])=c^4 lambda b=c b=b0,
    U0.b0=2,

and N remains zero. Thus(A) has a geometric point exactly when one of
the32 systems(P) does. No quotient boundary or infinity condition has
been discarded: the compact criterion already includes them.

Scheme-theoretically, adjoining c with c^3=z gives the corresponding open
chart of(A). It is a degree-three finite etale cover because c is a unit
and3 is invertible. Equivalently(P) is the quotient by the free scaling
(U0,b0)->(epsilon^-1 U0,epsilon b0), epsilon^3=1. It is therefore finite
and reduced, possibly empty, by the audited compact-system theorem.

## Why the nonzero scalar is essential

One cannot set both b_j=1 and R(U,b^[5])=b while retaining the number2
in U.b without restricting actual solutions. The scalar lambda corrects
exactly that error, and lambda z=1 must not be dropped without a proof.

The weak-system points in atlas_weak_points.json have U.b=0. In particular
orbit0 chart4 satisfies all N/R and is nevertheless NOT an atlas. It does
not satisfy(P); it cannot invalidate this reformulation.

## Measured boundary of the simplest multiplier search

On orbit_0000/chart23 the degree-one, linear-group-free multiplier matrix
has980rows,3017actual-support columns and265640terms. Native search
finished0.046s with an exact bounded dual, not an atlas decision.
Temporary reproducible prototype: /tmp/litt3-normalized-pencil-Ywe9OC.

There is a stronger explanation, so do NOT run degrees2,3,4 unchanged.
Write A_i for the32-by96 coefficient matrix of U*b_i^5 in the first96
rows. The stacked map c -> (A_i c)_(i>j) is injective if its rank is96.
Exact F25 elimination gives rank96 for i=24,...,31 on orbit_0000.
Consequently it is also injective on EVERY earlier chart j<=23.

Under this injectivity, no unit certificate with multipliers independent
of(U,lambda) and of total(b-tail,z)-degree<=4 can exist. Here is a proof.
Let f_1,...,f_96,g,h be the multipliers for the tensor, normalization and
inverse rows. In the U-coefficients, a monomial b_i^5*m with deg(m)>0
cannot collide with b_k^5*m' for k!=i and deg(m),deg(m')<=4, or with
the terms of degree<=5 from g*U.b. Comparing degrees from largest down
therefore kills every positive-degree part of f by injectivity. (At
degree6 through9 only the high Frobenius terms occur.) Thus f is constant.
Now the coefficient of U_j, for which b_j=1, forces every positive-degree
part of g to vanish: its degree is<=4, whereas the remaining tensor
terms have degree0 or5. Hence g is constant. Comparing the degree-five
U terms makes f=0 by injectivity; then the U_j coefficient makes g=0.
The lambda coefficient is h*z=0, so h=0, contradicting the required
constant identity -2g-h=1.

The injectivity is an exact small-matrix diagnostic, not a claim about
the rank of A(b^5) at every geometric point. The bound concerns ONLY
this multiplier ansatz. It neither proves an atlas nor excludes one.

## The complete degree-five multiplier space is much smaller

Under the same coefficient-stack injectivity, every unit certificate in
the above ansatz of total multiplier degree<=5 has ALL its multipliers in

    span{1, b_i, z, b_i^5 : i>j}.

Indeed, in the first96 multipliers f, a degree2,3,4 monomial gives a
unique high term of degree7,8,9. A degree5 monomial gives a term of
degree10: terms from two different b_i^5 can coincide only if the
multiplier is itself a pure b_k^5. The other degree5 terms therefore
vanish by the coefficient-stack injectivity. The normalization row
has degree at most6 and cannot affect these comparisons. This leaves
only constant, linear, and pure fifth-power terms in f. Comparing the
U_j coefficient then restricts g to the same monomials. The constant
identity -2g-h=1 does the same for h.

For chart23 this is18 monomials, rather than2002. The resulting
1764-by4257 matrix with478152 terms returned an independently replayed
bounded dual in0.111s. Thus the COMPLETE degree<=5 version of this
particular ansatz is insufficient. This says nothing about atlas
existence. A degree6 enlargement (one Frobenius factor times degree<=2)
gave13230-by28515 and a native-checked dual in3.168s; completeness of
that enlarged ansatz was NOT established, and its dual has not had a
separate replay. Do not promote it beyond that observation.

## Previously solved charts already give higher-degree certificates

This prevents another uninformative rediscovery. Suppose an old rooted
weak certificate proves s_j= sum f_i n_i + sum g_i s_i, where the second
sum uses indices i<j. Fifth powers give the ORIGINAL tensor identity

    R_j = sum f_i^5 N_i + sum g_i^5 R_i.

On the normalized chart b_i=0 for i<j and b_j=1, multiply by z and
subtract z(R_j-lambda) and (lambda*z-1). This gives the unit identity

    1 = sum z f_i^5 N_i + sum z g_i^5(R_i-lambda*b_i)
        -z(R_j-lambda) -(lambda*z-1).

All these multipliers are independent of(U,lambda). A rooted weak
certificate of degree4 therefore supplies a full normalized certificate
of degree<=21, with sparse Frobenius monomials. Consequently the small
failed tests are consistent with the known chart23 exclusion. This
conversion is not a bound for previously unsolved charts.

## Next computational boundary

Direct coefficient-table export and actual-support counting now work.
The first tested matrix is connected, so support-component pruning does
not help it. Only pursue this formulation with a stronger multiplier
design or another elimination mechanism; the preceding bound prevents
a series of uninformative low-degree runs. Do not replace production
with this prototype on current evidence.

An ansatz using multipliers independent of U,lambda is a sufficient
certificate search, NOT known complete even if the chart is empty.
Allowing higher linear-group multiplier degree may still be necessary.
This note claims no runtime bound, no chart exclusion, and no solution.
