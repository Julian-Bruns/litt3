# Cartier type under separable domination of coreless spans

Date: 2026-09-05. Status: direct algebraic lemma; conditional on the stated span hypotheses, not an all-Hecke classification.

Work over an algebraically closed field of characteristic \(p>0\). All horizontal spans below are finite etale spans of smooth projective connected curves of genus at least two, and are coreless. Canonical rings are embedded by **actual differential pullback**. Their intersections are \(k\) or \(k[s]\), by the [intersection theorem](../../Theorems/Thm_canonical_intersection.md).

Write \(C_n:\omega^{pn+1}\to\omega^{n+1}\) for the inverse-Frobenius-semilinear twisted Cartier operator on sections. The [generator argument](../../Theorems/Thm_cartier_generator.md), with 5 replaced by \(p\), proves that a positive primitive degree \(d\) is prime to \(p\). If \(1\le r<p\) is its inverse modulo \(p\), then

\[
C_{(rd-1)/p}(s^r)=0\quad\text{if }d\nmid p-1;
\qquad C_{(rd-1)/p}(s^r)=c s\quad\text{if }d\mid p-1.
\]

Call a positive intersection **Cartier-nonzero** when every nonzero homogeneous invariant of weight congruent to 1 modulo \(p\) has nonzero twisted Cartier image. Equivalently, \(d\mid p-1\) and the displayed scalar \(c\) is nonzero. Indeed, every eligible power is \(s^{r+pj}\), and its Cartier image is \(s^jC(s^r)\). This definition does not assert an ordinary Cartier operator on arbitrary weights.

## Separable domination lemma

Suppose there is a commutative diagram of spans

\[
\begin{array}{ccccc}
X'&\longleftarrow&Z'&\longrightarrow&Y'\\
\downarrow&&\downarrow&&\downarrow\\
X&\longleftarrow&Z&\longrightarrow&Y,
\end{array}
\]

whose vertical arrows are finite separable surjections. If both intersections are positive, then the upper intersection is Cartier-nonzero if and only if the lower intersection is Cartier-nonzero. Positivity downstairs implies positivity upstairs; positivity downstairs is an additional hypothesis for the converse formulation.

**Proof.** Differential pullback is injective on rational pluriforms for finite separable maps and preserves regular pluriforms. It commutes with twisted Cartier, including for ramified vertical arrows. To see the last assertion, factor a rational weight-\(pn+1\) tensor as \(\theta^{pn}\alpha\) for a nonzero rational differential \(\theta\); its image is \(\theta^nC(\alpha)\). Ordinary Cartier commutes with separable pullback, and the projection formula gives the stated compatibility.

Consequently a nonzero Cartier-zero common section downstairs would pull back to such a section upstairs. This proves descent of the nonzero property (even without assuming positivity downstairs).

Conversely, suppose the lower intersection is \(k[s]\), of Cartier-nonzero degree \(d\), and the upper one is \(k[t]\), of degree \(e\). Pulling back \(s\) gives \(\lambda t^q\), with \(d=eq\) and \(\lambda\ne0\). In particular \(e\mid d\mid p-1\). If \(r_d,r_e\in[1,p-1]\) are the respective inverses modulo \(p\), write \(qr_d=r_e+pj\), where \(j\ge0\). Nonvanishing of the pulled-back \(C(s^{r_d})\), together with

\[
C(t^{qr_d})=t^jC(t^{r_e}),
\]

forces \(C(t^{r_e})\ne0\). This proves ascent. \(\square\)

Thus connected full Cartesian pullbacks and finite quotients preserve this obstruction whenever they give such a diagram and the resulting horizontal spans retain corelessness and finite etaleness. Vertical ramification is allowed; purely inseparable vertical maps are excluded. A quotient with intersection \(k\) has no positive common section at all, so still cannot supply a common Cartier-zero section. The lemma does not claim that arbitrary base change preserves corelessness or that arbitrary quotient preserves etaleness.

## Scalar logarithmic witnesses and composition

Suppose nonzero regular differentials satisfy

\[
C(\eta_X)=\eta_X,\qquad C(\eta_Y)=\eta_Y,
\qquad f^*\eta_X=a\,g^*\eta_Y,
\qquad a\in\mathbf F_p^\times.
\]

Then \(\eta=f^*\eta_X=g^*(a\eta_Y)\) is an actual shared Cartier-fixed one-form. Corelessness forces

\[
A=k[\eta],\qquad d=1,\qquad C_n(\eta^{pn+1})=\eta^{n+1}\ne0.
\]

The scalar need not equal 1: rescaling the endpoint section is allowed inside its canonical ring and does not alter the differential pullback map. If two nonzero Cartier-fixed forms have a constant proportionality factor at all, Cartier semilinearity forces that factor into \(\mathbf F_p^\times\). After finite descent, the shared one-form can disappear, but any positive intersection still has primitive degree dividing \(p-1\) and remains Cartier-nonzero by the lemma.

For a sequence of correspondences carrying the same Cartier-fixed differential on every intermediate curve, scalar relations compose by multiplying their factors. Pulling them to a connected component of the composite fiber product gives the same relation between the outer endpoints. Therefore every such composite that remains coreless and finite etale has the same degree-one obstruction. This applies to iterates when the two endpoint witnesses on the repeated curve are proportional. More generally, matching positive pluriform witnesses on the intermediate curves, up to constants, suffice if their common weight \(h\) divides \(p-1\) and their eligible Cartier images are nonzero: the composite retains the witness, its primitive degree divides \(h\), and the ascent argument proves nonvanishing.

Matching intermediate witnesses is an explicit hypothesis. Cartier-nonzero intersections for two unrelated spans alone do not identify their witness lines on their common endpoint and do not justify a composition claim. Likewise, prime-to-\(p\) isogeny degree alone does not establish the scalar differential relation: that relation must be verified for the moduli differential and the actual maps in question. Once it is verified, a factor different from 1 supplies no escape from this obstruction.
