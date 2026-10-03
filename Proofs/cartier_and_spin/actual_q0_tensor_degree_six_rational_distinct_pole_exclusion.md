# Proof: all fifteen factor choices fail the original ordinary residues

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_rational_distinct_pole_exclusion.md). This is a new bounded necessary first-jet calculation. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

The [complete rational distinct-pole form](actual_q0_tensor_degree_six_rational_distinct_pole_form.md) already excludes pure µ6 transversals by the actual joint-field equality. In every mixed case use Q+=λ,Q−=−λω,−λω², S+=t−λ,S−=t²−λt+λ² and a monic quadratic factor U of t6−ONE, with V=(t6−ONE)/U. There are exactly FIFTEEN U choices. Each independent first-copy sign ε gives K=ελ³−ONE and the TWO necessary original-residue equations
\[
E_s=\lambda U(\lambda)(s-\lambda)V(s)-4\nu K^2sS_-'(s)=0,
\quad s=-\lambda\omega,-\lambda\omega^2.
\]
Their coefficient field is F25,ν²=ν+THREE,ω=ONE+TWO ν. They already use the exact fixed-tensor first jet to eliminate the multiplicative factor a=TWO Kp/[λU(λ)],p²=ν. They are not free local residue choices or arbitrary separable-map conditions.

The [new source](../../scripts/genus_two/oct03_q0_degree_six_rational_distinct_first_jet_gate.py) derives both E_s for EVERY two-root U and BOTH ε. It asserts UV=t6−ONE and the exact S− pole factorization. It computes the univariate extended gcd of the TWO equations and asserts the recorded Bezout combination equals that raw gcd. It then removes factors supported only on the explicit genuine opens
\[
\lambda K U(\lambda)V(-\lambda\omega)V(-\lambda\omega^2)\ne0,
\]
and the two own-triple-pole leading numerators
\[
4\nu K^2+\lambda^2U(\lambda)^2\ne0,\quad
4\nu K^2U(0)^2+U(\lambda)^2\ne0.
\]
These leading conditions come from the actual x2 pole at infinity and x1 pole at ZERO, as derived in the normal-form proof. They do not remove the allowed leading cancellation of x1 at its OTHER pole. No λ6−ONE open is added: a valid µ6 coincidence is retained exactly when its opposite factor remains nonzero.

The [receipt](../../../litt3-computation-data/oct03_q0_degree_six_rational_distinct_first_jet_gate/gate.json) has THIRTY completed cases. Every raw gcd divides a power of the recorded physical polynomial, and its physical residual is ONE. Every executed Bezout identity is true. The full raw gcd, removed factors, opens, equations and weights are preserved for each root-index pair and sign; no factor is removed merely because its parameter looks inconvenient.

All THIRTY cases completed sequentially in0.066448 mathematical CPU seconds, without timeout. A hard OS ten-CPU-second cap backed the Python timer. No norm-square calculation, Gröbner basis, finite point sweep or older completed gate was used.

Hence no rational degree-SIX model with THREE distinct ordinary pole coordinates survives its TWO actual first-jet equations. The repeated-coordinate rational configuration is covered separately by the [paired-pole exclusion](actual_q0_tensor_degree_six_rational_conjugate_pole_exclusion.md), not by this gate. Both original maps stay on their actual original source throughout.
