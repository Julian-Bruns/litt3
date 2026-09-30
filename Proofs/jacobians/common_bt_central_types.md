# Proof: rational orbit invariants and closed central types

[Statement](../../Theorems/jacobians/common_bt_central_types.md).
We use the actual two pullbacks throughout. The first argument
needs only the intersection of the two specified function fields;
the assertion about the exceptional set also uses clump uniqueness.

## 1. A common finite tensor structure has constant generic orbit

We first prove a useful algebraic lemma. Let $G$ be a connected
linear algebraic group over $k$, acting on a variety $V$. Suppose
there are rational maps $u_X:X\dashrightarrow V$ and
$u_Y:Y\dashrightarrow V$ whose values become $G$-conjugate over
$k(Z)$, and suppose $k(X)\cap k(Y)=k$ in that field.
Then their geometric generic values lie in one orbit defined over $k$.

Let $W$ be the reduced closure of $G\cdot u_X(X)$.
It is irreducible, because it is the closure of the image of
$G\times X$. The generic conjugacy shows that it is also the
closure of $G\cdot u_Y(Y)$. Rosenlicht's theorem gives a
nonempty invariant open $W^\circ$ and a rational orbit quotient
$q:W^\circ\to T$ with geometric fibers equal to orbits.
We may take $k(T)=k(W)^G$. The arbitrary-characteristic statement,
including the purely inseparable issue and its removal, is
[Bell--Ghioca--Reichstein, Theorem1.1 and its proof in Section7](https://arxiv.org/pdf/1408.4744).

Both generic maps meet $W^\circ$: otherwise the invariant closure
of their images would lie in its closed complement.
Moreover $q\circ u_X$ and $q\circ u_Y$ are dominant, since their
$G$-saturations are dense in $W$ and $q$ is invariant. They give
embeddings of $k(T)$ in $k(X)$ and $k(Y)$ which agree in $k(Z)$.
Consequently $k(T)\subseteq k(X)\cap k(Y)=k$, and $T$ is a point.
Thus $W^\circ$ is a single geometric orbit. It has a $k$-point
because $k$ is algebraically closed. This proves the lemma.

Apply it to Hopf algebras of a fixed finite rank $s$. After
trivializing the coordinate vector bundle on a dense open of each
endpoint, multiplication, unit, comultiplication, counit and antipode
are a finite collection of structure coefficients. The Hopf axioms
are polynomial equations, so these coefficients lie in an affine
scheme of finite type. Change of basis gives the action of
$\mathrm{GL}_s$ on its reduced underlying variety. An isomorphism
of the actual group schemes supplies precisely the generic
change of basis over $k(Z)$.

The lemma therefore provides one finite Hopf algebra over $k$
whose geometric isomorphism type is that of both generic fibers.
Denote its group scheme by $B_0$.
This argument does not presume a separated coarse moduli space
for finite group schemes.

## 2. Only one exceptional type is possible

For finite locally free group schemes, the isomorphism functor
is represented by a scheme of finite type: write a matrix for
the map, invert its determinant, and impose the Hopf identities.
The locus of geometric fibers isomorphic to $B_0$ is therefore
constructible. Since it contains the generic point of each curve,
it contains a dense open. Its complement on each projective
curve is a finite set.

The specified isomorphism on $Z$ identifies the two pullbacks of
these finite exceptional sets. If nonempty, their common pullback
is a clump. The same holds for the subset of any single exceptional
geometric fiber type. By
[clump uniqueness](../shared_tensors/matched_section_rings.md),
there cannot be two disjoint nonempty such subsets.
Hence every exceptional fiber has the same type $B_1$.

This proves the finite-group assertions in every characteristic.
It separates fiberwise constancy from a trivialization of the
family: nontrivial automorphism torsors and monodromy may remain.

## 3. A uniform truncation determines the full type

For a $p$-divisible group $D$ of dimension $d$ and codimension
$c$ over an algebraically closed field, let $n_D$ be its
isomorphism number. This is the least positive $n$ such that
$D[p^n]$ determines $D$ up to isomorphism.
[Lau--Nicole--Vasiu, Corollary1.4](https://arxiv.org/pdf/0912.0506)
gives
\[
n_D\le \left\lfloor\frac{2cd}{c+d}\right\rfloor
\qquad(c,d>0).
\]
The same paper's Theorem1.3 gives the sharper bound
$n_D\le\lfloor2\nu(c)\rfloor$ for a nonordinary Newton polygon
$\nu$; ordinary groups have $n_D=1$.
These invariants are unchanged by extension of algebraically
closed fields.

Every geometric BT$_N$ group extends to a full group.
If $N\ge b(c,d)$, two such extensions have isomorphic
$p^N$-torsion and hence are isomorphic by the displayed bound.
Thus their common full geometric type and Newton polygon are
intrinsic to the truncated group.

On a complete trait $R=k[[t]]$, a BT$_N$ group extends to a full
$p$-divisible group over $R$. We use exactly this local statement,
as in the proof of
[Lau--Nicole--Vasiu, Theorem4.14](https://arxiv.org/pdf/0912.0506),
which cites Illusie's lifting theorem. We do not assume that a
full extension exists over the original projective curve.

## 4. Fixed Newton polygon prevents a specialization jump

Let $B/C$ be one of the endpoint BT$_N$ families and let $B_0$
be its constant geometric generic type from Section1.
Choose a full group $D_0/k$ extending $B_0$.
Suppose the intrinsic Newton polygon is constant on $C$.

Fix an arbitrary closed point $x\in C$. Pull $B$ to the complete
local trait at $x$ and extend it there to a full group $D$.
Its geometric generic fiber is isomorphic to $D_0$, by
Section3 and the generic $p^N$-torsion isomorphism.
Its Newton polygon is constant, again by Section3 and the
assumption on $B$.

The isomorphism locus of a fixed full group is closed within its
Newton stratum. This is
[Oort, Theorem2.2](https://arxiv.org/pdf/math/0207050);
the two-family version is also
[Lau--Nicole--Vasiu, Theorem1.1(d), with distance zero](https://arxiv.org/pdf/0912.0506).
The geometric generic isomorphism therefore specializes to
$D_x\simeq D_0$. In particular $B_x\simeq B_0$.
Since $x$ was arbitrary, every geometric fiber has type $B_0$.

The same local argument shows that, even when Newton polygons
vary globally, an exceptional type cannot have the generic
Newton polygon. Otherwise apply it on the trait at that point.
Section2 supplies at most one exceptional truncated type, and
Section3 turns it into at most one exceptional full type.

For full group families, apply these arguments to level
$b(c,d)$. This level determines all their fiber types.
The cases $c=0$ or $d=0$ are already geometrically fiberwise
constant, so no extra restriction is needed there.

## 5. Application and precise boundary

Supersingular abelian varieties of dimension $r$ give full groups
of dimension and codimension $r$, with constant Newton polygon.
Their isomorphism cutoff is at most $r$. Consequently actual
compatibility of their $p^r$-torsion across a coreless span forces
all fibers to have one full type.

For $r=2$, this rules out an $a$-number jump as soon as compatible
BT2 data is supplied. It also applies to a putative compatible
BT2 extension of a common supersingular BT1 family, whether or
not that extension is globally the torsion of an abelian scheme:
the BT2 fibers uniquely determine their supersingular full types.
Thus a proposed level-one jump cannot persist to that level.

If compatibility is witnessed after an étale refinement of the
source, the endpoint fields have the same intersection inside
the enlarged field. Section1 is unchanged. Fiberwise
compatibility also descends as a statement about isomorphism
types, and the exceptional sets on the original source are
still saturated. The conclusions therefore concern the
original span.

None of this replaces a group isomorphism by a rational
isogeny. Constant-Newton families are all geometrically
isogenous fiberwise, and can have varying integral types.
The theorem instead bounds how much ACTUAL compatible
truncation is possible if that variation is to supply a clump.

## 6. Constant rational coefficients

The final section of the statement has the stronger hypothesis of
an actual full comparison and constant quasi-isogeny markings.
After making the two markings agree on $Z$, their kernels are
compatible embedded subgroups of one constant finite group.
Corelessness makes the corresponding projective Grassmannian maps
constant, so both groups and their comparison are the same constant
quotient. The [supporting proof](common_constant_isocrystal.md) gives
the full argument and the rational Dieudonné justification.
