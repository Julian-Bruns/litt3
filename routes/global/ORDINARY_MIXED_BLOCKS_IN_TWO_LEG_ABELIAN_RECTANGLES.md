# Ordinary mixed blocks in actual two-leg abelian rectangles

Date: 2026-09-05.
Authors: `/root` (proposed application) and
`/root/gluing_cohomology_rigidity` (derivation and proof checks).
Status: collaborative author proof; not independently audited.
No novelty, core-existence, or cofinality claim is made.
All earlier notes and the fixed curves are unchanged.

## 1. Hypotheses and the conditional conclusion

Let \(k=\overline{\mathbf F}_p\), and fix an actual correspondence
\[
 X\xleftarrow{f}Z\xrightarrow{g}Y
\]
of smooth proper connected hyperbolic curves, with both maps finite
étale. Suppose \(J(X)\) and \(J(Y)\) are geometrically simple and
nonisogenous. Put
\[
 A_X=J(X^{(1)}),\qquad A_Y=J(Y^{(1)}),\qquad
 \mathcal B_Z=F_{Z/k*}\mathcal O_Z/\mathcal O_{Z^{(1)}}.
\]
Consider the closed locus
\[
 D=\{(L,M)\in A_X\times A_Y:
 H^0(Z^{(1)},\mathcal B_Z\otimes(f^{(1)})^*L
                         \otimes(g^{(1)})^*M)\ne0\}.       \tag{1.1}
\]
Closedness follows from semicontinuity for the corresponding Poincaré
family. **Assume that \(D\) is proper.** This is an additional hypothesis;
it is not proved from simplicity, nonisogeny, or minimality of the
correspondence.

Choose distinct primes \(\ell_X,\ell_Y\ne p\). Let \(X_m/X\) and
\(Y_n/Y\) be the compatible connected maximal abelian étale covers of
exponents \(\ell_X^m\) and \(\ell_Y^n\), respectively. Thus their deck
groups have orders \(\ell_X^{2g(X)m}\) and
\(\ell_Y^{2g(Y)n}\). Put
\[
 R_{m,n}=Z\times_X X_m\times_Y Y_n.                       \tag{1.2}
\]
These fiber products are already smooth proper finite étale schemes
over \(Z\); they need not be connected.

**Theorem.** There are finite cutoffs \(a,b\ge0\) and a compatible choice
of connected components \(W_{m,n}\subset R_{m,n}\), for \(m\ge a,n\ge b\),
with the following properties. The assertions hold for every compatible
component choice.

1. Every \(W_{m,n}\) retains finite étale maps to \(Z,X_m,Y_n\).
2. Over \(W_{a,b}\), it is Galois with group \(K_X\times K_Y\), where
   \(K_X=\ker(\operatorname{Gal}(X_m/X)\to
                    \operatorname{Gal}(X_a/X))\), and likewise for \(K_Y\).
   These groups have relatively prime orders.
3. The mixed Jacobian quotient
   \[
   J(W_{m,n})\Big/
    \bigl(\operatorname{Im}J(W_{m,b})+
          \operatorname{Im}J(W_{a,n})\bigr)               \tag{1.3}
   \]
   is ordinary. The images are under actual pullback maps; all factor
   descriptions are up to isogeny.

In particular, writing \(\Delta(T)=g(T)-f(T)\), one has the exact identity
\[
 \Delta(W_{m,n})=\Delta(W_{m,b})+\Delta(W_{a,n})
                              -\Delta(W_{a,b}).           \tag{1.4}
\]
This controls the mixed part, not the two possibly nonordinary axis
parts.

## 2. Finite-support torsion cosets give horizontal and vertical strips

The full torsion-coset decomposition in
[the preceding note](BOXALL_TORSION_COSETS_AND_MAXIMAL_ABELIAN_DEFECT_EXPONENT.md#1-full-prime-power-torsion-decomposition)
extends from one prime to every fixed finite set \(S\) not containing
\(p\): for any abelian variety \(A\) and closed \(D_0\subset A\),
\[
 D_0(k)\cap A[S^\infty](k)
   =\bigcup_i\bigl(t_i+B_i[S^\infty](k)\bigr),
 \qquad t_i+B_i\subset D_0,                               \tag{2.1}
\]
with finitely many abelian subvarieties \(B_i\) and \(S\)-primary points
\(t_i\).

For completeness, the two changes in that proof are as follows. The
[checked prime-isolation lemma](FINITE_NONORDINARY_TARGETS_IN_FINITE_SUPPORT_ABELIAN_TOWERS.md#2-the-finite-prime-support-torsion-lemma)
supplies a Frobenius power moving any nonrational \(S\)-primary point
by a nonzero point of \(A[\ell]\) for some \(\ell\in S\). There are still
only finitely many possible translations, so the same dimension
induction applies after quotienting the full reduced stabilizer.
For lifting the resulting cosets, take the \(S\)-primary part of a
torsion lift; the finite component group of an inverse-image subgroup
contributes only its finitely many \(S\)-primary components. This proves
(2.1), including for supports of nonreduced loci, without a simplicity
assumption on \(A\).

Every abelian subvariety of \(A_X\times A_Y\) is one of
\[
 0,\quad A_X\times0,\quad0\times A_Y,\quad A_X\times A_Y.
\]
Indeed, a subvariety projecting nontrivially to \(A_X\) projects
surjectively. The reduced identity component of its kernel is either
zero or \(A_Y\). In the first case the projection is an isogeny (its
finite kernel need not be reduced), so the subvariety is isogenous to \(A_X\),
so its projection to \(A_Y\) must be zero; in the second case it is the
whole product. The other cases follow by symmetry. Simplicity and
nonisogeny are unchanged by Frobenius twist.

Apply (2.1) with \(A=A_X\times A_Y\),
\(S=\{\ell_X,\ell_Y\}\), and \(D_0=D\). Properness excludes a full-product
coset. The bad \(S\)-primary points are therefore a finite union of
horizontal torsion strips, vertical torsion strips, and individual
torsion points. Consequently there are cutoffs \(a_\theta,b_\theta\)
such that, for all \(m,n\),
\[
 \begin{gathered}
 L\in A_X[\ell_X^m],\quad M\in A_Y[\ell_Y^n],\\
 L\notin A_X[\ell_X^{a_\theta}],\quad
 M\notin A_Y[\ell_Y^{b_\theta}]
 \quad\Longrightarrow\quad (L,M)\notin D.                 \tag{2.2}
 \end{gathered}
\]
For example, \(a_\theta\) bounds the \(\ell_X\)-orders of the finitely
many fixed X-coordinates of vertical strips and isolated points, while
\(b_\theta\) bounds the corresponding fixed Y-coordinates. A fixed
coordinate with another primary component never occurs in the relevant
rectangle and can be discarded.

## 3. The high-high character block is ordinary

The full, possibly disconnected \(R_{m,n}/Z\) is a torsor under
\(G_{X,m}\times G_{Y,n}\), where these are the full axis deck groups.
Its structure-sheaf direct image decomposes into character line bundles
indexed by
\[
 A_X[\ell_X^m](k)\times A_Y[\ell_Y^n](k).
\]
On the relative Frobenius twist, the label \((L,M)\) has kernel
\[
 H^0(Z^{(1)},\mathcal B_Z\otimes(f^{(1)})^*L
                         \otimes(g^{(1)})^*M).            \tag{3.1}
\]
This follows from the Frobenius exact sequence, projection formula,
and étale pullback for \(\mathcal B\), just as in
[the earlier twist calculation](BOXALL_TORSION_COSETS_AND_MAXIMAL_ABELIAN_DEFECT_EXPONENT.md#proof-including-the-whole-nilpotent-part).
It remains true if a nontrivial pair pulls back to the trivial line
bundle on \(Z\): the preceding map on constant sections is then an
isomorphism.

Semilinear Frobenius sends character labels to \((L^p,M^p)\), preserving
each individual prime-power order. Hence the direct sum of the
high-high character spaces in (2.2) is Frobenius-stable and has zero
Frobenius kernel. Frobenius on this entire block is bijective. This is
ordinarity of the block, not merely a bound on its first kernel.

## 4. Actual connected components and the finite initial stage

Choose compatible points over a point of \(Z\). Let \(U_m\) be the
resulting component of \(Z\times_X X_m\), and let \(V_n\) be the
corresponding component of \(Z\times_Y Y_n\).

The image of \(\pi_1(Z)\) in the maximal abelian pro-\(\ell_X\) quotient
\(\mathbf Z_{\ell_X}^{2g(X)}\) of \(\pi_1(X)\) has index dividing
\(\deg f\), since \(\pi_1(Z)\) has that finite index in \(\pi_1(X)\).
This image therefore contains
\(\ell_X^{v_{\ell_X}(\deg f)}\mathbf Z_{\ell_X}^{2g(X)}\).
The analogous statement holds on the Y-axis. Thus one may take
\[
 a\ge\max(a_\theta,v_{\ell_X}(\deg f)),\qquad
 b\ge\max(b_\theta,v_{\ell_Y}(\deg g)).                    \tag{4.1}
\]
For \(m\ge a\), the full kernel \(K_X=\ker(G_{X,m}\to G_{X,a})\)
preserves every component of \(Z\times_X X_m\); its action on \(U_m\)
has quotient \(U_a\). The component count has stabilized. The same
holds for \(K_Y\) and \(V_n/V_b\).

Each \(U_m/Z\) is connected Galois of \(\ell_X\)-power degree, and
each \(V_n/Z\) is connected Galois of \(\ell_Y\)-power degree.
Their degrees are coprime, so they are linearly disjoint and
\[
 W_{m,n}=U_m\times_Z V_n
\]
is connected. These are exactly the component types of \(R_{m,n}\).
Furthermore,
\[
 \operatorname{Gal}(W_{m,n}/W_{a,b})=K_X\times K_Y,
\]
with quotients by \(K_X\) and \(K_Y\) equal to \(W_{a,n}\) and
\(W_{m,b}\), respectively. Every map just used is an actual finite
étale map, and the projections to \(X_m,Y_n\) remain finite étale.

## 5. Restricting the projector and computing the defect

In the rational endomorphism algebra define the averaging projectors
\[
 e_X=|K_X|^{-1}\sum_{h\in K_X}h,\qquad
 e_Y=|K_Y|^{-1}\sum_{h\in K_Y}h,
 \qquad e_{\rm mix}=(1-e_X)(1-e_Y).
\]
Their denominators are prime to \(p\), so they also act on coherent
cohomology. On the full rectangle, a character is nontrivial on
\(K_X\) exactly when its X-order exceeds \(\ell_X^a\); the analogous
statement holds for \(K_Y\). Thus \(e_{\rm mix}\) projects onto a
subblock of the ordinary high-high block in Section 3.

By Section 4 both tail groups preserve each connected component.
Consequently this projector restricts componentwise, as does absolute
Frobenius. Its image on each \(H^1(W_{m,n},\mathcal O)\) is therefore
Frobenius-bijective. This proves that the corresponding abelian factor
is ordinary. One must not instead assume that the full original deck
group acts on an individual component.

The images of \(e_X,e_Y,e_Xe_Y\) are, up to isogeny, the pullbacks of
\(J(W_{a,n}),J(W_{m,b}),J(W_{a,b})\). The four commuting projectors
\[
 e_Xe_Y,\quad(1-e_X)e_Y,\quad e_X(1-e_Y),\quad
 (1-e_X)(1-e_Y)
\]
give the old, X-only, Y-only, and mixed factors. The last is ordinary,
which proves (1.3). Additivity of genus and \(p\)-rank under isogeny
then gives (1.4).

The remaining nonordinary factors need not be bounded as \(m,n\) grow:
they may continue to arise along the two axis towers. This theorem
does not prove that a map to another curve factors through either
axis, that the original correspondence has a core, or that these
rectangles are cofinal in its recursive correspondence tower.
