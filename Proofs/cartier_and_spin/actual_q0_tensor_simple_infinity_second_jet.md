# Proof: the characteristic-five second coefficient fixes λ

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_simple_infinity_second_jet.md). Both actual original maps are retained on their SAME source. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

## The local tensor coefficient

At a shared simple pole write x=l/u+m+nu+… and q8/P²=x−4(ONE+A/x+B/x²+…). Since characteristic FIVE makes the binomial coefficient (−FOUR choose TWO)=TEN vanish, direct multiplication gives
\[
\frac{q(x)^8}{P(x)^2}(dx)^3
=-l^{-1}u^{-2}\left[1+\frac{m+A}{l}u+
\left(-\frac{2n}{l}+\frac{B}{l^2}\right)u^2+\cdots\right](du)^3.
\]
The calibrated exact tensor identity makes the bracket coefficients equal for the two original copies, with l2=ρl1. The coefficient of u yields ξ(Q)=ρA1−A2, agreeing with the accepted first jet. The coefficient of u² yields
\[
n_2-\rho n_1=\frac{B_2-\rho^2B_1}{2\rho l_1}.
\]
The left side is exactly dξ/du at Q. No common value of A_i or B_i is required for this general statement.

For the fixed degree-TEN P, centering X=x+ONE leaves P9 unchanged and gives P8,center=P8+P9=ONE. Scaling both centered coordinates by √D, with D=THREE+FOUR ν and ν²=ν+THREE, gives q_i=X²+ONE, P_i,9=ε_i p and P_i,8=r=ONE/D=FOUR+TWO ν. The separately allowed centered sign changes p9 but not p8. Thus
\[
B_i=3+3p^2-2r=3+3\nu-2(4+2\nu)=-\nu
\]
for BOTH copies and BOTH signs. The exact second jet is therefore−ν(ONE−ρ²)/(TWO ρl1).

## Exact simplification of the finite part

Use the [complete ordinary degree-FIVE parameter forms](actual_q0_tensor_degree_five_ordinary_parameter_forms.md), with s=v−ONE, J=z²+s²z+s4, b=vz+s², c=z+vs,ρ=−s³,K=ερ−ONE and L=p[λJ+KH]. Direct polynomial multiplication gives
\[
zb-\rho c=vJ,\qquad z^2c-\rho b=(z+s)J.
\]
Consequently the SAME original functions have the globally regular finite-part expression at both simple poles
\[
\xi=x_2-\rho x_1=vL/z+Y(z+s)/z^2,
\qquad Y^2=z[L^2+(z^2+z+1)J].
\]
Let a be either ωs² or ω²s². Put α=ρ/a, h=H(a), h′=H′ and J_a′=J′(a). The actual noncanceled pole has Y(a)=αL(a), α²=a, and L(a)=pKh≠ZERO. Differentiating Y² and the displayed ξ gives, in characteristic FIVE,
\[
\frac{\xi'(a)}p=C_a(\lambda J_a'+Kh')+D_aKh+
\frac{E_a}{\nu Kh},
\]
where
\[
C_a=\frac{v+(a+s)/\alpha}{a},\quad
D_a=\frac{-v+2\alpha+s/\alpha}{a^2},\quad
E_a=\frac{(a+s)(a^2+a+1)J_a'}{2\rho}.
\]
Here the derivative is with respect to the actual ordinary local parameter u=z−a. The first jet fixed its original residue l1=aKp/(THREE ρ). Hence the new second jet says
\[
C_a(\lambda J_a'+Kh')+D_aKh+\frac{E_a}{\nu Kh}
=-\frac{3(1-\rho^2)}{2aK}.
\]
This equation uses exactly the actual second coefficient, rather than a freely chosen derivative condition.

The coefficient C_a J_a′ is NONZERO. J_a′ is nonzero because J has two distinct roots and s≠ZERO. For a=ωs², α=−ω²s and the numerator of C_a is (ONE−ω)+(ONE−ω²)s. It can vanish only at s=ω, giving Δ=v²−v+ONE=s²+s+ONE=ZERO, contrary to the actual numerator-coprimeness open. Interchanging ω and ω² gives the analogous assertion at the other pole.

Thus ONE pole forces the unique value
\[
\lambda=\frac{-3(1-\rho^2)/(2aK)-C_aKh'-D_aKh-E_a/(\nu Kh)}{C_aJ_a'}.
\]
The other pole must give the SAME value. Equivalently compute the displayed rational expression in F25(v)[z]/(J), with α=ρ/z; its coefficient of z must vanish. All inverted terms are nonzero at both actual poles, and the full expression has no remaining λ. This is a strong ONE-variable compatibility condition, not yet an exclusion or an actual-map construction.
