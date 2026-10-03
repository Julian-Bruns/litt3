# Proof: Cartier cokernels and existence descent through five-groups

[Statement](../../Theorems/deformations/bt_p_cover_cartier_obstruction.md).
Use the actual [Cartier difference classification](versal_bt_cartier_realization.md)
and [unique normalized comparison](versal_bt_display_descent.md).

## The actual coherent kernel and free ambient module

Put $L=\mathcal O_C(S)$ and use the coherent Cartier kernel
$\mathcal B_H$ of the [absolute extension torsor](versal_bt_extension_torsor.md).
On ordinary functions the Cartier endomorphism is inverse-Frobenius
semilinear; on $F_{{\rm abs}*}L$ it is $\mathcal O_C$-linear.
All group-algebra statements retain this scalar twist. Actual etale
base change gives
\[
V_D^P=q^*V_C,\qquad \mathcal K_D^P=q^*\mathcal K_C.
\tag{7}
\]
The torsor proof's [coefficient-module lemma](versal_bt_extension_torsor.md#five-group-coefficient-modules)
gives $V_D\simeq k[P]^{3g(C)-3}$, hence $H^1(P,V_D)=0$.
This proves(1).

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

The actual next-extension fiber on $D$ is a torsor under the FULL
$\mathcal K_D$. Its deck differences have a primitive $b\in V_D$
by ambient freeness, and $\mathscr C_D(b)=q^*a$ by(7).
Changing $b$ by $q^*v$ changes $a$ by $\mathscr C_C(v)$;
changing the upper reference by $h\in\mathcal K_D$ changes $b$
by $h$ and leaves $a$ unchanged.

The [absolute torsor](versal_bt_extension_torsor.md) identifies this
$[a]$ with the intrinsic class $e_N(A_N)$. Its zero is exactly
existence of a normalized marked next extension on the ORIGINAL $C$.
Exact realization then supplies the correcting upper object if needed;
it retains the entire preceding marking and determinant. This proves(3)
at every height without assuming a missing global next reference.

## Maximal growth is exactly vanishing of the obstruction space

Apply the torsor proof's finite-module lemma to $M=\mathcal K_D$, whose invariant
dimension is $\delta_C$ by(7). It gives
$\delta_D\le d\delta_C$; the lower bound is the injective pullback.
That lemma and(2) give exactly(4a). Maximal growth kills every
possible actual class. If growth is smaller, the obstruction space
is nonzero but the particular class(3) can still vanish.

If $\delta_C=0$, the module lemma also proves $\mathcal K_D=0$.
This is a consequence for the actual logarithmic character block,
not an assumption that ordinariness is preserved under arbitrary
etale covers. General covers need not have five-group Galois closure.

## Exact cyclic block count

Suppose $P$ is cyclic of order $d=5^a$. Then
$R=k[t]/(t^d)$, $t=\gamma-1$, and the norm is $t^{d-1}$.
Every finite $R$-module is a sum of the cyclic blocks $R/(t^\ell)$,
$1\le\ell\le d$. Each block has one invariant dimension. Thus
$\mathcal K_D^P=q^*\mathcal K_C$ gives exactly $\delta_C$ blocks
in(5).

For a cyclic group,
\[
H^1(P,M)=\ker(t^{d-1}:M\to M)/tM.
\]
A summand of length $d$ contributes zero, and a summand of any
length strictly below $d$ contributes one dimension. This proves
(6). The base cokernel has dimension $\delta_C$, so (2) also
gives the asserted rank of pullback.

## The actual tangent bundle gives block parity and geometric bounds

The later [canonical tangent identification](bt_cartier_tangent_identification.md)
gives $\mathcal B_H\simeq\mathcal E_r^{\rm abs}$, compatibly with
actual etale pullback. Thus $\mathcal K_D$, with its scalar transport,
is the actual tangent-section module, not just a space of equal
dimension. Its bundle has a perfect canonical-valued alternating
pairing. The [cyclic block theorem](../../Theorems/deformations/section_growth/cyclic_symplectic_blocks.md)
proves the odd-block assertion in Part6 directly. If $\delta_C=1$, there is one block, so its
length is even or the full odd length $d$. At $d=5$ these are2,4,5.

If $\delta_C=1$, the
[augmentation theorem](section_growth/augmentation_width_defect.md)
applies to this actual active admissible connection and its $P$-torsor.
It gives(8) and the noncyclic, Frattini and Heisenberg bounds.
These do not identify its higher-Witt obstruction with the actual BT
class(3), or evaluate that class in any nonzero obstruction space.
