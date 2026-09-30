# An active common oper gives a degree-dependent bound on Witt height

Version1,21 September2026. Fix either selected genus-two endpoint
$Y/\mathbf F_{q_0}$, with its rational point at infinity. Put
$Q_Y=q_0^{21760}$, and let $N_q(d)$ be the explicit increasing
integer function in
[bounded-degree BT descent](bounded_degree_bt_descent.md).
The symbol $Q_Y$ is a numerical bound for fields of definition;
it is not an assertion that every group descends to that one field.

Let $X\xleftarrow f Z\xrightarrow gY_k$ be an ACTUAL common finite
etale span for the selected genus-nine $X$ and this $Y$, and put
$n=\deg f$, so $\deg g=8n$. Suppose it admits a common admissible
ACTIVE projective oper. Then its marked deformation ring is
\[
R_{f,g}=W(k)/(5^e),\qquad
\boxed{2\le e\le N_{Q_Y}(128n^2).}
\tag{1}
\]
In particular the upper bound depends only on the fixed endpoint
and the original covering degree, not on a field of definition
of the span, an auxiliary group, or a comparison marking.

More precisely, choose actual BT1 realizations of the common oper
and a single connected character cover $h:Z'\to Z$ of degree
$c\in\{1,2,4\}$ making them compatible. If its genus-two BT1
has a model over $\mathbf F_q$, then
\[
e\le N_q(8c^2n^2).
\tag{2}
\]
Every existing simultaneous $W_M$ curve lift produces compatible
normalized BT$_{M-1}$ groups on the two ORIGINAL endpoints, with
comparison on this fixed $Z'$. No full group on $X$ or ordinary
connection on $Z'$ is assumed.

The finite-field assertion used here is also useful separately.
Every one of the $21760$ actual BT1 classes on $Y_k$ has a model
over $\mathbf F_{q_0^s}$ for some $1\le s\le21760$. Its unique
determinant-normalized full prolongation descends over the SAME
field. The field need not grow with the truncation level.

This bounds existing lifts in the active branch. It does not
produce an active oper, construct the next curve lift, bound $n$,
or apply to dormant/no-common-connection branches. Both unmarked
common-cover problems remain UNSOLVED.

[Proof](../../Proofs/deformations/active_span_witt_bound.md).
