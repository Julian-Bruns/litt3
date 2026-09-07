# Nonabelian deck rigidity fails in characteristic five

**Status: proved; independently audited PASS, 2026-09-04; exact
finite-group certificate PASS.**

[Exact Sage certificate](93_PSL28_NONABELIAN_DECK_BOUNDARY_CERTIFICATE.sage).
[Audit record](audits/93_NONABELIAN_DECK_RIGIDITY_BOUNDARY_AUDIT.md).

[The arbitrary-abelian theorem](91_ARBITRARY_ABELIAN_DECK_RIGIDITY.md)
proves absolute deck rigidity for every finite abelian deck group.
This note determines a sharp boundary of that method.
There are curves (X/overline{\mathbf F}_5) with

\[
        \operatorname{Aut}(X)=1,\qquad J(X)\text{ absolutely simple},
\]

and connected finite etale Galois covers (D\to X) with **nonabelian** deck
group (H), for which (\operatorname{Aut}(D)>H).  In fact (D) has two
distinct conjugate free copies of (H) with isomorphic quotient (X).

The construction is not an isolated search.  It is a general rank-two
Hurwitz-space mechanism.  Its concrete input in characteristic five is

\[
 G=\operatorname{PSL}_2(8),\qquad
 H=\operatorname{Stab}_{G}(\infty)
       \cong (C_2)^3\rtimes C_7,
\]

in the natural nine-point action on (\mathbf P^1(\mathbf F _8)).

## 1. Big Hurwitz monodromy in tame positive characteristic

We use the following positive-characteristic form of Jain's theorem.

### Proposition 93.1 (tame form of Jain's theorem)

Let (k) be an algebraically closed field of characteristic (p), let (G)
be a finite center-free group with

\[
                         H_2(G,\mathbf Z)=0,
\]

and suppose (p\nmid |G|).  Fix conjugacy classes
(\mathcal C=(\mathcal C_1,\ldots,\mathcal C_s)) in (G).  Assume the
corresponding Nielsen class is nonempty, and let
(\mathcal H_{G,\mathcal C,\mathbf m}) be the Hurwitz space of connected
(G)-covers of (\mathbf P^1), with (m_i) branch points of inertia class
(\mathcal C_i).  Once all (m_i) are sufficiently large, this space is
geometrically connected because the Schur multiplier is trivial.

If (\ell\nmid 2p|G|), then, once every (m_i) is sufficiently large, the
geometric mod-(\ell) monodromy on

\[
                    V=H^1(D,\mathbf F _\ell)
\]

contains the derived group of the symplectic centralizer of (G):

\[
 [C_{\operatorname{Sp}(V)}(G),C_{\operatorname{Sp}(V)}(G)]
       \ \subseteq\ M_\ell(G).                              \tag{93.1}
\]

#### Proof

Over (\mathbf C), this is Theorem 5.4.2 of Lalit Jain,
[Big mod (\ell) monodromy for families of (G)-covers](https://asset.library.wisc.edu/1711.dl/5ACJP2ZOUB75Q8L/R/file-3bcaa.pdf).
We explain precisely why its proof, rather than merely its statement, gives
the tame positive-characteristic version.

The proof has three inputs.  First, the tame Chevalley--Weil character
formula determines (V) as an (\mathbf F _\ell[G])-module.  Second, orbit
counts for (M_\ell(G)) are converted into connected-component counts for
auxiliary Hurwitz spaces with groups (G\ltimes W), where (W) is an
(\ell)-group.  Third, finite classical-group transitivity results turn
those orbit counts into (93.1).

Here both (G) and every auxiliary group (G\ltimes W) have order prime to
(p).  Indeed, (W) is an (\ell)-group and (\ell\ne p).  We use the integral
Hurwitz construction, not an unsupported comparison of the full
fundamental groups of configuration spaces.  Romagny--Wewers,
[Hurwitz spaces](https://imag.umontpellier.fr/~romagny/articles/hurwitz_spaces.pdf),
Theorem 4.11 and Remark 4.15(ii), construct the Hurwitz scheme finite etale
over configuration space after inverting the group order and prove good
reduction at every prime not dividing that order; in particular its
geometric components in characteristic (p) are naturally identified with
its complex components.  Equivalently, in each good fiber the components
are the orbits of the usual Hurwitz braid action on the same Nielsen class.
See also Turkelli,
[Connected components of Hurwitz schemes and Malle's conjecture](https://arxiv.org/abs/0809.0951),
Section 2 (especially Theorems 2.5 and 2.7), for the finite-field formulation
and the explicit Nielsen action.

More precisely, one may adjoin the roots of unity of order dividing the
relevant group orders and use the colored Hurwitz union with the indicated
conjugacy class at each color.  It is an open-and-closed union in the
rigidified Hurwitz scheme.  Romagny--Wewers' construction and good-reduction
identification apply to this variant as well.  The forgetful maps from the
colored auxiliary (G\ltimes W)-spaces to the colored (G)-space extend over
the same cyclotomic base and remain finite etale in every good fiber.
Consequently the auxiliary component counts, not only the uncolored ambient
spaces, are compatible with reduction.

For completeness, Jain's auxiliary-cover argument itself is algebraic in
this setting.  If (D) is a geometric fiber, connected unramified
(W)-covers of (D) which are Galois over (\mathbf P^1) with group
(G\ltimes W) correspond to G-equivariant surjections

\[
       H_1^{\mathrm{et}}(D,\mathbf F_\ell)\twoheadrightarrow W,
\]

or dually to G-equivariant injections
(W^\vee\hookrightarrow H^1_{\mathrm{et}}(D,\mathbf F_\ell)).  Jain's
group-theoretic Lemmas 5.3.1--5.3.3 identify their inertia classes and
Schur multiplier.  The resulting auxiliary Hurwitz scheme maps finite
etale to the original one.  Hence the orbits of geometric etale monodromy
on the injection fiber are exactly the connected components of that
auxiliary Hurwitz scheme.  Good reduction identifies this component count
with Jain's complex braid-orbit count.  His Theorem 5.3.4 and the purely
finite-group argument of Section 5.4 therefore prove (93.1) verbatim.

Finally, the tame Chevalley--Weil formula holds for
(H^1_{\mathrm{et}}(D,\mathbf F_\ell)) under
(\ell\nmid p|G|), and all remaining transitivity arguments concern finite
classical groups.  Thus every input in Jain's proof has now been transported
to (k).  \(\square\)

The prime-to-(p) hypothesis on the **auxiliary** groups is important.  It is
why we require (\ell\ne p), not merely (p\nmid |G|).

## 2. A general rank-two counterexample machine

### Theorem 93.2

Let (p) be a prime and let (G) be a finite group satisfying:

1. (p\nmid |G|), (Z(G)=1), and (H_2(G,\mathbf Z)=0);
2. (G) has a faithful two-transitive action on a set (\Omega) of size
   (n>2), with nonabelian point stabilizer (H);
3. (G) has an inverse-stable conjugacy class (\mathcal C) whose elements
   act as (n)-cycles on (\Omega);
4. two elements of (\mathcal C) generate (G).

Then, for every sufficiently large even integer (r), there is a connected
tame (G)-cover

\[
                         D\longrightarrow\mathbf P^1_k,
             \qquad k=\overline{\mathbf F}_p,
\]

with (r) branch points, all with inertia in (\mathcal C), such that for

\[
                              X=D/H
\]

the following hold:

1. (D\to X) is finite etale Galois with nonabelian deck group (H);
2. (J(X)) is absolutely simple;
3. if (r>2n), the cover can be chosen with
   (\operatorname{Aut}(X)=1);
4. (G\leq\operatorname{Aut}(D)), so
   (\operatorname{Aut}(D)>H); moreover every (g\notin H) with
   (gHg^{-1}\ne H) gives a second free deck group
   (H'=gHg^{-1}), and
   \[
                             D/H'\simeq D/H=X.          \tag{93.2}
   \]

The genera are

\[
                 g(X)=\frac{(n-1)(r-2)}2,
\qquad
                 g(D)=1+|H|\bigl(g(X)-1\bigr).         \tag{93.3}
\]

#### Proof

Choose generators (a,b\in\mathcal C).  Since (\mathcal C) is stable
under inversion,

\[
        (a,a^{-1},b,b^{-1},a,a^{-1},\ldots,a,a^{-1})   \tag{93.4}
\]

is a product-one generating Nielsen tuple for every even (r\ge4).  Hence
the relevant Hurwitz spaces are nonempty.

An inertia group (I=\langle c\rangle), (c\in\mathcal C), acts regularly
on (\Omega).  Every nonidentity subgroup of (I) is fixed-point-free.
Equivalently, (I\cap gHg^{-1}=1) for every (g\in G).  Point stabilizers
on (D) are contained in conjugates of (I), so (H) acts freely on (D).
This proves assertion 1.  The quotient map

\[
                         f:X=D/H\longrightarrow\mathbf P^1
\]

has degree (n) and is totally ramified above each of the (r) branch
points.  Riemann--Hurwitz gives the first formula in (93.3), and etaleness of
(D\to X) gives the second.

We next prove that the quotient family has full symplectic monodromy.  Choose
a prime (\ell\ge5) with (\ell\nmid p|G|).  Put

\[
 \mathbf F _\ell[\Omega]=\mathbf 1\oplus W,
                  \qquad \dim W=n-1.                  \tag{93.5}
\]

Two-transitivity says that the permutation character has inner product two
with itself.  Since (\ell\nmid |G|), Maschke's theorem then shows that
(W) is absolutely irreducible.  It carries the nondegenerate symmetric
form obtained by restricting the standard dot product.  Also

\[
            \dim W^H=1,\qquad \dim W^I=0.              \tag{93.6}
\]

The tame Chevalley--Weil formula is

\[
 [H^1(D,\mathbf F _\ell)]
   =2[\mathbf 1]+(r-2)[\mathbf F _\ell G]
          -r[\operatorname{Ind}_I^G\mathbf 1].         \tag{93.7}
\]

Thus the (W)-isotypic component is

\[
                     W\otimes M,
             \qquad \dim M=(n-1)(r-2)=2g(X).           \tag{93.8}
\]

Moreover, Frobenius reciprocity and (93.5) show that no other nontrivial
irreducible (G)-module has (H)-invariants.  Since (\ell\nmid|H|),

\[
 H^1(X,\mathbf F _\ell)=H^1(D,\mathbf F _\ell)^H
                      =(W^H)\otimes M\simeq M.         \tag{93.9}
\]

The alternating intersection form on (W\otimes M) is the tensor product
of the symmetric form on (W) and an alternating form on (M).  Therefore
the (W)-factor of the symplectic centralizer is
(\operatorname{Sp}(M)).  Proposition 93.1 implies that the geometric
monodromy of the quotient family on (93.9) contains

\[
                         \operatorname{Sp}(M).         \tag{93.10}
\]

It is therefore the full symplectic group.

Take a geometrically connected Hurwitz component and descend it and its
universal quotient family to a finite extension of (\mathbf F _p).  The
closed (\ell)-adic monodromy subgroup surjects mod (\ell) onto
(\operatorname{Sp}(M,\mathbf F _\ell)).  The symplectic lifting theorem
of Landesman--Swaminathan--Tao--Xu,
[Lifting subgroups of symplectic groups](https://arxiv.org/abs/1607.04698),
then makes the geometric (\ell)-adic monodromy Zariski dense in
(\operatorname{Sp}(M,\mathbf Q_\ell)).  Chai--Oort,
[A note on the existence of absolutely simple Jacobians](https://arxiv.org/abs/math/9905063),
Lemma 2 and Proposition 4, now give infinitely many closed fibers whose
Jacobians are absolutely simple.  This proves assertion 2.

It remains to impose trivial automorphisms.  The map (f) is primitive,
because the two-transitive action is primitive.  Suppose
(\sigma\in\operatorname{Aut}(X)), and compare (f) with
(f\circ\sigma).  The compositum

\[
                 k(f)\,k(f\circ\sigma)\subseteq k(X)
\]

is an intermediate field for (k(X)/k(f)).  Primitivity says it is either
(k(f)) or (k(X)).  In the second case Castelnuovo--Severi gives

\[
                             g(X)\le(n-1)^2.            \tag{93.11}
\]

If (r>2n), (93.3) contradicts (93.11).  Hence
(k(f\circ\sigma)=k(f)), and

\[
                             f\circ\sigma=\mu\circ f
\]

for some (\mu\in\operatorname{PGL}_2(k)).

Every Hurwitz component maps finitely etale and surjectively to the
configuration space of its branch points.  On a nonempty open subset, the
unordered branch set has trivial (\operatorname{PGL}_2)-stabilizer.  After
restricting to this open, (\mu=1).  Finally, the deck group of the
non-Galois map (f) is (N_G(H)/H=1): a point stabilizer in a primitive
faithful action is maximal and self-normalizing.  Thus
(\operatorname{Aut}(X)=1) on this open.

Removing a nonempty closed subset does not shrink geometric monodromy: the
fundamental group of the open subset surjects onto that of the original
normal Hurwitz component.  We may therefore apply Chai--Oort after this
restriction and obtain a fiber satisfying assertions 2 and 3 simultaneously.

Assertion 4 is immediate from the (G)-action on (D).  Since (H) is
self-normalizing and proper, it is not normal, and conjugation by (g)
induces (93.2).  \(\square\)

## 3. The characteristic-five instance

### Theorem 93.3 (nonabelian characteristic-five counterexample)

There exist smooth projective curves (D,X/\overline{\mathbf F}_5) such
that

\[
 \operatorname{Aut}(X)=1,\qquad J(X)\text{ is absolutely simple},
\]

and (D\to X) is a connected finite etale Galois cover with nonabelian
deck group

\[
                         H=(C_2)^3\rtimes C_7,
\]

while

\[
              \operatorname{PSL}_2(8)\le\operatorname{Aut}(D),
                         \qquad H\not\triangleleft\operatorname{Aut}(D).
\]

There are two distinct conjugate free copies (H,H'\le\operatorname{Aut}(D))
with (D/H\simeq D/H'\simeq X).

More precisely, for every sufficiently large even (r), one can take

\[
                        g(X)=4(r-2),\qquad
                        g(D)=224r-503.                 \tag{93.12}
\]

#### Proof

Take (G=\operatorname{PSL}_2(8)) in its natural action on the nine points
of (\mathbf P^1(\mathbf F _8)).  It has order (504), trivial center, and
trivial Schur multiplier.  Its point stabilizer has order (56) and
structure

\[
                           (C_2)^3\rtimes C_7;
\]

it is nonabelian and self-normalizing.  Each of the three conjugacy classes
of elements of order nine is inverse-stable; its elements are nine-cycles,
and one such class contains a generating pair.  All hypotheses of Theorem
93.2 hold with (p=5) and (n=9).  Formula (93.12) is (93.3). \(\square\)

This proves that the abelian hypothesis in file91 is essential even over
the exact ground field of the common-cover problem.  It also identifies the
precise representation-theoretic escape: the permutation module has rank
two, so (H^1(X)) is a single multiplicity space rather than a sum or a
repeated (H)-fixed packet.

## 4. Why the closest nonabelian (2)-group test does not escape

The preceding example uses a solvable nonabelian group (H), but not a
nilpotent one.  The most economical nonabelian (2)-group candidate fails
for a concrete reason.

### Proposition 93.4

Let (G=\operatorname{PSL}_2(7)) and let (H=D_8) be a Sylow-two subgroup.
Suppose (D\to\mathbf P^1) is a tame connected (G)-cover on which (H)
acts freely, with all nontrivial inertia of order (3) or (7).  Put
(X=D/H).  If (g(X)\ge2), then (J(X)) is not simple.

#### Proof

The complex irreducible degrees of (G), with the two Galois-conjugate
three-dimensional characters displayed separately, are

\[
                          1,3,3',6,7,8.
\]

Their (H)-fixed dimensions are

\[
                          1,0,0,2,0,1.                \tag{93.13}
\]

Let (a) and (b) be the numbers of inertia groups of order (3) and
(7).  Chevalley--Weil gives multiplicities

\[
 m_6=-12+4a+6b,\qquad m_8=-16+6a+6b.                 \tag{93.14}
\]

If (m_6>0), the six-dimensional packet contributes twice its multiplicity
space to (H^1(X)=H^1(D)^H), by (93.13); the corresponding rational
idempotent decomposition makes (J(X)) nonsimple.  Hence simplicity would
force (m_6=0), or

\[
                              2a+3b=6.                \tag{93.15}
\]

The only nonnegative solutions are ((a,b)=(3,0)) and ((0,2)).  The first
has

\[
             2g(X)-2=-42+14a+18b=0,
\]

so (g(X)=1).  In the second, (93.14) gives (m_8=-4), impossible for an
actual representation.  Thus no simple quotient of genus at least two
occurs. \(\square\)

This last proposition does **not** prove rigidity for arbitrary nonabelian
prime-power deck groups.  It says only that the first natural
self-normalizing (D_8) envelope is killed before any geometric
realization issue arises.  The nilpotent nonabelian boundary remains open.
