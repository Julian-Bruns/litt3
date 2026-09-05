# Elliptic character directions: polarization-controlled a-numbers

Date: 2026-09-05. Author: `/root`.
Status: author proof. The ordinary-complement numerical specialization
received a focused PASS from `/root/gluing_cohomology_rigidity` on this
date; the more general supersingular-subgroup argument below is not
included in that verdict. No novelty claim. Existing special cases are
retained pending a consolidated check.

## 1. Statement without a genus or covering-degree bound

Let k be algebraically closed of characteristic p>0, let C/k be a
smooth projective connected hyperbolic curve, and let i:E -> J(C) be
an elliptic abelian subvariety. Let

\[
 e=\deg(i^*\mathcal O_{J(C)}(\Theta_{\rm principal})).
\]

On Frobenius twists assume the substantive geometric condition

\[
                  E^{(1)}\not\subset\Theta_C,                 \tag{1}
\]

where Theta_C is the Raynaud determinant divisor of
B_C=F_{C/k*}O_C/O_{C^(1)}. For every finite subgroup
Lambda of E^(1)(k) of order prime to p, let W_Lambda -> C be its
connected abelian etale character cover. All finite prime supports
are allowed simultaneously.

### Theorem

There is one finite exceptional character subgroup Lambda_0 such
that every W_Lambda with Lambda containing Lambda_0 has ordinary
relative Prym over W_(Lambda_0). Consequently this directed family
has only finitely many hyperbolic etale targets whose Jacobians have
no ordinary simple isogeny factor, including targets reached through
actual non-Galois intermediate curves.

Independently of Lambda, its degree, and its prime support,

\[
 a(W_\Lambda)\le
 \begin{cases}
 (p-1)(e-1),& E\text{ ordinary},\\
 (p-1)(e-1)+a(C),&E\text{ supersingular}.
 \end{cases}                                                \tag{2}
\]

Every actual finite etale target T of W_Lambda, or of an etale
intermediate source, satisfies the same a-number bound. This numerical
conclusion has no restriction on the simple factors of J(T).

Condition (1) holds in particular if J(C)/E is ordinary. In that
case a(C)=0 or 1 according as E is ordinary or supersingular, so the
bound can be written uniformly as

\[
                    a(W_\Lambda)\le(p-1)(e-1)+a(C).           \tag{3}
\]

The number in (2) or (3) is NOT asserted to bound the stable defect
g(W_Lambda)-f(W_Lambda), or the order of Lambda_0.

## 2. Determinants and the finite exceptional subgroup

Put D=Theta_C|E^(1), a genuine effective divisor by (1). Raynaud's
divisor class is (p-1) times the principal polarization, and scalar
Frobenius twisting preserves e. Therefore

\[
                             \deg D=(p-1)e.                 \tag{4}
\]

At any alpha in E^(1)(k), compute the cohomology of the family
B_C tensor L over the local DVR of E^(1) by a two-term complex of
free modules. Its Euler characteristic is zero, so the matrix is
square. Its determinant defines D; it is generically invertible by
(1). Its special-fiber kernel has dimension h^0(B_C tensor alpha).
Smith normal form gives

\[
               h^0(B_C\otimes\alpha)\le\operatorname{mult}_\alpha D.
                                                               \tag{5}
\]

Etale Frobenius base change and character decomposition give

\[
 a(W_\Lambda)=\sum_{\alpha\in\Lambda}h^0(B_C\otimes\alpha).    \tag{6}
\]

Since D is finite, its prime-to-p torsion points generate a finite
group Lambda_0. Apply the
[finite-bad-character descent theorem](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
to Gamma=E^(1)(k)_(p'). This proves the first paragraph of the theorem,
including all Frobenius iterates and actual intermediate maps. It uses
the finite bad set, not a bound for only the first Frobenius kernel.

## 3. Removing the compulsory characteristic-p contribution

Verschiebung functoriality makes ker(V_E) a closed subgroup scheme of
ker(V_J), with both regarded in the Frobenius-twisted varieties.

### 3.1. E ordinary

There are p-1 distinct nonidentity points alpha of ker(V_E). Viewed
as line bundles on C^(1), they satisfy F_C^*alpha=O_C. The Frobenius
exact sequence tensored by alpha gives

\[
 0=H^0(C^{(1)},\alpha)\longrightarrow H^0(C,O_C)=k
       \longrightarrow H^0(C^{(1)},B_C\otimes\alpha).
\]

Thus all these points lie in D. They have order p and none lies in
the allowed Lambda. Subtracting their multiplicities, at least one
each, from (4), and using (5)--(6), proves
a(W_Lambda)<=(p-1)(e-1). This argument does not require C itself
to be ordinary and does not use Dirac.

### 3.2. E supersingular

Here H=ker(V_E) is connected of length p, with local ring
k[t]/(t^p). It lies in K=(ker V_J)^0. Tong's Dirac property says that
a local equation of Theta_C restricts on K to a nonzero socle element.

If H=K, that element restricts on H to a nonzero multiple of
t^(p-1). If H is a proper closed subgroup scheme of K, it restricts
to zero. Indeed O_K is an Artin local Gorenstein ring, whose
one-dimensional socle is contained in every nonzero ideal: given a
nonzero ideal I, a last nonzero term of its maximal-ideal filtration
lies in the socle and hence spans it. Apply this to the nonzero
kernel of O_K -> O_H.

In either case the local equation restricted to E^(1) vanishes to
order at least p-1 at zero. It is not identically zero by (1). Hence

\[
                         \operatorname{mult}_0 D\ge p-1.    \tag{7}
\]

The zero character contributes a(C), rather than its possibly larger
intersection multiplicity. Separate it in (6) and apply (5), (4),
and (7) to the other terms:

\[
 a(W_\Lambda)\le a(C)+\deg D-\operatorname{mult}_0D
                         \le a(C)+(p-1)(e-1).
\]

This proves (2). The precise source is
[Tong, Definitions 1.2.7.1 and 1.2.7.4 and Theorem 1.2.7.7](https://arxiv.org/pdf/0712.2046),
PDF pp. 11--12. These statements and their local-ring discussion were
read directly. The same paper's introduction and Corollary 1.2.3.2
give the divisor class used in (4).

## 4. Ordinary complement and actual targets

If J(C)/E is ordinary, the connected kernel K above is contained in
E^(1): its image in the etale Verschiebung kernel of the ordinary
quotient is the identity. Since the local theta equation is nonzero
on K, it cannot vanish identically on E^(1). This proves (1).

By Poincare reducibility and isogeny invariance of p-rank,

\[
                   g(C)-f(C)=1-f(E)\in\{0,1\}.
\]

For a curve the a-number is zero exactly in the ordinary case, and
is at most g-f. Thus a(C)=0 in the ordinary-E case and a(C)=1 in the
supersingular-E case. This proves (3) without using a-number invariance
under a possibly p-divisible isogeny.

Finally, for an actual finite etale map W_Lambda -> T, etale base
change identifies the pullback of B_T with B_WLambda. Faithfully flat
pullback injects global sections, so a(T)<=a(W_Lambda). Composing two
actual etale maps proves the intermediate-source assertion. No
replacement by unrelated Jacobian inclusions is used.

For the elliptic Prym of an etale double cover of an ordinary
genus-two base, e=2. Formula (3) is exactly the uniform four/five
bound of the
[generalized-dihedral theorem](ODD_GENERALIZED_DIHEDRAL_TOWERS_OVER_ORDINARY_GENUS_TWO_HAVE_FINITE_NONORDINARY_TARGETS.md).
That corollary is retained separately because it also classifies
actual monodromy and its entire allowed family.
