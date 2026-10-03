# Proof of the uniform selected affine-line reduction

ID: `admissible_degree_ten_m9_half_selected_affine_line_reduction`.
Version1, 2 October2026. Exact polynomial pencil, no source search;
[focused review PASS](../../Research/audits/M9_SELECTED_AFFINE_LINE_REVIEW_2026_10_02.md).
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_half_selected_affine_line_reduction.md).

## Reversible coefficient changes retain the actual leading scale

Keep the original actual source, both actual maps, all short remainders,
and the accepted monic-$t$ whole-polynomial scalar normalization.
Divide homogeneous moments by their nonzero quadratic-trace scalar
for notation only, writing $n=q_3$.
The source double jets give $c=bC_*$,
$D=D_*+pD_3+rD_q$, and $C=D[2]\ne0$.
Put $e=[x^9]\operatorname{rem}(ZC_*-Z^2,P)$,
$c_0=[x^5]C_*$, and
$k(W)=[x^2](-P^{-1}\operatorname{rem}(Z^2W,P)\pmod t)$.
The fixed calculation below proves $e\ne0$ for every omission.

The [b-zero theorem](admissible_degree_ten_m9_half_bzero_exclusion.md)
gives $b\ne0$. Introduce ONLY coefficient ratios
$W=A/b$, $\alpha=a/b$, and $h=b^{-2}$.
The infinity-compatible first moment is
\[
\eta_1=b\mathcal L+ybm,\qquad
\mathcal L=\alpha q-k(W)n/C+b(c_0e/C^2)n,\quad m=-e/C.
\]
No original source function or map is rescaled by these substitutions.
Set $u=C\alpha$, $z=be/C$, and $w=hCV$, where $V$ is the
normalized coefficient of $y$ in $\eta_2$.
For fixed $h$, these changes are invertible on $bCe\ne0$;
the required scalar relation is $h(Cz/e)^2=1$.

## Exact six-row affine polynomial pencil

Use $R_f=\operatorname{rem}(Zf,P)$,
$S_f=\operatorname{rem}(Z^2f,P)$ and $\mathcal E=k[x]/(t)$.
Write $H_a=2dR_q-3qR_d$, $H_3=2dR_n-3nR_d$, and
$J_0=-n(D_*+pD_3+rD_q)+(3R_dR_n-3nS_d-dS_n)/P$.
The three selected quadratic-character rows become
\[
uH_a+C(WR_n-2nR_W)-k(W)H_3+z(c_0H_3+PC)=0
\quad\text{in }\mathcal E.
\]
The three selected linear-character rows become
\[
uq-k(W)n-eW+zc_0n+wd=hCJ_0
\quad\text{in }\mathcal E.
\]
To check the second equation directly, the selected linear character
before the changes is $dV=J_0-b^2(\mathcal L+mW)$.
Multiplication by $hC$ gives exactly the displayed expression.
For the first, divide the original quadratic character by $b$
and multiply it by $C$; proper $Z/P$ remainder terms give precisely
the terms displayed. Only the selected unit $P$ is inverted.
No leading endpoint value of $d$ is inverted.

Choose the fixed four-dimensional gap basis for $W$ and the basis
$1,x,x^2$ of $\mathcal E$. The two equations give a six-by-seven
matrix $M(p,r)$ on its four $W$ coordinates and $(u,z,w)$.
Each entry is AFFINE-LINEAR in the actual $p,r$, because
$d=pq_3+rq$ and $C=D_*[2]+pD_3[2]+rD_q[2]$ are affine-linear.
The right side is fixed when $(p,r,h)$ are fixed.

## Uniform finite rank-drop support, including exact vertical control

The seven maximal minors $m_I(p,r)$ have total degree at most six.
For EACH omission the new exact calculation gives their common
factor exactly $C$, up to a nonzero scalar. Divide all minors by
this factor and write $f_I=m_I/C$.
Since actual $C\ne0$, this division removes no possible actual
rank-drop point. The remaining polynomials have gcd ONE.
The certificate supplies stronger directly checkable witnesses:
\[
\sum_I A_I(p,r)f_I(p,r)=\delta(p)\ne0,
\qquad\deg\delta=6.
\]
Writing $f_I=\sum_j f_{Ij}(p)r^j$, it also supplies
\[
\sum_{I,j}B_{Ij}(p)f_{Ij}(p)=1.
\]
These are polynomial identities, not generic evaluations.
The first makes every common zero have $\delta(p)=0$.
The second ensures that for EVERY fixed $p$ at least one $f_I(p,r)$
is a nonzero polynomial in $r$; no vertical rank-drop line exists.
There are at most six possible $p$ values, and at each at most six
$r$ values. Thus the exact common-zero support
$\Sigma=V(f_I:\lvert I\rvert=6)$ has at most thirty-six geometric
points. It is a finite algebraic scheme; no assertion that it is
reduced is needed for the outside-support rank statement.

Outside $\Sigma$ at least one original maximal minor is nonzero
on $C\ne0$, so $M$ is surjective and has a one-dimensional kernel.
Every fixed right side therefore has a nonempty affine-line fiber.
The inverse coefficient changes and scalar relation retain the
necessary actual-source selected equations, without normalizing
the actual leading scale $p$.

## Exact evidence and limitations

Source:
[oct02_m9_half_nonzero_b_selected_rank_support.sage](../../scripts/oct02_m9_half_nonzero_b_selected_rank_support.sage).
External certificate:
[half_nonzero_b_selected_rank_support.json](../../../litt3-computation-data/oct02_m9_uniform/half_nonzero_b_selected_rank_support.json).
It records the fixed field and embedding, gap basis, every source
$C_*,e,c_0,C$, the six-by-seven matrix, all seven exact minors,
their removed common factor, the degree-six $\delta$, its polynomial
Bézout coefficients, and the coefficient-content identity.
All recorded polynomial identities are asserted before output.

The minors are computed symbolically by simultaneous Laplace expansion,
not by parameter sampling. Univariate Euclidean algorithms over
$k(p)[r]$, followed by denominator clearing, produce the first
witness; Euclidean gcd of all coefficient polynomials produces the
second. No Gröbner basis, source-$A$ search or settled program replay
is used. The fixed six-by-six source jet map is reconstructed only
to obtain the new constants $e,c_0$ needed for this new pencil.
The complete calculation took 0.362 seconds of script time, Sage10.9,
one CPU with all thread caps one, under a sixty-second hard bound.

This theorem gives a uniform affine-line stage and its finite rank
exceptions. The scalar inverse relation, selected scalar row, new
leading-zero rows, full original source constraints and global critical
square still have to be imposed. In particular an affine line is
not a source, and finiteness of rank exceptions is not their exclusion.
