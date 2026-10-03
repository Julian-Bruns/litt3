# Proof: the three exact second jets have no common parameter

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_ordinary_quintic_exclusion.md). This is a fresh bounded necessary-jet calculation, not a replay. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

Use the complete actual four-model theorem, with J=z³−ρ²,K=ερ−ONE,c=z²+σz+ρk,b=kz²+ρz+ρσ,k²=TWO σ−ONE, and ℓc=THREE ρKz modulo J. It gives
\[
Y^2=z[\nu\ell^2+(z-1)J],\qquad
\xi/p=k\ell/z+(Y/p)(z+\sigma)/z^2.
\]
The THREE actual ordinary pole sheets satisfy Y(a)=ρpℓ(a)/a. Their p9-scaled first-jet residues are l1=aKp/(THREE ρ). The exact second-jet lemma has BOTH B coefficients equal to−ν, independently of ε. Therefore the derivative of ξ at each pole must satisfy
\[
\xi'(a)/p=-3(1-\rho^2)/(2aK).
\]

Differentiate the displayed ξ and Y² directly before reducing. With a³=ρ² the ℓ′ coefficient is
\[
k/a+(a+\sigma)/\rho=c(a)/(\rho a).
\]
The ℓ coefficient is−k/a²+TWO/ρ+σ/(ρa). Since TWO=−ONE/TWO in characteristic FIVE, it equals−k/a²−ONE/(TWO ρ)+σ/(ρa). The remaining term comes from the derivative of (z−ONE)J in Y². Thus the exact necessary equation at each root of J is
\[
\frac{c(a)}{\rho a}\ell'(a)+
\left[-\frac{k}{a^2}-\frac1{2\rho}+\frac\sigma{\rho a}\right]\ell(a)
+\frac{(a+\sigma)(a-1)J'(a)}{2\nu\rho\ell(a)}
+\frac{3(1-\rho^2)}{2aK}=0.
\]
All divisions are legitimate at the genuine ordinary poles: ρ,K,c(a),ℓ(a),a are nonzero. The unique ℓ is quadratic and its ordinary derivative is taken with ρ fixed.

Compute this rational expression in F25(ρ)[z]/J. Its THREE coefficients must vanish, because the THREE pole coordinates are distinct. This reduction does not infer any value of ρ from local inertia alone and does not impose an artificial common derivative.

The [new source](../../scripts/genus_two/oct03_q0_degree_six_quintic_second_jet_gate.py) does exactly that for σ=±ONE and ε=±ONE, taking k=ONE or FOUR ν+THREE. It asserts both calibrated polynomial identities, M=J(z²+z+ONE), the exact defining ℓ congruence and its equivalent ℓb congruence. It records the THREE numerator equations, every physical inverted term, and a Bezout combination giving their raw monic gcd. All cleared denominators are checked against the genuine opens ρ,K,Norm(c modulo J),Norm(ℓ modulo J).

The [receipt](../../../litt3-computation-data/oct03_q0_degree_six_quintic_second_jet_gate/gate.json) records raw gcd ONE in ALL FOUR cases. Each saved Bezout identity is asserted exactly; NONE requires physical-factor removal. Thus no parameter on the genuine ordinary-pole open can satisfy these necessary second jets. No quintic smoothness open is used, so singular elliptic shared-root auxiliary normalizations remain included.

The single sequential worker completed ALL FOUR cases in0.101438 mathematical CPU seconds, without timeout. A hard OS ten-CPU-second cap backed the Python timer. This calculation uses no ramification norm, Gröbner basis, factor/root sweep or completed earlier calculation.

This closes exactly the stated distinct-ordinary quintic stratum. Other degree-six alternatives remain separate; no original Y-map is asserted to descend to a coarse curve or an auxiliary model.
