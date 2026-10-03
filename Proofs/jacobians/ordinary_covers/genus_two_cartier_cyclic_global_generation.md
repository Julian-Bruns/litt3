# Proof: cyclic étale global generation of the genus-two Cartier bundle

Version1, 2 October2026. [Statement](../../../Theorems/jacobians/ordinary_covers/genus_two_cartier_cyclic_global_generation.md).
This is an intrinsic one-endpoint construction, not a common-cover existence result.

## Statement

Let $k=\overline{\mathbf F}_5$ and
$C=Y_S:V^2=(x^4-1)(x-S)$, with $S(S^4-1)\ne0$.
For every finite set of primes $\Sigma$, there is a connected cyclic
finite étale cover $q:D\to C$, of degree avoiding $5$ and every prime
in $\Sigma$, such that $B_D=q^{(1)*}B_C$ is globally generated.

Equivalently, finitely many prime-avoiding torsion line coefficients
on $C^{(1)}$ already give a surjection onto $B_C$.
This applies to both selected parameters and to every smooth member of
the family. No source span is needed. Hence étale global generation of
the genus-two Cartier bundle, even by cyclic prime-avoiding covers,
cannot by itself exclude either selected unmarked common-cover problem.

## 1. Eight good fifth-torsion characters generate pointwise

For a nontrivial geometric fifth-torsion line $A$ on $C^{(1)}$, choose
$F^*A\simeq\mathcal O_C$. The exact sequence
$0\to A^{-1}\to F_*\mathcal O_C\to B_C\otimes A^{-1}\to0$
uses projection formula and the chosen trivialization. Since
$h^0(A^{-1})=0$, $h^0(\mathcal O_C)=1$ and $h^1(A^{-1})=1$,
\[
h^0(B_C\otimes A^{-1})=
1+\dim\ker(F:H^1(A^{-1})\to H^1(\mathcal O_C)).
\]
By Serre duality this last Frobenius map is dual to the corresponding
twisted Cartier map. If $\operatorname{div}\ell=5D$ and
$A=\mathcal O(D)$, it is $\omega\mapsto C(\ell\omega)$, with the
line frame on its target understood. Thus its kernel is one-dimensional
exactly when that twisted Cartier map vanishes on all regular forms.

[Universal twisted-Cartier exhaustion](../../../Theorems/cartier_and_spin/actual_two_map_twisted_cartier_characters.md)
proves that this happens for exactly two inverse-paired nontrivial
fifth-torsion characters, whose nonzero Cartier-fixed logarithmic forms
are $\beta=d x\,dx/V$, $d^2=S$. For the other 22 characters,
$h^0(B_C\otimes A^{-1})=1$. This application is to the endpoint
operator itself; it does not require an actual reciprocal source.

The curve is ordinary: its Cartier matrix is the coefficient-Frobenius
root of $\left(\begin{smallmatrix}3S^2&0\\3S&S^2\end{smallmatrix}\right)$,
whose determinant is $3S^4\ne0$. Consequently the geometric
fifth-torsion group and the Cartier-fixed regular-form space both have
$\mathbf F_5$-dimension two. There are six one-dimensional
$\mathbf F_5$-subspaces. Choose two independent ones avoiding the line
containing the exceptional pair, and take their four nonzero characters
each: eight characters, all with $h^0=1$.

Their canonical sections arise from the counit maps $A\to F_*\mathcal O_C$.
At every point one of these two logarithmic forms is nonzero. They
are $k$-linearly independent: a scalar proportionality between two
Cartier-fixed forms must have scalar in $\mathbf F_5$, contrary to
the chosen independence. They therefore span the basepoint-free
canonical system. For such a good
character, its counit local function $e$ is a unit with unit first
derivative. The five functions $1,e,e^2,e^3,e^4$ span
$k[z]/z^5$. Its four nonconstant powers are precisely the canonical
sections on the four characters of the same good line, up to nonzero
scalars. After quotienting the constant unit they span the Cartier
fiber. Thus the sum of the eight line evaluations surjects onto
$B_C$ everywhere. No exceptional jumping section was used.

## 2. Prime-avoiding torsion is dense on each needed component

The [dimension theorem](../../../Theorems/jacobians/theta_divisors/raynaud_rank_one_dimension.md)
excludes every abelian translate component of the Raynaud divisor
in characteristic five. Here its components are curves in the
Jacobian surface. Hence no component is contained in a translate
of any proper algebraic subgroup: containment in a positive-dimensional
proper connected subgroup would make it an elliptic translate, while
zero-dimensional or disconnected subgroups give the same impossibility
after selecting the component containing the irreducible curve.

Every nonempty open subset $U$ of each reduced component therefore
generates the entire Jacobian in Poonen's precise sense.
[Poonen, Corollary3.3, Remark5.2 and Corollary5.3](https://math.mit.edu/~poonen/papers/multiples.pdf)
give, after descent to a finite field,
\[
\bigcup_{n\ge1,\ n\equiv1\pmod m}[n]U(k)=J(k).
\]
Remove the origin from $U$ and apply this equality to zero. It supplies
a nonzero point of $U$ killed by such an $n$, so its exact order avoids
every prime dividing $m$. This works in every nonempty open, proving
the required Zariski density. There is no absolute-simplicity assumption
and no assumption that every torsion point has cohomology dimension one.

## 3. Deform the good evaluations and retain surjectivity

For each of the eight good parameter points $M_i=A_i^{-1}$ in the
Raynaud divisor, choose any reduced irreducible component $T_i$ through it.
Upper semicontinuity gives an open neighborhood $U_i\subset T_i$ where
$h^0(B_C\otimes M)=1$: it is at most one near $M_i$, and at least one
on the theta component. Its $h^1$ is also one because Euler
characteristic is zero. With a normalized Poincaré line $\mathcal P_i$
on $C^{(1)}\times U_i$, cohomology and base change makes
$H_i=\operatorname{pr}_{U_i*}(B_C\otimes\mathcal P_i)$ a line bundle.
The actual evaluation is
$H_i\otimes\mathcal P_i^{-1}\to B_C$.

On $C^{(1)}\times\prod U_i$ sum these eight evaluations. It is
surjective at the original tuple by part1. The support of its coherent
cokernel has closed projection to $\prod U_i$ because $C^{(1)}$ is proper.
Thus surjectivity holds on a nonempty open subset of that product.
The dense prime-avoiding torsion subsets in each $U_i$ have dense
Cartesian product, so a tuple of such torsion points lies in this open.
Orders can be chosen pairwise coprime as well: successively project the
nonempty open to the next factor, choose a torsion point avoiding the
previously chosen order primes, and keep its nonempty open fiber.

The eight coefficient lines $M_i^{-1}$ at this new tuple still
surject onto $B_C$. Their finite subgroup is cyclic, since their exact
orders are pairwise coprime, and has order avoiding $5\cup\Sigma$.
Its character algebra defines a connected cyclic finite étale cover
of $C^{(1)}$: only the trivial character line has a global section.
On this cover every coefficient line trivializes, so the pulled-back
Cartier bundle is globally generated. Pull the cover back by relative
Frobenius to obtain the stated actual cover $D\to C$; étale Frobenius
base change identifies its Cartier bundle with that pullback.

## Scope and unresolved extraction

The construction uses actual line frames and evaluation maps. It does
not deform an exceptional two-dimensional section space and never
replaces a smooth curve by a Jacobian isogeny. On an already given
actual span, one may include its leg degree primes in $\Sigma$ to keep
the corresponding fiber product connected, retaining both original maps.
But this supplies no common coefficient on the two endpoints: the
line characters and relation kernel are constructed on $Y$ alone.
Finite étale global generation is therefore a generic endpoint property
in this family, not the missing simultaneous extraction theorem.
