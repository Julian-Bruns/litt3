# Proof of nonzero homogeneous B0 quadratic trace

Version1, 2 October2026. All local source roots below belong to the
ORIGINAL primitive degree-ten étale source. The auxiliary irreducible
critical cubic may ramify elsewhere and is never substituted for
either of the two original étale maps.

## Zero trace forces zero first moment in both infinity strata

By [the actual low-trace theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_low_trace_quadratic_moments.md),
$n_0\in kq_3$, $\eta_1\in\langle q,q_3,y\rangle$ and
$\eta_2\in L_{12}$. Assume for contradiction $n_0=0$.
Then $\mu_1=\eta_1$, and $R_{26}=0$ kills its $y$ coefficient
because $C=(\delta_1)_{16}\ne0$. Write
$\mu_1=a q+b q_3$.
The half-stratum $R_{25}=0$ would also kill $b$, but we do not
use this extra row. Put $d=\delta_3=pq_3+rq$, with $p\ne0$.
Let $R_f=\operatorname{rem}(Zf,P)$, $R_q=R_{q}$ and $R_3=R_{q_3}$.
The exact short formulas are
$\mu_2=\eta_2-2y^2(aR_q+bR_3)/P$ and
$\delta_2=a_4+yb_1+3y^2R_d/P$.
Here $b_1$ may be linear in $x$ in the pole-thirteen stratum.
Its degree is irrelevant to the following $y^2$ equation.

Let $t$ be the selected cubic. Since its base fibers are ordinary,
$P$ is a unit in $\mathcal E=k[x]/(t)$ and the selected coordinate
algebra has basis $1,y,y^2$ over $\mathcal E$.
Every $\eta_2\in L_{12}$ has no $y^2$ character.
The actual selected equation $d\mu_2+\delta_2\mu_1=0$ therefore gives
\[
ap(2q_3R_q-3qR_3)-ar qR_q-bp q_3R_3
+br(2qR_3-3q_3R_q)=0\quad\text{in }\mathcal E.
\]
No inverse of $d$ is taken. In characteristic five the first and
fourth columns coincide. The exact fixed three-by-four matrix has
rank three for EVERY selected omission, and its kernel is precisely
$k(1,0,0,4)$, as recorded below. But the coefficient vector is
$(ap,ar,bp,br)$, the entries of the rank-at-most-one matrix
$\left(\begin{smallmatrix}ap&ar\\bp&br\end{smallmatrix}\right)$.
The nonzero kernel vector has determinant $4\ne0$.
Thus the coefficient vector is zero; since $p\ne0$, $a=b=0$.
We have proved $\mu_1=0$ in BOTH large-critical strata.

Now $\mu_2=\eta_2\in L_{12}$ and $Q=-d\mu_2$.
The moment cannot vanish, by actual critical coprimality.
If $d$ is a unit on the nine selected points, their equation gives
$\mu_2\in H^0(X,12O-T)=tL_3$, contrary to
[the pure selected-kernel theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_pure_selected_kernel_exclusion.md).
It remains to handle a selected zero of $d$.

## The selected-zero norm reduction

The four fixed ratios $-q_3(s)/q(s)$ at roots $s$ of the selected
quartic $A$ are distinct, and $q(s)\ne0$ at all four roots.
Hence $d$ has exactly ONE shared root with the selected cubic,
say $s$, and is a unit at the other two selected base points.
The leading cubic is squarefree: the accepted repeated-pencil
parameters have all roots outside $A$, as recorded in
[the source pole-three proof](admissible_degree_ten_m9_source_rational_critical_pole_three_exclusion.md).
Thus its zero at $s$ is simple.

Write $\mu_2=M_4(x)+c y$, $\deg M_4\le4$.
At either selected base point where $d$ is a unit, the selected
equation forces this linear polynomial in $y$ to vanish at all
three points. Thus $c=0$, and $\mu_2=M_4(x)$ exactly.
By [actual sign-norm parity](admissible_degree_ten_m9_critical_sign_norm_cone.md),
$dM_4/t$ has even divisor on $X$. All finite ramification indices
of $x$ are one or three, so this rational function of $x$ has even
valuations on $\mathbb P^1$. It is a square in $k(x)$.
Its sign class is therefore trivial. The original critical square
identity implies
\[
F(c)t\in k(C)^{*2}.
\]
Equivalently, with $g=x-s$ up to scalar, norm parity fixes
$M_4=\alpha dt/g^2$, $\alpha\in k^*$: $dt/g^2$ is squarefree
of degree four, so the bound $\deg M_4\le4$ leaves no further
polynomial square factor. We will only need the critical square.

In the pole-thirteen stratum there is already a short conclusion:
$\mu_1=n_0=0$ makes its final infinity row
$(-d\mu_2)_{21}=0$, excluding the pole twelve of this $M_4$.
The following local argument treats the boundary uniformly, including
the half stratum where that infinity contradiction is unavailable.

## Actual-source parity at the pole-one critical branch

Fix ANY of the three points over the shared base point $s$,
and let $r$ be a local uniformizer on $X$. All short coefficients
are regular here, $q_s$ has order three, $t$ order one, and
$d=d_1r+O(r^2)$ with $d_1\ne0$.
These regularity assertions come from the ORIGINAL coefficient lattice,
not the moment bounds. The finite-frame source coefficients are affine,
and their short translation $a_s=Z/y$ is regular at selected points
because $P(s)\ne0$, hence $y$ is a unit. The rational short remainders
have only denominators $P$ there. The fixed normalization
$q_s=(Q_{\rm fixed}-L_0^5)/y^5$ has EXACT selected order three
and $t$ exact order one, as in the
[source-critical reduction](admissible_degree_ten_m9_source_critical_fitting_reduction.md)
and [selected-contact proof](admissible_selected_quadratic_contact.md).
The original $v\in L_{10}$ is affine with exact infinity pole ten,
so it is nonzero globally and has a finite nonnegative order at
every selected endpoint.
We claim $\delta_2$ vanishes at this point.

Suppose instead $\delta_2=e_2+O(r)$, $e_2\ne0$.
The reciprocal critical equation
$d+\delta_2\zeta+\delta_1\zeta^2+\delta_0\zeta^3=0$
has an unramified simple root $\zeta$ of order one.
Hence $c=\zeta^{-1}$ has pole one and
$\beta=rc$ has residue $\beta_0=-e_2/d_1\ne0$.
Write $m=\operatorname{ord}v\ge0$.

The high-degree terms of the ORIGINAL raw polynomial are exactly
\[
F(T)=vT^{10}+(d/4)T^9+(\delta_2/3)T^8
+(\delta_1/2)T^7+\delta_0T^6+\text{terms of degree at most five}.
\]
All lower coefficients are regular. If $m=0$, $F(c)$ has exact
pole ten, and $F(c)t$ has odd order $-9$, a contradiction.
If $m\ge3$, the two terms of pole eight have leading sum
$\beta_0^8(d_1\beta_0/4+e_2/3)
=\beta_0^8e_2/12\ne0$. Thus $F(c)$ has exact pole eight
and $F(c)t$ again has odd order, now $-7$.

If $m=1$, the Newton polygon of the original source polynomial
has its high-degree edge from $(8,0)$ to $(10,1)$, with $(9,1)$
strictly above it. Exactly two source roots have pole $1/2$.
But the source map to $X$ is étale, so ALL TEN original roots
are in $k((r))$, with integral valuations. This case is impossible.

It remains to treat $m=2$. Put $v=v_2r^2+O(r^3)$,
$v_2\ne0$, and normalize
$G(z)=r^8F(r^{-1}z)$. This is integral with UNIT leading
coefficient and reduction
\[
\bar G(z)=z^8K(z),\qquad
K(z)=v_2z^2+(d_1/4)z+e_2/3.
\]
The original derivative identity gives $G'(\beta)=0$.
If $K(\beta_0)\ne0$, $F(c)$ has exact pole eight as before.
Otherwise $K'(\beta_0)=0$, since $\beta_0\ne0$ and
$\bar G'(\beta_0)=0$. Thus $\beta_0$ is an EXACT double root
of this degree-two polynomial. The ten normalized ORIGINAL
source roots are integral Laurent series: integrality follows
from the unit-leading polynomial $G$, and Laurent splitting
from the actual étale map. Precisely two have residue $\beta_0$;
the other eight have residue zero. Factoring out that actual
monic quadratic pair leaves an integral cofactor which is a unit
at $\beta$.

The elementary arbitrary-contact pair lemma in
[the sign-norm proof](admissible_degree_ten_m9_critical_sign_norm_cone.md)
therefore gives EVEN order of $G(\beta)$.
Explicitly, for roots $z_1,z_2$, their midpoint $h$ and
$\epsilon=(z_1-z_2)/2$, the derivative equation puts
$\beta-h$ in order at least $2\operatorname{ord}\epsilon$;
the value has order $2\operatorname{ord}\epsilon$.
The roots are distinct by actual source separability, and the
critical value is nonzero by actual critical coprimality.
Since $F(c)=r^{-8}G(\beta)$, its order remains even.
Multiplication by the order-one $t$ contradicts the critical square.

All possible $m$ are excluded. Hence $\delta_2=0$ at EVERY one
of the three points over $s$, including possible zeros of $v$.
This is the step which uses actual Laurent source splitting;
an arbitrary necessary polynomial would permit the $m=1$
ramified-root alternative and would not supply pair parity at $m=2$.

## Fixed shared-root remainders finish the contradiction

Write $d=\gamma d_0$, $\gamma\ne0$, with
$d_0=q_3+\lambda_s q$ and $\lambda_s=-q_3(s)/q(s)$.
The exact short coefficient is
$\delta_2=a_4+yb_1+3\gamma y^2R_0/P$,
$R_0=\operatorname{rem}(Zd_0,P)$.
The four fixed shared-root values $R_0(s)$ are NONZERO.
At $s$, therefore, $\delta_2$ is a polynomial of degree two
in $y$ with nonzero quadratic coefficient. It cannot vanish
at all three distinct roots of $y^3=P(s)$.
This contradicts the preceding actual-source local argument.
Thus $n_0=0$ is impossible. The established gap identity
$n_0\in kq_3$ proves the stated exact pole nine.

## Exact bounded certificate and provenance

The fixed input codes are, in increasing polynomial degree,
\[
P=[11,22,18,5,19,20,15,16,9,22,1],\quad
Z=[15,19,24,12,10,19,3,24,18,16],
\]
\[
A=[1,21,14,22,13],\quad q=[13,18,24],\quad q_3=[1,22,9,1].
\]
Interpret a code $c$ as $(c\bmod5)+\lfloor c/5\rfloor\beta$,
$\beta^2=\beta+3$. For exact output use
$E=\mathbb F_5[e]/(e^8+e^4+3e^2+4e+2)$ with
$\beta=[3,4,2,2,4,4,4,4]_e$; the subscript denotes coefficients
in the $e$ basis, in increasing degree.
The four roots, leading ratios and shared-root remainders are:

| Root $s$ | $\lambda_s=-q_3(s)/q(s)$ | $R_0(s)$ |
| --- | --- | --- |
| $[0,2,2,3,4,3,1,2]_e$ | $[0,4,3,3,4,2,4,4]_e$ | $[3,4,1,1,2,2,4]_e$ |
| $[4,1,1,1,0,4,2,2]_e$ | $[1,2,2,1,3,4,0,2]_e$ | $[2,3,2,3,2,1,2,1]_e$ |
| $[3,2,0,3,1,1,1,4]_e$ | $[3,4,1,0,0,1,2,1]_e$ | $[4,4,2,2,3,1,3,4]_e$ |
| $[3,1,0,1,1,3,2,3]_e$ | $[1,4,1,3,2,2,3,2]_e$ | $[3,4,0,4,3,1,1]_e$ |

Each remainder is visibly nonzero, and the ratios are distinct.
The generating source also records all six nonzero ratio-difference
numerators, all $q(s)$ units, and $\gcd(d_0,A)$ degree one.
The four three-by-four matrices are obtained by reducing the four
displayed columns modulo $A/(x-s)$ in the basis $1,x,x^2$;
exact row reduction gives rank three and the same kernel basis
$(1,0,0,4)$ in every case.

Both full small certificates are retained outside the repository:
[leading ratios and remainders](../../../litt3-computation-data/oct02_m9_uniform/selected_leading_ratio_separation.json)
and [the four exact tensor matrices](../../../litt3-computation-data/oct02_m9_uniform/zero_n0_selected_tensor_maps.json).
Their source is
[the bounded fixed-input script](../../scripts/oct02_m9_selected_leading_ratio_separation.sage).
It was executed once under Sage 10.9 with
`OMP_NUM_THREADS=OPENBLAS_NUM_THREADS=MKL_NUM_THREADS=1`, a ten-second
hard timeout, and completed both checks in $0.144$ seconds.
Verification requires only the fixed polynomial remainders, four
three-by-four row reductions and the displayed field equalities;
no source-coefficient search or multivariable elimination is involved.
