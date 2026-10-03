# Proof: the high cube coefficients have a nonzero mismatch

Version1, 3 October2026. [Fresh independent four-check review PASS](../../Research/audits/OCT03_CENTERED_SIXFOLD_FULL_SUPPORT_NORM_HAND_AUDIT_2026_10_03.md) for the repaired statement, including exact cube terms and repeated support. See the [statement](../../Theorems/curve_arithmetic/centered_sixfold_full_support_norm_obstruction.md).

## General coefficient criterion

Suppose p+G³=cU12 with p monic of degree ten. Necessarily G has degree exactly four: smaller degree would leave the monic U10 term uncancelled. Write G=aU4+bU3+hU2+jU+l with a≠0. The U11 coefficient gives3a²b0, hence b0. The U10 and U9 coefficients give
\[
h=-\frac1{3a^2},\qquad
j=-\frac{p_9}{3a^2}.
\]
The U7 coefficient of G³ is6ahj=ahj in characteristic five. Since 1/9=4, comparing with−p7 yields
\[
\frac{4p_9}{a^3}=-p_7,
\qquad a^3=\frac{p_9}{p_7}.
\]
The U8 coefficient first gives3a²l+3ah²=−p8, so
\[
l=-\frac{p_8}{3a^2}-\frac{h^2}{a}.
\]
The U6 coefficient is3aj²+h³+6ahl. Keeping this third term is essential. Since6=1, its h³ contributions cancel after substitution of l, and it equals
\[
\frac{2p_9^2+4p_8}{a^3}
=2p_9p_7+4p_8p_7/p_9.
\]
It must equal−p6. This proves the necessary criterion without choosing any cube root or searching G.

## Exact fixed-curve mismatch

Use d0=[23]=3−β, β²=β+3, so d0²2. The fixed centered coefficients are
\[
p_9=p_6=d_0-1=t,\qquad p_7=d_0-2.
\]
They are nonzero. Direct multiplication gives
\[
\frac{p_9}{p_7}=2d_0,\qquad
2p_9p_7=3-d_0,\qquad
4p_8p_7/p_9=d_0,\qquad p_8=1.
\]
Consequently p6+2p9p7+4p8p7/p9=(d0−1)+(3−d0)+d0=d0+2≠0. Thus no fixed-curve p+G³=cU12 is possible. The original draft omitted the6ahl term at U6; this was corrected by the author before accepting any review verdict.

## Three-point full-support divisor consequence

The centered fiber U0 is ordinary because p0=[8]≠0, and
\[
\operatorname{div}(U)=T_0+T_1+T_2-3O.
\]
Assume E has degree five, support in these three points, and all three occur. Write E=T0+T1+T2+E′ with E′ effective of degree two. A function f with divf6E−30O then gives f′=f/U6 satisfying
\[
\operatorname{div}(f')=6E'-12O.
\]
The fixed semigroup H(O)=〈3,10〉 gives
\[
L_X(12O)=\langle1,U,U^2,U^3,U^4,y\rangle.
\]
Its pole order is exactly twelve, so f′=a y+G(U), degG4, with nonzero U4 coefficient. Also a≠0: a polynomial in U has equal zero order at all three centered points, whereas a divisor6E′ of degree twelve supported on at most two of them has a missing point. Normalize a1.

Its function-field norm to the U-line is p+G³. Pushforward of its actual zero cycle is12[U0], and its pole cycle is12[∞], regardless of repeated points in E′. Therefore p+G³=cU12 with c≠0. The fixed mismatch above contradicts this identity.

No actual endpoint map is replaced and no claim is made about E that omits a centered point. The computation-free coefficient criterion, rather than a sampled local series or inferred torsion bound, supplies the obstruction.
