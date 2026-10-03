# Proof of the half b-zero finite leading support

ID: `admissible_degree_ten_m9_half_bzero_finite_leading_support`.
Version1, 2 October2026. New four-omission fixed calculation.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_half_bzero_finite_leading_support.md).
The independent [whole-boundary audit](../../Research/audits/M9_HALF_BZERO_EXCLUSION_AUDIT_2026_10_02.md)
passed this finite-support implication and its use in the exclusion.

## Actual source frame and the leading-only selected row

Keep the original actual source and both maps. The full-source affine
normalization, monic $t$, and fixed $\kappa_0=-1/[24]$ are derived
in [the pure selected-kernel proof](admissible_degree_ten_m9_pure_selected_kernel_exclusion.md).
No normalization of $d$ to a monic polynomial is made here.
The source double-jet reconstruction gives
$c=bC_*$ and $D=D_*+pD_3+rD_q$ in the short coefficient
$\delta_1=c+yD+2y^2R_A/P+3yS_d/P$.
The fixed maps defining these polynomials are invertible, as accepted
in that proof. Their right sides are linear in the actual $d$.

In this boundary $b=0$, hence $c=0$ and the infinity row gives
$M=[y]\eta_1=0$. Divide the homogeneous necessary trace equations
by the NONZERO scalar $\lambda$ only; this does not rescale the
actual source coordinate or either map. The selected linear character
then gives in $\mathcal E=k[x]/(t)$
\[
J_*+pJ_3+rJ_q=V(pq_3+rq),
\]
where
\[
J_*=-q_3D_*,\quad
J_3=-q_3D_3+(3R_3^2-4q_3S_3)/P,
\]
\[
J_q=-q_3D_q+(3R_qR_3-3q_3S_q-qS_3)/P.
\]
Here $R_f=\operatorname{rem}(Zf,P)$ and
$S_f=\operatorname{rem}(Z^2f,P)$. Only $P$, a unit on the selected
fibers, is inverted. This equation holds even if $d$ has selected
zeros, and is independent of the source polynomial $A$.

## Fixed quadratic support and absence of rank-drop families

Represent elements of $\mathcal E$ by their coefficient vectors in
$1,x,x^2$. Put
$a(V)=J_3-Vq_3$, $b(V)=J_q-Vq$, and $c=J_*$.
The preceding equation is $a(V)p+b(V)r+c=0$.
It forces the fixed polynomial
\[
\Delta(V)=\det[\,a(V),b(V),c\,]=0.
\]
This determinant has degree at most two. In all FOUR selected
omissions the new exact calculation proves degree EXACTLY two,
squarefreeness, and the following stronger uniform rank certificate.
Let $m_{ij}=a_i b_j-a_j b_i$ for $0\le i<j\le2$.
The certificate contains polynomial coefficients $u_{ij}(V)$ with
\[
\sum_{i<j}u_{ij}m_{ij}=1.
\]
Thus the two-column matrix has rank two at EVERY geometric value
of $V$, including the roots of $\Delta$, with no removed endpoint
or rank-drop stratum.

In the quadratic algebra $\mathcal B=k[V]/(\Delta)$ define
\[
p=-\sum_{i<j}u_{ij}(c_i b_j-c_j b_i),\qquad
r=-\sum_{i<j}u_{ij}(a_i c_j-a_j c_i).
\]
The certificate checks $a_ip+b_ir+c_i=0$ for all three coordinates
modulo $\Delta$. Conversely the Bézout identity makes this solution
unique. The calculated $p$ is coprime to $\Delta$, hence is a unit
and retains actual degree-three leading coefficients at both points.
The squarefree quadratic has exactly two points over algebraically
closed $k$; these are necessary selected-row candidates only.

## Exact input, certificate and execution

The new source is
[oct02_m9_half_bzero_leading_pencil.sage](../../scripts/oct02_m9_half_bzero_leading_pencil.sage).
The external exact certificate is
[half_bzero_leading_pencil.json](../../../litt3-computation-data/oct02_m9_uniform/half_bzero_leading_pencil.json).
It records the fixed field $\mathbf F_{5^8}$, its embedded
$\mathbf F_{25}$, every omitted endpoint, the fixed jet determinant,
$D_*,D_3,D_q$, $J_*,J_3,J_q$, the quadratic $\Delta$, its three
two-column minors and Bézout coefficients, and the actual residue
polynomials $p(V),r(V)$. Every source linear solution, Bézout identity,
three-coordinate solution identity and unit-$p$ assertion is checked
before the record is written.

The fixed nine-by-nine jet map is reconstructed directly from the
accepted primary source character equations, once for each omission.
No earlier source-parameter search or settled program is replayed.
The new complete execution took 0.307 seconds of script time with
Sage10.9, one CPU, OMP/BLAS/MKL/VECLIB thread caps one and a
thirty-second hard bound. An initial execution completed its algebraic
checks but failed to serialize static Sage integer data; the serializer
was corrected and this NEW check was rerun successfully.

Verification can reconstruct the displayed fixed jet map and check
the recorded polynomial identities, or execute the new source.
The calculation decides only the necessary leading-row support.
No remaining source coefficient or actual source realization is
claimed excluded by this theorem.
