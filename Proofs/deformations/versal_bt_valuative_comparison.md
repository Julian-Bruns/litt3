# Proof: the BT1 comparison and every subsequent digit are integral

[Statement](../../Theorems/deformations/versal_bt_valuative_comparison.md).
The later unmarked BT1 calculation and the earlier last-digit lemma
are combined here. All matrices evaluate crystals of two existing
groups; no effectivity of arbitrary truncated matrices is asserted.

## 1. Start with the supplied generic BT1 comparison

Suppress coefficient twists in matrix notation. In integral frames
adapted to the two Hodge lines, the reduced matrices are
\[
F_i=\begin{pmatrix}a_i&0\\c_i&0\end{pmatrix},\qquad
V_i=\begin{pmatrix}0&0\\d_i&e_i\end{pmatrix},\qquad
\nabla_i=d+C_i\,dt.
\tag{3}
\]
At an ordinary point $a_i,e_i$ are units. At a supersingular point
their valuations are one, $c_i,d_i$ are units, and $(C_i)_{12}$
is a unit by versality.

The actual generic group isomorphism preserves its Hodge line, so
its crystalline matrix is triangular:
\[
U=\begin{pmatrix}x&0\\z&w\end{pmatrix}\in\operatorname{GL}_2(K).
\]
The diagonal entries of $UF_2=F_1U^{(5)}$ and
$U^{(5)}V_2=V_1U$ give
\[
xa_2=a_1x^5,\qquad w^5e_2=e_1w.
\tag{4}
\]
The corresponding Hasse valuations agree; hence
$4v_t(x)=4v_t(w)=0$. Both diagonal entries are units, without
normalizing the determinant.

At a supersingular point the upper-left horizontality equation is
\[
x'+(C_1)_{11}x+(C_1)_{12}z=x(C_2)_{11}.
\]
Its other terms are regular and $(C_1)_{12}$ is a unit, so $z\in R$.
At an ordinary point the Frobenius equation
$za_2+wc_2=c_1x^5$ gives the same conclusion. Thus $U$ and its
inverse are integral. This supplies the actual BT1 marking needed
for induction.

## 2. The common-reduction last-digit lemma

For the common reduced BT1 write
\[
F_0=\begin{pmatrix}a&0\\c&0\end{pmatrix},\qquad
V_0=\begin{pmatrix}0&0\\d&e\end{pmatrix},\qquad ad+ce=0,
\qquad\nabla_0=d+C\,dt.
\]
Let $M=\left(\begin{smallmatrix}x&y\\z&w\end{smallmatrix}\right)$
over $K$ satisfy
\[
MF_0-F_0M^{(5)},\quad M^{(5)}V_0-V_0M,\quad M'+[C,M]
\in M_2(R).
\tag{5}
\]
The first two matrices are
\[
\begin{pmatrix}
a(x-x^5)+cy&-ay^5\\az+c(w-x^5)&-cy^5
\end{pmatrix},\qquad
\begin{pmatrix}
dy^5&ey^5\\dw^5-dx-ez&e(w^5-w)-dy
\end{pmatrix}.
\]
At a supersingular point $c,d$ are units; at an ordinary point
$a,e$ are units. The displayed entries therefore first force
$y\in R$. They then force $x,w\in R$: a pole of $x$, for
example, makes $a(x-x^5)$ have valuation $v_t(a)+5v_t(x)<0$,
because $v_t(a)$ is zero or one. At a supersingular point the
upper-left connection entry $x'+C_{12}z-yC_{21}$ forces $z\in R$;
at an ordinary point $az+c(w-x^5)$ does. Thus $M\in M_2(R)$.

## 3. Induct and recover the actual group maps

Evaluate the actual crystals on $S_N=W_N(k)[[T]]$, with
$\sigma(T)=T^5$ and Witt Frobenius on coefficients. Suppose the
generic comparison extends at level $N-1$. Lift its integral
matrix invertibly to $S_N$ and use it as a basis change. The
remaining generic comparison has the form
\[
U=1+5^{N-1}M,\qquad M\in M_2(K).
\]
The endpoint data agree modulo $5^{N-1}$. Divide the exact
$F,V$ and connection identities by $5^{N-1}$ and reduce modulo
five: they give (5), so the last digit is integral. Starting with
Section1 proves every level.

Crystalline full faithfulness for the two existing finite flat
groups is [de Jong, Remark2.4.10](https://www.numdam.org/item/PMIHES_1995__82__5_0.pdf),
with the module-with-connection description in Corollary2.2.3 and
Remark2.2.4. The formal-smoothness and finite-p-basis hypotheses
hold for $\operatorname{Spf}k[[t]]$. Integral matrices and their
inverses give actual group isomorphisms; the finite free Hopf
algebras algebraize their formal maps over $R$.

Uniqueness and preservation of generic markings and determinant
conditions follow from torsion-freeness of the Hopf coordinate
modules. Neither a new group nor a missing generic comparison is
constructed.

## 4. Global comparison and the ordinary invariant

Apply the local result at each completed stalk of the curve.
A rational map between finite locally free Hopf algebras, regular
at all these stalks, is regular globally. This proves the stated
global comparison.

For normalized marked BT2 groups, $\Delta_C=0$ supplies the actual
comparison on the ordinary open by the
[basic Kummer comparison](versal_bt_display_descent.md).
The comparison just proved extends it across the supersingular
points. Hence $\Delta_C$ is injective; this does not exclude poles
of a nonzero image.
