# The first trace of the saturated exact hyperplane has degree at least three

Version1,2 October2026.
[Focused root review](../../Research/audits/FIRST_SATURATED_CARTIER_TRACE_AUDIT_2026_10_02.md) PASS.
Let $X/\overline{\mathbf F}_5$ be the fixed
genus-nine curve, and let $U\subset B_X$ be the rank-three saturation
of its three global locally exact differentials. Retain two ACTUAL
finite etale maps from the SAME smooth projective connected source,
\[
X\xleftarrow h S\xrightarrow gY,\qquad g(Y)=2.
\]
Write $\deg h=n$, so $\deg g=8n$, and use the actual Cartier
identification $B_S=h^{(1)*}B_X=g^{(1)*}B_Y$. Define the first
unsaturated trace of the SATURATED hyperplane by
\[
H_Y=\operatorname{im}\bigl(g^{(1)}_*h^{(1)*}U\longrightarrow B_Y\bigr).
\]
Then $H_Y$ has rank four and
\[
\deg H_Y\ge3,\qquad
\operatorname{length}(B_Y/H_Y)\le1.
\]
Its first Frobenius adjunction evaluates onto all of $\omega_Y$.
At every Frobenius height $a\ge1$ one also has
\[
\mu_{\min}(F_Y^{a*}H_Y)\ge2\cdot5^{a-1}.
\]
Here the iterations retain the appropriate relative Frobenius twists;
the assertion concerns degrees and minimum HN slopes. The actual
canonical line filtration used in the proof is not asserted to be
the HN filtration.

No corelessness, clump exclusion, full radical orbit, prime-to-five
degree, or simultaneous finite Galois closure is assumed. The original
evaluation image $\mathcal O_X^3\to B_X$ is smaller than $U$ at its
thirteen-unit determinant defect. Its first trace can still have degree
one or two; this theorem does not replace that image by its saturation
and does not decide the common-cover problem.

Inputs: [the generated hyperplane](cartier_kernel_generated_subbundle.md)
and [its stable Frobenius kernel](cartier_generated_frobenius_hn.md).
[Proof](../../Proofs/cartier_and_spin/first_saturated_cartier_trace.md).
