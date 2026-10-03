# Proof: all eighty cubic-factor systems fail their exact residues

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_seven_balanced_pole_exclusion.md). [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

The [complete degree-SEVEN rational form](actual_q0_tensor_degree_seven_one_triple_rational_form.md) retains exactly TWO balanced orientations:
\[
S_+=(t-\lambda)(t-\zeta\lambda),\quad
S_-=(t+\lambda)(t+\zeta'\lambda),\quad
\{\zeta,\zeta'\}=\{\omega,\omega^2\}.
\]
For EVERY monic cubic factor U of t6−ONE retain V=(t6−ONE)/U, and retain both ε=±ONE. There are TWO×TWENTY×TWO=EIGHTY cases. Put A=λ,K=ελ³−ONE,C=S−(A)U(A). Exact residue calibration gives
\[
c=2ApK S_+'(A)/C,\qquad p^2=\nu.
\]
The remaining THREE exact original first-jet equations are ONE other-plus equation
\[
A S_+'(A)S_-(T)U(T)-T S_+'(T)C=0,\quad T=\zeta\lambda,
\]
and TWO minus equations
\[
C S_+(S)V(S)-4AS\nu K^2S_+'(A)S_-'(S)=0,
\quad S=-\lambda,-\zeta'\lambda.
\]
These are the fixed original tensor's prescribed residues, not freely chosen local residues.

The [new source](../../scripts/genus_two/oct03_q0_degree_seven_rational_balanced_first_jet_gate.py) derives all THREE polynomials over F25[λ], asserts the TWO pole factorizations and UV=t6−ONE, and computes their exact iterative extended gcd. It records THREE Bezout weights and asserts their combination equals the raw monic gcd. It localizes only at λK, U(A),U(T),V(−λ),V(−ζ′λ), together with the TWO actual own-triple leading numerators from the form proof. Explicitly, if N=FOUR ν A²K²S+'(A)², these are
\[
N+C^2\ne0,\quad
N[S_-(0)U(0)]^2+C^2S_+(0)^2\ne0.
\]
These are actual pole conditions, including the residue denominators. No λ6−ONE open is imposed, and the other-map infinity leading cancellation is retained. Repeated removal of raw gcd factors dividing the physical polynomial is exact saturation in this univariate setting.

The [executed receipt](../../../litt3-computation-data/oct03_q0_degree_seven_rational_balanced_first_jet_gate/gate.json) contains EIGHTY completed cases with their equations, physical opens, raw gcds, THREE Bezout weights and removed factors. Every asserted raw identity passed, and every physical residual gcd is ONE. The sequential calculation completed in0.130762 mathematical CPU seconds, without timeout, under a hard ten-CPU-second OS guard. No norm, Gröbner computation or root sweep was performed.

Consequently no physical balanced model satisfies its THREE prescribed residues. This excludes the entire stated allocation while retaining BOTH original maps and any original Y-leg on their SAME source.
