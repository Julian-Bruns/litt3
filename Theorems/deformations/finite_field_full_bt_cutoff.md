# An effective comparison cutoff for supplied full groups

Version2,3 October2026. The general arithmetic comparison retains
its focused independent audit and requires TWO ALREADY EXISTING full
groups over one fixed finite field. The later absolute torsor supplies
the ordinary case automatically.

Let $q=5^f$, and let $C/\mathbf F_q$ be smooth, proper and geometrically
connected of genus $g\ge2$. Fix a generically ordinary, everywhere-versal
height-two, dimension-one BT1 $H$, with nonempty reduced supersingular
divisor and its specified determinant character
$\delta:\pi_1(C)\to\mathbf F_5^\times$. A normalized marked full extension
has first truncation $H$ and determinant
$\mu_{5^\infty}\otimes[\delta]$.

Put $\delta_H=\dim K_H$, the actual
[Cartier defect](versal_bt_extension_torsor.md) of $H$. If $\delta_H=0$, the actual $H$ has its
UNIQUE normalized marked full extension over $\mathbf F_q$; the
comparison cutoff is $1$. For the general arithmetic case define
\[
A=4g\,16^gq^{5g},\qquad
m=\min\{a\ge0:q^a\ge8(2g+1)\},\qquad d=16m,
\]
\[
\boxed{\ B(q,g)=A(A-1)(fd+2).\ }
\tag{1}
\]
Set $B_H=1$ if $\delta_H=0$ and $B_H=B(q,g)$ otherwise.
For two normalized marked full extensions $G_1,G_2$ over $C$,
\[
G_1[5^{B_H}]\simeq G_2[5^{B_H}]
\quad\Longrightarrow\quad G_1\simeq G_2,
\tag{2}
\]
with the supplied markings and determinants. The normalized marked
isomorphism is unique. A geometric normalized marked comparison at the
displayed level suffices; it descends to $\mathbf F_q$ by uniqueness.

More economically, their rational Dieudonne crystals are determined by
the exact Frobenius traces at the finitely many closed points of degree
at most $d$. For these traces, congruence modulo $5^{B(q,g)}$ already
implies equality. This last assertion uses the arithmetic field of
definition of the FULL groups, not just that of $H$.

The exact next-level counts give the finite bound
\[
\#\{\text{normalized marked full extensions of }H
\text{ over }\mathbf F_q\}\le q^{\delta_H(B_H-1)}.
\tag{3}
\]
More generally at most $q^{\delta_H(N-1)}$ marked BT$_N$ classes
extend this fixed $H$ over $\mathbf F_q$. Existence of such truncations
over THAT field at arbitrarily high levels is equivalent to existence
of a full extension over the same field: their finite branching gives
a compatible infinite path. A single deep truncation does not supply
that unbounded-existence hypothesis.

For an actual finite etale span defined over $\mathbf F_q$, with supplied
normalized full endpoint groups and their marked common BT1, apply (2)
on the ORIGINAL source $Z$. Compatibility at the corresponding
source cutoff $B_{H_Z}$ forces
the supplied full comparison. In the ordinary-source case BT1 already
suffices and both ordinary endpoint towers exist uniquely. In the
general case endpoint full groups and the finite-level comparison
remain inputs; its bound depends on the actual source genus and field.

[Proof](../../Proofs/deformations/finite_field_full_bt_cutoff.md).
