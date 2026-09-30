# A degree bound makes sufficiently deep truncated descent effective

Version1,21September2026. Let $Y/\mathbf F_q$ be a smooth proper
geometrically connected genus-two curve with an $\mathbf F_q$-point,
where $q=5^f$. Fix a normalized full height-two, dimension-one
Barsotti--Tate group $G/Y$, everywhere versal and generically ordinary,
with nonempty reduced supersingular divisor. Its determinant is the
Teichmuller normalization of its BT1 determinant character.

For a positive integer $d$, define the following explicit integers:
\[
g_d=d+1,\qquad
M_d=96d(d!)^8,\qquad
l_d=\min\{l\ge0:5^l\ge8(2g_d+1)\},
\]
\[
A_d=4g_d16^{g_d}q^{5M_dg_d},\qquad
\boxed{N_q(d)=1+4A_d^2(1+16fM_dl_d).}
\tag{1}
\]
These deliberately large bounds require no enumeration of covers.

Let $X\xleftarrow a Z\xrightarrow bY_k$ be TWO ACTUAL finite etale
maps of smooth proper connected hyperbolic curves over
$k=\overline{\mathbf F}_5$, with degrees $n,m$. The span need not
have a model over $\mathbf F_q$. Suppose there is a normalized,
everywhere-versal BT$_N$ group $A/X$ and a specified normalized
comparison
\[
\eta_N:a^*A\xrightarrow{\sim}b^*G[5^N],\qquad N\ge N_q(nm).
\tag{2}
\]
Then there is an ACTUAL full BT group $G_X/X$, with $G_X[5^N]\simeq A$,
and a full comparison $a^*G_X\simeq b^*G$ retaining (2). The descent
datum and the extension of the supplied comparison are unique.

In particular a full group on X is NOT an input. Neither is a
field-of-definition bound on X, Z, their maps, or the comparison.
The proof bounds that field only for the actual components of
$Z\times_XZ$, considered as self-correspondences of the fixed Y.

For either selected candidate, compatible full versal groups would
force a simultaneous mixed-characteristic lift, already excluded.
Thus for this fixed $G/\mathbf F_q$, every compatible normalized
finite-level group on the genus-nine endpoint satisfies
\[
\boxed{N<N_q(8n^2),\qquad n=\deg(Z\to X).}
\tag{3}
\]
The genus-two ordinary-indigenous uniqueness theorem lets one apply
this to its specified canonical full extension whenever the chosen
common BT1 is given. No source ordinariness is assumed.

For the explicit backup Y there is a further rigidity conclusion.
If an actual self-correspondence $Y\xleftarrow{c_1}T\xrightarrow{c_2}Y$
has degree at most d on each leg and admits a normalized comparison
of the two pulled-back $G[5^{N_q(d)}]$, then
\[
c_2=\sigma\circ c_1\quad\text{for some }\sigma\in\operatorname{Aut}(Y).
\tag{4}
\]
In particular its joint-minimal source is just Y. The same conclusion
holds at any height for a supplied FULL comparison. This uses both
the backup arithmetic exclusion and its complete tame-atlas exclusion;
it is not a classification of arbitrary self-correspondences of Y.

This is a degree-dependent ceiling on EXTRA compatible BT data. It
does not construct the first common BT1, force compatibility at the
displayed height, bound the covering degrees, or bound arbitrary Witt
deformation lengths. Both unmarked common-cover problems remain open.

[Proof](../../Proofs/deformations/bounded_degree_bt_descent.md).
