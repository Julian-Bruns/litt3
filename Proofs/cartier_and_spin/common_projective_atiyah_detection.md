# Proof: the Witt Lie subbundle and its extra Cartier descent

[Statement](../../Theorems/cartier_and_spin/common_projective_atiyah_detection.md).
The returned Pro reply supplies Sections1--3 and the arithmetic
subcase. Sections4--6 strengthen the reduction locally. We use the
actual no-clump common category: every image is saturated, so kernels,
quotients and intersections are vector bundles. Common positive
canonical sections vanish.

## 1. A Lagrangian Lie subbundle in the actual orthogonal bundle

Use a local parameter $z$ on the untwisted curve and write $D=\partial_z$.
A vector field $hD$ acts on inverse-square differentials by
\[
L_h=hD-2h'.
\]
This is linear over the Frobenius target. Finite-duality adjunction
gives $L_h^\dagger=-hD-3h'=-L_h$ in characteristic five. Also
$[L_h,L_j]=L_{hj'-jh'}$. Thus Lie differentiation embeds
$W=F_*\omega^{-1}$ as a Lie subbundle of $\mathfrak{so}(T)$.
The embedding is fiberwise injective: application to $1$ and $z$
first recovers $h'$ and then $h$.

The ordinary endomorphism trace of every differential operator of
order at most three on the Frobenius algebra is zero. In the local
basis $1,z,\ldots,z^4$, each possible diagonal sum is a multiple of
\[
\sum_{i=0}^4 i(i-1)\cdots(i-j+1)=j!\binom5{j+1}=0
\quad(0\le j\le3).
\]
This remains true with polynomial coefficients and the relation
$z^5$ equal to a scalar on the target. Products $L_hL_j$ have order
at most two. Therefore $W$ is isotropic for $\operatorname{tr}(AB)$.
That pairing is nondegenerate on $\mathfrak{so}_5$ in characteristic
five; one may check it on the usual skew matrix units. The ranks
are five and ten, so
\[
W=W^\perp,\qquad
0\longrightarrow W\longrightarrow\mathfrak{so}(T)
\longrightarrow W^\vee\longrightarrow0.
\tag{4}
\]
All constructions commute with the original etale pullbacks.

## 2. The unique possible proper subbundle of W

The canonical filtration of $F^*W$ has line grades
$\omega^{-1},\mathcal O,\omega,\omega^2,\omega^3$.
For a common rank-$a$ subbundle $N\subset W$, every nonzero induced
line grade is full, by saturation. Canonical transversality makes
the occupied grades the first $a$. On the genus-two endpoint,
\[
5\deg N=a(a-3).
\]
For $1\le a\le5$, integrality permits only $a=3,5$.
A proper subbundle therefore has rank three and degree zero. Two
different such subbundles would intersect in rank one or two, which
is impossible. Thus it is unique and common-simple. Its quotient
$Q$ is also common-simple: a common line in $Q$ would lift to a
rank-four subbundle of $W$.

## 3. The alternating second fundamental form

Suppose $\kappa_B=0$. By the
[centered-bundle theorem](centered_frobenius_common_bundle.md), $T$ has
its unique common orthogonal connection, with zero $p$-curvature.
The induced connection on $\mathfrak{so}(T)$ gives the alternating
second fundamental map
\[
\beta:W\longrightarrow W^\vee\omega.
\]
Its rank is zero, two or four. Rank zero would give a connection
on $W$, whose determinant has degree two on $Y^{(1)}$, impossible
in characteristic five. Rank four would give a common line kernel
in $W$, also impossible. Thus its rank is two everywhere, and
$K=\ker\beta$ is the unique rank-three common subbundle.

Initially $\nabla K\subset W\omega$. The further second fundamental
map $K\to Q\omega$ vanishes: a nonzero common map from the simple
rank-three $K$ cannot have image inside a rank-two bundle. Hence
$K$ is horizontal and dormant.

The induced connection is a derivation of the Lie bracket. Since
$W$ is a Lie subbundle, for local $a,b\in K$ one has
$\nabla[a,b]\in W\omega$, which says $\beta([a,b])=0$. Thus
$K$ is a Lie subalgebra. Its bracket is nonzero: over the generic
Frobenius-constant field, commuting nonzero vector fields have
constant ratio, so an abelian vector-field subspace has dimension
at most one. The nonzero common map $\Lambda^2K\to K$ is onto by
simplicity, and the equal ranks make it an isomorphism.

The occupied grades of $F^*K$ are $\omega^{-1},\mathcal O,\omega$.
The last two-step term $V_3$ in the filtration of $F^*W$ consequently
maps isomorphically onto $F^*Q$. Indeed it has zero intersection
with $F^*K$ and the same rank, and its common image is saturated.
It gives
\[
0\longrightarrow\omega^3\longrightarrow F^*Q
\longrightarrow\omega^2\longrightarrow0,
\tag{5}
\]
with the canonical oper second fundamental isomorphism. The quotient
connection is the actual Cartier connection. This is a common
regular dormant projective oper.

We will use injectivity of Frobenius on the COMMON Picard group.
If $F^*L\simeq\mathcal O$ commonly, the transported canonical
connection is $d+\alpha$ for a common regular one-form $\alpha$.
There are no such nonzero forms. Cartier descent therefore identifies
$L$ with the trivial common line. Applying this to determinants in
(5) gives $\det Q\simeq\omega$ on the first twist.

## 4. The new adjoint identification

The bracket of $K$ with $W$ induces a representation on $Q=W/K$:
\[
\rho:K\longrightarrow\operatorname{End}(Q).
\]
It has trace zero, since $K=[K,K]$. It cannot be the zero map.
Otherwise $K$ would be an ideal in the generic Witt algebra $W$.
That algebra is geometrically simple. For an elementary check over
an algebraic closure of the generic field, write it as derivations
of $k[z]/(z^5)$. The distinct weights of $zD$ isolate a monomial
$z^iD$ in any nonzero ideal. Repeated bracketing with $D$ gives
$D$; bracketing with the remaining monomials gives all five basis
vectors (the last follows from $[z^3D,z^2D]=-z^4D$). All factorials
used have order less than five and are nonzero.

Thus $\rho$ is a nonzero common map from simple $K$ to rank-three
$\operatorname{End}^0(Q)$. It is injective, and saturation makes
it an isomorphism:
\[
K\simeq\operatorname{End}^0(Q).
\tag{6}
\]
The connection on $K$ preserves its bracket. The bundle of Lie-algebra
frames of $\operatorname{End}^0(Q)$ is the projective frame bundle
of $Q$, because $\operatorname{Aut}(\mathfrak{sl}_2)=\mathrm{PGL}_2$
in characteristic five. A bracket-preserving connection is therefore
exactly a projective connection on $Q$. Its $p$-curvature is zero,
as can also be checked in the faithful adjoint representation.

With $\det Q=\omega$, this says
\[
a(Q)=\tfrac12\operatorname{id}_Q\otimes a(\omega).
\]
Since $\tfrac12+2=0$ in characteristic five, tensoring by $\omega^2$
gives an ACTUAL common connection on $Q\omega^2$. This connection
is unique and dormant: common simplicity kills the Hom groups to
its positive canonical twists. Cartier descent gives a common $R$
on the next twist with $F^*R=Q\omega^2$. Frobenius injectivity on
the common Picard group gives $\det R=\omega$. This proves the
necessity of the second descent in the statement.

## 5. Converse and the exact obstruction

For any common regular dormant projective oper, let $Q$ be its
canonical-determinant Bol bundle. Its oper quotient gives the
canonical inclusion $Q\hookrightarrow F_*\omega^2$. Multiplication
of sections, followed by projection formula, defines
\[
\operatorname{Sym}^4 Q\otimes\omega^{-2}
\longrightarrow F_*\omega^{-2}=T.
\tag{7}
\]
This is an isomorphism. In a flat projective coordinate $z$, the Bol
bundle has basis $(dz)^2,z(dz)^2$. The five fourth-power monomials,
after the target-canonical twist in (7), give exactly
$(dz)^{-2},z(dz)^{-2},\ldots,z^4(dz)^{-2}$, the full Frobenius basis.
The construction is intrinsic multiplication, so the local checks
glue and preserve the actual source comparisons. The analogous
cube gives $B\simeq\operatorname{Sym}^3Q\otimes\omega^{-1}$.

If $F^*R=Q\omega^2$ commonly, its Cartier connection induces a
dormant projective connection on $Q$. The representation
$\operatorname{Sym}^4Q\otimes(\det Q)^{-2}$ depends only on the
projective bundle and is orthogonal. Via (7) it gives a common
connection on $T$, hence $\kappa_B=0$. Thus the second-descent
criterion is an equivalence, not just a necessary condition.

For clarity, the common oper itself is not automatically available.
If it is available, it is unique, since differences of common
projective connections are common quadratic differentials. Its
rank-three bundle is also the unique proper subbundle of $W$:
the complementary Bol operator $D^3+rD+3r'$ gives the exact sequence
$0\to K\to F_*\omega^{-1}\to Q\to0$, locally the map $D^3$.
Thus the $Q$ used in both directions is the same actual object.

## 6. A finite common descent chain over one field

Start with $Q_0=Q$. For any common-simple canonical-determinant
rank-two bundle $V$, a common projective connection is equivalent
to a common connection on $V\omega^2$. When it exists, that
connection is unique and dormant, since
\[
\operatorname{Hom}_{\rm common}(V,V\omega)=
\operatorname{Hom}_{\rm common}(V,V\omega^5)=0.
\]
Its antecedent is again common-simple, and again has determinant
$\omega$, by the Picard injectivity just proved. This constructs
the unique chain $F^*Q_{i+1}=Q_i\omega^2$ as long as it exists.
Uniqueness includes the connection and the antecedent comparison;
it is not a choice among unrelated endpoint roots.

Every $Q_i$ is geometrically stable on $Y^{(i+1)}$. For $Q_0$, a
line of degree at least one would pull back to a horizontal line
of degree at least five in (5); it cannot map to the degree-four
quotient, and cannot be the nonhorizontal oper line. This is the
usual oper stability argument. Stability then propagates backwards:
a destabilizing line in $Q_{i+1}$ would destabilize its stable
pullback $Q_i\omega^2$.

Suppose the whole original span is over $\mathbf F_q$, $q=5^s$.
The unique common oper is Galois invariant. Each successive common
connection is unique and therefore defined over that SAME field;
Cartier descent retains this field, on the appropriate relative twist.
For the point count it suffices that the resulting stable moduli
classes are $\mathbf F_q$-rational. There are only $s$ coefficient
twists of the genus-two curve. On each twist the fixed-canonical-
determinant rank-two moduli space is a form of $\mathbf P^3$; over
a finite field that form is split. Thus it has $q^3+q^2+q+1$ rational
points, an upper bound for its stable points.

No pair consisting of a twist phase and a stable moduli class can
repeat along the chain. If $i<j$ repeated, $j-i$ would be divisible
by $s$, and composing the intervening normalized Frobenius maps
would make $Q_i$ periodic. After a geometric theta normalization,
this is an actual degree-zero Frobenius-periodic rank-two bundle.
It is strongly semistable: an unstable pullback stays unstable under
all further pullbacks, contradicting the stable periodic returns.
Forward propagation would make $Q_0$ strongly semistable as well,
contrary to its unstable oper pullback (5).

Pigeonhole now proves the stated bound $s(q^3+q^2+q+1)$. A chain
cannot continue forever, so its final projective Atiyah class is
nonzero. This argument uses the finite field of the WHOLE span;
independent antecedents over growing fields would not be bounded.
It does not prove that the first obstruction is nonzero.

## 7. The explicit arithmetic subcase and evidence

For a clumpless span over $\mathbf F_{125^r}$ with $5\nmid r$,
the [residue theorem](../deformations/frobenius_residue_escape.md)
already proves that the common regular-connection space is empty.
Part 1 identifies $\kappa_B=0$ with a common connection.
Hence $\kappa_B\ne0$. The cited theorem contains the exact
degree-five dormant-residue certificate.
