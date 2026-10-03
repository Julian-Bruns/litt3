# Proof: étale stability of the original hyperplane

Version1,2 October2026. [Statement](../../Theorems/cartier_and_spin/actual_generated_hyperplane_etale_stability.md). This is a short consequence of source bounds already reviewed in the [contact-seven audit](../../Research/audits/CONTACT_SEVEN_EQUALITY_AUDIT_2026_10_02.md), rather than a new branch audit.

The canonical evaluation of $F_T^*h^{(1)*}U$ into $\omega_T$ is surjective and has semistable rank-two kernel of degree $49d$, by the accepted stable source-kernel theorem and étale pullback. Here $\deg\omega_T=16d$.

Every nonzero line in $B_{T^{(1)}}\subset F_{T*}\omega_T$ has nonzero Frobenius adjoint into $\omega_T$. Thus a line $L\subset h^{(1)*}U$ satisfies $5\deg L\le16d$. If $V$ has rank two, its evaluated Frobenius image is nonzero, because evaluation is nonzero on a nonzero line in $V$. Its rank-one kernel has degree at most $49d/2$ after saturation in the semistable source kernel, and its image has degree at most $16d$. Hence
\[
5\deg V\le49d/2+16d=81d/2.
\]
Since $16/5<13/3$ and $81/10<26/3$, every proper subbundle lies strictly below the slope of $h^{(1)*}U$. This proves stability on every actual connected étale cover.

For the trace assertion, split the actual finite étale $Y$ leg by its one-leg Galois closure. The pullback of $g_*h^*U$ is a direct sum of the stable sheet bundles, all of the same slope. Therefore $g_*h^*U$ is semistable of slope $13/24$ and its actual quotient $H$ has minimum HN slope at least $13/24$.

If $\deg H=4$, then $H=B_Y$, which is stable. If $\deg H=3$, a rank-one quotient of $H$ has integer degree at least one and a rank-two quotient has integer degree at least two. Therefore every rank-three subbundle has degree at most two and every rank-two subbundle at most one. A line subbundle of $H\subset B_Y$ has degree at most zero by the genus-two adjunction bound $5\deg L\le2$. These three inequalities are strict below the rank-three bundle's relevant comparison degrees $9/4$, $3/2$, and $3/4$ for stability of rank-four $H$ of degree three. Thus $H$ is stable on $Y$.

No strong semistability assertion for $H$ follows from the integer argument, because its discrete quotient bounds change after Frobenius or arbitrary endpoint refinement.
