# Proof: geometry and absolute simplicity of the original pair

[Statement](../../Theorems/curve_arithmetic/fixed_pair_arithmetic.md).
Use X:y³=F(x) and Y:z²=L(t)(L(t)−1)(t−4), L=t²⁵+t⁵+t,
from the [fixed-pair definition](../../Definitions/fixed_pair.md).
The [exact arithmetic certificate](../../scripts/arithmetic/fixed_pair_frobenius.sage)
computes the Frobenius polynomials and checks the small inputs below.

## 1. Geometry and canonical frame

F is squarefree of degree10. The tame cubic map is totally ramified
at its ten roots and unique rational infinity O, so
2g(X)−2=−6+11·2=16. A degree-two pencil would generate k(X) with
the cubic pencil, forcing g(X)≤(3−1)(2−1)=2 by Castelnuovo–Severi.
Thus X is nonhyperelliptic. At infinity x,y have poles3,10;
theta=dx/y² has order16. At a finite branch point y is a parameter
and dx has order2; elsewhere theta is a unit. Hence div(theta)=16O.

Since L′=1 and L(4)=2, the degree51 polynomial defining Y is squarefree,
so g(Y)=25. On F125, L is the trace to F5; its two fibers L=0,1 have
25 rational points each. Together with4 and infinity these give all
52 rational Weierstrass points.

## 2. Two simplicity criteria from the real Frobenius field

Let A/F_q have irreducible Frobenius polynomial of degree2g, g>2,
and let K⁺=Q(pi+q/pi). A squarefree residue-degree pattern(1,g−1)
for its degree-g defining polynomial makes K⁺ primitive and non-Galois,
by the residue-degree argument in
[Howe–Zhu, proof of Lemma9](https://arxiv.org/html/math/0002205v1#S5).
In particular it is not a cyclotomic maximal real subfield.

If A is ordinary, and its polynomial is not T^(2g)+cT^g+q^g,
[Howe–Zhu, Lemma8](https://arxiv.org/html/math/0002205v1#S5)
therefore proves absolute simplicity.

There is a shorter criterion when 0<f_p(A)<g. For every n>0,
K_n=Q(pi^n) is CM: a real Weil power would have only slope1/2,
contrary to positive p-rank. Its real subfield lies in K⁺ and is
therefore either K⁺ or Q. The first case gives K_n=Q(pi).
In the second, [Q(pi):K_n]=g, so the characteristic polynomial of
pi^n is a g-th power. Its number of unit roots, namely f_p(A),
would then be divisible by g, a contradiction. Thus all K_n=Q(pi),
and [Howe–Zhu, Proposition3(2)](https://arxiv.org/html/math/0002205v1#S3)
proves absolute simplicity. No ordinarity or half-slope hypothesis
is needed for this second criterion.

## 3. The exact inputs for X and Y

Write P_C(T)=T^(g(C))Q_C(T+q_C/T) for the Frobenius polynomial
over the defining finite field. The exact certificate supplies:

| C | q_C | g(C) | P_C irreducible modulo | Q_C squarefree residue degrees | f_p(C) |
| --- | --- | --- | --- | --- | --- |
| X |25|9|2|(1,8) at107|6|
| Y |5|25|47|(1,24) at173|25|

For X, the real polynomial is only degree nine:
\[
Q_X(U)=U^9-2U^8-254U^7+457U^6+21826U^5-29834U^4
-703917U^3+354810U^2+6210225U+6613875.
\]
Moreover
\[
P_X(T)\equiv T^{12}(T+1)^2(T^4+T^3+3T^2+3)\pmod5,
\]
whose nonzero factor has degree six. Hence f_p(X)=6 and the
nonordinary criterion applies. It replaces the old root-ratio
resultant factorization entirely.

For Y, the middle coefficient of P_Y is −135307468, prime to5;
thus Y is ordinary. Its T^49 coefficient is −2, excluding the
exceptional shape in Lemma8. The ordinary criterion applies.
The different geometric dimensions9 and25 now give
Hom_k(JX,JY)=0.

The Frobenius computations remain author-prose inputs. Integer
reconstruction uses a modulus larger than twice the Weil coefficient
bound. The [earlier refinement audit](../../Research/audits/FIXED_ARITHMETIC_SIMPLIFICATION_AUDIT_2026_09_13.md)
retains its original scope; the
[new focused audit](../../Research/audits/FIXED_REAL_FIELD_SIMPLICITY_2026_10_03.md)
checks the nonordinary field-power argument. No settled Frobenius
computation is replayed.
