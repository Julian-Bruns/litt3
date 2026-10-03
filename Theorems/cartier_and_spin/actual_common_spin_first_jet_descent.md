# The actual spin-series first jets descend to a genus-two Atiyah lattice

Version1,2 October2026. Computation-free reusable implication; focused whole-argument review PASS. No finite common coefficient or common-cover exclusion is claimed.

Use the actual same-source sixteen-spin refinement and basepoint-free orbit series $(T,q,L,W)$ of [the spin-series theorem](actual_common_sixteen_spin_series.md), with $\deg q=8d$, $\deg L=d$, $L^{16}\simeq\omega_T$, and BOTH actual finite étale endpoint maps retained. Let $P$ be the RAW integral image bundle of
\[
W\otimes O_T\longrightarrow J^1L.
\]
It has rank two. Its common ramification divisor is $R_W$, defined by the common divisor of its first-jet determinants. There is an effective divisor $D$ on $Y$, of degree at most two, such that
\[
R_W=q^*D,\qquad P\otimes L^{-1}=q^*Q_Y,
\]
where $Q_Y$ is an actual rank-two integral lattice in the Atiyah extension of $\omega_Y$. It fits
\[
\boxed{0\longrightarrow\omega_Y(-D)\longrightarrow Q_Y\longrightarrow O_Y\longrightarrow0,\qquad\deg Q_Y=2-\deg D.}
\]
Its extension class maps to $c_1(\omega_Y)/16=c_1(\omega_Y)\ne0$ in $H^1(Y,\omega_Y)$, since characteristic five makes sixteen equal to one and $\deg\omega_Y=2$.

Under the exact noncyclic contact-eight hypotheses, $D=2Q$ at the distinguished target point of the [branch-fiber theorem](contact_eight_noncyclic_branch_fiber.md). Thus all common first-jet ramification is EXACTLY $2q^*Q$, and the descended bundle has degree zero:
\[
0\to\omega_Y(-2Q)\to Q_Y\to O_Y\to0.
\]
If this degree-zero bundle has an actual finite étale trivialization, every such trivializing cover has degree divisible by five. Its finiteness and existence of such a trivialization are NOT asserted.

[Proof](../../Proofs/cartier_and_spin/actual_common_spin_first_jet_descent.md).
