# Proof of the whole homogeneous half b-zero exclusion

ID: `admissible_degree_ten_m9_half_bzero_exclusion`.
Version1, 2 October2026. Fixed finite support and linear obstruction.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_half_bzero_exclusion.md).
The independent whole-boundary
[audit passed](../../Research/audits/M9_HALF_BZERO_EXCLUSION_AUDIT_2026_10_02.md),
using the corrected final certificates without numerical replay.

## Retain the actual source and all boundary strata

Assume an actual source in the stated half stratum has $b=0$.
The actual [nonzero quadratic trace theorem](admissible_degree_ten_m9_homogeneous_B0_nonzero_quadratic_trace.md)
gives $n_0=\lambda q_3$, $\lambda\ne0$.
The full-source scalar normalization and monic $t$ are justified in
[the pure selected-kernel proof](admissible_degree_ten_m9_pure_selected_kernel_exclusion.md):
one multiplies the defining polynomial by a constant, preserves its
original roots and source functions, and retains the actual scale
$d=pq_3+rq$, $p\ne0$.
No source coordinate or original map is rescaled here.

Divide the homogeneous trace rows by $\lambda$ for notation only.
The normalized regularizers have
$n=q_3$, $\eta_1=L$, $\eta_2=H+yV$, with $\deg H\le4$.
The source double jets give $c=bC_*=0$ and
$D=D_*+pD_3+rD_q$. Put $C=D[2]$, the nonzero pole-sixteen
coefficient of $\delta_1$. The infinity rows give
\[
L=aq-k(A)q_3/C,\qquad
k(A)=J_A[2],\quad
J_A=-P^{-1}\operatorname{rem}(Z^2A,P)\pmod t.
\]
Here $A$ ranges in the four-dimensional gap space
$\deg A\le4$, $[x^9]\operatorname{rem}(ZA,P)=0$.
The only five variables relevant below are its four coordinates
and $a$. Remaining source constant freedom is retained and never
enters the critical coefficient or trace rows used below.

By [the finite leading support theorem](admissible_degree_ten_m9_half_bzero_finite_leading_support.md),
EVERY possible actual tuple $(p,r,V)$ is one of two points in a
fixed squarefree quadratic algebra for its selected omission.
This support was derived without inverting $d$ or deleting its
boundary strata. The exact new certificate checks that all EIGHT
points over the four omissions have $C\ne0$ and that $d$ is
squarefree and coprime to $P t$. Thus the necessary
[finite leading-zero rows](admissible_degree_ten_m9_finite_leading_zero_trace_constraint.md)
and the two-divisor interpolation argument apply at every point.
No possible support point with repeated roots or endpoint intersection
is silently omitted; the exact support simply has none.

## Six homogeneous linear rows force A and the first-pair coordinate zero

Use $K_j(f)=\operatorname{quo}(Z^jf,P)$,
$R_j(f)=\operatorname{rem}(Z^jf,P)$, and abbreviate
$K_d=K_1(d)$, $K_n=K_1(n)$, $R_d=R_1(d)$.
The OLD selected quadratic-character rows are
\[
2dR_1(L)-3LR_d+AR_1(n)-2nR_1(A)=0\pmod t.
\]
These give three homogeneous linear rows in the five variables
$(A,a)$.

The affine finite-frame coefficients and moments are exactly
\[
e=A-3y^2K_d,\qquad
f=yF_1-2y^2K_1(A),\qquad
F_1=D+ZK_d-3K_2(d),
\]
\[
h=h_0+y\bigl(J_A+2ZK_1(A)-K_2(A)\bigr),
\]
\[
h_0=E_s-ZD-K_3(d)+3ZK_2(d)-3Z^2K_d,
\]
\[
n_1=L+y^2K_n,\qquad
n_2=H+y\bigl(V-K_2(n)+2ZK_n\bigr)+2y^2K_1(L).
\]
The scalar short part $E_s$ of $\delta_0$ is fixed by the SAME
original source double-jet reconstruction that fixes $D$;
it is not the free scalar constant of $S$. These formulas are
exact translations of the original source and moments, with all
proper remainders retained.

The NEW leading linear character of $en_2+fn_1+hn=0$ is
\[
A\bigl(V-K_2(n)+2ZK_n\bigr)-PK_dK_1(L)+F_1L
-2PK_1(A)K_n+\bigl(J_A+2ZK_1(A)-K_2(A)\bigr)n=0\pmod d.
\]
The term $-PK_dK_1(L)$ is essential: it is the characteristic-five
reduction of $-6PK_dK_1(L)$ coming from $y^2\cdot y^2$.
These give another three homogeneous linear rows in $(A,a)$.
The six-by-five map is fixed at each of the two candidate points;
it involves no variable source-parameter search.

For EACH of the eight support points the new certificate records
a nonzero five-by-five minor of this map. Hence $A=0$ and $a=0$,
and therefore $L=0$ and $J_A=0$.

## The second moment vanishes and the remaining scalar row contradicts it

With $A=L=0$, the old selected scalar row is $dH=0\pmod t$.
Since $d$ is a unit modulo $t$, $H=0\pmod t$.
The new leading quadratic character is $-3K_dH=0\pmod d$.
The exact constant Bézout identity in the leading-zero theorem
makes $K_d$ a unit modulo $d$, so $H=0\pmod d$.
The two coprime cubics divide $H$, whose degree is at most four;
hence $H=0$ identically. This argument retains the entire
two-dimensional selected kernel, rather than assigning its parameters.

Now the new leading scalar character is the fixed vector
\[
G_0=P\left[-3K_d\bigl(V-K_2(n)+2ZK_n\bigr)+F_1K_n\right]
+h_0n\pmod d.
\]
It must be zero. The certificate records all three coordinates
of $G_0$, and at every one of the eight support points at least
one coordinate is NONZERO. This is the contradiction.
The same original source and both original maps were retained
throughout; no auxiliary critical cover was substituted for them.

## Exact evidence and focused verification

The finite-support source and certificate are linked in its
[canonical proof](admissible_degree_ten_m9_half_bzero_finite_leading_support.md).
The NEW obstruction source is
[oct02_m9_half_bzero_two_divisor_linear.sage](../../scripts/oct02_m9_half_bzero_two_divisor_linear.sage),
and its external exact certificate is
[half_bzero_two_divisor_linear.json](../../../litt3-computation-data/oct02_m9_uniform/half_bzero_two_divisor_linear.json).
It records the four-dimensional gap basis, every quadratic candidate
factor and multiplicity, actual $p,r,C$, the three boundary gcds,
the full six-by-five matrix, rows and value of a nonzero minor,
$D,E_s$, and the nonzero vector $G_0$.

The input quadratics are proved squarefree, and both linear factors
are retained for every omission. Thus the recorded factors are the
ENTIRE reduced candidate schemes over algebraically closed $k$,
not merely sample points over a finite field. The program has explicit
rank-four/CRT and lower-rank branches, but all eight actual candidate
factors have rank five, so no such branch is assumed away.

To guard the character-expansion failure mode, the final program
directly multiplies the displayed finite polynomials in $y$ and
reduces modulo $y^3-P$. It checks the new linear and quadratic
characters and the scalar forcing against the formulas above.
It also directly multiplies the short selected expressions and
checks their quadratic character. Every such assertion passes.
The source scalar coefficient $E_s$ is recovered from the original
source double-jet equations with the recorded $D$, not guessed.

The final complete execution took 8.774 seconds of script time,
Sage10.9, one CPU, thread caps one and a thirty-second hard bound.
An initial focused expansion review found the omitted
$-PK_dK_1(L)$ term in the first implementation; it was corrected,
the new check rerun, and direct character assertions were added.
Only the corrected final certificate is mathematical evidence.
No settled source search or large elimination was replayed.

Verification consists of checking the recorded finite polynomial
identities and minors, or running these two new bounded sources.
The result excludes the entire stated $b=0$ source boundary;
the $b\ne0$ homogeneous half locus remains open.
