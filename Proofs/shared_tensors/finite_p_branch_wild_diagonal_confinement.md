# Proof: branch contact, one quadratic coefficient, and distinct weights

Version1, 3 October 2026. [Fresh independent whole local/certificate audit PASS](../../Research/audits/OCT03_FINITE_P_BRANCH_WILD_DIAGONAL_CONFINEMENT_WHOLE_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/shared_tensors/finite_p_branch_wild_diagonal_confinement.md).

## The new exact root-algebra certificate

Use β²=β+3 and encoding [a+5b]=a+bβ. The fixed P has ascending coefficients[11,22,18,5,19,20,15,16,9,22,1]. Its centered polynomial p(U)=P(U−1) has coefficients
\[
[8,3,21,23,22,12,22,21,1,22,1].
\]
The [single new bounded source](../../scripts/oct03_finite_p_branch_weight_separation_probe.sage) works in the ten-dimensional étale algebra A=F25[U]/p, with p-squarefreeness provided by the fixed smooth endpoint. It checks exact Bézout identities making both U and q(U)=U²+[23] units on A. Thus the stated rational weight is defined and nonzero at all ten geometric roots.

Its reduced weight W(U) in A has coefficient list
\[
[3,24,16,23,19,1,20,0,3,13].
\]
The source forms the multiplication-by-W matrix in the basis1,U,…,U⁹. Its monic characteristic polynomial χ(T) has ascending coefficients
\[
[21,17,17,7,17,17,16,19,24,12,1].
\]
It checks χ(W)=0 modulo p and exact polynomials a(T),b(T) satisfying aχ+bχ′=1. The FULL ten-by-ten matrix, unit inverses/Bézout coefficients, weight, χ and squarefreeness Bézout coefficients are in the [fresh complete output](../../../litt3-computation-data/oct03_finite_p_branch_weight_separation_probe/stdout.jsonl).

After extending scalars to k=bar F5, A is the product of one copy of k for each p-root. Multiplication by W is diagonal there with eigenvalues W(a) for those ten roots, each once. Therefore χ(T)=∏_{p(a)=0}(T−W(a)). Its squarefreeness proves all ten values distinct. The conclusion is ALL-geometric and uses no sampled roots or parameter values.

The [receipt](../../../litt3-computation-data/oct03_finite_p_branch_weight_separation_probe/receipt.json) records source SHA256 e65e540ae026c63d482ddf164a2877cb720a9499b71dbc9c0269a1a94880832e, the sage-python command, eight numerical environment settings at one, and the hard external fifteen-second process-group timeout. The ONE process exited successfully without timeout in2.7878 seconds, with mathematical decision at0.0791 seconds and empty stderr. No pair enumeration, Gröbner basis, PSC replay, sampling or follow-up calculation was performed. Independent whole static scope review is pending; no independently executed numerical replay is claimed.

## Actual finite branch orders and the original tensor phase

At both finite endpoint branch points y_i are actual source parameters, because the maps h_i are étale. Thus ord(y_i)=1, ord(Xi−Xi(P))=3 and ord(dXi)=2. Put a=X1(P), b=X2(P). The root-algebra unit certificates give a,b,q(a),q(b) nonzero; endpoint smoothness gives p′(a),p′(b) nonzero.

Let e=5 or10 be the actual local π-degree and δ its different. Since z comes from Q and is a finite unit, ord(dz)≥δ. Differentiate the actual q-comparison and use the actual θ-comparison:
\[
\left(\frac{q'_2y_2^2}{\kappa z^8y_1^2}-z^3q'_1\right)dx_1
=3z^2q_1\,dz.
\]
The two terms in parentheses are units: y2/y1 is a unit even though both y_i vanish. Their difference has order at least δ−2. Cubing and clearing the actual factor z²⁴P(x1)²/8 gives, with the REQUIRED κ³=1,
\[
K=X_2^3p(X_2)^2-z^{33}X_1^3p(X_1)^2,
\qquad \operatorname{ord}(K)\ge\delta+4,
\]
because P(x1)² has order six. No endpoint lift or phase is changed.

Put s=z(P)³=q(b)/q(a). Freeze V²=sX1²+d0(s−1), V(P)=b. The branch exists because2b is a unit. The π-index gives ord(z³−s)≥e, hence X2−V has order at least e. Both p(X2) and p(V) have order three: X2−b has order three, while V−b has order three because V′(a)=sa/b is nonzero. Therefore
\[
\operatorname{ord}\bigl(p(X_2)^2-p(V)^2\bigr)\ge e+3.
\]
The correction in X2³ times p(X2)² and the z³³−s¹¹ correction times p(X1)² have order at least e+6. It follows that
\[
F=V^3p(V)^2-s^{11}X_1^3p(X_1)^2
\]
has source order at least e+3, since δ+4≥e+3 for δ≥8 when e5 and δ≥13 when e10.

The frozen F belongs to k[[X1−a]], and X1−a has source order three. Thus its zero multiplicity in X1 is at least three for e5 and at least five for e10. In particular its quadratic coefficient vanishes in BOTH cases.

## The necessary quadratic coefficient forces the diagonal parameter

The constant and linear coefficients of F vanish because p(a)=p(b)=0. Its quadratic coefficient is exactly
\[
b^3p'(b)^2\left(\frac{sa}{b}\right)^2
-s^{11}a^3p'(a)^2
=s^2a^2\bigl[bp'(b)^2-s^9ap'(a)^2\bigr].
\]
Every displayed clearing factor is nonzero. Dividing by q(b)⁹ and using s=q(b)/q(a) gives W(a)=W(b). The new root-algebra separation makes a=b, hence s1. Consequently x1(P)=x2(P), as asserted. Their actual y-values both vanish; no conclusion identifying the two maps or their embedded global fields is inferred.

The s1 diagonal configuration may still occur, and the argument does not address other finite branches. Both actual étale endpoint maps remain on the SAME source, without a simultaneous endpoint normal closure or a replacement by one-leg data. The unmarked common-cover problem remains unresolved.
