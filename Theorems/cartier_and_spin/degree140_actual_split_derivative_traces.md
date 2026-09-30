# Actual splitting gives smaller critical trace equations

Version1,30 September2026. Retain the primitive constant degree140
family, its original open chart, and its connected normalized critical
double cover C->X. Use the regular source coordinate W and write
\[
F_\ell(W)=\ell\phi(W)^2+\phi(W)S(W)+t^3,
\quad \phi=W^5+\overline Q,
\quad S=g_2W^3+g_3W^2+g_4W+g_5.
\]
On S'(W)=0 put Lambda=-(phi*S+t^3)/phi^2. Let delta0 be the
derivation dual to dx/(3y^2) on X, extended to k(C). Thus delta0(Lambda)
can be computed by differentiating its coefficients with W held fixed,
because its W derivative vanishes on the critical curve.

If a nonzero scale lambda gives an ACTUAL everywhere-etale degree-ten
source over X, then delta0(Lambda) vanishes at every geometric point
of Lambda^{-1}(lambda). This is stronger than vanishing of
eta*delta0(Lambda), which follows merely from normalized ramification.

For every affine regular f on X with pole order at most p at O, define
\[
\widehat T_f=\operatorname{Tr}_{k(C)/k(\Lambda)}
                   (f\,\delta_0\Lambda),\qquad
\widehat Q_f=\operatorname{Tr}_{k(C)/k(\Lambda)}
                   (f\,\delta_0\Lambda/\phi).
\]
These are polynomials in Lambda and both vanish at every actual scale.
They satisfy the uniform bounds
\[
\deg\widehat T_f\le
 \max\left(2,\left\lfloor\frac{21+p}{4}\right\rfloor,
                \left\lfloor\frac{24+p}{7}\right\rfloor\right),
\quad
\deg\widehat Q_f\le
 \max\left(5,\left\lfloor\frac{1+p}{4}\right\rfloor,
                \left\lfloor\frac{17+p}{7}\right\rfloor\right).
\]
Every coefficient of degree at least three in a T-hat trace comes
only from the two infinity points. In particular T-hat_1 has degree
EXACTLY five, with the following unit leading coefficient in the
incoming K=F_(5^8) coding:
\[
[\ell^5]\widehat T_1=\langle333905\rangle\,w h^{-12}.
\]
Thus h^12*T-hat_1/(<333905>*w) is a uniform MONIC QUINTIC necessary
scale equation, on the original ratio chart. No new exceptional
leading-coefficient locus is introduced. Also T-hat_x has degree
EXACTLY six. If
Lambda=c*z^{-4}+O(z^{-3}) at O4, in the standard parameter with
x=z^{-3} and y=z^{-10}(1+O(z)), then
\[
[\ell^6]\widehat T_x=c^{-5}\ne0.
\]
The degree-six equation is an additional necessary condition.

These are necessary conditions for actual source splitting. They do
not purport to characterize fully ramified critical fibres, construct
an etale source, or decide the unmarked common-cover problem.

[Proof](../../Proofs/cartier_and_spin/degree140_actual_split_derivative_traces.md).
