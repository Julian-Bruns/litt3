# Ordinary genus-two targets do not supply a simultaneous-lifting theorem

**Status:** bounded primary-source and example check, 2026-09-05.
Reviewer: `/root/x_elliptic_quotient_maps`. This is a literature boundary
and an explicit liftable example, not a classification of coreless
correspondences and not a nonliftability theorem.

## Verdict

No theorem found in the checked sources says that a specified proper
bi-etale correspondence in characteristic five lifts simultaneously merely
because one target is ordinary of genus two, or because
`p=5>2g=4`. The standard facts that a smooth curve lifts and that a finite
etale cover lifts after its base has been lifted do not identify the two
source liftings selected independently by the two legs.

The known positive-characteristic coreless examples also do not give a
nonliftable ordinary genus-two example. On the other hand, ordinary
genus-two curves certainly can carry coreless correspondences: the explicit
Shimura example below is proper and bi-etale, but lifts by construction.
Thus the unresolved adjective is **nonliftable**, not **coreless**.

## 1. What Example 3.19 actually supplies

Raju Krishnamoorthy,
[*Correspondences without a Core*, Example 3.19](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
considers a one-dimensional central leaf in the reduction at an inert prime
of a Hilbert modular threefold for a totally real cubic field. The leaf
parametrizes abelian threefolds whose common Newton polygon has slopes

\[
             (1/3,1/3,1/3,2/3,2/3,2/3).
\]

Prime-to-`p` Hecke correspondences preserve the leaf, and the surrounding
Newton stratum has a transverse one-dimensional isogeny foliation. This is
the source of the one-parameter deformation in characteristic `p`.

This does **not** answer the present genus-two lifting question:

- the paper gives neither the genus nor the p-rank of the compactified leaf
  as an algebraic curve;
- the displayed Newton slopes belong to the universal abelian threefold,
  not to the Jacobian of the leaf, so they do not determine curve
  ordinarity;
- no genus-two specialization is identified; and
- "purely in characteristic p" describes the exhibited deformation
  direction. It is not a calculation of a nonzero `W_2` obstruction for an
  individual correspondence.

The Igusa-level construction in Remark 3.18 is even more explicit about
this last limitation: the text says that one *morally expects* it not to
lift. It does not prove nonliftability, and it supplies no ordinary
genus-two compact target.

Corollary 4.15 of the same paper is a one-way criterion. If a coreless
proper etale correspondence over `Fbar_p` already lifts over the Witt
vectors, then its characteristic-zero curves are Shimura curves. It does
not assert the existence of such a lift.

## 2. An explicit liftable coreless ordinary genus-two example

There is nevertheless an actual proper coreless correspondence with an
ordinary genus-two target in characteristic five.

Gonzalez and Rotger,
[*Equations of Shimura Curves of Genus Two*, Theorem 3.1](https://arxiv.org/abs/math/0312434),
give the compact Shimura curve

\[
 X_{26}:\qquad y^2=-2x^6+19x^4-24x^2-169.              \tag{1}
\]

Its reduction modulo five is smooth:

\[
 \bar X_{26}:\qquad y^2=3x^6+4x^4+x^2+1.              \tag{2}
\]

Indeed the polynomial on the right is coprime to its derivative. If
`f=3x^6+4x^4+x^2+1`, the characteristic-five genus-two Hasse--Witt matrix,
using the coefficients of `f^2`, is

\[
                        H=\begin{pmatrix}4&0\\0&2\end{pmatrix},
                        \qquad \det H=3.                \tag{3}
\]

Thus `bar X_26` is ordinary.

The arithmetic Fuchsian group defining `X_26` is torsion-free. One quick
check uses the standard genus formula

\[
 g(X_D)=1+\frac{\varphi(D)}{12}-\frac{e_2}{4}-\frac{e_3}{3}.
\]

Here `varphi(26)=12` and `g(X_26)=2`, forcing `e_2=e_3=0`.
Consequently the usual Hecke correspondences at a split prime, for example
three, are finite etale correspondences of smooth proper curves rather
than only etale correspondences of orbifolds. They are coreless Hecke
correspondences in the sense discussed after Definition 3.15 of
Krishnamoorthy's paper.

The same diagram has simultaneous good reduction at five. For a
three-power Hecke correspondence, the normal closures of both legs have
groups contained in the relevant `PGL_2(Z/3^a)` permutation groups, whose
orders are prime to five. Prime-to-five specialization therefore extends
both legs over a finite extension of the good-reduction DVR; uniqueness of
the stable source model identifies the two extensions. Lemma 4.10 of
Krishnamoorthy then preserves corelessness in the special fiber.

It follows that `bar X_26` over `Fbar_5` admits proper coreless bi-etale
self-correspondences which lift together to characteristic zero. This
example rules out any attempted statement that ordinary genus two itself
forces a core or forbids Hecke dynamics.

## 3. Why the two proposed smallness hypotheses do not bridge the gap

1. The inequality `p>2g(Y)` is not a simultaneous deformation theorem.
   Deligne--Illusie-type dimension bounds concern Hodge--de Rham
   degeneration once a `W_2` lift exists; they neither construct a lift of
   two maps nor compare the two induced liftings of their common source.

2. Jacobian ordinarity is also insufficient. An ordinary genus-two curve
   has nontrivial etale `C_5` torsors, since its 5-rank is two, so the
   Galois closures of its covers need not even have prime-to-five order.
   Serre--Tate functoriality lifts homomorphisms between ordinary abelian
   varieties, but the common source curve of a correspondence need not be
   ordinary, and lifting its Jacobian data does not recover the two curve
   maps.

3. Mochizuki's "ordinary p-adic curve" theory uses a chosen nilpotent
   ordinary indigenous bundle (a p-adic Teichmuller structure). It is a
   stronger and different condition from maximal p-rank of the Jacobian.
   The checked statements do not turn bare Jacobian ordinarity into a
   simultaneous lift of an arbitrary correspondence.

## 4. Closest valid positive hypotheses

The nearest general lifting statements all add genuinely joint data:

- if the correspondence comes by reduction of one characteristic-zero
  finite-etale diagram, as for `X_26`, it of course has the required common
  lift;
- if both legs factor through one liftable tame common orbifold, lift the
  orbifold and its finite-etale atlases; this assumes a core and therefore
  does not address the coreless case;
- if two Galois deck groups sit in one finite tame action on the source,
  equivariant deformation lifts that action and its quotients, but the
  quotient by the generated finite group is again a common core; and
- infinitesimally, the exact extra condition is the vanishing of the
  simultaneous two-leg obstruction from file 110. Neither genus two nor
  ordinary p-rank forces that vanishing.

Accordingly, the finite-orbifold degree bound for ordinary genus-two curves
controls the cored locus, while a separate invariant is still needed for
coreless diagrams. The bounded search found no published nonliftable
proper coreless example with an ordinary genus-two target.
