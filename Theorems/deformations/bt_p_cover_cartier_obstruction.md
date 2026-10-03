# The actual BT descent obstruction is killed by Cartier pullback

Version3,3 October2026. Let $C/k$ be smooth projective connected,
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
The following conditions are EQUIVALENT:
\[
\delta_D=d\delta_C\quad\Longleftrightarrow\quad
\mathcal K_D\text{ is free over }k[P]\quad\Longleftrightarrow\quad
H^1(P,\mathcal K_D)=0\quad\Longleftrightarrow\quad
q^*\text{ is injective on the Cartier cokernel.}
\tag{4a}
\]
Thus MAXIMAL defect growth makes EVERY possible obstruction class
vanish and forces next-level EXISTENCE descent at every height.
When growth is smaller, the obstruction space is nonzero, but its
actual class (3) can still vanish. Neither direction is prescribed-object
descent.

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

7. If $\delta_C=1$, put $J=\operatorname{rad}k[P]$ and
$h_i=\dim J^i/J^{i+1}$. The later
[augmentation theorem](section_growth/augmentation_width_defect.md)
gives the geometric bound
\[
\delta_D\ge w_2(P):=\max_i(h_i+h_{i+1}).
\tag{8}
\]
In particular every noncyclic $P$ gives $\delta_D\ge9$;
if $P\ne C_5^2$ this improves to ten, and Frattini rank at least
three gives37. An actual exponent-five Heisenberg quotient gives25.
These are defect bounds for the actual induced connection, not values
of the actual BT existence class.

The cyclic-five ambient freeness and primitive construction were
proved in the returned Pro answer. Exact realization removes its
former distinction between actual differences and the Cartier
kernel. The intrinsic cokernel and arbitrary five-group extension are
subsequent deductions. The later absolute torsor and actual tangent
bundle identify the obstruction class and supply block parity directly.
Neither an unconditional existence-descent theorem nor an actual
proper-curve counterexample is asserted. The two-map common-cover
problem remains open.

[Proof](../../Proofs/deformations/bt_p_cover_cartier_obstruction.md).
