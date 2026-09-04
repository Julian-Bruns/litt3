# Profile-4 high-point reductions

Status: `proved-text`. These reductions do not prove profile-4
nonexistence; they only classify the high-point branches that still require
work.

Work over `k = \bar F_5`. Let `(C,x,r)` be a profile-4 pair with high points
`P_i=P_i(x)`, `Q_j=P_j(r)`, common reduced boundary `U`, and incidence matrix

```text
M =
[[0,1,3],
 [1,2,1],
 [3,1,0]]
```

where the labels are `0,1,infty`.

Explicitly, both maps are separable of degree `35`, have no ramification away
from `0,1,infty`, and have fibers `31P_i+E_i` and `31Q_j+F_j`, where every
`E_i,F_j` is reduced of degree `4`. The two boundary sums equal `U`, and
`g(C)=11` by Riemann--Hurwitz.

The three `P_i` are mutually distinct, as are the three `Q_j`. Write
`U_{a,b}=E_a cap F_b`; these atoms are reduced and have degrees `M_{a,b}`.
The equality of the two boundary sums also makes `U` disjoint from all six
high points.
For the nonempty atoms, use

```text
A=U_{0,1}, B=U_{0,infty}, C=U_{1,0}, D=U_{1,1},
E=U_{1,infty}, F=U_{infty,0}, G=U_{infty,1}.
```

Their degrees are respectively `1,3,1,2,1,3,1`.

## Logarithmic quotients

For one profile map `h`, put

```text
Omega_0(h)     = dh/(h-1),
Omega_1(h)     = dh/h,
Omega_infty(h) = dh/(h(h-1)).
```

If `{a,b,c}={0,1,infty}`, with the evident interpretation at infinity, then

```text
div Omega_c(h)
  = 30 P_c(h) - P_a(h) - P_b(h) - E_a(h) - E_b(h).       (1)
```

Indeed, at `P_0`, `P_1`, and `P_infty`, respectively, use the target
coordinates `h`, `h-1`, and `1/h`. The displayed form for the matching label
is a unit times the differential of that coordinate, hence has order `30`.
At either other high point it is a unit times `dt/t`, hence has a simple pole.
The same local calculation gives a simple pole at the corresponding
unramified boundary points and no other zero or pole. Both sides of (1) have
degree `20=2g(C)-2`.

At an unramified boundary point of label `l`, the residue is

```text
              l=0   l=1   l=infty
Omega_0        0      1      -1
Omega_1        1      0      -1
Omega_infty   -1      1       0.
```

Suppose `Q_j=P_i`, and set

```text
Y_{i,j}=Omega_j(r)/Omega_i(x).
```

If `{a,b,i}={0,1,infty}` and `{c,d,j}={0,1,infty}`, (1) gives the equality of
divisors

```text
div Y_{i,j}=(P_a+P_b+F_j)-(Q_c+Q_d+E_i).                 (2)
```

Consequently

```text
deg(Y_{i,j}) <= 2 + deg(F_j-E_i)_+ = 6-M_{i,j}.          (3)
```

Here `deg(Y)` means the degree of the induced map, with degree `0` for a
constant. With no other high-point coincidence, equality holds in (3).
Further coincidences can only cancel a positive `P`-term against a negative
`Q`-term in (2), so they can only lower the degree.

At `U_{a,b}` with `a!=i` and `b!=j`, numerator and denominator have simple
poles. Their residue quotient therefore fixes the value of `Y_{i,j}` at
every point of that atom. Counting the reduced atoms gives

```text
coincidence       M_ij   deg(Y) <=   forced finite fibers
Q0=P0               0        6      Y= 1: 2,  Y=-1: 2
Q1=P0               1        5      Y= 1: 1,  Y=-1: 4
Qinfty=P0           3        3      Y= 1: 5,  Y=-1: 2

Q0=P1               1        5      Y= 1: 1,  Y=-1: 4
Q1=P1               2        4      Y=-1: 6
Qinfty=P1           1        5      Y= 1: 4,  Y=-1: 1

Q0=Pinfty           3        3      Y= 1: 5,  Y=-1: 2
Q1=Pinfty           1        5      Y= 1: 4,  Y=-1: 1
Qinfty=Pinfty       0        6      Y= 1: 2,  Y=-1: 2.
```

For a nonconstant degree-`d` function, a finite fiber has degree `d`. The two
entry-3 rows in the table contain two different forced values, so their
quotients are nonconstant. In the middle cell `Q1=P1`, (2) simplifies to

```text
div Y=P0+Pinfty+A+G-Q0-Qinfty-C-E,
```

even after the common atom `D=U_{1,1}` is cancelled. The atom terms cannot
cancel against high points or against one another, so this quotient is also
nonconstant. The fiber counts therefore prove that

```text
Qinfty=P0,   Q1=P1,   Q0=Pinfty                           (4)
```

are impossible.

## Symmetry of the two entry-zero cells

Simultaneous inversion

```text
x' = 1/x,   r' = 1/r
```

interchanges the labels `0` and `infty` for both maps and fixes label `1`.
For example,

```text
div(x')   =31Pinfty+E_infty-31P0-E_0,
div(x'-1)=31P1+E_1-31P0-E_0.
```

The matrix `M` is unchanged by simultaneously interchanging its `0` and
`infty` rows and columns. Thus `Qinfty=Pinfty` is equivalent to `Q0=P0`.

## The paired entry-zero case

**Proposition.** A profile-4 pair cannot satisfy both

```text
Q0=P0,   Qinfty=Pinfty.                                  (5)
```

**Proof.** The excluded middle cell in (4) gives `Q1!=P1`. Under (5) this also
shows that there are no further high-point coincidences: `Q1` is distinct
from `Q0,Qinfty`, hence from `P0,Pinfty`, and its only remaining possible
equality with a `P`-point would be `P1`.

Set

```text
u=Omega_0(r)/Omega_0(x),
v=Omega_infty(r)/Omega_infty(x).
```

Using (2) and cancelling common atoms gives

```text
div(u)=P1+C+F-Q1-A-B,
div(v)=P1+B+E-Q1-F-G.                                    (6)
```

Thus `deg(u)=deg(v)=5`. Let `Gamma` be the integral image of `(u,v)` in
`P1 x P1`, and put `n=[k(C):k(u,v)]`. Each coordinate degree is `5`, so `n`
divides `5` and `Gamma` has bidegree `(5/n,5/n)`.

If `n=5`, then `Gamma` has bidegree `(1,1)` and is the graph `v=T(u)` of a
linear fractional transformation. Formula (6) gives `(u,v)=(0,0)` at `P1`
and `(infty,infty)` at `Q1`. At either of the two points of the reduced atom
`D=U_{1,1}`, the residue table gives `(u,v)=(1,1)`. Hence `T` fixes
`0,1,infty`, so `T` is the identity. But every point of the nonempty atom
`B=U_{0,infty}` maps to `(infty,0)`, a contradiction.

It follows that `n=1`; hence `C` is the normalization of an integral
bidegree-`(5,5)` curve `Gamma`. The reduced atoms `B`, `F`, and `D`, of
degrees `3,3,2`, map respectively to the three distinct image points

```text
(infty,0),   (0,infty),   (1,1).
```

Because the normalization is birational, their distinct points give
respectively `3,3,2` distinct branches of `Gamma`. A reduced curve
singularity with `m` distinct branches has delta invariant at least
`binom(m,2)`. These three points therefore contribute at least

```text
binom(3,2)+binom(3,2)+binom(2,2)=7.
```

The arithmetic genus of an integral bidegree-`(5,5)` curve in `P1 x P1` is
`(5-1)(5-1)=16`. Thus the genus of its normalization is at most `16-7=9`,
contrary to `g(C)=11`. This proves the proposition.

## What remains

The only individual high-point cells not excluded above are

```text
entry 0: Q0=P0, Qinfty=Pinfty (equivalent by inversion);
entry 1: Q1=P0, Q0=P1, Qinfty=P1, Q1=Pinfty;
and the branch with no high-point coincidence.
```

The four entry-one cells form one orbit under transposition (interchanging
`x,r`) and simultaneous `0`/`infty` reversal, so `Q1=P0` is a valid
representative. If `Q0=P0` occurs and there is no entry-one coincidence,
then (4), distinctness within each high-point triple, and the paired-case
proposition show that it is the only coincidence. This is the precise input
used by the double-fiber route.

## Further coincidences in the entry-one representative

Suppose `Q1=P0`. Since the `P`-points and the `Q`-points are each mutually
distinct, no other `Q`-point can equal `P0`, and `Q1` cannot equal another
`P`-point. The exclusions (4) also rule out `Q0=Pinfty`. Consequently the
only possible additional coincidences are

```text
Q0=P1,   Qinfty=P1,   Qinfty=Pinfty.                     (7)
```

The first two cannot coexist because `Q0!=Qinfty`; the last two cannot
coexist because `P1!=Pinfty`. Hence the only compatible pair in (7) is

```text
Q0=P1,   Qinfty=Pinfty.                                  (8)
```

For this representative, (2) gives

```text
div(Y_{0,1})=P1+Pinfty+D+G-Q0-Qinfty-B.                  (9)
```

With no additional coincidence, its degree is `5`. Each equality in (7)
cancels exactly one positive high-point term with one negative high-point
term in (9), while the atom divisors are disjoint from all high points.
Thus one additional coincidence gives degree `4`, and the pair (8) gives
degree `3`. These possibilities are classified here, not excluded; they
remain part of the entry-one task.

In all of these strata, the two functions `x` and `Y_{0,1}` generate
`k(C)`. For degrees `4` and `3`, the intermediate degree

```text
[k(C):k(x,Y_{0,1})]
```

divides both `35` and `deg(Y_{0,1})`, so it is `1`. In the degree-`5`
case, the only other possibility is intermediate degree `5`. That would
give the tower

```text
k(x) subset k(Y_{0,1})=k(x,Y_{0,1}) subset k(C)
```

with successive degrees `7` and `5`. The ramification index `31` of `x` at
any `P_i` would then be a product of local ramification indices at most `7`
and `5`. Since `31` is prime, that is impossible. Hence the intermediate
degree is again `1`.

In particular, in the no-further-coincidence case `C` is the normalization
of its integral bidegree-`(5,35)` image under `(x,Y_{0,1})`, where the two
entries record the degrees in the `x`- and `Y_{0,1}`-variables.
