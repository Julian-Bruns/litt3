# Proof: stable Frobenius kernels force the first saturated trace degree

Version1,2 October2026.
[Statement](../../Theorems/cartier_and_spin/first_saturated_cartier_trace.md).
This proof uses the two original finite etale maps. A Galois closure
is taken over the genus-two leg alone; no simultaneous closure is used.

The [generated-hyperplane theorem](cartier_kernel_generated_subbundle.md)
gives rank four for the first trace: rank three would descend $U$
through $g$, forcing degree $13/8$ on $Y$. Splitting the finite
etale algebra identifies the trace image with the sum of the actual
sheet subbundles; this remains valid when five divides a degree.
Since $F_X^*U\to\omega_X$ is surjective, that sheet inclusion also
forces $F_Y^*H_Y\to\omega_Y$ to be surjective.

Put
\[
\mathcal H_X=\ker(F_X^*U\to\omega_X),\qquad
\mathcal K_Y=\ker(F_Y^*H_Y\to\omega_Y).
\]
The [stable-kernel input](cartier_generated_frobenius_hn.md) proves
that $\mathcal H_X$ has rank two and degree $49$ and is geometrically
stable. The bundle $\mathcal K_Y$ has rank three and degree
$5\deg H_Y-2$.

Take a connected one-leg Galois closure $q:T\to Y$ dominating
$S\to Y$. If $\deg q=8d$, each conjugate map $h_i:T\to X$ has
degree $d$. Every $h_i^*\mathcal H_X$ is a rank-two semistable
bundle of degree $49d$, contained in $q^*\mathcal K_Y$. Only
semistability after finite etale pullback is needed; preservation
of stability is not assumed.

Suppose $\deg H_Y\le2$. Then
$\deg(q^*\mathcal K_Y)\le64d$. If two conjugate rank-two bundles
have distinct generic subspaces, their intersection has rank one,
and their rank-three sum is a subsheaf of $q^*\mathcal K_Y$. Thus
\[
\deg(h_i^*\mathcal H_X\cap h_j^*\mathcal H_X)
\ge98d-64d=34d.
\]
Its saturation in either rank-two bundle has at least this degree,
contradicting the semistable line bound $49d/2$. All conjugate
generic subspaces therefore coincide.

Each such kernel is saturated in
$\mathcal A_T=\ker(F_T^*B_T\to\omega_T)$: surjectivity of
$F_T^*h_i^{(1)*}U\to\omega_T$ identifies its quotient in
$\mathcal A_T$ with $F_T^*B_T/F_T^*h_i^{(1)*}U$, a vector bundle.
Consequently equal generic subspaces give equal embedded bundles.
The deck group preserves this common bundle, which descends to a
bundle on $Y$. Its degree would be $49/8$, an impossibility. Hence
$\deg H_Y\ge3$. Since $\deg B_Y=4$, its defect has length at most one.

For the minimum-slope assertion, the canonical filtration of $F_X^*U$
has line grades
\[
\omega_X,\quad\omega_X^2,\quad\omega_X^3(-D),
\qquad \deg D=31,
\]
of degrees $16,32,17$. Further Frobenius pullbacks preserve this
filtration and multiply its line degrees. An extension of bundles
with minimum slopes at least $m$ has minimum slope at least $m$;
therefore
$\mu_{\min}(F_X^{a*}U)\ge16\cdot5^{a-1}$ for every $a\ge1$.
Finite etale pullback multiplies minimum HN slopes by its degree.
After a Galois base change splitting the etale pushforward, the
pullback of $g_*h^*F_X^{a*}U$ is a direct sum of the sheet bundles.
It follows that its minimum slope is at least
$16n\cdot5^{a-1}/(8n)=2\cdot5^{a-1}$.
Frobenius commutes with finite etale pushforward, and
$F_Y^{a*}H_Y$ is an actual quotient of this bundle. The asserted
minimum-slope bound follows.

The statement retains the unsaturated trace of $U$. It does not
identify it with the first trace of the original three-section
evaluation lattice, and neither trace constructs a compatible
finite common coefficient or an admissible line.
