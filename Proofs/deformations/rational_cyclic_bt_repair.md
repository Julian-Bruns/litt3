# Proof: the rational cover and its infinity chart

[All-six theorem](../../Theorems/deformations/cyclic_descent/all_cyclic_five_fourth_obstructions.md).
This supporting proof identifies its rational arithmetic orbit by an
explicit equation. The BT height follows from the separate height theorem.
21 September2026. The new model and its arithmetic use exact field
and polynomial calculations; the earlier BT2 obstruction is not replayed.

Let $O$ be the point at infinity of $C$, and put $z=u^2/v$, a local
parameter at $O$. The classes $z^{-3},z^{-1}$ are a basis of
$H^1(C,\mathcal O_C)$. On the punctured formal neighborhood put
\[
c=z^{-3}+\tau z^{-1}
=v\left(F/u^6+\tau/u^2\right).
\]
In the coefficient field of the statement, the exact numerator
\[
N=F^7+\tau^5F^2u^{20}-\chi Fu^{24}
 -\chi\tau u^{28}-A(u)u^{30}
\tag{2}
\]
has degree27. Consequently
\[
c^5-\chi c-vA(u)=vN/u^{30}
\tag{3}
\]
is regular at $O$ and vanishes there: its valuation is
$-5-2\cdot27+2\cdot30=1$. On $C-\{O\}$ the displayed cover is
already etale, since its derivative in $w$ is the nonzero constant
$-\chi$. Above $O$ use $w_O=w-c$. Its equation is
\[
w_O^5-\chi w_O=-vN/u^{30},
\]
whose right side is regular and whose derivative is still a unit.
This proves actual etaleness at the omitted point; there is no
unexamined projective boundary.

Over an extension containing $s$ with $s^4=\chi$, replace the cover
coordinate by $w/s$, dividing its equation by $s^5$ and its transition
by $s$. The resulting constant Artin--Schreier
torsor has nonzero cohomology image $[c/s]$ in $H^1(\mathcal O_C)$.
The image is nonzero since the first coordinate of $[c]$ in the above
basis is one. The Artin--Schreier sequence over algebraically closed
constants injects $H^1_{\rm et}(C,\mathbf F_5)$ into $H^1(\mathcal O_C)$.
Thus the torsor is nontrivial and geometrically connected. Etale
Riemann--Hurwitz gives genus $5(2-1)+1=6$.

For completeness, in that basis the actual semilinear Frobenius is
$v\mapsto M_1v^{(5)}$, where
\[
M_1=\begin{pmatrix}
4\tau^2+\tau+2&3\tau+3\\
\tau^3+3\tau^2+3&4\tau^2+1
\end{pmatrix}.
\]
This is the matrix from the established six-cover cohomology calculation.
One checks $M_1(1,\tau)^{(5)}=\chi(1,\tau)$. The four-step matrix is
\[
M=\begin{pmatrix}
\tau^3+3\tau^2+3\tau+2&\tau^3+3\tau^2+3\tau+1\\
4\tau^3+2\tau^2+4\tau+2&4\tau^3+2\tau^2+2\tau+1
\end{pmatrix}.
\]
It has $(M+I)^2=0$, $\operatorname{rank}(M+I)=1$, with eigenspace
$k_0(1,\tau)$. On Frobenius-fixed Artin--Schreier vectors, arithmetic
$625$-Frobenius acts projectively as $M^{-1}$. Its nontrivial unipotent
projective action has order five, with the unique fixed line just
displayed. Since there are six geometric cover classes, the orbit
lengths are exactly one and five.

Finally $\chi^{(625-1)/4}=-1$. Thus $s^{625}=-s$, so the five deck
translations $w\mapsto w+as$, $a\in\mathbf F_5$, become constant over
$k_0^2$, with arithmetic Frobenius acting by inversion. The curve and
cover themselves are already defined by (1) over $k_0$.

The [source checker](../../scripts/deformations/cyclic/certify_rational_cyclic_bt_repair.sage)
verifies (2)--(3), the vanishing of both obstructing negative infinity
coefficients, the two Frobenius matrices and their Jordan form, and
the deck splitting field. Its executed
[receipt](../../../litt3-computation-data/bt_obstruction_transport_20260921/rational_cyclic_repair.json)
contains all coefficients and reports PASS. This is an author check;
no new independent audit of the model is claimed.

The [actual BT2 repair theorem](etale_p_witt_obstruction.md), together
with [group effectivity and obstruction comparison](explicit_bt2_descent_failure.md),
applies to every geometric cyclic-five cover, hence to (1). No
additional higher-Witt calculation is hidden in this specialization.
The source equation is exactly the older fourth-obstruction cover.
The subsequent [all-six cyclic theorem](cyclic_descent/all_cyclic_five_fourth_obstructions.md)
therefore proves that this BT2 repair has noBT3 and no full prolongation.
