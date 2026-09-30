# The actual BT descent obstruction is killed by Cartier pullback

Version2,20 September2026. Let $C/k$ be smooth projective connected,
$k=\overline{\mathbf F}_5$, of genus at least two. Let $A_N/C$ be
an actual BT$_N$, with everywhere-versal height-two, dimension-one
BT1 $H$, generically ordinary and with reduced supersingular divisor
$S$. Retain the marking and Teichmuller-normalized determinant.
Let $q:D\to C$ be an actual connected finite etale Galois cover with
finite five-group $P$ of order $d$. Suppose $q^*A_N$ has a normalized
marked BT$_{N+1}$ extension $B$ on $D$.

Put $V_C=H^0(C,\mathcal O_C(S))$ and
$V_D=H^0(D,\mathcal O_D(q^*S))$. The logarithmic character forms
define inverse-Frobenius-semilinear endomorphisms
$\mathscr C_C,\mathscr C_D$ by
\[
C(\pi^*h\,\Omega)=\pi^*\mathscr C(h)\,\Omega.
\]
These retain the tame character covers; no identification of a
curve with its relative Frobenius twist is made. Their kernels
are the actual difference spaces $\mathcal K_C,\mathcal K_D$.

The following statements hold.

1. The ambient module is free:
\[
V_D\simeq k[P]^{\,3g(C)-3}.
\tag{1}
\]
In particular, $H^1(P,V_D)=0$.

2. There is a canonical additive isomorphism
\[
H^1(P,\mathcal K_D)\simeq
\ker\!\left(
q^*: \operatorname{coker}\mathscr C_C
\longrightarrow \operatorname{coker}\mathscr C_D
\right).
\tag{2}
\]
The usual Frobenius twist is needed if (2) is written as a
$k$-linear isomorphism.

3. The ACTUAL existence obstruction has the following representative.
For each $\gamma\in P$, let
$d_\gamma=\Delta_N(B,\gamma^*B)\in\mathcal K_D$.
Choose $b\in V_D$ with $d_\gamma=\gamma b-b$ for every $\gamma$.
There is a unique $a\in V_C$ with
\[
q^*a=\mathscr C_D(b).
\tag{3}
\]
The class $[a]\in\operatorname{coker}\mathscr C_C$ is independent
of these choices and of $B$. It vanishes if and only if $A_N$ has
some normalized marked BT$_{N+1}$ extension on the ORIGINAL $C$.
Such an extension need not pull back to the supplied $B$.

4. Write $\delta_T=\dim_k\mathcal K_T$. Then
\[
\delta_C\le\delta_D\le d\delta_C.
\tag{4}
\]
If $\delta_D=d\delta_C$, the module $\mathcal K_D$ is free over
$k[P]$ and the class (3) always vanishes. Thus MAXIMAL defect
growth is a sufficient condition for descent of next-level
EXISTENCE, at every height. It is not prescribed-object descent.

5. If $P$ is cyclic, put $R=k[t]/(t^d)$ with $t=\gamma-1$.
For some $1\le\ell_i\le d$,
\[
\mathcal K_D\simeq
\bigoplus_{i=1}^{\delta_C}R/(t^{\ell_i}),\qquad
\delta_D=\sum_i\ell_i,
\tag{5}
\]
and
\[
\dim_kH^1(P,\mathcal K_D)=\#\{i:\ell_i<d\}.
\tag{6}
\]
Equivalently, pullback on the Cartier cokernels has rank
$\#\{i:\ell_i=d\}$. These numerical statements describe the
possible obstruction space; they do not evaluate the actual
class (3) when that space is nonzero.

6. In the cyclic case the multiplicity of each odd block length
$\ell<d$ in (5) is EVEN. This follows from the actual canonical-valued
alternating indigenous tangent bundle, not just equality of total
kernel dimensions. In particular,
\[
\delta_C=1,\quad d=5
\quad\Longrightarrow\quad
\delta_D\in\{2,4,5\}.
\tag{7}
\]
The case $\delta_D=5$ has zero existence obstruction. In each of
the cases $\delta_D=2,4$, its possible obstruction space is a line;
its actual class remains to be evaluated. More generally, if
$\delta_C=1$ and $d=5^a$, the single length is even or equals $d$.

The cyclic-five ambient freeness and primitive construction were
proved in the returned Pro answer. Exact realization removes its
former distinction between actual differences and the Cartier
kernel. The intrinsic cokernel, arbitrary five-group extension,
maximal-growth criterion, and equivariant block-parity comparison
are subsequent local deductions.
Neither an unconditional existence-descent theorem nor an actual
proper-curve counterexample is asserted. The two-map common-cover
problem remains open.

[Proof](../../Proofs/deformations/bt_p_cover_cartier_obstruction.md).
