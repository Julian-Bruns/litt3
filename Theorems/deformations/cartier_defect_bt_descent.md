# No increase in Cartier defect forces prescribed full-group descent

Version1,20 September2026. Work over $k=\overline{\mathbf F}_5$.
Let $q:D\to C$ be an ACTUAL connected finite etale cover of proper
hyperbolic curves, of degree $d$ prime to five. Let $H/C$ be an
actual everywhere-versal height-two, dimension-one BT1, generically
ordinary with reduced supersingular divisor. Use the Cartier spaces
$K_C,K_D$ of [exact realization](versal_bt_cartier_realization.md).

Trace preserves these spaces and yields a direct sum
\[
K_D=q^*K_C\oplus K_{D/C},\qquad
K_{D/C}=\ker(\operatorname{Tr}_q:K_D\to K_C).
\tag{1}
\]
Suppose $A_N/C$ is a normalized marked BT$_N$ with first level $H$,
and $B/D$ is a normalized marked next extension of $q^*A_N$.
There is a canonical obstruction function
\[
r_q(B)\in K_{D/C}
\tag{2}
\]
which vanishes if and only if the SPECIFIED $B$ descends to a
normalized marked next extension on the original $C$. It is computed
from any downstairs next extension $A$ by
\[
h=\Delta_N(q^*A,B),\qquad
r_q(B)=h-d^{-1}q^*\operatorname{Tr}_q(h).
\tag{3}
\]
Such an $A$ exists by the prime-to-five norm theorem. No Galois
assumption or prime-to-five assumption on the Galois closure is used.
The function in (3) is independent of $A$.

In particular, if $\dim K_D=\dim K_C$, EVERY specified next
extension descends. If a normalized full group $G_D$ is given, with
$G_D[5]\simeq q^*H$, then $G_D$ itself descends to a normalized
full group on $C$. The entire tower and its original marking are
retained, not just existence of unrelated next levels.

For an actual span $X\xleftarrow fZ\xrightarrow gY$ with common
admissible active projective opers, suppose $r_Y$ is ordinary,
$5\nmid\deg f$, and
\[
\dim K_{r_Z}=\dim K_{r_X}.
\tag{4}
\]
Then the ORIGINAL span has a simultaneous smooth proper
mixed-characteristic lift with both maps finite etale. The source
and $X$ need not be indigenous-ordinary. The finite fourth-character
discrepancy is removed by the already permitted source refinement,
then the lift descends to the original source.

Thus a nonliftable span in this active branch with ordinary $Y$
must satisfy
\[
5\mid\deg f\quad\text{or}\quad
\dim K_{r_Z}>\dim K_{r_X}.
\tag{5}
\]
This does not construct a common oper from a bare span or exclude
the two cases in (5).

There is also a finite local test for (2): its simple-pole principal
parts at the supersingular points all vanish if and only if it is
zero. On $D\times_C D$, the specified group descends exactly when
the polar parts of the difference of its two pullbacks vanish on
every connected component. This latter criterion requires no degree
restriction, but does not prove cancellation.
[Proof](../../Proofs/deformations/cartier_defect_bt_descent.md).
