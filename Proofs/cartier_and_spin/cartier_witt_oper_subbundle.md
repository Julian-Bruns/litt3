# Proof: the intrinsic Witt subbundle criterion

[Statement](../../Theorems/cartier_and_spin/cartier_witt_oper_subbundle.md).
Version2,3 October2026. The rank, bracket and oper arguments are
established here before any common connection is assumed. All maps
retain the specified comparisons on the same actual source. With no
clump, common morphisms have saturated image and common positive
canonical sections vanish.

## 1. Rank and uniqueness

The canonical filtration of $F^*W$ has grades
$\omega^{-1},\mathcal O,\omega,\omega^2,\omega^3$; it is the
usual Frobenius filtration shifted by $\omega^{-1}$.
Its graded connection maps are isomorphisms. For a common
rank-$a$ subbundle $N\subset W$, horizontality makes the occupied
grades the first $a$, and saturation with no clump makes their line
images full. On the genus-two endpoint this gives
\[
5\deg N=a(a-3),\qquad1\le a\le5.
\]
Integrality leaves only $a=3,5$. Two different proper subbundles
would intersect in rank one or two, which is impossible.
The unique proper $K$ is therefore common-simple of rank three
and degree zero. Its quotient $Q$ is common-simple: a common
line in $Q$ would lift to a rank-four subbundle of $W$.

## 2. Bracket and quotient action

The composite $\Lambda^2K\to W\to Q$ is zero:
$\Lambda^2K\simeq K^\vee\otimes\det K$ is common-simple of
rank three, whereas $Q$ has rank two. Thus $K$ is a Lie subbundle,
without assuming a connection on it.

Its bracket is nonzero. Over the generic Frobenius-constant field,
commuting nonzero vector fields have constant ratio; an abelian
subspace has dimension at most one. The nonzero common map
$\Lambda^2K\to K$ is therefore an isomorphism by simplicity and
saturation.

The induced action $\rho:K\to\operatorname{End}(Q)$ has trace zero
because $K=[K,K]$. It is nonzero, since otherwise $K$ would be an
ideal in the generic Witt algebra, which is geometrically simple.
Here is the elementary check after scalar extension: for derivations
of $k[z]/(z^5)$ the five distinct weights of $z\partial_z$ isolate
a monomial in any nonzero ideal. Repeated brackets with
$\partial_z$ give $\partial_z$, and brackets with the other
monomials give all five basis vectors; the last follows from
$[z^3\partial_z,z^2\partial_z]=-z^4\partial_z$.
All coefficients used are nonzero in characteristic five.
Thus simplicity, equal ranks and saturated image give
\[
K\xrightarrow{\sim}\operatorname{End}^0(Q).
\]

## 3. The actual dormant oper and its determinant

The first three full grades of $F^*K$ imply that the last
two-step term of $F^*W$ maps isomorphically to $F^*Q$:
the projection is generically an isomorphism and its rank-drop
divisor would be a common divisor, hence a clump. Consequently
\[
0\longrightarrow\omega^3\longrightarrow F^*Q
\longrightarrow\omega^2\longrightarrow0.
\]
The canonical Cartier connection gives the oper second fundamental
isomorphism. This is the actual regular dormant projective oper,
with its prescribed source comparison.

Frobenius is injective on the common Picard group. If a common
trivialization of $F^*L$ exists, its transported canonical connection
is $d+\alpha$, where $\alpha$ is a common regular one-form.
There is no such nonzero form. Cartier descent identifies $L$
with the trivial common line. Since $F^*\det Q=\omega^5$ in the
displayed sequence, this proves $\det Q=\omega$ on the first twist.

Conversely the [complementary Bol complex](../projective_connections/dormant_bol_complex.md)
of any common regular dormant oper gives
$0\to K\to F_*\omega^{-1}\to Q\to0$. Its kernel is common under
the original comparison and is the unique proper subbundle above.
This proves the equivalence independently of the Atiyah problem.
