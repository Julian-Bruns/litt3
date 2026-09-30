# Proof: a global norm-resultant identity closes the ramification curve

[Statement](../../Theorems/cartier_and_spin/degree140_root9_ramification_exclusion.md).
This integrates the completed Pro response, whose final theorem is in
Sections26--30 of the
[original report](../../../litt3-computation-data/frobenius_ratio_complete_reply_20260928/frobenius_ratio/REPORT.md).
Earlier partial-status passages in that report are superseded by Section30.
The source and localized ring are precisely those of the
[submitted request](../../Research/requests/next_structural_bottlenecks_2026_09_27/02_root9_frobenius_truncation.md).

## The complete ring and the actual square equations

Put g=b u^2+2c u+3e. The ordinary-double-root ring is the original
ratio ring modulo g, with bu+c inverted. All original factors q,u,mu,d,
V=a_0u^3+bu^2+cu+e and the specified excluded q-values remain units.
No new factor is inverted before its whole geometric inverse image is
excluded. Let I be the full square ideal from the
[universal model](universal_degree140_linear_square_model.md).
Write a(T)=1+sum a_n T^n and C_n=[T^n]a^63. In particular
C71,C72,C73 belong to I; the sixteen late Frobenius-carry equations
remain in I, although the final norm identity uses these early tails.

Complete boundary certificates make the required finite polar factors
units modulo I. Only then put z=bu and work in the complete quadratic
algebra
\[
S=D[z]/(z^2+2cz+3be),\qquad
D=K[q,1/B_q].
\]
The b=0 boundary and both branches over each new q-factor are included.
This is not the selection of one root of the quadratic.

## Membership of the normalized resultants

For n=72,73 form the fixed-degree Sylvester resultant r_n of C71,Cn
in the scale mu, with degree bounds53,54. Its adjugate gives
r_n in(C71,Cn) over the entire ring, even when specialized leading
coefficients vanish. Therefore N_n=r_n sigma(r_n) also belongs to I.
The coefficient weight bound4j<=3n proves these scale-degree bounds.

Section26 gives the full polar divisor and certified coefficientwise
valuation bounds. Integer row/column potentials verify every determinant
valuation inequality. Multiplying N_n by the resulting already-unit
polar factors gives genuine polynomials P72,P73 in K[q], of degrees
at most640178 and648297. There is no middle-coefficient localization
or generic-degree assumption in this construction.

Polynomiality includes the entire q-line, with all removed q-fibres
handled before interpolation. If h is the product of the thirteen
K-rational polar factors, h^2 P_n has degree at most648323<781250.
Its values and first derivatives at all390625 elements of K determine
it uniquely: their vanishing difference would be divisible by
(q^390625-q)^2. Exact zero jets at the thirteen holes follow from h^2,
not from evaluating an undefined rational residual. The full two-sheet
quadratic algebra is retained at every other node.

The executed reconstruction checks every coefficient beyond the proved
bound, divides h^2 exactly, and produces the retained polynomial hashes.
Thus this computation proves identities over K[q], rather than merely
excluding parameter points in K.

## The final unit identity

The retained coefficient arrays E72,E73 have degrees647552,639433 and
satisfy
\[
E72 P72+E73 P73=(q-\langle118020\rangle)^{384}H_-^5.
\]
The first factor is an original Cramer-chart unit. H_- is squarefree
of degree72. Over every one of its sixteen coefficient-field factors,
the two distinct ratio roots each have an exact identity
U C71+W C72=1. CRT gives(I,H_-)=S[mu], so H_- is a unit modulo I.
This covers the conjugate ratio sheet as well as the slope sheet used
to discover H_-. The argument is ring-theoretic and retains nilpotents.

The left side belongs to I and the right side is a unit modulo I.
Therefore the localized square quotient is zero. Every preceding
localization was at a unit modulo the original I, so the original
ordinary-double-root square quotient is also zero.

The certificate is checked by direct polynomial multiplication; no
gcd-discovery assertion is needed. A second check uses four Hasse jets
at all390625 elements of K. The difference has degree at most1287730,
less than1562500=deg((q^390625-q)^4), hence these jets give a second
complete polynomial-identity verification without GMP multiplication.

## Consequence for the whole square locus

The [triple-root theorem](degree140_linear_cubic_cusp_exclusion.md)
gives(I,f',f'')=(1) on the original source ring. The completed ordinary
case gives(I,f')[1/f'']=(1). In the quotient by(I,f'), f'' is a unit
by the first assertion; the second therefore makes that quotient zero.
Thus f' is a unit in the full square quotient, including nilpotents.
Since u f'(u)=-g and ds/du=-g/(d u^4), the ambient ratio map is etale
at every possible square point. This is the only etaleness consequence:
a repeated root on the OTHER sheets has not been excluded.

## Evidence and replay

The archive SHA256 is
`2b4bf2173d8c4c9107dcae2cbe2133691d9422d0cbcab61123f6e8f25fab6e0c`.
The original193-file manifest passes. Sources are retained in
[the source directory](../../scripts/arithmetic/pro_frobenius_ratio_20260928/README.md).
The [integration audit](../../Research/audits/FROBENIUS_RATIO_COMPLETE_2026_09_28.md)
records the local fresh-source, fresh-model, fresh-coset replay and the
separate polynomial identity check. Data, arrays and logs remain outside
the prose workspace.
