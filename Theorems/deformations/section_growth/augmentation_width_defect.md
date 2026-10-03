# Augmentation order bounds actual indigenous defect

Version2,3 October2026. The original geometric presentation retains
its independent audit. The general radical formula is Jennings's
theorem; the higher-order and Frattini consequences have focused
author review.

## A filtered-algebra bound

For a finite $p$-group $P$ over a field $k$ of characteristic $p$,
put $R=k[P]$, $J=\operatorname{rad}R$ and
$h_i=\dim_k J^i/J^{i+1}$, with $h_i=0$ outside the radical range.
For integers $\nu,s\ge1$, define
\[
w_\nu(P)=\max_{i\ge0}\sum_{j=0}^{\nu-1}h_{i+j}.
\]
If a square $s$-by-$s$ matrix over $R$ has all entries in $J^\nu$,
its cokernel has $k$-dimension at least $s\,w_\nu(P)$.
In particular $\dim_k R/(Rf)\ge w_\nu(P)$ for $f\in J^\nu$.
No commutativity or associated-graded rank equality is assumed.

These bounds use the radical Hilbert polynomial
\[
\sum_i h_it^i=\prod_{n\ge1}
(1+t^n+\cdots+t^{(p-1)n})^{d_n},
\qquad
d_n=\dim_{\mathbf F_p}D_n(P)/D_{n+1}(P),
\]
where $D_n(P)=\{g:g-1\in J^n\}$. Thus all group-specific radical
calculations can be replaced by the dimension-subgroup data.

## The actual geometric input

Let $(C,r)$ be an active admissible pair over $\overline{\mathbf F}_5$,
of genus at least two and indigenous defect one. For an actual
connected finite etale Galois $P$-cover $T\to C$, with $P$ a
five-group, the Frobenius-linearized Hodge cokernel has a presentation
\[
\operatorname{coker}\Psi_T=R/(Rf),\qquad f\in J^2.
\]
Consequently $\operatorname{defect}(T)\ge w_2(P)$. Every further
actual finite etale pullback retains the lower bound. A higher
augmentation-order bound requires that higher order to be established
for the ACTUAL operator.

For $q=5^a>1$:

| Actual Galois group | Defect lower bound |
| --- | --- |
| $C_q$ | $2$ |
| $(C_q)^2$ | $2q-1$ |
| $(C_q)^3$ | $(3q^2-1)/2$ |
| Exponent-five Heisenberg group of order125 | $25$ |

Every noncyclic $P$ therefore gives defect at least nine. If
$P\ne C_5^2$, the bound improves to at least ten; if its Frattini
rank is at least three, it is at least37. In particular the
nonabelian lower bound ten holds for EVERY defect-one active pair,
not only the selected bad doubles.

A Heisenberg quotient gives25 through its actual intermediate.
A quotient of the closure group of a non-Galois source does not
supply such an intermediate dominated by that source. The theorem
neither realizes arbitrary matrices as Hodge operators nor excludes
an arbitrary common cover.

[Proof](../../../Proofs/deformations/section_growth/augmentation_width_defect.md).
