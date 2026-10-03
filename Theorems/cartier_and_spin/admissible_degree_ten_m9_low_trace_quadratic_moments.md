# Actual m9 low-trace quadratic moments

ID: `admissible_degree_ten_m9_low_trace_quadratic_moments`.
Version1, 2 October2026. Computation-free necessary actual-source theorem.
Root focused whole-implication review
[PASS](../../Research/audits/M9_LOW_TRACE_QUADRATIC_MOMENTS_AUDIT_2026_10_02.md).
The unrestricted common-cover problem remains open.

Retain an ACTUAL primitive degree-ten m9 admissible source $h:S\to X$,
its original annihilator, and the short polynomial
$F=v(T^5+q_s)^2+(T^5+q_s)S_s+t^3$, with $D=S_s'$ and $U(W)=uD(W)$.
Both original finite étale maps remain on that SAME source. The auxiliary
critical normalization may ramify and does not replace that source.
Assume $m_5=\operatorname{Tr}(u)\in L_9$, with arbitrary
$\rho=\operatorname{Tr}((u/\phi)W^4)\in\langle1,x,x^2\rangle$.

At infinity put $B=(\delta_2)_{14}$, $C=(\delta_1)_{16}$,
$E=(\delta_0)_{17}$, $v_0=v_{10}$ and $A=(U_3)_{22}$.
The actual five-big-sheet leading quintic
$H(z)=v_0z^5+(B/3)z^3+(C/2)z^2+e$ is SQUAREFREE,
$e\ne0$, $(B,C)\ne(0,0)$, and $A\ne0$.

For $B\ne0$, with $\beta_0=-C/B$, the affine zeroth quadratic
moment $n_0=\operatorname{Tr}(u^2/\phi)$ has EXACT pole ten, with
\[
(n_0)_{10}=-A^2/(B H(\beta_0))\ne0.
\]
This includes $C=0$ and needs no critical rank or numerator-cancellation
hypothesis.

For $B=0$, necessarily $C\ne0$, and the short quadratic moments satisfy
\[
\operatorname{pole}n_0\le9,\qquad
\operatorname{pole}\mu_1\le10,\qquad
\operatorname{pole}\mu_2\le12,
\quad\mu_j=\operatorname{Tr}((u^2/\phi)W^j).
\]
Write $R=\delta_1\mu_1+\delta_0n_0$. Then $R_{26}=0$.
If $\delta_2$ has exact pole thirteen and $c_4$ is the actual formal
pole-four critical root, the further affine row is
$[-\delta_3\mu_2+R/c_4]_{21}=[2v\rho m_5/c_4]_{21}$.
If $\delta_2$ has pole at most twelve, the large critical point is
tame of index two and the further row is $R_{25}=2(v\rho m_5)_{25}$.
No split base Laurent critical root is presumed in that stratum.

For fixed source coefficients, $\rho$ and $m_5$, these necessary bounds,
the original moment-gap constraints and the two additional rows leave
EXACTLY EIGHT affine moment coordinates before the nine selected SHORT
contact equations. Setting $\rho=0$ recovers the homogeneous eight-coordinate
model. Uniform compatibility with the nine selected equations, the
critical square class and the full source identity remain unresolved.

[Proof](../../Proofs/cartier_and_spin/admissible_degree_ten_m9_low_trace_quadratic_moments.md).
