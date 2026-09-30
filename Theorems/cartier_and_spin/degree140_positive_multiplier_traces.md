# Positive critical multipliers give polynomial ramification tests

Version1,29 September2026. Retain the actual normalized critical curve,
parameter open set and primitivity hypotheses of
[the normalized trace theorem](degree140_normalized_critical_trace.md).
Write eta^2=d, V0=eta*delta, v=V0(Lambda), and phi=W^5+Qbar. Let f be
regular on affine X, with pole at most p at O. For every integer m>=1 put
b_m=floor((5m-2)/3). Then
\[
P_{m,f}(\ell)=\ell^{b_m}
 \operatorname{Tr}_{k(C)/k(\Lambda)}(f\phi^m v)
\]
is a polynomial of degree at most
\[
b_m+\left\lfloor\frac{37+20m+p}{4}\right\rfloor.
\]
It vanishes at every nonzero fully ramified fibre of Lambda. The statement
includes singular critical models and every normalization divisor Gamma.
It makes no squarefree-discriminant assumption.

For f=1 its degree is exactly b_m+9+5m. With the normalized constants
C9=<103636>, C10=<104299>, K0=2/epsilon^2 and U=-epsilon^5*K0^(-5),
its leading coefficient is
\[
C9\,U^m w h^{-(24+20m)}.
\]
For f=x its degree is exactly b_m+10+5m and its leading coefficient is
\[
C10\,U^m h^{-(27+20m)}.
\]
Both coefficients are units on the prescribed ratio chart. In particular,
ell*Tr(phi*v) is a monic degree15 necessary scale polynomial after unit
normalization, and ell*Tr(x*phi*v) has exact degree16. These supplement
the earlier degree-nine test; they do not replace its smaller scale bound.

Positive multipliers remove the poles of the tested function at the nine
finite endpoint branches of type A. This differs from dividing by phi,
which increases those poles. No assertion that all varying-parameter
coefficient denominators have been removed is part of this theorem.

These are necessary ramification tests, not an exclusion of all ratios,
an admissible cover, or a solution of the unmarked common-cover problem.

[Proof](../../Proofs/cartier_and_spin/degree140_positive_multiplier_traces.md).
