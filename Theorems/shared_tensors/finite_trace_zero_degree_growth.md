# Zero-degree strongly semistable trace images must grow in rank

Version3,1 October2026. Let $k=\overline{\mathbf F}_p$ and let
$X\xleftarrow f Z\xrightarrow gY$ be an ACTUAL finite étale span of
smooth projective connected curves. Let $V_X,V_Y$ be rank-$N$ vector
bundles with a specified identification $f^*V_X\simeq g^*V_Y$.
Assume that no nonzero strongly semistable degree-zero COMMON coefficient has
compatible nonzero maps into $V$ on these original endpoints.

Start with a nonzero map $R_X\to V_X$, where $R_X$ is strongly
semistable of degree zero, and write $I_X$ for its actual image, of rank $r$.
Transport the map by the actual finite étale adjunction to
\[
g_*f^*R_X\longrightarrow V_Y,
\]
and take its actual image $J_Y$. Each later transport uses the current
actual image and its inclusion into $V$, alternating the two legs.
Images are taken before saturation. No trace averaging is used.

Every transported image is nonzero. If $\deg J_Y=0$, then both
$I_X$ and $J_Y$ are strongly semistable degree-zero bundles. The
adjunction gives a compatible injection
\[
f^*I_X\hookrightarrow g^*J_Y.
\]
Consequently $\operatorname{rk}J_Y\ge r$. Equality makes this an
isomorphism and produces a nonzero common strongly semistable degree-zero coefficient mapping
to $V$, contrary to the hypothesis. Thus EVERY degree-zero passage
increases the actual generic rank strictly.

Starting with rank $r$, at most $N-r$ successive transported images
can have degree zero. A positive-degree image occurs by passage
$N-r+1$. Until that first positive-degree passage, each generator and
each image is strongly semistable of degree zero; the next image has
degree at least zero. This includes finite local and height-one
coefficients. If the original seed is finite-étale-trivial, every
zero-degree image and generator is finite-étale-trivial as well.
No assertion of strong semistability or finite monodromy is made
after the first positive-degree passage.

For either selected characteristic-five candidate, take $V=B$, the
rank-four Cartier bundle, and assume the original span is coreless.
The degree-zero common-coefficient vanishing theorem supplies the hypothesis, so
there are at most $4-r$ successive degree-zero passages. More generally
this specialization holds on a coreless no-clump span in odd
characteristic when $p\nmid g(C)-1$ at one endpoint.

In the finite-étale seed case there is a stronger FIRST-passage
criterion with an extra hypothesis.
If $\deg J_Y=0$ and $\pi_1(Z)$ surjects onto the FULL finite monodromy
image of $J_Y$ on $Y$, then their ranks are equal, hence a common
finite coefficient is already obtained at that passage. Equivalently,
the connected monodromy torsor of $J_Y$ has connected pullback
to $Z$. This connectedness is not automatic. Restricting the endpoints
to the images of $\pi_1(Z)$ is not a substitute: arbitrary components
of such endpoint refinements need not preserve corelessness or clumps.

This is a two-map compatibility criterion and bounded growth statement.
It constructs no common coefficient in the strict-rank-growth cases,
does not bound all induction-path ranks, and does not decide the
unmarked common-cover problem.

Over $\overline{\mathbf F}_p$, strong semistability of degree zero
also implies essential finiteness by the usual eventual Frobenius
periodicity theorem. That fact is not needed in the proof here; no
Nori-monodromy surjectivity or local torsor connectedness is asserted.

## A rank-three hyperplane fills the opposite generic Cartier bundle

For either selected coreless span, let $R_Y\subset B_Y$ be ANY
rank-three actual subsheaf with saturation
\[
E_Y=A_Y^\perp,\qquad A_Y\subset B_Y\text{ a saturated line},
\qquad \deg A_Y=0.
\]
The orthogonal is for the canonical symplectic Cartier pairing.
Then the first opposite trace map $f_*g^*R_Y\to B_X$ has generic
rank FOUR. This does not require strong semistability or degree zero
of $R_Y$. In particular it applies to a rank-three height-one
coefficient image with this saturation. It gives generic filling,
not equality of the unsaturated integral image with $B_X$.

## The double-zero contact case has opposite trace degree at least two

Retain an actual selected span $X\xleftarrow hT\xrightarrow qY$.
On $X$ take its canonical degree-seven Lagrangian $P_X\subset B_X$,
canonical line $\lambda_X\subset P_X$, and reduced degree-thirteen
divisor $R_X$. Let $A_Y\subset B_Y$ be a saturated degree-zero line,
let $W_1$ be one reduced point of $Y$, and put
\[
J_Y=A_Y+A_Y^\perp(-W_1)\subset B_Y.
\]
Assume the actual source inclusions and fiber contacts
\[
q^*A_Y\subset h^*P_X,\qquad q^*W_1\subset h^*R_X,
\qquad (q^*A_Y)_t=(h^*\lambda_X)_t\quad(t\in q^*W_1).
\]
The fiber contact is automatic in the double-zero adjunction case:
evaluation of $F^*P_X$ is surjective, the evaluated $\lambda_X$
vanishes on $R_X$, and the evaluated $A_Y$ vanishes at $W_1$.

Then the actual opposite trace image
\[
I_X=\operatorname{image}(h_*q^*J_Y\longrightarrow B_X)
\]
has generic rank four and $\deg I_X\ge2$.

More precisely, some connected component $S$ of $T\times_XT$ has
distinct pulled-back embedded lines $A_1,A_2$. Write $f:S\to X$,
$g_i:S\to Y$, $n=\deg f$, $D_i=g_i^*W_1$, and
$m=\deg\min(D_1,D_2)$. Then $\deg g_i=8n$ and
\[
3n\le m\le7n,\qquad
\deg(J_1\cap J_2)=m-9n,\qquad
\deg(J_1+J_2)=9n-m\ge2n,
\]
where $J_i=g_i^*J_Y$. Their sum lies in $f^*I_X$.
All intersections and sums here are actual integral lattices, before
saturation. No component is substituted for the original two-map
problem, and no simultaneous Galois closure is assumed. This degree
bound does not construct an admissible line or exclude the remaining
full-rank trace case.

[Proof](../../Proofs/shared_tensors/finite_trace_zero_degree_growth.md).
