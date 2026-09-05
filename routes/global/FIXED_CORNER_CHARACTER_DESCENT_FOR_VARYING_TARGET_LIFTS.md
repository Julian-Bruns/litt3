# Fixed-corner character descent for varying target lifts

Date: 2026-09-05.
Author: `/root/canonical_trace_algebra`.
Status: complete author proof; not independently audited. No novelty claim.
No existing theorem, curve, or certificate is changed.

**Fixed-corner requirement.** The curve \(C\), its maps to \(X,Y\), and
the intermediate map \(u:C\to X\) in each application live on the same
fixed finite-level curve \(C\). The map \(u\) is allowed to vary, but its
domain is not. The result below does not turn descent to an unbounded
strip into descent to a fixed corner.

## 1. Fixed data and character conventions

Let \(k\) be algebraically closed of characteristic \(p\), let
\(\ell\ne p\) be prime, and fix smooth projective connected hyperbolic
curves and finite étale maps
\[
                         X\xleftarrow{f}C\xrightarrow{g}Y.
                                                                    \tag{1.1}
\]
Assume
\[
                         \operatorname{Hom}(J_X,J_Y)=0.         \tag{1.2}
\]
All Jacobian pullbacks in this note are the actual homomorphisms
induced by the displayed curve maps. We write their groups of
geometric points additively, including for line-bundle classes.

Let \(B_X\subset J_C\) be the abelian subvariety which is the sum of
the images of all homomorphisms \(J_X\to J_C\). This is a finite sum:
choose a finite sum of maximal possible dimension; adding another
image cannot enlarge it. Equivalently, up to isogeny, \(B_X\) is the
sum of the isotypic parts of \(J_C\) whose simple factors occur in
\(J_X\). In particular, for **every** morphism \(u:C\to X\),
\[
                     u^*J_X\subset B_X,
                     \qquad f^*J_X\subset B_X.                 \tag{1.3}
\]
The subgroup scheme
\[
                          E=B_X\cap g^*J_Y\subset J_C          \tag{1.4}
\]
is finite. Indeed, any positive-dimensional reduced identity
component of this intersection would have a simple isogeny factor
occurring in both \(J_X\) and \(J_Y\), contradicting (1.2).
This uses the isogeny decomposition of abelian varieties, not a
claim that these images form a direct product as group schemes.

Choose \(c\ge0\) so that
\[
                         \ell^c E(k)[\ell^\infty]=0.           \tag{1.5}
\]
For the trivial \(\ell\)-primary subgroup, take \(c=0\). The constant
depends only on the fixed data \((C,X,Y,f,g,\ell)\), and may be
chosen before any of the covers or maps below. A nonreduced
\(p\)-primary part of \(E\) is irrelevant to (1.5).

## 2. The connected product-cover hypothesis

Let
\[
 q:W\longrightarrow C
\]
be any connected finite étale Galois cover, equipped with a specified
identification
\[
                  \operatorname{Gal}(W/C)=H_X\times H_Y,        \tag{2.1}
\]
where both groups are finite abelian \(\ell\)-groups.

Character descent gives an injective homomorphism
\[
 \lambda_q:\operatorname{Hom}(H_X\times H_Y,k^*)
                                      \hookrightarrow J_C(k).
                                                                    \tag{2.2}
\]
Here \(\lambda_q(\chi)\) is the associated character line bundle,
with one consistent associated-bundle convention used throughout.
Its image is exactly \(\ker(q^*:J_C(k)\to J_W(k))\).
Define the two character subgroups
\[
 \begin{split}
 \Lambda_X&=\lambda_q\bigl(\operatorname{Hom}(H_X,k^*)\bigr),\\
 \Lambda_Y&=\lambda_q\bigl(\operatorname{Hom}(H_Y,k^*)\bigr),
 \end{split}                                                     \tag{2.3}
\]
extending a character trivially over the other factor. Thus
\[
              \ker q^*=\Lambda_X\oplus\Lambda_Y.               \tag{2.4}
\]
The required compatibility with the fixed two legs is
\[
                    \Lambda_X\subset f^*J_X(k),\qquad
                    \Lambda_Y\subset g^*J_Y(k).               \tag{2.5}
\]
These are hypotheses on the **actual connected cover** \(W/C\).
In particular no product action is silently assigned to a component
of a disconnected fiber product. Stabilized product tails of actual
two-leg abelian rectangles are one source of (2.1)–(2.5).
More explicitly, suppose the component's monodromy in the product
of the two original abelian deck groups is a coordinate product
\(H_X\times H_Y\). Every character of \(H_X\) extends to the
original X-deck group, and likewise for \(H_Y\), since characters
of subgroups of finite abelian groups extend over algebraically
closed \(k\). Pulling the extended character line bundles back to
\(C\) proves (2.5), even when the original fiber product is disconnected.

For completeness, (2.2)–(2.4) can be proved directly. A line bundle
whose pullback to \(W\) is trivial acquires, under a choice of
trivialization, a descent character: the ratios under deck
transformations are global units on connected proper \(W\), hence
elements of \(k^*\). Conversely, each character gives such a line
bundle. The character map is injective because a nontrivial
character cannot act on a nonzero constant function on \(W\).
The character group of the product splits as in (2.3). All the
line bundles have \(\ell\)-power order and hence degree zero.

## 3. Uniform descent of every actual lift from the fixed corner

Let
\[
                     \pi_m:X_m\longrightarrow X               \tag{3.1}
\]
be any connected cyclic finite étale cover of degree \(\ell^m\).
No compatibility between different choices of \(m\) is needed.
Choose a faithful character of
\(G_m=\operatorname{Gal}(X_m/X)\), and let
\(L_m\in J_X(k)\) be its associated line bundle. It has exact order
\(\ell^m\).

Let \(u:C\to X\) be any finite étale map, not necessarily equal to
\(f\), and suppose there is an actual lift
\[
 r:W\longrightarrow X_m,
 \qquad \pi_m r=u q.                                         \tag{3.2}
\]
Both \(m\) and \(u\) may vary arbitrarily.

**Theorem.** With the single constant \(c\) of (1.5), every lift (3.2)
is invariant under the subgroup \(\ell^c H_Y\) of the Y-factor.
Consequently it factors through an actual finite étale map
\[
                \bar r:W/(\ell^c H_Y)\longrightarrow X_m.     \tag{3.3}
\]
More precisely, write the unique decomposition
\[
                        u^*L_m=\xi_X+\xi_Y,
                        \qquad \xi_i\in\Lambda_i.             \tag{3.4}
\]
Then
\[
                     \xi_Y\in E(k)[\ell^\infty],              \tag{3.5}
\]
and the order of \(\xi_Y\) is exactly the order of the image of
\(H_Y\) in \(G_m\) acting on the lift \(r\).

**Proof.** The existence of \(r\) makes the pullback of the cyclic
torsor (3.1) to \(W\) trivial, so \(q^*u^*L_m=0\). Equations
(2.4) and (2.5) give (3.4). By (1.3), both \(u^*L_m\) and
\(\xi_X\) lie in \(B_X(k)\). Therefore
\[
              \xi_Y=u^*L_m-\xi_X\in B_X(k)\cap g^*J_Y(k).
\]
It has \(\ell\)-power order, proving (3.5) and
\(\ell^c\xi_Y=0\). This is the step making the bound uniform in
the varying maps \(u\); no bound on their number or a separate
constant for each \(u\) is used.

To identify this line-bundle calculation with the actual lift, for
each \(h\in H_X\times H_Y\), the maps \(r h\) and \(r\) lie
over the same map \(u q\). The torsor property of \(\pi_m\) gives
a unique locally constant map \(W\to G_m\) relating them.
Connectedness of \(W\) makes it constant. Thus
\[
                     r h=\varepsilon(h)\,r
\]
for a homomorphism
\(\varepsilon:H_X\times H_Y\to G_m\).
Under character descent, \(u^*L_m\) corresponds to the faithful
chosen character of \(G_m\) composed with \(\varepsilon\).
Its restriction to \(H_Y\) corresponds exactly to \(\xi_Y\).
Injectivity of (2.2) and faithfulness of the target character show
that its order equals \(|\varepsilon(H_Y)|\). Consequently
\[
                  \ell^cH_Y\subset\ker\varepsilon,
\]
which is invariance of the actual map \(r\), not just its induced
Jacobian homomorphism.

The original \(r\) is finite étale: it is finite and nonconstant,
and \(\pi_m r=u q\) is étale, so separability and ramification
indices force \(r\) to be étale. The quotient
\(W\to W/(\ell^cH_Y)\) is likewise finite étale. The descended
map (3.3) is an intermediate factor of \(r\), hence finite étale.
\(\square\)

The pullback \(C\times_X X_m\) is allowed to be disconnected.
Accordingly \(\varepsilon\) need not surject onto \(G_m\), and
\(u^*L_m\) need not retain order \(\ell^m\). Neither surjectivity
nor preservation of that order was used.

There is also an exact existence criterion before imposing (3.2):
such a lift exists if and only if
\[
                         u^*L_m\in\Lambda_X\oplus\Lambda_Y.
                                                                    \tag{3.6}
\]
Indeed this means that the associated line bundle becomes trivial
on \(W\). The resulting cyclic torsor is trivial as well: by the
Kummer sequence its only additional ambiguity comes from
\(k^*/(k^*)^{\ell^m}\), which is zero over algebraically closed
\(k\). Thus a section, equivalently an actual lift, exists.

## 4. Bounded Y-step, and the degree distinction

Since the deck groups are abelian, the cover in (3.3) has group
\[
 \operatorname{Gal}\bigl(W/(\ell^cH_Y)\,/\,C\bigr)
                      =H_X\times(H_Y/\ell^cH_Y).              \tag{4.1}
\]
In particular the degree over the actual X-axis quotient \(W/H_Y\)
is \(|H_Y/\ell^cH_Y|\). If \(H_Y\) is cyclic, this degree is at
most \(\ell^c\), independent of its original order. More generally,
if \(H_Y\) needs at most \(d_Y\) generators, the degree is at most
\(\ell^{c d_Y}\). Without a rank bound one has bounded residual
exponent, not a uniform residual degree.

For example, suppose \(C=W_{a,a}\) is fixed and all levels
\(W_{s,t}/C\) have the actual connected product tails
\[
 (\ell^a\mathbf Z_\ell/\ell^s\mathbf Z_\ell)
      \times(\ell^a\mathbf Z_\ell/\ell^t\mathbf Z_\ell),
 \qquad s,t\ge a,
\]
with compatible transition maps, the indicated coordinate quotients,
and character containment (2.5). For every \(s\ge a\),
\(t\ge a+c\), every cyclic target \(X_m/X\), and every actual
map \(r:W_{s,t}\to X_m\) whose composite to \(X\) descends to
some \(u:C\to X\), one has descent of \(r\) itself to
\[
                              W_{s,a+c}\longrightarrow X_m.
                                                                    \tag{4.2}
\]
The indices \(s,t,m\) need not agree. The single cutoff \(a+c\)
works for all of them and for all the maps \(u\) on the fixed
corner. The symmetric assertion holds for lifts to cyclic covers
of \(Y\), with the corresponding fixed isotypic intersection.

## 5. What this does not supply

No ordinary-Jacobian, Raynaud-theta, or mixed-vanishing hypothesis
was used in this character-descent theorem. Its additional input is
instead the **fixed-corner factorization** of the composite map in
(3.2), together with the actual product-cover character containment.

The current
[same-prime rectangle strip theorem](SAME_PRIME_GENERIC_RECTANGLES_AND_ONE_FACTOR_AXIS_DESCENT.md)
only gives, for a fixed target, descent to one of two strips whose
other coordinate can remain unbounded. It does not show that the
composite of a varying-target map descends to one fixed \(C\).
Thus that theorem does not automatically supply (3.2) for the fixed
corner required here.

If one replaces \(C\) by varying strip curves \(C_n\), their
Jacobians and the finite groups \(E_n\) also vary. This proof supplies
no uniform bound on their exponents. It must not be iterated across
such varying corners without an additional argument.

Finally, descent of the composite does not mean that the lift loses
both tower directions. For the canonical projection of an actual
rectangle to \(X_m\), the composite to \(X\) already descends to
the corner, while the lift can retain the entire X-direction. The
conclusion is precisely the uniformly bounded **opposite**, Y-direction
in (4.2). No cofinality, core, or solution of the common-cover problem
is asserted.
