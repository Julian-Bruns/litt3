# Proof: actual logarithmic different and a squarefree degree-twelve numerator

Version1, 3 October2026. [Fresh complete static differential/certificate audit PASS](../../Research/audits/OCT03_FINITE_WILD_ORDINARY_DIAGONAL_LOGARITHMIC_WHOLE_AUDIT_2026_10_03.md), with its one provenance correction applied and no outstanding corrections. See the [statement](../../Theorems/cartier_and_spin/finite_uniform_wild_ordinary_diagonal_exclusion.md).

## Actual source parameter and the different tower

Write u=A−a. Since p(a)≠0, the affine x-coordinate is unramified on X at either actual endpoint. Étaleness of h1 makes u an ACTUAL source parameter and dA=du a differential frame. Let ε=z³−1. Since z(P)³=1, characteristic five does not divide three, and the actual finite local Q/z-index is f, its source order is
\[
k=\operatorname{ord}_P(\varepsilon)=e f\ge5.
\]
Both maps in the tower C→Q→P1_z are separable. The exact completed different formula therefore gives
\[
\operatorname{ord}_P(d\varepsilon/\varepsilon)
=\delta+e\delta_{Q/z}-ef
\ge\delta-e\ge3,
\]
because δQ/z≥f−1 for every finite separable local extension. This includes wild Q/z and all larger breaks of π. It concerns the actual completed maps and the actual variation of z, not a normalized tensor row. In the parameter u it says ord(ε′)≥k+3, with ε′≠0 by separation.

## Exact conic and original canonical comparison

The q-comparison and the diagonal value B(P)=A(P)=a select the unique formal square-root branch
\[
B=A+F(A)\varepsilon+O(\varepsilon^2),
\qquad F(A)=\frac{q(A)}{q'(A)}=\frac{q(A)}{2A}.
\]
Here F is a unit, and every coefficient of the ε-expansion is regular near A=a, because2a is a unit. Cubing the ORIGINAL θ-comparison, with κ³=1 and the actual y_i³=p(A_i), gives
\[
(B')^3=\left(\frac{p(B)}{p(A)}\right)^2(1+\varepsilon)^{-8}.
\]
The conic and ord(ε′)≥k+3 give B′(P)=1. Thus the unique cube root with value one has expansion
\[
B'=1+\left(4\frac{p'}p F-1\right)\varepsilon+O(\varepsilon^2),
\]
using2/3=4 and8/3=1 in characteristic five. No freely chosen phase or endpoint replacement is made.

Differentiate the conic expansion of B. For its error term, writing O(ε²)=Σ_{j≥2}F_j(A)ε^j with regular F_j, the coefficient derivatives have order at least2k and the ε-derivatives order at least2k+3. Consequently its derivative divided by ε has order at least k. Comparing the two expressions for B′ and dividing the resulting identity by the nonzero ε and the unit F gives
\[
\frac{\varepsilon'}{\varepsilon}
=4\frac{p'}p-\frac1F-\frac{F'}F+O(u^k)
=4\frac{p'}p-2\frac{q'}q+\frac{q''}{q'}+O(u^k)
=4\frac{p'}p+\frac A q+\frac1A+O(u^k).
\]
The first member has order at least three and k≥5. Hence G=4p′/p+A/q+1/A must vanish to order at least three at a. The regular denominator Aqp is a unit, so its numerator
\[
L(A)=4A(A^2+d_0)p'(A)+(2A^2+d_0)p(A)
\]
would have a geometric root of multiplicity at least three.

## Exact polynomial certificate

The fixed centered p has ascending coefficient codes
\[
[8,3,21,23,22,12,22,21,1,22,1].
\]
The ONE approved new one-thread process emitted the full arrays
\[
L=[21,0,0,4,13,17,11,13,6,13,22,11,2],
\qquad L'=[0,0,2,17,0,11,21,18,17,0,11,4].
\]
It also emitted the second Hasse derivative, prepared for the triple-root test:
\[
D^{[2]}L=[0,2,13,0,0,13,18,13,0,0,2].
\]
Already gcd(L,L′)=1. The emitted exact Bézout coefficients, in the same ascending encoding, are
\[
U=[15,0,9,10,21,19,23,14,14,12,19],
\qquad V=[12,7,0,4,18,15,7,20,6,16,0,8],
\qquad U L+V L'=1.
\]
The source asserts this complete identity before emitting PASS. Its third Hasse-derivative coefficient is zero, since the stronger squarefreeness certificate already suffices. Thus L has no repeated geometric root, contradicting the necessary triple root. This is an algebraic-closure decision, not root sampling or an existence claim for arbitrary polynomial rows.

The frozen [source](../../scripts/oct03_finite_diagonal_logarithmic_triple_gate.sage) has SHA256 `e82f7dd162aa470e74940c20e60f158a979f7942a1a21dc7ec4c452d728eae21`. The complete flushed [stdout](../../../litt3-computation-data/oct03_finite_diagonal_logarithmic_triple_gate/stdout.jsonl) and [receipt](../../../litt3-computation-data/oct03_finite_diagonal_logarithmic_triple_gate/receipt.json) record `/usr/local/bin/sage -python`, eight numerical thread settings equal to one, an external process-group timeout of15 seconds, no timeout/error, and external elapsed2.656749416142702 seconds. Mathematical work completed at0.05280275037512183 seconds. The source's prepared-only wording is historical launch metadata; the receipt records the separately approved execution. No replay or further polynomial process was used.

Both actual finite étale endpoint maps stay on the SAME C. The argument has no intermediate-field generation, quotient-genus, Jacobian-Hom, descended-X-map or simultaneous endpoint Galois-closure premise. It proves precisely the stated conditional ordinary diagonal exclusion; it does not extract the comparison from an arbitrary original common-cover source.
