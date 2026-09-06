# A genus-two open with proper theta for every double-abelian tower

Date: 2026-09-05. Author: `/root`.
Status: author proof. The finite exceptional-fiber argument, the explicit
pair, and the moduli closedness/dimension argument received focused
PASS checks from `/root/gluing_cohomology_rigidity` on this date.
No claim of priority or of a solution to Litt 3. The fixed pair of
file76 is not replaced by this auxiliary open family.

## 1. Statement

Let k=Fbar_5. There is a nonempty Zariski-open substack V of the
ordinary genus-two moduli stack such that the following holds for
every Y in V(k).

For every connected finite etale double cover a:U -> Y and every
degree-zero line bundle alpha on U^(1),

\[
        \alpha+a^{(1)*}J(Y^{(1)})\not\subset\Theta_U.           \tag{1}
\]

Equivalently, for each alpha, a nonempty open subset of J(Y^(1))
satisfies

\[
 H^0(U^{(1)},B_U\otimes\alpha\otimes a^{(1)*}L)=0.             \tag{2}
\]

Here Theta_U is the Raynaud determinant divisor, not the classical
principal theta divisor. The quantifier includes all degree-zero
line bundles, not merely torsion of a specified order.

Consequently, for every actual connected abelian Galois finite etale
cover b:W -> U, of arbitrary degree, the composite q=a b satisfies

\[
       H^0(W^{(1)},B_W\otimes q^{(1)*}L)=0                    \tag{3}
\]

on a nonempty open subset of J(Y^(1)). Both even degrees and degrees
divisible by five are allowed, with no fixed prime support. No
Galoisness of W/Y or inversion action is assumed.

The same assertion holds for every actual intermediate Z/Y and after
any further actual Galois five-group refinement above W. If such Z
has a second actual finite etale map to any hyperbolic X, the proposed
two-leg theta properness statement (R) follows by setting the X-line
bundle equal to O. No second-leg descent is assumed.

The good open in the line-bundle parameter space is allowed to depend
on the finite cover. We do not claim one L works for infinitely many
covers simultaneously.

## 2. At most one bad fiber for an arbitrary ordinary base

For this section Y is any ordinary genus-two curve, not necessarily
in V. Put J=J(U^(1)), A=im(a^(1)*), let P be the scalar-twisted
elliptic Prym, and let pi:J -> Q=J/A. These objects have models over
any field of definition of a.

The checked double-cover calculation gives

\[
 \dim J=3,\quad \dim A=2,\quad \dim P=1,\quad
 P\cap A=P[2],\quad \deg(\Theta_{\rm principal}|P)=2.          \tag{4}
\]

Since J/P is ordinary, P is not contained in Theta_U. Hence

\[
                    D=\Theta_U|P,\qquad \deg D=8.             \tag{5}
\]

The mandatory part of D is as follows:

- If P is ordinary, D contains the four distinct nonzero points of
  ker(V_P), each of order five.
- If P is supersingular, D has multiplicity four at zero.

The first assertion follows by tensoring the Frobenius exact sequence
with a nontrivial line L in ker(F_U^*). The second follows from Tong's
Dirac property on the connected Verschiebung kernel, which here equals
ker(V_P) and has ring k[t]/(t^5). The equation restricts to a nonzero
multiple of t^4. These inputs and (4)--(5) are proved in
[the elliptic Prym note, Sections 2 and 3](ODD_GENERALIZED_DIHEDRAL_TOWERS_OVER_ORDINARY_GENUS_TWO_HAVE_FINITE_NONORDINARY_TARGETS.md),
using [Tong, Theorem 1.2.7.7](https://arxiv.org/pdf/0712.2046).

The zero fiber A is not contained in Theta_U: on J(Y^(1)) its bad
locus is the union of Theta_Y and its translate by the two-torsion
class defining U/Y. Both are proper by Raynaud's theorem.

### Lemma 2.1

There is at most one q in Q(k) with pi^(-1)(q) contained in Theta_U.
If one exists, q is nonzero and has order two.

### Proof

A bad fiber is an irreducible abelian-surface translate, hence an
effective divisor component of Theta_U with multiplicity at least one.
Its restriction to P is a reduced degree-four divisor: pi|P has
kernel P[2]. Two distinct fibers restrict to disjoint such divisors,
already exhausting degree eight in (5).

Neither fiber is the zero fiber A. If P is supersingular, both
restrictions miss the origin, leaving the compulsory multiplicity
four unaccounted for. If P is ordinary, each restriction contains at
most one point of ker(V_P): the difference of two such points would
belong to both P[2] and ker(V_P), whose orders are coprime. Thus at
least two of the four mandatory nonzero five-torsion points lie
outside the two restrictions. This again contradicts (5).

This proves uniqueness, without any torsion assumption on q. Theta_U
is symmetric, so a unique bad fiber is preserved by inversion: q=-q.
The zero fiber has already been excluded, proving the lemma.

In particular every bad fiber is represented on P by an exact-order-
four point. Indeed pi|P factors as [2]:P -> P followed by an isomorphism
P -> Q, because its kernel is exactly P[2]. The three nonzero Q[2]
classes correspond to the three cosets P[4]/P[2] other than zero.
The factorization and isomorphism are over the field of definition.

## 3. Frobenius rules out the exceptional fiber for one actual pair

### Lemma 3.1

Suppose a:U -> Y is defined over a finite field F_q and the ordinary
genus-two condition holds. If the elliptic Prym P has no nonzero
F_q-rational two-torsion, then there is no bad fiber at all.

### Proof

The divisor, quotient, and possible unique bad fiber are invariant
under arithmetic Frobenius. If it existed, its class would therefore
be a nonzero point of Q[2](F_q). The isomorphism P -> Q above identifies
their Frobenius modules on two-torsion, contradicting the hypothesis.

### An exact example over F_5

Set

\[
 f=t(t-1),\qquad c=t^3+t+1,\qquad
 g=(t-2)c=t^4+3t^3+t^2+4t+3.
\]

Let

\[
 Y:\ y^2=fg,
 \qquad k(U)=k(t)(u,v),\quad u^2=f,\ v^2=g,
 \qquad E:\ v^2=g.
\]

The factors are square-free and disjoint. The diagonal sign change
on U is free, so U -> Y is an actual etale double cover. The other
map U -> E is ramified of degree two; its pullback embeds J(E) and
identifies it, over F_5, with the Prym P. This auxiliary ramified map
is used only to identify P; it is not substituted for either of the
etale maps in (3).

The Hasse--Witt matrix of Y, computed from (fg)^2, is

\[
                   \begin{pmatrix}3&1\\3&4\end{pmatrix},
                \qquad \det=4\ne0.
\]

Thus Y is ordinary. The elliptic Hasse invariant is the coefficient
of t^4 in g^2, namely 1. The cubic c is irreducible over F_5, so
Frobenius acts on E's four branch points as (1)(3). Its action on
the three pair partitions, which describe nonzero E[2], is a
three-cycle. Hence E[2](F_5)=0. Lemma 3.1 proves (1) for this pair.

The calculation was run exactly in Sage and independently hand-checked
by /root/gluing_cohomology_rigidity. The companion
[example and certificate](EXPLICIT_ORDINARY_GENUS_TWO_DOUBLE_WITH_FROBENIUS_CYCLIC_PRYM_TWO_TORSION.md)
give its full verification. This does NOT assert that all fifteen
doubles of this particular F_5 curve are good.

## 4. From one good pair to bases with all fifteen doubles good

Work over the ordinary genus-two moduli stack M. Let R -> M classify
a nonzero two-torsion line-bundle class, with the scalar ambiguity
rigidified. It is finite etale of degree 15. The corresponding double
cover exists etale-locally, which suffices for the constructions below.
Equivalently use a scheme with suitable auxiliary level structure.
No assertion of etaleness for the coarse moduli map is needed.

R is irreducible of dimension three. A genus-two curve is hyperelliptic,
and a nonzero two-torsion class is a distinguished unordered pair of
its six branch points. The ordered six-point configuration space on
P^1 is irreducible and maps surjectively to R after quotienting by
PGL_2 and by permutations within the distinguished pair and its
complement. Restricting to the nonempty ordinary open preserves
irreducibility. Over k=Fbar_5 there is no quadratic-twist ambiguity
affecting this geometric argument.

Over R, form the finite etale parameter space F of exact-order-four
points alpha on the Prym. On its relative J(Y^(1)) family, the set

\[
 \mathcal O=\{(a,\alpha,L):
        h^0(U^{(1)},B_U\otimes\alpha\otimes a^{(1)*}L)=0\}
                                                               \tag{6}
\]

is open by upper semicontinuity. The projection from this Jacobian
family to F is smooth, hence open. Its image is therefore the open
set of (a,alpha) for which there exists a good L. Its complement is
the closed locus of bad translates. The image of this closed locus
under the finite map F -> R is closed.

By Lemma 2.1, this image is exactly the bad-pair locus B: no other
degree-zero translate can be bad. Section 3 exhibits a point of R
outside B, so B is a proper closed subset of the irreducible
three-dimensional R. Its image in M is closed, since R -> M is finite,
and has dimension at most two. It cannot be all of M. Put

\[
                         V=M\setminus\operatorname{im}(B).  \tag{7}
\]

This is the claimed nonempty open. Every one of the fifteen doubles
over Y in V(k) is good, and Lemma 2.1 then gives (1) for every alpha.
Nonemptiness is a finite-type open condition, so V has actual k-points.
There is no intersection of infinitely many opens or appeal to a
very general point outside Fbar_5.

## 5. All abelian degrees, intermediates, and normal five-groups

First suppose b:W -> U has degree prime to five, with character subgroup
Lambda in J(U^(1)). The exact decomposition is

\[
 H^0(W^{(1)},B_W\otimes q^{(1)*}L)
  =\bigoplus_{\alpha\in\Lambda}
       H^0(U^{(1)},B_U\otimes\alpha\otimes a^{(1)*}L).
                                                               \tag{8}
\]

By (1), each summand vanishes on a nonempty open of J(Y^(1)). Their
finite intersection is nonempty, proving (3). Oddness has disappeared.

For abelian b of arbitrary degree, quotient its Galois group by its
Sylow five-subgroup: W -> W_0 is a Galois five-group cover and W_0/U
is abelian of degree prime to five. The saved
[five-group refinement invariance theorem](P_GROUP_REFINEMENT_INVARIANCE_OF_RESTRICTED_RAYNAUD_THETA.md)
shows that vanishing after pullback to W is equivalent to vanishing
on W_0. The same argument permits further Galois five-group refinements.

For any actual intermediate Z/Y of the resulting composite, etale
base change identifies the pullback of B_Z with B on the larger
curve, and pullback injects global sections. Thus the good open
descends to the assertion for Z. Setting the other line parameter
equal to O proves (R) for any actual second etale leg from Z.

In group terms, a sufficient condition on the Y-leg Galois closure
is a normal five-subgroup R whose quotient has an abelian subgroup
of index at most two. The index-one case is already known; in the
index-two case use its double quotient. No action-by-inversion or
bound on character orders is required.

## 6. Strategic scope

This is an all-degree vanishing mechanism on an actual nonempty open
family of ordinary genus-two bases. It is stronger than checking
individual dihedral degrees, but it does not control arbitrary finite
groups or arbitrary depths of iterated abelian extensions.

It also does not improve the old fixed-genus-nine Jacobian exclusion
in every covered group class: the old bounded-character-degree packet
bound already excludes that target over genus-two bases for abelian
index-two monodromy without five-group refinements. The new result
is theta properness for all second targets, not another numerical
exclusion of the same pair.

The actual common-cover problem remains open in this investigation.
Using (R) to control the genuine cofinal correspondence tower is still
a separate step; no such cofinality is supplied by this theorem.
