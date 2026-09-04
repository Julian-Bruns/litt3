# No-highpoint residual gate

Status: mixed `proved-text` / `open`. This file verifies the elementary
boundary identities of the proposed family and states the missing bridge and
elimination problems. It does not prove that every no-highpoint pair enters
the family, and it does not prove that the family is empty.

Work over `k=\bar F_5`. The low-degree quotient in
`../162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md` requires a high-point
coincidence, so it does not address the branch in which all six high points
are distinct.

## The proposed family

Let

```text
P(X,R)=R^4*X^4-R^4*X^3-R^3*X^4
       +2*R^3*X-2*R^2*X
       +2*R*X^3-2*R*X^2+R+X-1,

L=4*X*R+4*X+4*R+2,
D=X*(X-1)*R*(R-1).
```

The line `L=0` is the graph

```text
R=(4*X+2)/(X+1),
```

which sends `X=0,1,infty` to `R=2,3,4`. For a polynomial

```text
A(X,R)=sum a_ij*X^i*R^j,   0<=i,j<=32,
```

set

```text
H_A=L^31*P-D*A.                                            (1)
```

After bihomogenization, (1) has bidegree `(35,35)`. The six boundary
restrictions of its residual factor can be checked directly:

```text
P(0,R)       =R-1,             P(1,R)=R*(R-1)^2,
[X^4]P       =R^3*(R-1),

P(X,0)       =X-1,             P(X,1)=X*(X-1)^2,
[R^4]P       =X^3*(X-1).
```

Interpreting missing affine degree as multiplicity at infinity, these are
exactly the rows and columns of

```text
[[0,1,3],
 [1,2,1],
 [3,1,0]].
```

The term `D*A` vanishes on the four affine boundary lines. Its bihomogeneous
degree is at most `(34,34)`, so it also vanishes on the two boundary lines at
infinity after homogenization to `(35,35)`. Thus every member of (1) has the
same six scheme-theoretic boundary restrictions as `L^31*P`.

There are two necessary corner coefficient conditions. At
`(X,R)=(0,infty)`, put `w=1/R` and multiply (1) by `w^35`. If `a_0,32` is the
coefficient of `R^32` in `A(0,R)`, the degree-two term is

```text
(a_0,32+3)*X*w.
```

Hence multiplicity at least three forces `a_0,32=2`. By the `X,R` symmetry,
the other corner gives `a_32,0=2`. These two equations ensure only the stated
plane multiplicities; they do not by themselves prove that the normalization
has three distinct branches with the required contacts.

The remaining graph-branch opens, residual branch partitions, integrality,
and normalization genus conditions must all be imposed separately.

## Missing residual extraction

No retained proof shows that an arbitrary no-highpoint profile-4 pair can be
normalized so that its three order-31 branches lie on this particular graph,
its residual boundary polynomial is `P`, and the difference of its equation
from `L^31*P` is divisible by `D` with quotient of bidegree at most `(32,32)`.

This is a substantive restriction. The chosen graph fixes

```text
r(P0),r(P1),r(Pinfty)=2,3,4,
x(Q0),x(Q1),x(Qinfty)=2,3,4,
```

in the displayed ordering. Once the branch values `0,1,infty` are fixed, the
remaining target automorphisms form only `S_3`; they cannot in general move
an arbitrary triple of cross-values to `2,3,4`. Any claim that these values
are forced needs a proof from the profile equations.

That residual-extraction statement is an open theorem, not a choice of
coordinates that may presently be made without proof.

## Ramification must be tested on the normalization

Suppose a particular `H_A` is geometrically integral, let `Gamma_A` be its
projective curve, and let

```text
nu:C_A -> Gamma_A
```

be the normalization. If the two coordinate functions on `C_A` are
separable profile maps of degree `35` and `g(C_A)=11`, Riemann--Hurwitz gives
total ramification degree

```text
2*11-2+2*35=90
```

for either projection. The three index-31 boundary points already contribute
`3*(31-1)=90`. Therefore the **maps on the normalization** can have no other
ramification.

Plane partial derivatives detect this condition only at smooth image points.
In characteristic `5`, write

```text
Phi=L^5*L^25=L^30,   F=L*P,
```

so `H_A=Phi*F-D*A` and both partial derivatives of `Phi` vanish. On the
affine open `D*F!=0`, the equation `H_A=0` gives

```text
partial_R(H_A)=-N_R/F,
partial_X(H_A)=-N_X/F,                                    (2)
```

where

```text
N_R=F*partial_R(D*A)-D*A*partial_R(F),
N_X=F*partial_X(D*A)-D*A*partial_X(F).                    (3)
```

At a smooth point of `Gamma_A`, the `X`-projection ramifies exactly when
`partial_R(H_A)=0`, and the `R`-projection ramifies exactly when
`partial_X(H_A)=0`. Thus (2)--(3) correctly test smooth interior
ramification on this open.

At a singular image point, however, both plane partial derivatives vanish
even when every branch of the normalization is unramified. An ordinary node
is the simplest example. Consequently the requirement that

```text
H_A=N_R=0   or   H_A=N_X=0
```

have no interior solution is a useful **sufficient, stronger condition**, but
it is not a necessary condition for a valid profile pair. A necessary
smooth-locus condition on `D*F!=0` is only

```text
V(H_A,N_R) subset V(partial_X H_A),
V(H_A,N_X) subset V(partial_R H_A).                       (4)
```

Points in the right sides of (4) are singular and must then be checked branch
by branch on the normalization. Points with `F=0`, the other affine/projective
charts, and the boundary also require direct partial-derivative or local
normalization analysis because (2) was obtained by dividing by `F`.

In particular, (3) are equations defining candidate ramification loci; a
valid curve is not supposed to satisfy `N_R=N_X=0` identically.

## Status of the reported finite searches

Missing notes `52`, `60`, and `62` reportedly tested constant, sparse, and
symmetric low-parameter choices of `A`. Their scripts and certificates are
not in this repository, so those claims are not independently reproducible
here and do not classify the 1089-parameter coefficient space.

There is a second logical limitation. The recorded resultant shape

```text
Res_R(H_A,partial_R H_A)=X^36*(X-1)^32*Q(X)
```

with nonconstant `Q` shows at most that the plane equation and its partial
derivative have a common point, after projective/leading-coefficient artifacts
are excluded. Such a point can be a singularity of the plane image rather
than a ramification point of its normalization. A candidate is eliminated
only after one exhibits a smooth interior common point or analyzes the
branches over a singular common point and finds ramification. No such checks
are retained here. Accordingly, the reported small-family searches are
evidence or task-granted facts, not active proofs of exclusion.

## Honest ways to close the branch

Any one of the following would be meaningful progress:

```text
R1. Residual extraction:
    prove that every no-highpoint profile-4 pair produces (1), including all
    branch and open conditions.

R2. Normalization-aware residual elimination:
    prove that no A yields an integral curve whose normalization has genus 11,
    the required boundary profiles, and intrinsically unramified interiors
    for both projections.

R3. Residual construction:
    produce an A and verify those same conditions on the normalization.

R4. Nonresidual obstruction:
    exclude no-highpoint pairs without using (1).
```

At present neither `R1` nor `R2` is proved.
