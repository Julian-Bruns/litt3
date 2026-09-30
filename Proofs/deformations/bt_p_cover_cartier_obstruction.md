# Proof: Cartier cokernels and existence descent through five-groups

[Statement](../../Theorems/deformations/bt_p_cover_cartier_obstruction.md).
Use the actual [Cartier difference classification](versal_bt_cartier_realization.md)
and [unique normalized comparison](versal_bt_display_descent.md).
No independent global existence theorem is invoked.

## A Cartier endomorphism on functions with simple poles

Let $\pi:P_C\to C$ kill the logarithmic character of $H$.
The [Cartier bridge](versal_bt_cartier_rigidity.md) identifies
$V_C$ with the character block of regular differentials on $P_C$
by $h\mapsto\pi^*h\,\Omega$. The character takes values in
$\mathbf F_5^*$, so Cartier preserves this block. Dividing the
result by $\Omega$ defines $\mathscr C_C:V_C\to V_C$.
It is additive and satisfies
\[
\mathscr C_C(\lambda h)=\lambda^{1/5}\mathscr C_C(h).
\]
Its image and kernel are $k$-subspaces because $k$ is perfect.

The cover $P_C\to C$ has degree prime to five. Base change by the
five-group torsor gives the corresponding character cover over
$D$, with its compatible deck action and logarithmic differential.
Cartier commutes with the actual etale pullbacks. Thus
$\mathscr C_D$ commutes with $P$ and
$\mathscr C_Dq^*=q^*\mathscr C_C$. In particular,
\[
V_D^P=q^*V_C,\qquad \mathcal K_D^P=q^*\mathcal K_C.
\tag{7}
\]
All semilinear maps below may be linearized on a Frobenius-twisted
source. Since the deck-group coefficients lie in $\mathbf F_5$,
this operation preserves the displayed group-algebra modules.

## Freeness of the ambient module

Write $\mathcal E=q_*\mathcal O_D$ and $L=\mathcal O_C(S)$.
The torsor identifies $\mathcal E$ with the bundle associated to
the regular representation. Every simple representation of a
finite five-group in characteristic five is trivial. Therefore
the trace kernel $\mathcal E_0$ has a filtration with $d-1$
quotients $\mathcal O_C$.

Here $\deg L=4(g(C)-1)>2g(C)-2$, so $H^1(C,L)=0$.
The filtration gives $H^1(C,L\otimes\mathcal E_0)=0$.
Consequently trace is onto:
\[
\operatorname{Tr}:V_D\twoheadrightarrow V_C.
\]
The group norm $\mathsf N=\sum_{\gamma\in P}\gamma$ acts on
$V_D$ as $q^*\operatorname{Tr}$. It follows that
$\mathsf N V_D=V_D^P$.

For completeness, this equality forces a finite $k[P]$-module
$M$ to be free. The group algebra is local and self-injective;
its socle is the one-dimensional line spanned by $\mathsf N$.
If $\mathsf N m\ne0$, the map $k[P]\to M$, $r\mapsto rm$,
is injective: every nonzero left ideal meets that socle. Since
$k[P]$ is injective, this copy splits off. Repeat. A remaining
nonzero summand has nonzero invariants, whereas the norm on it
is zero, contradicting $\mathsf N M=M^P$.

Apply this to $M=V_D$. Each free summand has one invariant
dimension, and Riemann--Roch gives $\dim V_C=3g(C)-3$.
This proves (1). Free group-algebra modules have vanishing
positive-degree group cohomology.

## The exact obstruction, including its actual realization

Put $W_D=\operatorname{im}\mathscr C_D$. The additive exact
sequence
\[
0\longrightarrow\mathcal K_D\longrightarrow V_D
\overset{\mathscr C_D}\longrightarrow W_D\longrightarrow0
\]
gives, using $H^1(P,V_D)=0$,
\[
H^1(P,\mathcal K_D)
\simeq W_D^P/\mathscr C_D(V_D^P).
\tag{8}
\]
By (7), the numerator is
$\operatorname{im}\mathscr C_D\cap q^*V_C$, and the denominator
is $q^*\operatorname{im}\mathscr C_C$. This is exactly the
kernel of pullback on cokernels in (2).

The normalized next-extension fiber on $D$ is a torsor under the
FULL $\mathcal K_D$, not merely a subgroup. The actual deck
differences $d_\gamma$ satisfy the cocycle equation. Freeness
gives a simultaneous primitive $b\in V_D$. Applying Cartier
shows $\mathscr C_D(b)$ is invariant, giving (3).
Another primitive differs by $q^*v$; its $a$ differs by
$\mathscr C_C(v)$. Replacing $B$ by $B+h$, $h\in\mathcal K_D$,
changes the cocycle by $\gamma h-h$ and permits replacing $b$
by $b+h$. This does not change $a$.

If $a=\mathscr C_C(v)$, then $b_0=b-q^*v$ belongs to
$\mathcal K_D$ and still satisfies
$d_\gamma=\gamma b_0-b_0$. Exact realization gives the actual
normalized extension $B-b_0$. Its class is deck-invariant.
Unique marked normalized isomorphisms supply the entire cocycle;
effective descent of its finite locally free Hopf algebra gives
an actual BT$_{N+1}$ on $C$. Conversely, an extension downstairs
pulls back to an invariant class, so (3) vanishes. The construction
retains the marking by $A_N$ and its determinant normalization.

This proves the assertion at every height. It requires a next-level
reference on $D$, which is part of the hypothesis; it does not
construct that reference or assert a missing global next level.

## Maximal growth is a sufficient existence criterion

Let $M=\mathcal K_D$ and $R=k[P]$. Its invariant dimension is
$\delta_C$ by (7). The vector-space dual $M^*$ needs exactly
$\delta_C$ generators over the local algebra $R$: the dual of
its space of coinvariants is $M^P$ (with the usual inverse
group action on the dual). Nakayama gives a surjection
$R^{\delta_C}\twoheadrightarrow M^*$. Dualizing and using the
regular pairing $R^*\simeq R$ gives
\[
M\hookrightarrow R^{\delta_C}.
\tag{9}
\]
Hence $\delta_D\le d\delta_C$; the lower bound comes from (7).
Equality makes (9) an isomorphism. In that case
$H^1(P,\mathcal K_D)=0$, so the actual class vanishes.

If $\delta_C=0$, (9) also proves $\mathcal K_D=0$.
This is a consequence for the actual logarithmic character block,
not an assumption that ordinariness is preserved under arbitrary
etale covers. General covers need not have five-group Galois closure.

## Exact cyclic block count

Suppose $P$ is cyclic of order $d=5^a$. Then
$R=k[t]/(t^d)$, $t=\gamma-1$, and the norm is $t^{d-1}$.
Linearize the Cartier endomorphism between the two free ambient
$R$-modules. The map from coinvariants to invariants given by
$t^{d-1}$ is an isomorphism for a free module. It commutes with
the linearized Cartier maps. Thus the reduction of the matrix
modulo $t$ has the same corank as the base Cartier operator,
namely $\delta_C$.

Smith reduction over $R$ therefore has exactly $\delta_C$
nonunit entries. Write them as $t^{\ell_i}$, interpreting a
zero entry as $\ell_i=d$. Both the kernel and cokernel of this
diagonal map have summands $R/(t^{\ell_i})$; units contribute
nothing. This proves (5).

For a cyclic group,
\[
H^1(P,M)=\ker(t^{d-1}:M\to M)/tM.
\]
A summand of length $d$ contributes zero, and a summand of any
length strictly below $d$ contributes one dimension. This proves
(6). The base cokernel has dimension $\delta_C$, so (2) also
gives the asserted rank of pullback. Equivalently, the pullback
is represented by the norm map on the cyclic cokernel module.

These module computations resemble the existing
[higher Hodge obstruction calculation](etale_p_witt_obstruction.md).
No identification of the two ACTUAL obstruction classes is made.
In particular, a short Smith block or a nonzero cohomology group
does not exhibit a geometric BT nonexistence example.

## The equivariant polarization comparison and block parity

Equality of the dimensions of two inverse-character Cartier
kernels alone would not justify a block-parity claim. The following
argument retains their actual deck modules.

Let $\chi$ be the logarithmic character on the tame character cover
$P_D$, and put $\mathbb H=H^1_{\rm dR}(P_D)$,
$A=H^0(P_D,\omega)$, and $B=\ker V=\operatorname{im}F$.
The polarized Jacobian BT1 gives $A=\ker F=\operatorname{im}V$;
both $A$ and $B$ are Lagrangian. The restriction of $V$ to $A$ is
Cartier. Thus $V:\mathbb H/B\to A$, with its coefficient twist,
identifies
\[
\operatorname{coker}(C|A_\chi)
\simeq\bigl(\mathbb H/(A+B)\bigr)_\chi.
\tag{10}
\]
Polarization identifies the right side with
$(A\cap B)_{\chi^{-1}}^*$, retaining the dual deck action and
the Frobenius twist. Every map is equivariant for the actual
five-group action, which commutes with the tame character action.

The [Hasse--Cartier identification](../projective_connections/hasse_cartier_criterion.md)
identifies $(A\cap B)_{\chi^{-1}}$ with the nilpotent tangent
space of the pulled-back admissible active oper. This is an
equivariant identification: its multiplication by the actual
Hasse-root differential and its Cartier map commute with deck
action. The [tangent-bundle construction](../projective_connections/tangent_bundle_cyclic_refinements.md)
identifies that space naturally with $H^0(D^{(1)},q^{(1)*}E)$,
where $E$ has a perfect alternating pairing valued in
$\omega_{C^{(1)}}$.

In the cyclic case, the Smith calculation above gives the same
block lengths for the kernel and cokernel of $\mathscr C_D$.
Dualizing a cyclic block $R/(t^\ell)$ leaves its length unchanged:
the dual action replaces $\gamma$ by $\gamma^{-1}$, and
$\gamma^{-1}-1$ is $t$ times a unit. Frobenius twisting the scalar
coefficients also leaves these lengths unchanged. Equation (10)
therefore proves that $\mathcal K_D$ and the ACTUAL tangent-section
module have identical block multiplicities. Applying
[cyclic symplectic block parity](../../Theorems/deformations/section_growth/cyclic_symplectic_blocks.md)
proves assertion6.

If $\delta_C=1$, (5) has just one block. Any odd proper length
would have odd multiplicity and is excluded. The remaining lengths
are even or the full odd length $d$. At $d=5$ these are exactly
$2,4,5$. No arbitrary representation is being asserted realizable,
and (10) does not identify the actual BT existence class with an
actual higher-Witt obstruction class.
