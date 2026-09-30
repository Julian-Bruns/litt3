# The unique Frobenius-killed joint obstruction line

Version1,22September2026. Let $k=\overline{\mathbf F}_5$ and let
$X\xleftarrow f Z\xrightarrow gY$ be an ACTUAL coreless finite
etale span of smooth proper connected curves, with $g(Y)=2$ and
no clump. Both maps and all their relative Frobenius twists are
retained. Put $C_i=C^{(i)}$ and, for $m\ge1$, define
\[
Q_m(i)=\frac{H^1(Z_i,\omega_{Z_i}^{-m})}
{f_i^*H^1(X_i,\omega_{X_i}^{-m})+
g_i^*H^1(Y_i,\omega_{Y_i}^{-m})}.
\]
The two endpoint maps are injective with disjoint images. Relative
Frobenius induces $k$-linear maps between the indicated twists
\[
\mathfrak F_{m,i}:Q_m(i+1)\longrightarrow Q_{5m}(i).
\]
After the usual absolute-Frobenius identification of twists these
maps are semilinear, not $k$-linear endomorphisms of a fixed space.

For every $m\ge2$, $\mathfrak F_{m,i}$ is injective. For $m=1$
its kernel is a canonical NONZERO line, denoted $L(i+1)$. Moreover,
for every $r\ge1$,
\[
\ker\bigl(F^{[r]*}:Q_1(i+r)\longrightarrow Q_{5^r}(i)\bigr)
=L(i+r).
\]
Thus additional Frobenius pullbacks introduce no new killed
directions after the first one.

The line has an actual obstruction interpretation. Let
$B=F_*\mathcal O/\mathcal O$ on the target twist. The dual
Cartier extension
\[
0\longrightarrow B\omega^{-1}
\longrightarrow (F_*\omega)\otimes\omega^{-1}
\longrightarrow\mathcal O\longrightarrow0
\]
defines compatible nonzero classes $\gamma_X,\gamma_Y,\gamma_Z$.
The snake boundary for the original endpoint-to-source diagram
identifies their common line with $L(i+1)$.

In particular the first simultaneous Witt-lifting obstruction of
the ACTUAL span on twist $i+1$, in $Q_1(i+1)$, spans $L(i+1)$.
Changing the two endpoint lifts changes its representative only
by the endpoint subspace already quotiented out. This statement
retains the Witt-Frobenius coefficient convention; a simultaneous
change of Cech sign changes the generator, not the line.

For the fixed genus-nine $X$, writing $n=\deg f$, one has
\[
\dim Q_m(i)=(2m+1)(8n-9).
\]
The canonical line is consequently an explicitly located
nonvanishing obstruction inside the full joint quotient. It
recovers the established absence of a simultaneous $W_2$ lift
under no clump. It does NOT rule out spans existing only in
characteristic five or settle either common-cover candidate.

[Proof](../../Proofs/deformations/joint_frobenius_obstruction_line.md).
