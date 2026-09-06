# Sharp divisor intersection bounds on elliptic grids

Date: 2026-09-05. Proposed application: `/root`.
General bound and sharpness proof: fresh agent
`/root/elliptic_grid_divisor_bound`; checked and persisted by `/root`.
Status: proved elementary lemma, no priority claim. This note makes
no assertion about existence of particular Raynaud divisor components.

Let E be an elliptic curve over an algebraically closed field of any
characteristic, let S be a finite subset of E(k), and put n=|S| and
G=S times S. The subgroup property is NOT required. Let D be an
effective divisor on E^2. Write

    H_y=E times {y},    V_x={x} times E,
    a=D.H_y,           c=D.V_x.

Relative to the product principal polarization its Hermitian class
is M_D=[[a,b],[b^dagger,c]], with b in End(E). In particular
M_V=diag(1,0), M_H=diag(0,1). These conventions allow arbitrary
endomorphism rings, including quaternionic ones. An algebraic account
is [Katsura--Schuett, Theorem 2.1](https://arxiv.org/pdf/1710.08661).

## 1. Sharp bound with a nonzero off-diagonal class

### Theorem

Assume b is nonzero. Necessarily a,c>=1. If 1<=a,c<=n, then

    |supp(D) intersect G|
       <= n(a+c-1)-ac+min(a,c).                       (1)

For arbitrary positive a,c the bound is

    |supp(D) intersect G|
       <= n^2-(n-min(a,c))_+ (n+1-max(a,c))_+,         (2)

where x_+=max(x,0). Both bounds are sharp for all parameter values.
When max(a,c)>n, (2) is simply the trivial n^2 bound.

### Proof

An effective divisor R with R.H_y=0 consists of horizontal fibers.
Indeed an irreducible component whose projection to the y-coordinate
is nonconstant maps surjectively to E, and that projection's degree
is its positive intersection with H_y. Horizontal fibers have
off-diagonal class zero. The analogous assertion holds vertically.

Let m be the total multiplicity of vertical fiber components of D.
Removing them leaves an effective divisor with degrees (a-m,c) and
unchanged off-diagonal entry b. Therefore a-m>=1, or m<=a-1.
Similarly the total multiplicity of horizontal fibers is <=c-1.

If k of the vertical grid fibers are components, their union contributes
kn points. Each remaining grid fiber has a proper intersection of
degree c with D, so contributes at most c distinct points. Thus

    |supp(D) intersect G| <= kn+(n-k)c,
                    k<=a-1.

When a,c<=n, the right side is increasing in k and gives

    |supp(D) intersect G| <= nc+(a-1)(n-c).

Counting horizontally gives the companion bound

    |supp(D) intersect G| <= na+(c-1)(n-a).

Their minimum is (1). If a<=c<=n it can be rewritten
n^2-(n-a)(n+1-c), and the symmetric expression yields (2).
Outside this range use n^2.

Tangencies and multiplicities cause no problem: every distinct point
of a proper divisor-fiber intersection contributes at least one to
its intersection degree. No separability of a component projection
and no matrix positivity criterion are needed. QED.

### Sharpness

For a,c<=n choose nested subsets R,T of S of sizes a-1,c-1. Then

    D=diagonal + sum_(x in R)V_x + sum_(y in T)H_y

has matrix [[a,-1],[-1,c]]. The covered rows and columns account for
n(a+c-2)-(a-1)(c-1) grid points; the diagonal adds n-max(a-1,c-1)
points. Their sum is exactly (1).

If, for example, a>=n+1, take all n vertical grid fibers, the diagonal,
and enough additional vertical/horizontal fibers to reach (a,c).
This keeps b=-1 and covers every grid point. The other case is symmetric.

## 2. Irreducible curves and a norm refinement

If C is an irreducible curve with positive degrees (a,c), it cannot
be a coordinate fiber. Counting in both directions gives

    |C intersect G| <= min(n^2,na,nc).                 (3)

In particular, a=c=2 gives 2n; nonellipticity is unnecessary here.
For any effective D with a=c=2 and b nonzero, (1) gives 3n-2.
The latter bound is attained by the diagonal and the two coordinate
fibers through one chosen grid point.

If additionally deg(b)>=2, the 3n-2 bound improves to 2n. Otherwise
exceeding 2n would force a grid fiber component in both directions,
by the elementary counts above. Removing these leaves an effective
divisor of class [[1,b],[b^dagger,1]]. Its self-intersection is
2(1-deg b)<0, impossible for an effective divisor on an abelian
surface. Such divisors are nef and have nonnegative self-intersection.
The Hermitian intersection identity is valid in the quaternionic case
as well; b^dagger b=[deg b].

## 3. A factor-covering obstruction independent of the grid labeling

Let C have degrees (2,2) and be irreducible, and let D have degrees
(2,2) with nonzero off-diagonal entry. For any bijection u:G -> G,

    |u^(-1)(C intersect G) union (supp(D) intersect G)|
                         <= 5n-2.

For n>=5 this is strictly less than n^2-1. Hence the two sets cannot
cover all grid points except one, even after a different bijective
parameterization of one factor. At least n^2-5n+1 nonexceptional grid
points remain uncovered.

More generally, sums of the bounds (1)--(3) apply to any finite list
of divisor zero sets under arbitrary grid bijections. This is useful
only when geometry supplies both the numerical classes and the
mandatory points; the counting lemma itself supplies neither.

The [ordinary cyclic-triple application](../../Theorems/Thm_ordinary_cyclic_triple_finite_bad_cosets.md)
uses the five-torsion grid and a polarization isogeny that permutes
it. Its separate proof verifies those geometric inputs. This general
lemma is not a claim of arbitrary-degree common-cover nonexistence.
