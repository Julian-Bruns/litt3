# The smallest first section trace has full positive-plane rank

Version1,2 October2026. Independent focused review PASS:
[audit](../../Research/audits/ACTUAL_FIRST_TRACE_POSITIVE_RANK_THREE_AUDIT_2026_10_02.md).
Work over $\overline{\mathbf F}_5$ with the fixed genus-nine curve $X$,
its infinity point $O$, Cartier bundle $B_X$, original three-section
image $I\simeq O_X^3$, saturation $U$ and canonical positive plane
$P_X$. Retain BOTH actual finite etale maps
$X\xleftarrow hS\xrightarrow gY$ from the SAME smooth connected
projective source, where $Y$ has genus two and the degrees are $n,8n$.
All sheaves below are on the corresponding first Frobenius targets.
Write $J,K,H$ for the complete actual trace images of $I,P_X,U$.

If $K$ has generic rank three, its actual image is saturated of
degree two. Put $E=K$, $A=E^\perp$ and $V=E/A$. The canonical
quadratic injection
\[
j:\mathscr H=A^2\operatorname{Sym}^2V\otimes\omega_Y^{-1}
\longrightarrow E
\]
has degree-zero image and defect two, as in
[the positive quadratic trace](positive_rank_three_quadratic_trace.md).
Then the COMPLETE truncated canonical-line trace is exact:
\[
\operatorname{image}\bigl(g_*h^*(\lambda_X(-O))\to B_Y\bigr)
=j(\mathscr H).
\]
In particular $j(\mathscr H)\subset J$. Consequently
\[
\boxed{\operatorname{rank}K=3\quad\Longrightarrow\quad\deg J\ge2.}
\]
Equivalently, if the first section trace has degree one, the positive
plane has rank-FOUR trace. No corelessness or simultaneous Galois
closure is assumed for this implication.

More sharply, if the radical $A$ has a DOUBLE adjunction zero, then
\[
\boxed{J=H,\qquad\deg J\ge3.}
\]
Thus in that branch the original three-section lattice already has
the same complete first trace as its saturation. If the two zeros
are split, the asserted lower bound is $\deg J\ge2$; that larger
split branch is not excluded.

There is also a rank-two truncated-line conclusion: if the saturated
canonical-line trace is a rank-two degree-zero bundle $S_Y$, then
\[
\operatorname{image}\bigl(g_*h^*(\lambda_X(-O))\to B_Y\bigr)=S_Y,
\qquad S_Y\subset J.
\]
The degree-zero saturation is an explicit hypothesis in this second
assertion. Strong semistability is not asserted for every such
rank-two trace.

The proof gives a reusable binary-line collision bound retaining all
sheet multiplicities. Actual original-section fiber ranks and the
fixed radical/canonical-line determinant contact give the double-zero
trace equality; the reduced-zero radical loss bound excludes degree
one in the split case.
The rank-four positive trace branch, larger section-trace degrees,
and the unmarked common-cover problem remain open.

[Proof](../../Proofs/cartier_and_spin/actual_first_trace_positive_rank_three_exclusion.md).
