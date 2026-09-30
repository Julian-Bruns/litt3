# Proof: paired integral references compare the actual cocycles

[Statement](../../Theorems/deformations/bt_hodge_obstruction_comparison.md).
User-returned Pro proof,21 September2026, answering
[the self-contained comparison request](../../Research/requests/bt_obstruction_transport_2026_09_20/01_bt2_hodge_class_comparison.md).
The operator and overlap normalizations were checked locally during
integration; no independent audit or formal verification is claimed.

## Integral paired references

Choose a marked $C_3^0/W_3$ extending $C_2$. Such a smooth curve lift
exists because $H^2(C,T_C)=0$. On an affine etale cover $U_i$, lift the
original Hodge line in $\mathcal H_2(C_3^0)$. Its second fundamental
isomorphism persists by Nakayama. Its determinant and maximal graded
Higgs bundle therefore identify with the specified ones. The remaining
graded scalar is fixed using the determinant and a square root lifting
the previous scalar; two is invertible.

Complete each of these LOCAL filtered objects to higher periodic data,
choosing smooth lifts at every stage. The Hodge obstruction lies in
coherent $H^1$ on an affine scheme and is zero. The line and its flat
finite-order determinant twist lift compatibly. This gives a local full
filtered Fontaine module. It is not a global prolongation of $H$.
The construction and its reduction compatibility are those of
[Lan--Sheng--Zuo, Section5](https://arxiv.org/pdf/1311.6424v2), and the
Hodge-line variation is in
[Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/html/1404.0538#S5).

In a normal decomposition $P=P_0\oplus P_1$, set
$P^\sharp=P_0\oplus5^{-1}P_1$, with the rescaled connection
$\widetilde\nabla=5\nabla$. The periodic isomorphism
$U:\sigma^*P^\sharp\simeq P$ gives
\[
F=U\operatorname{diag}(1,5),\qquad
V=\operatorname{diag}(5,1)U^{-1}.
\]
These are effective weights-$[0,1]$ windows. Their connection is
$d+(d\sigma/5)\widetilde\nabla$, and the overlap between local
Frobenius lifts uses
\[
\Gamma_{ij}=\sum_{n\ge0}\widetilde\nabla_{\partial_u}^{,n}
\frac{((\sigma_i(u)-\sigma_j(u))/5)^n}{n!}.
\]
Integrality follows from
$\widetilde\nabla_{\partial_u}^{,n}(P^\sharp)
\subset5^{n-1}P^\sharp$ for $n\ge1$. The resulting actual local
groups $G_i$ have BT2 truncations $A_i$ with the given BT1 marking
and normalized determinant. Their filtered crystalline realizations
modulo25 are exactly the paired Hodge references just chosen.

## The predecessor removes an otherwise real ambiguity

On an ordinary splitting cover use the same absolute Frobenius lift.
For the normalized mixed-characteristic Kummer parameter $Q$, write
\[
\nabla e_0=0,\quad \nabla e_1=e_0,d\log Q,\quad
\Phi(e_0)=e_0,\quad
\Phi_1(e_1)=e_1+\ell_Q e_0,\quad
\ell_Q=\tfrac15\log(\sigma(Q)/Q^5).
\]
The actual BT1 marking gives $q_j=q_i a^5$ on the characteristic-five
ordinary field. The lifts could initially differ by
\[
Q_j=Q_i\widetilde a^{,5}(1+5B)\pmod{25}.
\]
Their divided Frobenius coefficients satisfy
$\ell_{Q_j}-\ell_{Q_i}=B^5\pmod5$. The FIXED FIRST PERIODIC datum
identifies those divided maps, not just their undivided reductions.
Thus $B^5=0$ on a reduced overlap, and $B=0$.
This is the substantive use of the predecessor hypothesis.

Put $d\log Q_i=w_i du$, and $c=d\log a/d\log q_i$. Then
$w_j=w_i(1+5\widetilde c)\pmod{25}$. The projective potential is
\[
R(w)=\tfrac34(w'/w)^2-\tfrac12w''/w.
\]
Its divided variation is
\[
\frac{R(w_j)-R(w_i)}5
=-\tfrac12\left(c''-(w'/w)c'\right)
=\tfrac12\mathscr D_H(c^5-c).
\tag{2}
\]
Here $s=w^4(du)^4$, so $s'/s=-w'/w$ in characteristic five.
The final expression is the ACTUAL $\Delta(A_i,A_j)$, not an
arbitrary Cartier-kernel vector.

## The same variation is the Hodge obstruction

Write the Hodge obstruction cocycle as $f_{ij}\partial_u$.
For a normalized cyclic generator $e''=re$, its change is
\[
e\longmapsto(1-\tfrac52 f')e+5f e'\pmod{25}.
\]
Differentiation gives the divided projective-potential change
$2rf'+r'f-\tfrac12f'''=\mathfrak b_r(f\partial_u)$.
Together with (2), this proves the actual overlap equality
\[
\mathscr D_H\Delta(A_i,A_j)=2\mathfrak b_r(f_{ij}\partial_u).
\tag{3}
\]
Both sides are regular bundle sections across the supersingular
divisor: the right side comes from integral Hodge references, and
regularity on the left is the established Hessian theorem. Equality
on the dense ordinary open therefore extends over the whole overlap.

## The quotient and pairing normalization

The Hodge-projection map is $\mu(f\partial_u)=s_u f^5\partial_u$.
Its composite with $\mathfrak b_r$ is zero. The latter operator
lands in the nilpotent tangent kernel because it changes the Hodge
line of the same nilpotent flat connection. At a simple supersingular
point the leading $s$-term has order two, less than five, so the image
of $\mu$ in the Frobenius pushforward is primitive. It is primitive
on the ordinary open as well. The resulting rank-four quotient
$F_*T/\mu(T)$ has degree $4(g-1)$, the degree of $\mathcal N_r$.
The ordinary calculation below proves that its induced map to
$\mathcal N_r$ is generically an isomorphism. Its determinant has
an effective zero divisor of degree zero, so the map is an
isomorphism everywhere. This proves the stated exact sequence
without ignoring a possible supersingular torsion cokernel.

On an ordinary logarithmic chart $\Omega=dx/x$, put $D=x\partial_x$.
The formulas reduce to
\[
\mu(fD)=f^5D,\qquad
\mathfrak b_r(fD)=-\tfrac12D^3f\,\Omega^2,\qquad
\mathscr D_H(b)=D^2b\,\Omega^2.
\]
The summed-Wronskian pairing on the tangent bundle is
$2C(hDk\,\Omega)$, and its Hessian pullback is
$2C(bDb'\,\Omega)$. Under Frobenius duality the induced map into
$F_*T/\mu(T)$ is $j(b)=[-2D^3b\,D]$. Indeed
\[
C((-2D^3b)D^2b'\,\Omega)=2C(bDb'\,\Omega),
\qquad \overline{\mathfrak b}_rj(b)=D^6b\,\Omega^2=D^2b\,\Omega^2.
\]
The last identity uses $D^5=D$. Thus
$J=\overline{\mathfrak b}_{r*}^{-1}\mathscr D_{H*}$.
Taking cohomology of (3) gives $J(e(H))=2\epsilon(C,r)$.
Cartier and scalar Frobenius have not been replaced by linear copies.

## Actual effectivity in both directions

The sheaf of local higher-Hodge solutions, retaining the first datum,
is a torsor under $F_*T/\mu(T)$. Paired local completion induces a map
to the actual BT2 torsor, equivariant for the isomorphism
\[
F_*T/\mu(T)\xrightarrow{\ 2\mathscr D_H^{-1}\overline{\mathfrak b}_r\ }
\mathcal B_H.
\]
For a global Hodge solution, the resulting local $A_i$ have zero
actual difference. Their unique normalized marked isomorphisms
satisfy the cocycle and descend finite locally free Hopf algebras.
The descended group is an actual BT2 on $C$ with all markings.

Conversely, an actual BT2 $A$ differs locally from $A_i$ by
$d_i=\Delta(A_i,A)$. Translate the local Hodge solution by
$\tfrac12\overline{\mathfrak b}_r^{-1}\mathscr D_H(d_i)$.
Different representatives differ by $\mu(T)$ and are absorbed by
marked curve-lift isomorphisms. The translated solutions glue and
retain the predecessor. This proves both implications without a
global full-group assumption.
