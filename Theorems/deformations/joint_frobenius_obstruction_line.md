# The canonical Frobenius-killed joint obstruction line

Version2,3 October2026. Let $k=\overline{\mathbf F}_p$, $p$ odd.
Let $X\xleftarrow fZ\xrightarrow gY$ be an ACTUAL coreless finite
etale span of smooth proper connected hyperbolic curves, with no
clump and $p\nmid g(Y)-1$. Retain both maps on every relative twist
$C_i=C^{(i)}$. For $m\ge1$, put
\[
Q_m(i)=
\frac{H^1(Z_i,\omega_{Z_i}^{-m})}
{f_i^*H^1(X_i,\omega_{X_i}^{-m})+
g_i^*H^1(Y_i,\omega_{Y_i}^{-m})}.
\]
The endpoint images are injective and disjoint. Relative Frobenius
gives $k$-linear maps between the specified twists
\[
\mathfrak F_{m,i}:Q_m(i+1)\longrightarrow Q_{pm}(i).
\]
Absolute identification makes them semilinear; it does not identify
two curve models.

For $m\ge2$, $\mathfrak F_{m,i}$ is injective. For $m=1$ its
kernel is a canonical NONZERO line $L(i+1)$. For every $r\ge1$,
\[
\ker\bigl(F^{[r]*}:Q_m(i+r)\longrightarrow Q_{p^rm}(i)\bigr)
=
\begin{cases}
L(i+r),&m=1,\\
0,&m\ge2.
\end{cases}
\]
Further Frobenius pullbacks introduce no new killed directions.

The compatible nonzero classes of the dual Cartier sequence
\[
0\longrightarrow B\omega^{-1}
\longrightarrow (F_*\omega)\otimes\omega^{-1}
\longrightarrow\mathcal O\longrightarrow0,\qquad
B=F_*\mathcal O/\mathcal O,
\]
map to $L(i+1)$ by the endpoint-to-source snake boundary. The
ACTUAL first simultaneous Witt-lifting obstruction on twist $i+1$
spans this line. Changing endpoint lifts changes its representative
only by the endpoint subspace. The Witt-Frobenius coefficient
convention is retained; a common Cech sign change changes its
generator, not the line.

Write $\beta=g(Z)-g(X)-g(Y)+1$. Then
\[
\dim Q_m=(2m+1)\beta,\qquad
\dim\operatorname{coker}F^{[r]*}
=2m(p^r-1)\beta+\mathbf1_{\{m=1\}}.
\]
In particular $\beta\ge1$. For the selected genera nine and two,
$\beta=8\deg f-9$.

This identifies the entire killed quotient direction and recovers
absence of a simultaneous $W_2$ lift. It does not exclude a span
existing only in characteristic $p$ or solve the unmarked problem.

[Proof](../../Proofs/deformations/joint_frobenius_obstruction_line.md).
