# Mixed Jacobian vanishing has a uniformly bounded abelian residual

Date: 2026-09-05.
Author: `/root/canonical_trace_algebra`.
Section 7 extension proposed by `/root` and checked by the author.
Status: complete author proof, including the positive-characteristic adaptation;
not independently audited. No novelty claim.
All existing curves and earlier notes are unchanged.

## 1. Statement and the actual intermediate curve

Let \(k\) be algebraically closed, let \(W,T\) be smooth projective connected
curves, and assume that \(T\) is nonhyperelliptic of genus \(g\ge3\).
Let the finite group \(H=H_1\times H_2\) act freely on \(W\), and let
\(r:W\to T\) be finite étale. No group order is required to be prime to
\(\operatorname{char}k\). Assume
\[
 r_*(a_*-1)(b_*-1)=0:J_W\longrightarrow J_T
                    \qquad(a\in H_1,\ b\in H_2).                 \tag{1.1}
\]
Define the deliberately generous constants
\[
 d(g)=18g(g-1),\qquad
 B(g)=\binom{d(g)^2-1}{2}.                                      \tag{1.2}
\]

**Theorem.** Either one entire factor fixes \(r\), or the following all hold.

1. The subgroups
   \[
   K_i=\operatorname{Stab}_{H_i}(r)=\{h\in H_i:r h=r\}
   \]
   are normal, and \(Q_i=H_i/K_i\) are nontrivial abelian groups with
   \[
                            |Q_i|<B(g).                         \tag{1.3}
   \]
2. There is a constant biadditive pairing
   \[
       c:H_1^{\mathrm{ab}}\times H_2^{\mathrm{ab}}\to J_T(k).
   \]
   Its full left and right radicals are exactly \(K_1,K_2\).
   More strongly, for every \(b\notin K_2\) and \(a\notin K_1\),
   \[
       \ker c(-,b)=K_1,\qquad \ker c(a,-)=K_2.                  \tag{1.4}
   \]
3. Writing
   \[
       V=W/H,\qquad U=W/(K_1\times K_2),
   \]
   the original map factors as \(r=\bar r\circ q\) in an actual diagram
   \[
       W\xrightarrow{q}U\xrightarrow{\bar r}T,
       \qquad U\longrightarrow V.
   \]
   All three displayed maps are finite étale. The map \(U\to V\) is
   connected abelian Galois, with group \(Q_1\times Q_2\), and
   \[
                       \deg(U/V)<B(g)^2.                       \tag{1.5}
   \]

In the axis alternative, \(r\) descends étale to the corresponding
\(W/H_i\). The conclusion in the other alternative is a bounded abelian
intermediate over the **actual** quotient \(V\), not axis descent and not
a bound on \(\deg(U/T)\) independent of \(V\).

The same radical bounds hold for an arbitrary product action without
freeness; freeness is used here for the stated quotient degrees and
étaleness. The proof below stays with the free-action formulation.

## 2. The difference surface in positive characteristic

Choose an Abel embedding \(j:T\hookrightarrow J_T\), and put
\[
 S=T-T\subset J_T,\qquad
 \partial:T\times T\to S,\quad (x,y)\mapsto j(x)-j(y).
\]
All images and subvarieties in this note have their reduced structures.

**Lemma 2.1.** The difference map restricts to an isomorphism
\[
 (T\times T)\setminus\Delta_T\ \xrightarrow{\sim}\ S\setminus\{0\}.
                                                                    \tag{2.1}
\]
The surface \(S\) has the unique singular point \(0\). In particular
\[
                    \operatorname{Stab}(S)(k)=\{0\}.             \tag{2.2}
\]
Only the group of geometric translation points is asserted in (2.2);
no assertion about a possibly nonreduced stabilizer scheme is needed.

**Proof.** If \([x-y]=[x'-y']\), then
\(x+y'\sim x'+y\). On a nonhyperelliptic curve no two distinct effective
degree-two divisors are linearly equivalent: otherwise, after removing
their common fixed divisor, there would be a degree-at-most-two pencil,
contradicting nonhyperellipticity and \(g\ge3\).
Consequently, outside the diagonal, the two ordered pairs are equal.
The zero fiber is exactly the diagonal.

For scheme-theoretic (2.1), the Abel tangent line at \(x\), translated
to the origin, is the canonical point
\(\kappa_T(x)\in\mathbf P(T_0J_T)\). The canonical map of a
nonhyperelliptic curve is an embedding in every characteristic. Thus,
when \(x\ne y\), the two tangent lines are distinct, and the differential
of \(\partial\) has rank two. The restricted proper map in (2.1) is
quasi-finite, universally injective, and unramified. It is therefore a
closed immersion onto its reduced image, which is all of \(S\setminus\{0\}\).
This also proves that the latter is smooth.

For each \(x\in T\), the curve \(j(T)-j(x)\subset S\) passes through
\(0\) with tangent line \(\kappa_T(x)\). These lines span \(T_0J_T\),
because the canonical curve is nondegenerate. Hence
\(\dim T_0S=g>2=\dim S\), and \(0\) is singular. Translation preserving
\(S\) preserves its unique singular point, so the translation is zero.
\(\square\)

The off-diagonal statement is the precise primary-source near-match:
O. de Gaay Fortman and S. Schreieder,
[*Abelian varieties with no power isogenous to a Jacobian*](https://doi.org/10.1112/S0010437X25007171),
Compositio Math. 161 (2025), 1404–1457, Lemma 2.4, p. 1411
([open primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/D3145F1DE2164C41EC1115B358B019C6/S0010437X25007171a.pdf/abelian-varieties-with-no-power-isogenous-to-a-jacobian.pdf)).
Its proof and the surrounding hypotheses were inspected. The paper works
over \(\mathbf C\); the degree-two and differential argument above gives
the required positive-characteristic proof. In particular we do **not**
import its statements about multiplication maps on \(S\) or Gauss-map
ramification into characteristic \(p\).

## 3. A uniform bound for translation groups on curves in the difference surface

Fix a theta divisor \(\Theta\) representing the principal polarization of
\(J_T\), and embed \(J_T\) by the very ample line bundle \(3\Theta\).
The numerical Poincaré formula and the Pontryagin product give
\[
 [S]=\frac{2\Theta^{g-2}}{(g-2)!},\qquad
 \deg_{3\Theta}S=18g(g-1)=d(g).                                \tag{3.1}
\]
These are numerical intersection equalities, valid in every
characteristic. One can also check the second equality directly on
\(T\times T\): if \(F_1,F_2\) are its fiber classes, then
\[
 \partial^*\Theta\equiv(g-1)(F_1+F_2)+\Delta_T,
 \qquad (\partial^*\Theta)^2=2g(g-1).
\]
Here \(F_i^2=0\), \(F_1F_2=F_i\Delta_T=1\), and
\(\Delta_T^2=2-2g\); the pullback formula is the usual theorem-of-the-square
formula for the Abel embedding. Birationality of \(\partial\) then
gives (3.1).

**Lemma 3.1.** If an integral curve \(D\subset S\) is preserved by a
finite subgroup \(A\le J_T(k)\) of translations, then
\[
                               |A|<B(g).                       \tag{3.2}
\]

**Proof.** If \(A=\{0\}\), the assertion is immediate. Otherwise choose
\(a\in A\setminus\{0\}\). By (2.2), \(S+a\ne S\). Both surfaces
contain \(D\), so their intersection has dimension at most one and
\(D\) is one of its irreducible components. Translation preserves
numerical degree under the fixed \(3\Theta\) embedding. The projective
Bézout inequality for irreducible components, including excess
intersections, gives
\[
                             \deg D\le d(g)^2.                 \tag{3.3}
\]
Equivalently, project the two distinct surfaces generically to
\(\mathbf P^3\), with distinct surface images and with degree preserved
on \(D\), and apply ordinary Bézout there. This avoids treating the
intersection as a proper intersection in the much larger ambient
projective space.

Let \(\widetilde D\) be the smooth normalization of \(D\). Since
\(D\not\subset\{0\}\), (2.1) lifts its generic point to \(T\times T\).
At least one projection gives a nonconstant rational map
\(\widetilde D\dashrightarrow T\), which extends to a morphism.
It follows that \(g(\widetilde D)\ge2\). This remains true even for
an inseparable morphism: factor off Frobenius and apply separable
Riemann–Hurwitz to a Frobenius twist of \(\widetilde D\).

A generic birational plane projection of an integral projective curve
of degree \(e\) bounds its normalization genus by
\((e-1)(e-2)/2\). Applying (3.3) gives
\[
                          g(\widetilde D)\le B(g).              \tag{3.4}
\]
The translations in \(A\) lift uniquely and faithfully to
\(\widetilde D\). They act freely: a fixed point upstairs would map
to a fixed point of a nonzero translation on \(J_T\), which is
impossible. The quotient \(\widetilde D\to\widetilde D/A\) is thus a
finite étale torsor under the constant finite group \(A\), even if
\(\operatorname{char}k\mid |A|\). Consequently
\[
 g(\widetilde D)-1
      =|A|\bigl(g(\widetilde D/A)-1\bigr).
\]
The left side is positive, so the quotient has genus at least two and
\(|A|\le g(\widetilde D)-1<B(g)\), as claimed. \(\square\)

## 4. The constant pairing and its exact kernels

Write \(A_W=j\circ r:W\to J_T\). For \(a\in H_1,b\in H_2\), let
\[
 c_{a,b}(w)=A_W(abw)-A_W(aw)-A_W(bw)+A_W(w).                   \tag{4.1}
\]
The induced homomorphism on \(J_W\) is (1.1), so the universal property
of the Jacobian makes (4.1) constant. Write its value as \(c(a,b)\).
Changing the base point of the Abel embedding does not change (4.1).

Constancy and the commuting product action give
\[
 c(aa',b)=c(a,b)+c(a',b),\qquad
 c(a,bb')=c(a,b)+c(a,b').                                     \tag{4.2}
\]
For example the first identity follows by splitting (4.1) into the
mixed difference for \((a,b)\) evaluated at \(a'w\) and that for
\((a',b)\) evaluated at \(w\). Hence \(c\) is biadditive and factors
through the two abelianizations. Its values are torsion, killed by
both relevant element orders; no division by those orders is used.

Assume now that neither entire factor fixes \(r\). Fix
\(b\in H_2\setminus K_2\), and put
\[
 \delta_b:W\to S,\qquad
 \delta_b(w)=j(rb w)-j(rw).                                    \tag{4.3}
\]
The map \(\delta_b\) is nonconstant. Otherwise the curve image of
\((rb,r):W\to T\times T\) would lie in one fiber of \(\partial\).
The only positive-dimensional fiber is the diagonal, which would
give \(rb=r\), contrary to the choice of \(b\).
Let \(D_b=\delta_b(W)\), an integral projective curve in \(S\).
Equation (4.1) says
\[
                      \delta_b(aw)=\delta_b(w)+c(a,b).          \tag{4.4}
\]
It follows that \(\operatorname{im}c(-,b)\) preserves \(D_b\).

If \(c(a,b)=0\), the two ordered pairs
\((rbaw,raw)\) and \((rbw,rw)\) have the same difference.
At the generic point they lie off the diagonal, so (2.1) implies
\(ra=r\). Conversely, if \(ra=r\), commutativity gives
\(rba=rab=rb\), so (4.4) has zero translation. Therefore
\[
                         \ker c(-,b)=K_1.                      \tag{4.5}
\]
In particular \(K_1\) is normal and \(H_1/K_1\) is abelian.
Lemma 3.1 applied to its faithful translation image gives
\[
                         [H_1:K_1]<B(g).                      \tag{4.6}
\]
The image is nontrivial in this non-axis case: otherwise (4.5) would
say \(K_1=H_1\). Thus no nontrivial-group step above is being applied
to a trivial image. A trivial stabilizer \(K_1=1\), on the other
hand, causes no problem: then the whole finite group \(H_1\)
embeds into the translation group and satisfies (4.6).

Every element of \(K_1\) pairs to zero with **all** \(H_2\), again by
commutativity. Conversely, a point in the full left radical lies in
the kernel for the single chosen \(b\), hence in \(K_1\) by (4.5).
The full left radical is exactly \(K_1\), independently of the choice
of \(b\notin K_2\). Interchanging the factors proves all the analogous
statements for \(K_2\), including (1.4).

If one whole factor fixes \(r\), (4.1) instead gives \(c=0\), whose
full radicals are both entire factors. In that case one must **not**
identify the other full radical with its possibly smaller stabilizer
of \(r\). This is why the precise radical identification is stated
only in the non-axis case.

## 5. Retaining both the original map and étaleness

There is an additional geometric fact about (4.3) useful in applications.
The map \(W\to D_b\) lifts to its normalization \(\widetilde D_b\).
By (2.1), the two projections from its generic point recover \(rb\)
and \(r\). They extend to maps \(\widetilde D_b\to T\), and
\[
             r:W\longrightarrow\widetilde D_b\longrightarrow T
                                                                    \tag{5.1}
\]
is the original map, not a replacement correspondence. Both factors
of (5.1) are finite étale. Indeed their function fields are intermediate
fields in the separable extension defined by \(r\), and multiplicativity
of ramification indices gives \(1=e(r)=e_1e_2\) at every point.
Residue fields are \(k\), so unramified finite maps between these smooth
curves are étale. The same holds for the factorization of \(rb\).

For the claimed group-theoretic intermediate, invariance under \(K_1\)
and \(K_2\) gives invariance under \(K=K_1\times K_2\), so
\(r\) descends to \(\bar r:U=W/K\to T\).
Normality gives a faithful action of
\[
                 H/K=Q_1\times Q_2
\]
on \(U\), whose quotient is \(V=W/H\). Since the original action
on \(W\) is free, \(W\to V\), \(W\to U\), and \(U\to V\)
are finite étale. Their degrees are the corresponding group orders,
proving (1.5). The factorization of the finite étale map \(r\)
through \(W\to U\) proves that \(\bar r\) is finite étale by the
same ramification-index argument. This completes the theorem.

## 6. Conditional ordinary-mixed application and scope

Let \(P_{\mathrm{mix}}\subset J_W\) be the abelian subvariety generated
by the images
\[
                         (a_*-1)(b_*-1)J_W.
\]
If \(\operatorname{Hom}(P_{\mathrm{mix}},J_T)=0\), then (1.1) holds.
In particular, over \(\overline{\mathbf F}_p\), this follows when
\(P_{\mathrm{mix}}\) is ordinary and \(J_T\) has no ordinary simple
isogeny factor. Under that **additional verified input**, every actual
étale map \(r\) to a nonhyperelliptic \(T\) either descends to an axis
or descends to the bounded abelian intermediate above.

This refines the unbounded abelian residual in
[the preceding mixed-vanishing note](MIXED_JACOBIAN_VANISHING_REDUCES_TO_ABELIAN_OR_METABELIAN_QUOTIENTS.md).
It does not replace the stronger axis conclusion under coprime group
orders in
[the coprime-product theorem](COPRIME_PRODUCT_MIXED_JACOBIAN_VANISHING_FORCES_DESCENT.md).
Nor does it prove the properness or ordinarity hypotheses of
[the conditional two-leg rectangle construction](ORDINARY_MIXED_BLOCKS_IN_TWO_LEG_ABELIAN_RECTANGLES.md).
No automatic mixed vanishing, rectangle cofinality, common core, or
solution of the common-cover problem is asserted.

Positive-dimensional intersections of translates of \(W_2(T)\) alone
would not suffice: if \(c=[x-y]\), then \(x+T\) lies in
\(W_2(T)\cap(W_2(T)+c)\). The proof uses the stronger consequence of
the **actual group action**, namely that a finite translation group
preserves the same difference-image curve \(D_b\).

Finally, the nonhyperelliptic hypothesis is substantive for this proof.
For hyperelliptic \(T\), the off-diagonal difference map generally has
degree two; its image can contain elliptic curves, for example when
\(T\) is also bielliptic. Then the normalization-genus and kernel
arguments above need not apply. The following section supplies a
different sufficient hypothesis for a bounded hyperelliptic residual;
without that hypothesis no hyperelliptic bound or actual counterexample
is claimed here.

## 7. Hyperelliptic extension when the Jacobian has no elliptic factor

In this section assume \(\operatorname{char}k\ne2\), as in the intended
characteristic-five application. Replace nonhyperellipticity by
\[
 \begin{gathered}
 T\text{ hyperelliptic},\quad g(T)=g\ge3,\\
 J_T\text{ contains no elliptic abelian subvariety}.
 \end{gathered}                                                \tag{7.1}
\]
For example, a geometrically simple \(J_T\) of dimension at least three
satisfies the last condition. No ordinarity hypothesis is involved in
this geometric extension.

**Theorem 7.1.** Retain the free product action, the actual finite étale
map \(r\), and (1.1). Either one whole factor fixes \(r\), or its
stabilizers \(K_i=\operatorname{Stab}_{H_i}(r)\) satisfy
\[
                         [H_i:K_i]<2B(g).                     \tag{7.2}
\]
Consequently \(r\) descends through the actual finite étale curve
\[
 U=W/(K_1\times K_2),\qquad
 U\longrightarrow V=W/(H_1\times H_2),
 \qquad \deg(U/V)<4B(g)^2,                                   \tag{7.3}
\]
and \(U\to T\) is finite étale. The \(K_i\) are not asserted to be
normal in general, so \(U\to V\) is not asserted to be Galois.
If both \(H_i\) are abelian, it is abelian Galois with group
\((H_1/K_1)\times(H_2/K_2)\).

### 7.1 The surface and the genus condition

Let \(\iota\) be the hyperelliptic involution and \(L_2\) its unique
degree-two pencil class. Identifying the appropriate Picard varieties
by translation,
\[
      S=T-T=W_2(T)-L_2,\qquad
      [x-y]=[x+\iota(y)-L_2].                                \tag{7.4}
\]
The Abel map
\[
       a_2:\operatorname{Sym}^2T\to W_2(T)
\]
has exactly one positive-dimensional fiber, the pencil
\(|L_2|\simeq\mathbf P^1\). It is an isomorphism outside that fiber.
Indeed all other degree-two effective divisors have \(h^0=1\), so
their Abel fibers are singletons and the Abel differential is injective.
Properness, universal injectivity, and this differential assertion
give the isomorphism as in Lemma 2.1, now on the smooth symmetric square.

The differential assertion, including repeated-point divisors, is
[Milne, *Jacobian Varieties*, Theorem 5.1(b)](https://www.jmilne.org/math/xnotes/JVs.pdf),
whose proof on pp. 16–19 was inspected. It is valid over a general
field: the differential kernel has dimension \(h^0(D)-1\), by the
evaluation of regular differentials and Riemann–Roch. Thus no
characteristic-zero smoothness assertion is needed here.

It follows that \(S\) is smooth away from \(0\). As before the curves
\(j(T)-j(x)\) show that \(\dim T_0S=g>2\). Hence \(0\) is again its
unique singular point, and
\[
                    \operatorname{Stab}(S)(k)=0.              \tag{7.5}
\]
Here
\[
                    \deg_{3\Theta}S=9g(g-1)\le d(g),          \tag{7.6}
\]
because \(S\) is a translate of \(W_2\); equivalently the difference
map has generic degree two in the intersection calculation of (3.1).
Every nonzero fiber of \(\partial:T\times T\to S\) is finite: in
(7.4) it factors through the finite degree-two symmetric quotient
followed by the Abel isomorphism off the pencil.

For any integral curve \(D\subset J_T\), its normalization has genus
at least one, since an abelian variety contains no rational curves.
If the normalization had genus one, choosing an origin on it would
make its map to \(J_T\) a translate of a nonzero homomorphism from an
elliptic curve. Its image would be an elliptic abelian subvariety,
contrary to (7.1). Therefore every such normalization has genus at
least two. With this replacing the map-to-\(T\) argument of Lemma 3.1,
(7.5) and (7.6) prove the same bound
\[
 |A|<B(g)
 \quad\text{for every finite translation group preserving a curve }
 D\subset S.                                                  \tag{7.7}
\]
The case \(A=0\) remains immediate.

### 7.2 A two-element ambiguity, not an exact kernel identification

Suppose neither factor fixes \(r\), and fix \(b\in H_2\) with
\(rb\ne r\). Define \(\delta_b\) as in (4.3). It is nonconstant:
a constant nonzero difference would force the curve \((rb,r)(W)\)
into a finite fiber of \(\partial\), while a zero difference would
give \(rb=r\). Thus its image is a curve in \(S\).

Set
\[
       R_1=\ker\bigl(c(-,b):H_1\to J_T(k)\bigr),\qquad
       m_1=[H_1:R_1]=|\operatorname{im}c(-,b)|.
\]
The translation identity (4.4) and (7.7) give \(m_1<B(g)\).
Also \(K_1\subset R_1\), since elements fixing \(r\) pair to zero
with every element of the other factor.

For \(a\in R_1\), the degree-two divisors in (4.1) are linearly
equivalent. If they are equal, irreducibility of \(W\) forces
\(ra=r\) or \(rb=r\). Otherwise both are members of the unique
hyperelliptic pencil. In that case the corresponding global
identities are
\[
       rab=\iota r,\qquad rb=\iota ra,
       \quad\text{and hence }ra=\iota rb.                    \tag{7.8}
\]
To justify the global alternatives, the two equalizer loci together
with the locus where both pairs are hyperelliptically conjugate are
closed and cover the irreducible curve \(W\); one must be all of \(W\).
Since \(rb\ne r\), the orbit of \(r\) under \(R_1\) consequently
has at most the two elements
\[
                              r,\quad\iota rb.
\]
Its stabilizer is \(K_1\), so
\[
 [R_1:K_1]\le2,\qquad
 [H_1:K_1]=m_1[R_1:K_1]\le2m_1<2B(g).                       \tag{7.9}
\]
This also handles \(c(-,b)=0\): then \(m_1=1\), and the orbit bound
alone gives index at most two. Unlike the nonhyperelliptic case,
that zero-image possibility is not discarded.

The same argument applies to \(H_2\). It proves (7.2), and quotient
descent and the étaleness argument of Section 5 prove (7.3).
The full radicals of \(c\) contain \(K_i\) and are contained in any
single-slot kernel \(R_i\) just chosen; they are **not** identified
with \(K_i\) in this extension. In particular the nonhyperelliptic
normality conclusion has not been carried over without justification.

Finally, this proof does not assert a factorization
\(W\to\widetilde D_b\to T\) in the hyperelliptic case: the generic
ordered-pair recovery has degree two. The actual étale map to \(T\)
retained in Theorem 7.1 is instead the rigorously descended map from
\(W/(K_1\times K_2)\).

The restriction \(g\ge3\) cannot be removed by this proof. For genus
two, \(W_2(T)=\operatorname{Pic}^2(T)\) and \(S=J_T\), so (7.5)
fails even when \(J_T\) is simple. No genus-two claim follows.
