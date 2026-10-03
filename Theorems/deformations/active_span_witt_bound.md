# An active common oper bounds Witt height by the original degrees

Version2,3 October2026. Work over $k=\overline{\mathbf F}_5$ and
$W=W(k)$. Let $X\xleftarrow fZ\xrightarrow gY$ be two ACTUAL finite
etale maps of smooth proper connected hyperbolic curves, of degrees
$n,m$. Suppose they admit matching admissible ACTIVE projective opers,
the oper on $Y$ is indigenous-ordinary, and
\[
f^*H^1(X,T_X)\cap g^*H^1(Y,T_Y)=0\quad\text{in }H^1(Z,T_Z).
\tag{J}
\]
Assume the original two-map span has no simultaneous full Witt lift.

Choose an actual BT1 $H_Y$ realizing the oper, over a field
$\mathbf F_q$ on which $Y$ has a rational point. Put $h=g(Y)$ and
use $N_{q,h}(d)$ from
[bounded-degree BT descent](bounded_degree_bt_descent.md).
Choose a BT1 realization $H_X$ and one connected character cover
$Z'\to Z$, of degree $c\in\{1,2,4\}$, comparing their ACTUAL first
periodic data. Then
\[
R_{f,g}=W/(5^e),\qquad
\boxed{2\le e\le N_{q,h}(c^2nm)\le N_{q,h}(16nm).}
\tag{1}
\]
Every existing simultaneous $W_M$ curve lift produces normalized
BT$_{M-1}$ groups on the two ORIGINAL endpoints with comparison
on this SAME $Z'$, retaining the first marking. No new cover is
introduced at higher levels. A full group on $X$ is not an input.

## Uniform bound for the selected endpoints

Fix either selected genus-two $Y/\mathbf F_{q_0}$, with its rational
point at infinity. A common active oper with its selected genus-nine
$X$ satisfies (J) and the nonliftability hypothesis; here $m=8n$.
There are $21760=85\cdot4^4$ actual BT1 classes on this fixed $Y_k$.
Each has a model over $\mathbf F_{q_0^s}$ for some $1\le s\le2040$:
the $85$-oper orbit bound combines with the affine symplectic action
on the four-torsion character torsor, whose order is at most $24$.
Its unique normalized full tower descends over that SAME field.

Put $Q_Y=q_0^{2040}$ and $N_q(d)=N_{q,2}(d)$. Thus
\[
\boxed{2\le e\le N_{Q_Y}(128n^2).}
\tag{2}
\]
$Q_Y$ is a numerical bound for field sizes; the period $s$ need
not divide $2040$. The bound depends only on the fixed endpoint
and original degree, with no field hypothesis on the span.

The theorem bounds existing lifts in the active branch. It does
not produce a common oper, the next curve lift, or a bound on $n$.
The dormant and no-common-oper branches remain outside its scope.
The unmarked common-cover problem remains unsolved.

[Proof](../../Proofs/deformations/active_span_witt_bound.md).
