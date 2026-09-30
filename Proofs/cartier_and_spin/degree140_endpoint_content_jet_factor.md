# The local content factor and the reciprocal pole coefficient

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_endpoint_content_jet_factor.md).
Use the universal fixed-degree resultant formula and the endpoint
congruences in sections1 and3 of the accepted
[normalized critical-curve report](../../../litt3-computation-data/september29_evening_replies/actual_ramification/REPORT.md).
No incoming verification is repeated.

All formulas below are in characteristic five. Retain the local coefficient
functions, rather than replacing them by constants until reduction modulo t.
Set q=t^3*u, c=t*chi, tau=t^3*(-u*e+t^2*kappa). In the universal resultant
formula put B=a^5*q^2+b^5*q+2*c^5 and T=b^5+2*a^5*q.
The coefficient of ell^2 is4B^2, hence has order at least six.

In the coefficient of ell, the order-three terms combine as
4b^10*t^3*(u*e+tau/t^3)=4b^10*t^5*kappa. The remaining terms of order
five are4u*b^9*chi^2*t^5 and3e*b^5*chi^5*t^5. Consequently
\[
[\ell]\left.(D/t^5)\right|_{t=0}=4b_0^5R.
\]
On the dense formal open a_0*b_0!=0, the second critical point reduces to
V=b_0/a_0. Its critical value is finite, with value
\[
\Lambda_B=-a_0^5e_0/b_0^5-2a_0^3/b_0^2.
\]
The norm factorization of the scale resultant therefore makes its
endpoint constant coefficient -Lambda_B times its linear coefficient.
This gives4a_0^3*(a_0^2*e_0+2b_0^3)*R. Both sides are polynomial in
the local jets, so the identity extends across a_0*b_0=0; it is not a
localization that discards those endpoints. The lower coefficients in t
vanish by the same universal substitution.

For a direct finite verification of this NEW identity, the source
[endpoint_content_jet_identity](../../scripts/arithmetic/degree140_endpoint_content_jet_identity_20260930.sage)
allows all36 coefficient variables through t^5, imposes only the two
displayed source congruences and checks all18 coefficients. It takes
approximately0.03 seconds on one core. Its exact symbolic output and
receipt are
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/endpoint_content_jet_identity.sobj`
and the adjacent JSON file.

The two coefficients b_0^5 and a_0^3*(a_0^2*e_0+2b_0^3) generate the
unit ideal on the stated open. Indeed, at a prime where b_0 vanishes,
a_0 and e_0 are units and the second coefficient is a unit. Thus the
three resultant coefficients generate exactly(R), including nilpotents
in a parameter base. The original raw-to-barred normalization is a power
of y, which is a unit at every chosen endpoint and changes no ideal.

To identify the moving pole coefficient on type A, the simple critical
root has expansion V=2*chi_0*t/b_0+O(t^2). Substitution into
phi*S+tau yields
\[
\phi S+\tau=t^5\left(
\kappa_0+u_0\chi_0^2/b_0+2e_0\chi_0^5/b_0^5\right)+O(t^6)
=t^5R/b_0^5+O(t^6).
\]
Since phi=t^3*u_0+O(t^4), the assertion for Lambda follows. At type B,
the accepted primitive endpoint dichotomy gives chi_0!=0, hence R!=0.
Finally, in a finite locally free algebra an element is a unit exactly
when the determinant of multiplication by it is a unit. Applying this
to the nine-sheet endpoint algebra proves the Norm(R) formulation.

The new conclusion identifies the endpoint denominator geometrically.
It is not an exclusion of the remaining primitive scale locus, and no
unproved regularity across type-B parameter degenerations is inferred.

For the actual source, the new
[content-norm construction](../../scripts/arithmetic/degree140_endpoint_content_norm_20260930.sage)
uses only length-three jets at the three x-endpoints. Multiply each raw
source coefficient by w^5 to work polynomially. The corresponding jet
factor is w^30*R; its cubic norm is taken in each endpoint algebra
K[y]/(y^3-P(r)). All local source congruences hold exactly in these jets.
Multiplying the three cubic norms and removing the recorded power of w
gives an explicit polynomial N(H,q) with
\[
\operatorname{Norm}(R)=q^{-72}N(H,q),\qquad
\deg_H N=54,\quad \deg_q N=270.
\]
It has8765 terms. The entire construction takes approximately4 seconds
on one core, without a parameter grid or a large resultant. The exact
polynomial and the three intermediate endpoint factors are retained in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/endpoint_content_norm.sobj`;
the adjacent JSON records the support and scaling. This constructs the
content denominator; it does not assert a denominator bound for every
coefficient of an unweighted trace.
