# A degree bound makes sufficiently deep truncated descent effective

Version2,3 October2026. Let $Y/\mathbf F_q$ be smooth, proper and
geometrically connected of genus $h\ge2$, with an $\mathbf F_q$-point,
where $q=5^f$. Fix a normalized full height-two, dimension-one
Barsotti--Tate group $G/Y$, everywhere versal and generically ordinary,
with nonempty reduced supersingular divisor. Its determinant is the
Teichmuller normalization of its BT1 determinant character.

For a positive integer $d$, put
\[
g_{h,d}=1+d(h-1),\qquad
M_{h,d}=96(h-1)d^2(d!)^{4h-2},\qquad
l_{h,d}=\min\{l\ge0:5^l\ge8(2g_{h,d}+1)\},
\]
\[
A_{q,h,d}=4g_{h,d}16^{g_{h,d}}q^{5M_{h,d}g_{h,d}},\qquad
\boxed{N_{q,h}(d)=A_{q,h,d}(A_{q,h,d}-1)
(16fM_{h,d}l_{h,d}+2).}
\tag{1}
\]
For genus two write $N_q(d)=N_{q,2}(d)$. Thus its field exponent is
$M_{2,d}=96d^2(d!)^6$, replacing $96d(d!)^8$; its arithmetic cutoff
also uses the sharper common-Hecke-operator bound. No cover enumeration
is required.

Let $X\xleftarrow a Z\xrightarrow bY_k$ be TWO ACTUAL finite etale
maps of smooth proper connected hyperbolic curves over
$k=\overline{\mathbf F}_5$, with degrees $n,m$. Suppose there is a
normalized, everywhere-versal BT$_N$ group $A/X$ and a specified
normalized comparison
\[
\eta_N:a^*A\xrightarrow{\sim}b^*G[5^N],
\qquad N\ge N_{q,h}(nm).
\tag{2}
\]
Then there is an actual normalized full group $G_X/X$ extending $A$,
equipped with a full comparison $a^*G_X\simeq b^*G$ retaining (2).
This comparison-equipped extension and its actual descent datum
are unique.

A full group on $X$ is not an input. Neither $X$, $Z$, their maps nor
the comparison need have a model over $\mathbf F_q$. Only components
of the actual descent relation $Z\times_X Z$, viewed as
self-correspondences of the fixed $Y$, require bounded fields.

For either selected genus-nine/genus-two pair, compatible full groups
force an already excluded simultaneous mixed-characteristic lift.
Consequently every supplied comparison to this fixed $G/\mathbf F_q$
satisfies
\[
\boxed{N<N_q(8n^2),\qquad n=\deg(Z\to X).}
\tag{3}
\]
For an indigenous-ordinary genus-two BT1, its unique canonical full
extension supplies $G$. No source ordinariness is assumed.

For the explicit backup $Y$, an actual self-correspondence
$Y\xleftarrow{c_1}T\xrightarrow{c_2}Y$ of degree at most $d$ on each
leg, with a normalized comparison of the two pulled-back
$G[5^{N_q(d)}]$, satisfies
\[
c_2=\sigma\circ c_1\quad\text{for some }\sigma\in\operatorname{Aut}(Y).
\tag{4}
\]
Its joint-minimal source is therefore $Y$. The same conclusion holds
for a supplied FULL comparison. This corollary uses the backup's
arithmetic and tame-atlas exclusions.

This bounds EXTRA compatible truncated data. It does not construct
such data, bound covering degrees or bound arbitrary Witt deformation
lengths. The unmarked common-cover problem remains open.

[Proof](../../Proofs/deformations/bounded_degree_bt_descent.md).
