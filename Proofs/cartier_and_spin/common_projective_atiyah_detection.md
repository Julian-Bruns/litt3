# Proof: the Witt Lie subbundle and its extra Cartier descent

[Statement](../../Theorems/cartier_and_spin/common_projective_atiyah_detection.md).
Version2,3 October2026. The later intrinsic Witt criterion now
supplies the rank, bracket and oper arguments independently of the
Atiyah hypothesis. The original second-descent criterion remains. We use the
actual no-clump common category: every image is saturated, so kernels,
quotients and intersections are vector bundles. Common positive
canonical sections vanish.

## 1. Centering and the actual orthogonal model

The [intrinsic Wronskian identification](all_tensor_cartier_hn.md#3-the-two-distinct-characteristic-five-bundle-models)
gives $T\simeq P=\Lambda^2_0B\otimes\omega^{-1}$.
The exterior-square action has differential
$d\rho:\mathfrak{sp}(B)\xrightarrow{\sim}\mathfrak{so}(P)$:
if it vanishes on $P$, it also vanishes on the scalar symplectic line,
hence on all of $\Lambda^2B$; the exterior-square differential in
dimension four is injective when2 is invertible. Both Lie bundles
have rank ten. Atiyah functoriality gives
\[
a(T)=d\rho(\kappa_B).
\]
Indeed the centered scalar $\tfrac12a(\omega)$ contributes
$a(\omega)$ on the exterior square, canceled by the $\omega^{-1}$
twist. The skew-adjoint summands split from the full endomorphism
bundles, so the identity proves $\kappa_B=0$ if and only if $T$ has
a common connection. The centered-bundle theorem then supplies its
uniqueness, orthogonality and dormancy.

### The Lagrangian Lie subbundle

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

## 2. The intrinsic Witt criterion

The later [Witt-subbundle theorem](cartier_witt_oper_subbundle.md)
establishes the following without any connection hypothesis:
a proper nonzero common subbundle of $W$ is unique, has rank
three and degree zero, and is common-simple. Its rank-two
quotient $Q$ is common-simple and is the actual canonical-determinant
Bol bundle of a common regular dormant oper, with
$K\simeq\operatorname{End}^0(Q)$ and $\Lambda^2K\simeq K$.
Its canonical oper filtration is
\[
0\longrightarrow\omega^3\longrightarrow F^*Q
\longrightarrow\omega^2\longrightarrow0.
\tag{5}
\]
That theorem also proves injectivity of Frobenius on common
Picard classes. These arguments are not repeated here.

## 3. The alternating second fundamental form

Suppose $\kappa_B=0$. Section1 gives a common connection on $T$; the
[centered-bundle theorem](centered_frobenius_common_bundle.md)
makes it unique, orthogonal and dormant.
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

## 4. The second projective Cartier descent

By Section2, the kernel already has its bracket and adjoint
identification $K\simeq\operatorname{End}^0(Q)$.
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
classes are $\mathbf F_q$-rational. There are at most $s$ coefficient
twists of the genus-two curve. On each twist the fixed-canonical-
determinant rank-two moduli space is a form of $\mathbf P^3$; over
a finite field that form is split. Thus it has $q^3+q^2+q+1$ rational
points, an upper bound for its stable points.

There is a sharper label for every member: its first unstable
Frobenius pullback has index EXACTLY $i+1$. Indeed for $0\le h\le i$
the normalized pullback of $Q_i$ is $Q_{i-h}$, hence stable,
whereas its $(i+1)$st pullback is a line twist of the unstable
$F^*Q_0$ in (5). This excludes repetition under ANY isomorphism
of endpoint twists, without a separate periodicity argument.

Let $d$ be any positive period of the endpoint's coefficient
Frobenius twists up to $\mathbf F_q$-isomorphism. One may always
take $d=s$; a model over $\mathbf F_{5^d}$ gives that period when
$d\mid s$. There are at most $d$ phase moduli spaces, each with
$q^3+q^2+q+1$ rational points. The distinct instability indices
therefore give the bound $d(q^3+q^2+q+1)$. A chain
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
