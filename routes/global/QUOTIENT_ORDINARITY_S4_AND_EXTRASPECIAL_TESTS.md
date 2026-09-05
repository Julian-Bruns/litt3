# Quotient ordinarity: an S4 induction test and an extraspecial boundary

**Status:** exact representation-theoretic tests, checked 2026-09-05.
**Author/checker:** canonical_trace_algebra.
**Scope:** conditional statements about the quotients of an **actual** finite
Galois étale cover. No geometric realization of a proposed nilpotent module
is asserted. This note supplements, and does not duplicate, the general
projective-nilpotent quotient theorem.

Let \(k\) be algebraically closed of characteristic \(p\), let \(W\to Y\)
be a connected finite Galois étale cover with group \(G\), and put
\[
 N=H^1(W,\mathcal O_W)_{\mathrm{nil}},\qquad
 \Delta(C)=g(C)-f(C).
\]
The quotient theorem gives
\[
 \Delta(W/H)=\dim_k N^H.
 \tag{1}
\]
In both tests below \(p\nmid |G|\), so \(N\) is semisimple as a
\(kG\)-module. Consequently identities between permutation modules give
identities between the corresponding defects. All curves occurring in such
an identity are quotients of this same \(W\).

## 1. A degree-six S4 quotient tests a degree-four quotient

Take \(p=5\), \(G=S_4\), and let

- \(H=S_3\) stabilize one letter;
- \(K=S_2\times S_2\) stabilize each block of the partition
  \(\{\{1,2\},\{3,4\}\}\);
- \(D=D_8\) stabilize this partition as an unordered pair of blocks.

Thus \(K\triangleleft D\), \([D:K]=2\). Define
\[
 Z=W/H,\qquad T=W/K,\qquad B=W/D.
\]
Their degrees over \(Y\) are respectively \(4,6,3\), and \(T\to B\) is
a connected étale double cover. Write \(\chi:D\to\{\pm1\}\) for the
character recording whether an element exchanges the two blocks.

Let \(\mathrm{Std}\) be the three-dimensional standard representation of
\(S_4\), and let \(U\) be its two-dimensional irreducible representation.
The exact module decompositions are
\[
 \begin{aligned}
 k[G/H]&=\mathbf1\oplus\mathrm{Std},\\
 k[G/D]&=\mathbf1\oplus U,\\
 k[G/K]&=\mathbf1\oplus U\oplus\mathrm{Std},\\
 \operatorname{Ind}_D^G\chi&=\mathrm{Std}.
 \end{aligned}
 \tag{2}
\]
For the last identity, the line spanned by \((1,1,-1,-1)\) in
\(\mathrm{Std}\) transforms under \(D\) by \(\chi\). Frobenius reciprocity,
irreducibility of \(\mathrm{Std}\), and equality of dimensions prove the
identity. Also
\(\operatorname{Ind}_K^D\mathbf1=\mathbf1\oplus\chi\), which proves the
third decomposition from the second and fourth.

As an elementary additional check, the incidence map from letters to
two-element subsets has matrix \(A\) satisfying
\[
 A^{\mathsf T}A=2I_4+J_4,\qquad
 \det(2I_4+J_4)=48\ne0\quad\text{in }k.
\]
Thus the four-letter permutation module embeds as a direct summand of
the six-subset permutation module. A separate enumeration of all
24 permutations checked both character identities in (2).

From
\[
 k[G/H]\oplus k[G/D]\simeq \mathbf1\oplus k[G/K]
\]
and (1) one obtains the exact identity
\[
 \boxed{\Delta(Z)+\Delta(B)=\Delta(Y)+\Delta(T).}
 \tag{3}
\]
This is a comparison of different intermediate covers: neither \(H\)
nor \(K\) contains the other, so it is not simply descent along a map
\(T\to Z\).

### The ordinary representation interpretation

For the actual double cover \(a:T\to B\), write
\[
 a_*\mathcal O_T=\mathcal O_B\oplus L_\chi.
\]
Since \(\chi\) has values in \(\mathbb F_5\), the decomposition is preserved
by Frobenius. Define
\[
 \delta_\chi=\dim H^1(B,L_\chi)_{\mathrm{nil}}
             =\Delta(T)-\Delta(B)\ge0.
\]
Then (3) is
\[
 \Delta(Z)=\Delta(Y)+\delta_\chi.
 \tag{4}
\]
In particular:
\[
 \boxed{Z\text{ ordinary}\iff
        Y\text{ ordinary and }\chi\text{ ordinary on }B.}
 \tag{5}
\]
Here ordinary for the finite character means that its associated
cohomology Frobenius is bijective, equivalently Raynaud's ordinary
representation condition. His Proposition 1(4) states precisely that
ordinarity is preserved and reflected by induction along an actual
finite étale cover; its proof identifies the induced bundle with the
finite pushforward. Thus (2) is an exact application of that proposition,
not an assumption that arbitrary constituents are induced characters.
See [Raynaud, *Revêtements des courbes en caractéristique p > 0 et
ordinarité*, Proposition 1(4), pp. 74–75](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).

Consequently \(T\) ordinary forces \(Z\) ordinary. If the **actual**
\(Z\) also maps finitely étale to a nonordinary curve \(X\), then \(Z\)
is nonordinary: \(J_X\) embeds up to isogeny into \(J_Z\), and an ordinary
abelian variety has only ordinary abelian subvarieties. If \(Y\) is
ordinary, (4) therefore forces this particular character \(\chi\) on
the actual cubic intermediate cover \(B\) to be nonordinary.

The criterion does not require \(W\) to be ordinary. For instance the
formal module \(N=\mathrm{sgn}\), with zero Frobenius, has no invariants
under \(G,H,K,D\), although \(N\ne0\). This tests the algebraic boundary
only: no curve realizing this formal module is asserted here.

## 2. Extraspecial groups: faithful quotients see every nonlinear block

Let \(\ell\ne p\) be prime and let \(G\) be an extraspecial group of order
\(\ell^{1+2n}\), \(n\ge1\). Put
\[
 C=Z(G)=[G,G],\qquad |C|=\ell.
\]
This statement covers both exponent types and also \(\ell=2\).
For a corefree subgroup \(H\le G\), one has \(H\cap C=1\).
Commutators and \(\ell\)-th powers of elements of \(H\) therefore vanish,
so \(H\) is elementary abelian. Its image in the symplectic vector space
\(G/C\) is isotropic. Hence \(|H|=\ell^r\) for some \(0\le r\le n\).

There are \(\ell^{2n}\) linear irreducibles, all trivial on \(C\). For
each nontrivial character \(\lambda:C\to k^\times\), there is exactly
one irreducible \(\rho_\lambda\) with this central character, of
dimension \(\ell^n\).

For completeness, uniqueness does not require an exponent assumption.
The central-character block \(kG e_\lambda\) has dimension \(\ell^{2n}\).
For every noncentral \(g\), the commutator map \([-,g]:G\to C\) is
surjective. Conjugation on \(g e_\lambda\) therefore has a nontrivial
scalar eigenvalue. It follows that the center of this block consists
only of \(k e_\lambda\). The block is semisimple and central simple,
so it is a full matrix algebra of size \(\ell^n\). The trivial central
block is \(k[G/C]\). In the odd-prime exponent-\(\ell\) case, the same
character statement and its induction proof appear explicitly in
[Green–Leary, *Chern Classes and Extraspecial Groups*, Lemma 3](https://arxiv.org/pdf/0711.5013).

The center \(C\) acts freely on \(G/H\). Thus the restriction of
\(k[G/H]\) to \(C\) is the regular representation of \(C\) repeated
\(\ell^{2n-r}\) times. Its \(\lambda\)-eigenspace consequently has this
dimension. Since \(\rho_\lambda\) is the unique irreducible with that
central character, its multiplicity is
\[
 \boxed{[k[G/H]:\rho_\lambda]
       =\dim\rho_\lambda^H=\ell^{n-r}>0.}
 \tag{6}
\]
More explicitly,
\[
 k[G/H]\simeq
 \bigoplus_{\substack{\chi\ \mathrm{linear}\\\chi|_H=1}}\chi
 \quad\oplus\quad
 \bigoplus_{\lambda\ne1}
       \rho_\lambda^{\oplus\ell^{n-r}}.
 \tag{7}
\]
Thus no faithful transitive permutation module omits a nonlinear
irreducible, for any \(n\).

### Consequence for actual covers, and the exact limitation

Now suppose that the actual abelian intermediate cover \(W/C\to Y\)
is ordinary. This follows, for example, from a hypothesis that all
connected abelian exponent-\(\ell\) étale covers of \(Y\) are ordinary.
By (1), \(N^C=0\), so all linear constituents of \(N\) vanish. Write
\[
 N=\bigoplus_{\lambda\ne1}\rho_\lambda^{\oplus m_\lambda}.
\]
Equations (1) and (6) give
\[
 \Delta(W/H)=\ell^{n-r}\sum_{\lambda\ne1}m_\lambda,\qquad
 \Delta(W)=\ell^n\sum_{\lambda\ne1}m_\lambda.
\]
Therefore
\[
 \boxed{\Delta(W)=|H|\,\Delta(W/H),\qquad
 W/H\text{ ordinary}\iff W\text{ ordinary}.}
 \tag{8}
\]
This is a limitation of the proposed quotient improvement: once the
linear blocks are controlled, a faithful non-Galois quotient cannot
hide any nonlinear nonordinary block for extraspecial monodromy.
It is not an exclusion of such monodromy and not a realization theorem.
Faithfulness matters: a subgroup containing \(C\) has zero invariants
in every \(\rho_\lambda\), and can hide all these blocks.

## 3. Boundaries of the tests

These examples use exact integer multiplicities, not the trace of an
averaging projector inside \(k\): the latter records a dimension only
modulo \(p\), and zero trace need not mean zero fixed space.
Neither example assumes that all finite-group irreducibles are
monomial or that ordinarity is closed under tensor products.
For general coefficients, semilinear Frobenius permutes Frobenius-twist
types, so an argument using individual isotypic pieces must retain
entire Frobenius orbits unless those pieces are already defined over
\(\mathbb F_p\), as in the S4 test above.
