# Completing the original equations and rank from five minors and a determinant

1 October2026.
[Statement](../../Theorems/cartier_and_spin/mixed_five_minor_same_moment_completion.md).
All shifts are the ORIGINAL shared moments and all rows retain their
actual constants. Write $P_{ij}=a_ib_j-a_jb_i$.
The first three projected equations say $P_{12},P_{13},P_{23}\in K$.
The elementary identity
$a_1P_{23}-a_2P_{13}+a_3P_{12}=0$
and independence of $a_1,a_2,a_3$ force all three FULL minors to vanish.
Their independence follows by projecting to the supplied invertible $T$.
Thus $a_1\ne0$ and $\epsilon=b_1/a_1$ gives $b_i=\epsilon a_i$ for
$i\le3$. No coordinate or matrix pivot was chosen.

Put $z=b_4-\epsilon a_4$. The remaining two projected equations imply
$a_1z,a_2z\in K$. If $z\ne0$, the field property gives $a_1z\ne0$ and
$a_2/a_1=(a_2z)/(a_1z)\in K$. This contradicts independence of
$\pi a_1,\pi a_2$. Hence $z=0$ and all four original equations hold.
The converse is immediate. For actual full endpoints a scalar
$\epsilon\in K$ would give $0=G_3=\epsilon C_3$, hence $\epsilon=0$.
The second original equation would then give $\pi G=0$, contrary to
the stated input. Thus $\epsilon\notin K$.

The map $a\mapsto(\pi a,\pi(\epsilon a))$ is injective on the
FOUR-dimensional $K$-space $F$: an element of its kernel belongs to
$K$ and its product with $\epsilon$ belongs to $K$, forcing it to be
zero. Consequently the stacked projected-column rank equals
$\dim_K\langle a_1,a_2,a_3,a_4\rangle$. The first three columns are
independent, so this rank is three precisely when the full top-column
determinant vanishes. This is a separate necessary condition, not a
consequence of the original four scalar equations. It restores exact
rank-three equivalence without a pivot or inverse parameter.

For FIXED ACTUAL FULL rows satisfying the stated conditions there is a
short direct uniqueness argument that also covers every scalar-graph
boundary. Both solution scalars are outside $K$ by the preceding argument.
Suppose two moment completions have scalars
$\epsilon,\epsilon'$. If $\Delta=\epsilon-\epsilon'\ne0$, subtracting
their first three equations gives
$\Delta E_1,\Delta C,\Delta U\in\langle1,\epsilon,\epsilon'\rangle_K$.
The element $\Delta$ belongs to that same space. Since
$1,E_1,C,U$ are independent and multiplication by $\Delta$ is injective,
the four elements $\Delta,\Delta E_1,\Delta C,\Delta U$ are independent.
This is impossible in a space of dimension at most three.
Therefore $\epsilon=\epsilon'$. The first equation then gives
$\epsilon(X^{5^7}-X'^{5^7})=Y^{5^7}-Y'^{5^7}$.
Since $\epsilon\notin K$, both scalar differences vanish and
$X=X'$, $Y=Y'$. This proves uniqueness without an auxiliary skew-part
or generic-rank hypothesis.

For affine linearity, write $a_i=A_i+\alpha_i$ and $b_i=B_i+\beta_i$,
where $A=(E_1,C,U,Z)$, $B=(D,G,-V_0,-W)$ and
$\alpha=(-X^{5^7},-Y,-X^{5^4},Y^5)$,
$\beta=(-Y^{5^7},-X,-Y^{5^8},X^{5^{11}})$.
Projection gives exactly
$\pi(A_iB_j-A_jB_i)+\alpha_i\pi B_j-\alpha_j\pi B_i
+\beta_j\pi A_i-\beta_i\pi A_j$.
The products $\alpha_i\beta_j-\alpha_j\beta_i$ lie in $K$ and vanish.
All displayed Frobenius maps are $\mathbf F_5$-linear on the ACTUAL
marked field. Five pairs and three projected coordinates give15 $K$
equations, hence210 affine rows in28 prime coordinates. The determinant
is affine-linear too: the moment shifts change only the constant basis
ROW of its four-by-four matrix. Expanding along that row gives a constant
plus a linear combination of the original four shifts. Adding its14
prime coordinates gives224 affine rows. If inconsistent,
choose a basis of at most28 coefficient rows and one augmented row that
contradicts them. Their linear combination is $0=1$, giving a certificate
with at most29 original affine rows.

For the genuine finite model, each actual unordered pair $(a,b)$,
INCLUDING repetitions $a=b$, is bound to BOTH
$c=\xi^{5a}+\xi^{5b}$ and $u=\xi^{17a}+\xi^{17b}$ through one index
in the435-pair table. Fourier reconstruction with
$CW=(13,3,9,2)$, $EW=(4,3,14,0)$,
$UW=(22,24,12,11)$ and $VW=(6,21,11,0)$ recovers every original row,
including its constant. The $E$ row uses $\phi_3(u)$ and the $V$ row
uses $\phi_8(c)$. Every projected minor is therefore degree at most two
in the field-valued pair sums and moment coordinates.
These row identities and the supplied genuine source classification
justify the two repeated-source models. The rank determinant is degree
at most four in these pair sums and moments. In the actual coordinates
$E_{1,3}=Z_3=0$, it can be computed sparsely as
$C_3\det_3(E_1-X^{5^7},U-X^{5^4},Z+Y^5)
-U_3\det_3(E_1-X^{5^7},C-Y,Z+Y^5)$,
where each three-by-three determinant uses coordinates zero, one and
two. This formula divides by nothing and keeps every coefficient boundary.
Earlier exported degree-two models omit this condition and are necessary
relaxations, not exact rank-three representations. No executed existence
decision is claimed.

The argument above is algebraic; finite tests are supplemental.
The fixed-source and both uniform-family circuits passed180 original
projected-minor coordinate comparisons and96 original source/target row
comparisons across twelve exact field points. Source:
[five_minor_circuit.py](../../scripts/oct01_mixed_incidence/five_minor_circuit.py).
Original outputs are in the sibling computation-data directory
`oct01_local_continuation/mixed/` under `five_minor_fixed6.json`,
`five_minor_adjacent.json` and `five_minor_opposite.json`.
Focused parent review passed scalar completion and uniqueness on1 October2026.
Subsequent focused review found and corrected the version1 assertion that
rank three was automatic; version2 includes the determinant. The explicit
counterexample and affected model scopes are recorded in
[the correction note](../../Research/experiments/oct01_mixed_incidence/FIVE_MINOR_RANK_SCOPE_CORRECTION.md).
The [experiment note](../../Research/experiments/oct01_mixed_incidence/FIVE_MINOR_COMPLETION.md)
records the source hypotheses, exact finite scope and remaining gap.
