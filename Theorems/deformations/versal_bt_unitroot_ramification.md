# A sharp simple-pole bound for actual marked BT differences

Version1,20 September2026. Work in characteristic five. For two
determinant-normalized marked BT2 extensions $A,B$ of the same
generically ordinary height-two, dimension-one BT1, let
\[
\epsilon(A,B)\in H^1_{\rm et}(U,\mathbf F_5)
\]
be the difference of the characters of their rank-one ordinary etale
quotients. Their reductions agree by the marking; identify $1+5a$
with $a\in\mathbf F_5$. Here $U$ is the ordinary locus.

1. The Artin--Schreier class of the intrinsic ordinary invariant is
\[
[\Delta(A,B)]=2\epsilon(A,B).
\tag{1}
\]
The equality uses the Kummer convention in which changing the etale
constituent basis by $v$ and multiplicative basis by $u$ changes its
parameter to $q^{v/u}$. Reversing all character conventions reverses
both sides, with no change to any ramification assertion.

2. At a simple versal supersingular point with parameter $t$,
the intrinsic FUNCTION satisfies the sharp bound
\[
v_t\Delta(A,B)\ge-1.
\tag{2}
\]
In suitable integral frames there are $u,w\in k[[t]]$ such that
$\Delta=w^5-w+2u/t$. Consequently the difference character has
Swan conductor zero or one. These conclusions concern actual BT2
groups, not arbitrary truncated matrices.

3. The local pole bound $v_t(\Delta)\ge0$ is FALSE. There are actual
height-two, dimension-one p-divisible groups $G_0,G_1$ over
$R=\overline{\mathbf F}_5[[t]]$ with canonically identified BT1s,
simple Hasse zero and unit Kodaira--Spencer map, for which
\[
\Delta(G_0[25],G_1[25])=2/t+w^5-w,\qquad w\in t^5k[[t]].
\tag{3}
\]
Thus $v_t\Delta=-1$. The returned second local reply supplies this
exact representative; the independent local continuation had already
identified the same effective groups and their conductor-one class.

The groups are specified by effective FULL crystalline modules over
$W(k)[[T]]$. With $f_j=T+5j$, $j=0,1$, their matrices are
\[
F_j=\begin{pmatrix}f_j&5\\1&0\end{pmatrix},\qquad
V_j=\begin{pmatrix}0&5\\1&-f_j\end{pmatrix}.
\tag{4}
\]
The proof constructs their convergent crystalline connections and
uses the actual p-divisible-group equivalence to establish effectivity.

4. On a proper curve $C$ of genus $g\ge2$ with reduced supersingular
divisor $S$ and an everywhere-versal BT1, the maps
\[
\Delta:Q_C\hookrightarrow H^0(C,\mathcal O_C(S)),\qquad
\epsilon:Q_C\hookrightarrow H^1_{\rm et}(C-S,\mathbf F_5)
\tag{5}
\]
are injective. The second image has conductor at most one and meets
the unramified subgroup only in zero. Principal parts inject $Q_C$
into $H^0(\mathcal O_C(S))/k$, a vector space of dimension $3g-4$.
This is an injection of additive groups; no $k$-vector-space structure
on $Q_C$, finite cardinality, or surjectivity is asserted.

The same local bound applies to two marked BT$_{N+1}$ extensions of
a fixed BT$_N$, with fixed normalized determinant, by replacing the
last digit $5$ by $5^N$. Its Kummer formula uses $q_B=q_A r^{5^N}$.
A local example is not a proper-curve counterexample or a common-cover
example. The global image is constrained further by
[the Cartier criterion](versal_bt_cartier_realization.md).
[Proof](../../Proofs/deformations/versal_bt_unitroot_ramification.md).
