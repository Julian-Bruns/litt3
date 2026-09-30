# An effective comparison cutoff for supplied full groups

Version1,21 September2026. Focused independent audit PASS. This is a
comparison theorem for TWO ALREADY EXISTING full groups over one fixed
finite field. It does not extend a truncated group.

Let $q=5^f$, and let $C/\mathbf F_q$ be smooth, proper and geometrically
connected of genus $g\ge2$. Fix a generically ordinary, everywhere-versal
height-two, dimension-one BT1 $H$, with nonempty reduced supersingular
divisor and its specified determinant character
$\delta:\pi_1(C)\to\mathbf F_5^\times$. A normalized marked full extension
has first truncation $H$ and determinant
$\mu_{5^\infty}\otimes[\delta]$.

Define the following explicit, deliberately large integers:
\[
A=4g\,16^gq^{5g},\qquad
m=\min\{a\ge0:q^a\ge8(2g+1)\},\qquad d=16m,
\]
\[
\boxed{\ B(q,g)=1+4A^2(1+fd).\ }
\tag{1}
\]
For two normalized marked full extensions $G_1,G_2$ over $C$,
\[
G_1[5^{B(q,g)}]\simeq G_2[5^{B(q,g)}]
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

For an actual finite etale span defined over $\mathbf F_q$, with supplied
normalized full endpoint groups and their marked common BT1, apply (2)
on the ORIGINAL source $Z$. Compatibility at level $B(q,g(Z))$ forces
the supplied full comparison. It supplies neither a missing endpoint
group nor that finite-level comparison; the bound increases with the
genus of the source and the field of definition.

[Proof](../../Proofs/deformations/finite_field_full_bt_cutoff.md).
