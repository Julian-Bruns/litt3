# Endpoint multiplication gives a global monic degree-thirteen condition

Version1,30 September2026. Retain the constant degree140 primitive
critical family, its actual normalized map Lambda, v=eta delta(Lambda),
and the monic cubic endpoint polynomial t from
[normalized critical traces](degree140_normalized_critical_trace.md).
Put L0=(18,20,20,15), U0=(Q-L0^5)/t^3, and, in the affine cubic curve
algebra y^3=P(x), write
\[
G_2(G_3-3L_0G_2)^2=r_0(x)+y r_1(x)+y^2 r_2(x).
\]
For f in K[x], define
\[
\mathcal T_f=\operatorname{Tr}(t f v),\qquad
\mathcal Q_f=\operatorname{Tr}(t^4 f v/\phi).
\]
The fixed-endpoint residue formula for these traces has NO endpoint
correction in any positive scale degree. Its constant correction is
respectively
\[
2\operatorname{Tr}_{K[x]/(t)}(f t' U_0 r_2/P^3),
\qquad
2\operatorname{Tr}_{K[x]/(t)}(f t' r_0/P^2).
\]
All inverses in this rank-three algebra are fixed: gcd(P,t)=1. In
particular these corrections are Laurent polynomials in the original
ratio parameters, of h-degree at most three. No content polynomial,
critical-discriminant value or varying endpoint coefficient is inverted.

All other terms are the two infinity residues from
[the proper polar formula](degree140_fixed_endpoint_residue_traces.md).
Consequently, after H=hw,q=w^3,ell=w mu, the coefficients of
w^-1*T_f(w mu) and Q_f(w mu) lie in K[H^+-1,q^+-1,Psi^-1]. The formulas
extend to every admitted primitive normalization stratum, including
type-B endpoints, by the actual function-field trace construction.

For f=1,x,x^2 the degrees of T_f are at most11,12,13. Moreover
\[
[\ell^{13}]\mathcal T_{x^2}=\epsilon(-K_0h^3)^{-12}\ne0,
\qquad K_0=\langle246025\rangle.
\]
Thus multiplication by its inverse gives a global monic degree-thirteen
necessary scale polynomial with coefficients free of endpoint-content
denominators. Every nonzero fully ramified critical fibre annihilates
all these traces. This is an elimination tool, not a proof that the
remaining geometric locus is empty or a common-cover decision.

[Proof and compact implementation](../../Proofs/cartier_and_spin/degree140_endpoint_multiplier_traces.md).
