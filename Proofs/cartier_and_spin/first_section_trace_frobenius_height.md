# Proof: source hyperplanes control the first Frobenius-instability height

ID: `first_section_trace_frobenius_height`. Version1,2 October2026.
[Statement](../../Theorems/cartier_and_spin/first_section_trace_frobenius_height.md).
[Focused independent proof review](../../Research/audits/CONTACT_FIRST_FROBENIUS_INSTABILITY_HEIGHT_AUDIT_2026_10_02.md) PASS.
This is a
quantitative restriction on the degree-one first trace, not a shared
coefficient or a common-cover exclusion. No computation is used.

Retain the fixed genus-nine X, any actual genus-two etale partner Y,
and the SAME-source maps of degrees n and 8n. Let J be the complete
original three-section trace of degree one, and put $r=t/n<9$.
The accepted [contact theorem](../../Theorems/cartier_and_spin/first_section_contact_strictness.md)
makes J stable and gives $r\ge7$.
Suppose a is the FIRST positive integer for which $F_Y^{a*}J$ is
unstable. Then
\[
\boxed{r\ge7+\frac{2}{3\cdot5^a}.}
\]
More precisely, if its top HN term has rank k and degree A,
\[
r\ge5+\frac{8A}{k5^a}.
\]
For a=1, rank-one/two/three top terms respectively force
$r\ge41/5,37/5,107/15$. Hence $r<107/15$ makes the FIRST
Frobenius pullback semistable. The threshold tends to seven with
height; no uniform bound on a or strong semistability is asserted.

## Actual hyperplanes and their line quotients

Use the actual one-leg Y-Galois closure $q:T\to Y$, of degree 8d,
with conjugate maps $h_i:T\to X$ of degree d. Let
$L_i=h_i^*U\cap q^*J$, a saturated rank-three hyperplane of degree
$(13-r)d$, and write $N_i=q^*J/L_i$. Then
$\deg N_i=(r-5)d$.
The saturated U trace has generic rank four by the accepted
[first-saturated-trace theorem](../../Theorems/cartier_and_spin/first_saturated_cartier_trace.md).
Therefore not all actual $h_i^*U$
are the same generic hyperplane. No simultaneous closure is used.

Let G be the top HN term of $F_Y^{a*}J$, of rank k and degree A.
It is semistable, $k\le3$, and $A/k>5^a/4$. Its pullback to T is
still semistable. If it is NOT contained in some $F_T^{a*}L_i$, its
nonzero map to the line $F_T^{a*}N_i$ has an image quotient of
slope at least $8dA/k$. Thus
\[
5^a(r-5)d\ge8dA/k,
\]
which is the claimed inequality. It remains to prove that containment
in every hyperplane is impossible at the first unstable height.

## Canonical horizontal closure cannot lie in all source hyperplanes

Assume $q^*G\subset F_T^{a*}L_i$ for every i. Each larger
$F_T^{a*}h_i^*U$ is horizontal for the canonical connection of the
last relative Frobenius pullback. The saturated horizontal closure of
G consequently lies in every one of these rank-three hyperplanes.
It has rank at most three and is deck invariant, so Cartier descent
gives a subbundle W of $F_Y^{(a-1)*}J$ whose Frobenius pullback is
this closure. Rank three would make all $h_i^*U$ the same generic
hyperplane, contrary to the generic rank-four trace. Thus the closure
has rank one or two.

If k=2, rank two is the only possible closure rank, so G itself is
horizontal. Semistability of $F_Y^{(a-1)*}J$ gives
$\deg G=5\deg W\le5^a/2$, contradicting its destabilizing slope.
If k=3 the closure would have rank at least three and is already
excluded.

For k=1, rank-one closure would similarly imply
$A\le5^a/4$, a contradiction. Suppose the closure has rank two.
Put $D=\deg W$. Since the preceding pullback is semistable,
\[
D\le\left\lfloor\frac{5^{a-1}}2\right\rfloor
=\frac{5^{a-1}-1}2.
\]
The saturated line G has degree A in $F^*W$. A nonzero second
fundamental map is necessary for rank-two horizontal closure, hence
\[
G\longrightarrow(F^*W/G)\otimes\omega_Y\ne0,
\qquad 2A\le5D+2.
\]
But $5^a\equiv1\pmod4$ and destabilization give
$A\ge(5^a+3)/4$. Therefore
\[
2A\ge(5^a+3)/2>(5^a-5)/2+2\ge5D+2,
\]
a contradiction. The integrality is on Y, not merely on its high-degree
etale pullback; deck invariance of the canonical HN term and its
horizontal closure is essential here.

## The smallest possible instability gives the uniform height bound

The possible ranks k are one, two and three. Their smallest
destabilizing degrees are respectively
$(5^a+3)/4,(5^a+1)/2,(3\cdot5^a+1)/4$.
The smallest normalized excess over slope $5^a/4$ occurs for k=3
and is $1/12$. Substitution gives
$r\ge7+2/(3\cdot5^a)$.
For a=1 the three ranks give the stated thresholds.

This explains quantitatively why the contact-seven equality is
strongly semistable, while small positive contact excess can hide
instability at increasing heights. It does not bound that height on
an arbitrary actual source, and the unmarked problem remains open.
