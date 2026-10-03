# Proof: both paired-pole orientations fail the exact first jet

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_rational_conjugate_pole_exclusion.md). [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

The [complete conjugate-pole form](actual_q0_tensor_degree_six_rational_conjugate_pole_form.md) retains Q+=λ and Q−=−λ,−ζλ, where ζ is either primitive cube root ω orω². Set S+=t−λ,S−=(t+λ)(t+ζλ),ρ=λ³ and K=ελ³−ONE. The two independent first-copy signs ε are retained. The exact product F+F−=t6−ONE gives
\[
F_+=aS_-U/S_+,\quad F_-=a^{-1}S_+V/S_-,\quad UV=t^6-1,
\]
with U,V monic of degrees TWO,FOUR. All FIFTEEN quadratic factors U are covered. The exact original first-jet residue at λ makes a=Kp/[λ(ONE+ζ)U(λ)], with p²=ν and ν²=ν+THREE. Each negative-cube pole s therefore imposes
\[
E_s=\lambda(1+\zeta)U(\lambda)(s-\lambda)V(s)-2\nu K^2sS_-'(s)=0,
\quad s=-\lambda,-\zeta\lambda.
\]
These are equations for the fixed original tensor, not adjustable residues of arbitrary maps.

The [new source](../../scripts/genus_two/oct03_q0_degree_six_rational_conjugate_first_jet_gate.py) derives every equation over F25 for the TWO ζ choices, FIFTEEN U choices and TWO ε choices. It asserts UV=t6−ONE, computes the exact univariate extended gcd of the TWO equations and asserts its recorded Bezout combination. The allowed localization is precisely the genuine pole conditions
\[
\lambda K U(\lambda)V(-\lambda)V(-\zeta\lambda)\ne0,
\]
together with the two actual own-triple-pole leading numerators
\[
\nu K^2+\lambda^2(1+\zeta)^2U(\lambda)^2\ne0,\quad
\nu\zeta^2K^2U(0)^2+(1+\zeta)^2U(\lambda)^2\ne0.
\]
Their derivation is in the form proof. No λ6−ONE open is imposed, and cancellation of x1's leading term at its OTHER triple pole is retained. Saturation removes only factors dividing powers of the displayed physical polynomial.

The [executed receipt](../../../litt3-computation-data/oct03_q0_degree_six_rational_conjugate_first_jet_gate/gate.json) preserves all SIXTY equations, opens, raw gcds, exact Bezout weights and removed factors. Its raw gcd degrees are TWO in TWELVE cases, FOUR in THIRTY-SIX cases and SEVEN in TWELVE cases. In every case the physical residual gcd is ONE; every raw Bezout identity was asserted successfully. All SIXTY cases completed sequentially in0.131182 mathematical CPU seconds, without timeout, under a hard ten-CPU-second OS limit. No norm, Gröbner computation or point search was used.

Thus no physical parameter can satisfy both original residue equations, excluding the entire stated rational conjugate-pair stratum. Both actual maps and any original Y-leg stay on their SAME source. This is not a claim about the other degree-SIX infinity profiles or cubic root index ONE.
