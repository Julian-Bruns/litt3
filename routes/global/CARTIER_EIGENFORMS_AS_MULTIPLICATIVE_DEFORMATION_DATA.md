# Cartier eigenforms as multiplicative deformation data

Date: 2026-09-05. Author: `/root/generalized_cartier_eigenforms_sources`.
Status: exact literature identification and direct translation; no new
nonexistence theorem or resolution of the Cartier-zero branch.

Let \(C/\overline{\mathbf F}_5\) be smooth, projective, connected, of genus
at least two. Let \(d\mid4\), \(r=5-4/d\), and let

\[
0\ne s\in H^0(C,\omega_C^d),\qquad C_{d-1}(s^r)=s.
\]

Here the twisted absolute Cartier operator has the conventions of
[the invariant-generator note](../../Theorems/Thm_cartier_generator.md).

## Direct translation

Choose a separating rational parameter \(t\), write \(s=a(dt)^d\), and
choose a root \(b^d=a\). Let \(Z\) be the smooth projective curve with
function field \(k(C)(b)\), and put \(\eta=b\,dt\).
The cover \(Z\to C\) is cyclic of degree dividing \(d\), with faithful
character on \(\eta\) taking values in \(\mu_d\subset\mathbf F_5^\times\).
This formulation automatically chooses a connected component if the full
root construction is disconnected.

Since \(dr=5(d-1)+1\), ordinary Cartier on the function field of \(Z\)
satisfies

\[
C(a^r dt)=C(b^{5(d-1)}b\,dt)=b^{d-1}C(\eta).
\]

The twisted eigenform equation is \(C(a^r dt)=a\,dt\). Consequently

\[
\boxed{C_{d-1}(s^r)=s\quad\Longleftrightarrow\quad C_Z(\eta)=\eta.}
\]

Moreover, \(\eta\) is regular: its \(d\)-th tensor power is the actual
differential pullback of \(s\), which is regular. This uses separability
of the root cover, not the false assertion that ramified differential
pullback preserves vanishing orders unchanged.

If \(P\in C\), \(Q\in Z\) lies above \(P\), \(m\) is the ramification
index, and \(e=\operatorname{ord}_P(s)\), then tame differential pullback
gives

\[
d\operatorname{ord}_Q(\eta)=me+d(m-1),\qquad
\frac{\operatorname{ord}_Q(\eta)+1}{m}=1+\frac ed.
\]

## Exact primary-source match

Bouw–Wewers, [*Indigenous bundles with nilpotent p-curvature*](https://arxiv.org/pdf/math/0505275),
Definition 4.1, defines precisely these cyclic covers with logarithmic
character eigenforms as deformation data. Cartier-fixedness is the
logarithmic condition. Their Lemma 4.6 gives the equivalent equation
\(D^4(v)=-1\), with \(D=\partial/\partial t\) and \(b^4=v^{-1}\).
Their Theorem 4.11 identifies deformation data with active nilpotent
indigenous bundles, allowing marked singularities. Active means nonzero
p-curvature, so this is not a dormant-oper identification.

Here \(v=a^{-4/d}\). Thus the quadratic equation is
\(D^4(a^{-2})=-1\), and the quartic equation is
\(D^4(a^{-1})=-1\).

Their local invariant is \(\sigma_P=(\operatorname{ord}_Q\eta+1)/m\).
Their supersingular value is \(3/2\); singular points are those with
\(\sigma_P\ne3/2\) and \(\sigma_P\not\equiv1\pmod5\).
For an unmarked active nilpotent bundle, formula (5) gives either
\(\sigma_P=3/2\) or \(\sigma_P=1+n_P/4\), with \(n_P\ge0\).

## Consequences and limitations of the translation

Our direct valuation calculation says \(\sigma_P=1+e/d\ge1\).
Thus supersingular points in this translation have \(e=d/2\): simple
quadratic zeros or double quartic zeros. General regular eigenforms can
give marked singularities; regularity alone does not make the associated
indigenous bundle unmarked.

Conversely, a deformation datum whose group order divides \(d\) yields
a rational \(d\)-differential \(s\) by descent of \(\eta^d\).
The same valuation formula proves that \(s\) is regular exactly when
all \(\sigma_P\ge1\). It then satisfies the normalized twisted Cartier
equation. In particular every unmarked active nilpotent indigenous
bundle supplies a nonzero regular **quartic** eigenform. This does not
automatically supply a quadratic one: the relevant character cover can
have order four.

Therefore emptiness of the quartic pool on any genus-at-least-two curve
would exclude all its unmarked active nilpotent indigenous bundles,
including ordinary ones. Hoshi's
[RIMS1970 introduction](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1970revised.pdf)
explicitly records the basic question whether every hyperbolic curve
is hyperbolically ordinary. A negative quartic-pool example would thus
have consequences for that question. The checked sources do not provide
a universal existence theorem for our pools, or a characteristic-five
genus-at-least-two example with empty quartic pool.

At the easy end, any nonzero regular Cartier-fixed one-form \(\alpha\)
gives solutions \(s=\alpha^d\) in all three degrees. This follows directly
from the root-form calculation and includes curves with positive
5-rank. It gives no inference from vanishing or nilpotence of ordinary
Cartier on \(C\) to vanishing of the quadratic or quartic pools.

This identification concerns only the nonzero-Cartier branch of a
coreless invariant generator. It does not bound the primitive degree
in the Cartier-zero branch and does not produce a common-cover obstruction.
