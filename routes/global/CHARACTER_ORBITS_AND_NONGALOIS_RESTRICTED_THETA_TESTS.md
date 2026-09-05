# Character orbits and non-Galois restricted-theta tests

Date: 2026-09-05. Author: /root.
Status: author proof. The character-orbit and direct-product arguments
were separately checked by /root/gluing_cohomology_rigidity; the
non-Galois refinements below have not yet had a separate check.

This strengthens the [user-supplied Pro socle criterion](SOCLE_CRITERION_FOR_RESTRICTED_RAYNAUD_THETA.md).
The strengthening uses several deck-character twists, rather than only
the untwisted point, and retains the subgroup specifying an actual
non-Galois cover. No literature novelty claim is made.

## 1. Setup

Let \(k\) be algebraically closed of characteristic \(p>0\), and let
\(q:W\to C\) be a connected finite étale Galois cover of smooth projective
curves of genus at least two, with finite group \(G\). Write \(q_1\) for
its Frobenius twist. Put
\[
 D(L)=H^0(W^{(1)},B_W\otimes q_1^*L),\qquad
 D_0=D(\mathcal O),\qquad a(W)=\dim D_0,
 \quad L\in J(C^{(1)}).
\]
Let \(\mathcal X=\operatorname{Hom}(G,k^*)\), a finite group of
prime-to-\(p\) characters. It acts on the finite set of simple
\(kG\)-modules by tensor product. A character orbit is called nonlinear
if its simple modules have dimension greater than one.

For each simple \(S\), define
\[
 a_S=\dim\operatorname{Hom}_{kG}(S,D_0),\qquad
 \nu_S=\min_L\dim\operatorname{Hom}_{kG}(S,D(L)).
\]
The minima hold simultaneously on a nonempty open subset. Indeed,
torsor descent identifies these Hom spaces with
\[
 H^0(C^{(1)},B_C\otimes L\otimes E_S),\qquad
 E_S=(q_{1*}\mathcal O_{W^{(1)}}\otimes S^\vee)^G,
\]
where \(E_S\) is locally free of rank \(\dim S\). Upper semicontinuity
applies. This identity uses descent, not exactness of invariants.
See [Stacks, Lemma 35.6.2](https://stacks.math.columbia.edu/tag/0CDQ).

For a character \(\chi\), its associated line bundle \(L_\chi\) on
\(C^{(1)}\) has trivial pullback with the specified character
linearization. With a consistent sign convention,
\[
                    D(L\otimes L_\chi)\simeq D(L)\otimes\chi.
                                                               \tag{1}
\]
Replacing every \(\chi\) by \(\chi^{-1}\) makes no difference below.

## 2. Generic socle multiplicities are constant on character orbits

**Theorem 1.** For every character orbit \(\mathcal O\), the numbers
\(\nu_S\), \(S\in\mathcal O\), are equal to a number \(\nu_{\mathcal O}\).
Moreover
\[
             0\le\nu_{\mathcal O}\le\min_{S\in\mathcal O}a_S.       \tag{2}
\]
For one-dimensional simples, \(\nu_S=0\).

**Proof.** Translation by \(L_\chi\) is an automorphism of the parameter
Jacobian. Taking minima in (1) therefore gives
\(\nu_S=\nu_{S\otimes\chi}\). Semicontinuity gives \(\nu_S\le a_S\),
proving (2). For a one-dimensional \(S\), \(E_S\) is a degree-zero
torsion line bundle. Raynaud's theta theorem gives generic vanishing
of \(H^0(B_C\otimes L\otimes E_S)\).
\(\square\)

Thus one missing member of a character orbit in the original socle
excludes the entire orbit from the generic socle.

**Corollary 2.** If no complete nonlinear character orbit is contained
in the simple support of \(\operatorname{Soc}(D_0)\), then
\[
                            D(L)=0\quad\text{generically}.        \tag{3}
\]

Indeed, Theorem 1 makes the generic socle zero. A nonzero
finite-dimensional module over a finite-dimensional algebra always has
a nonzero simple submodule, so the whole module must be zero.

This allows nonlinear simples in the original socle. It is strictly
weaker as a representation-theoretic hypothesis than requiring their
complete absence. An algebraically realized strict example is not
asserted here.

Define
\[
 b_p(G)=\min_{\mathcal O\ {\rm nonlinear}}
                |\mathcal O|\dim S_{\mathcal O},
\]
with \(b_p(G)=+\infty\) if there are no nonlinear simples. If
\(\delta_q\) denotes the generic dimension of \(D(L)\), then
\[
             \delta_q=0\quad\text{or}\quad
                    b_p(G)\le\delta_q\le a(W).                    \tag{4}
\]

To prove the new lower bound, choose a nonlinear orbit with
\(\nu_{\mathcal O}>0\). At a point where all Hom dimensions are minimal,
the socle contains at least one copy of each of its pairwise
nonisomorphic simples. Its dimension is at least
\(|\mathcal O|\dim S_{\mathcal O}\).
The upper bound is semicontinuity at the origin.
In particular \(a(W)<b_p(G)\) suffices for (3).
The quantity \(\delta_q\) is a twisted section dimension, not
\(g(W)-f_W\).

## 3. Retaining the actual non-Galois intermediate

Fix \(H\le G\), put \(Z=W/H\), and let \(f:Z\to C\) be the resulting
actual finite étale cover. It need not be Galois. Let
\[
                         M_H=k[G/H]
\]
be its permutation module, and let \(\mathcal I_H\) be the set of its
simple composition factors. This set means Jordan--Hölder support,
not direct-summand support.

Descent of sections gives
\[
 H^0(Z^{(1)},B_Z\otimes f^{(1)*}L)=D(L)^H
                    =\operatorname{Hom}_{kG}(M_H,D(L)).           \tag{5}
\]

**Theorem 3.** Suppose that every nonlinear character orbit meeting
\(\mathcal I_H\) has at least one member absent from
\(\operatorname{Soc}(D_0)\). Then the group in (5) is zero generically.

**Proof.** On the common generic open of Theorem 1, no simple in
\(\mathcal I_H\) occurs as a submodule of \(D(L)\): the nonlinear
ones are excluded by (2), and characters are excluded by Raynaud.
If a nonzero map \(M_H\to D(L)\) existed, its nonzero image would have
a simple submodule \(S\). Since that image is a quotient of \(M_H\),
\(S\) would be a composition factor of \(M_H\). It would also be a
simple submodule of \(D(L)\), a contradiction. This proves (5).
\(\square\)

This is valid when \(p\mid|G|\). It neither replaces \(D(L)\) by a
semisimplification nor takes invariants through an arbitrary exact
sequence.

Consequently failure of restricted properness for the specified
non-Galois cover forces a complete nonlinear orbit in the original
socle, with at least one member occurring in \(k[G/H]\). Simple
representations invisible to this permutation module need not be
excluded. This can be substantially less demanding than proving
properness for the full Galois closure.

A numerical necessary condition follows by setting
\[
 b_p(G,H)=\min_{\substack{\mathcal O\ {\rm nonlinear}\\
                         \mathcal O\cap\mathcal I_H\ne\varnothing}}
                   |\mathcal O|\dim S_{\mathcal O}.
\]
With the usual empty-minimum convention, \(a(W)<b_p(G,H)\) suffices
for properness on \(Z\). This is a bound on \(a(W)\), not on \(a(Z)\).

## 4. Exact generic dimensions when the group order is prime to p

Assume now \(p\nmid|G|\). Maschke's theorem makes \(D(L)\)
semisimple. For an orbit \(\mathcal O\), put
\[
                     w_H(\mathcal O)=\sum_{S\in\mathcal O}\dim S^H.
\]
The generic section dimension on the actual intermediate is exactly
\[
 \delta_f
   =\sum_{\mathcal O\ {\rm nonlinear}}
                     \nu_{\mathcal O}w_H(\mathcal O).              \tag{6}
\]
It follows that
\[
 \delta_f=0\quad\text{or}\quad
 \min_{\substack{\mathcal O\ {\rm nonlinear}\\w_H(\mathcal O)>0}}
          w_H(\mathcal O)\le\delta_f\le a(Z).                       \tag{7}
\]
Again an empty minimum means \(+\infty\).
Unlike (4), this lower bound uses fixed vectors and can be one.
It does not imply properness merely from \(a(Z)\le1\).
Formula (6) is not asserted in modular characteristic.

## 5. An ordinary quotient by an abelian direct factor

**Corollary 4.** Suppose \(G=A\times Q\) with \(A\) finite abelian,
and the actual curve \(W/A\) is ordinary. Then (3) holds, and so
restricted properness holds for every intermediate \(W/H\to C\).
The characteristic may divide either factor's order.

**Proof.** On a simple \(kG\)-module the central group \(A\) acts by
a character, by Schur's lemma. Its \(p\)-part acts trivially, since
\(k^*\) has no nontrivial \(p\)-power torsion. This character extends
to \(G=A\times Q\). Twisting by its inverse therefore gives an
\(A\)-trivial member of the character orbit of every simple.

But
\[
                    D_0^A=H^0((W/A)^{(1)},B_{W/A})=0
\]
by étale descent and ordinarity. No \(A\)-trivial simple can occur
in \(\operatorname{Soc}(D_0)\). Every nonlinear orbit is therefore
missing a member, and Corollary 2 applies.
\(\square\)

Centrality and extension of the character are essential to this proof.
An arbitrary normal abelian subgroup cannot replace the direct factor
without proving the corresponding character-extension property.

## 6. Computational and strategic meaning

For an explicit cover it suffices to compute the simple socle support
of its Cartier kernel, partition the simples into character orbits,
and, for a non-Galois leg, retain the orbits meeting the permutation
module of its actual stabilizer. One can also use the more flexible
test at separately chosen translated points from the linked socle
note. These are finite certificates of generic vanishing, not a claim
that a bounded number of numerical tests settles every unknown cover.

For an actual two-leg correspondence, properness on either axis
implies the two-leg claim (R). None of the hypotheses of Theorem 3
has been deduced here from the existence or minimality of the second
étale map. Perfect groups have no nontrivial character twists, so the
orbit strengthening alone does not address that important case.
No simultaneous Galois envelope, cofinal tower, or counterexample to
Litt's problem is obtained.
