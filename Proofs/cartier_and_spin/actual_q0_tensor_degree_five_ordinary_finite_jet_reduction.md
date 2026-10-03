# Proof: compatibility of the two actual second jets

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_five_ordinary_finite_jet_reduction.md). [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

Use the complete ordinary parameter forms and the exact λ formula of the [second-jet proof](actual_q0_tensor_simple_infinity_second_jet.md). Evaluate it at a=ω(v−ONE)² and d=ω²(v−ONE)² over F25(v), with ω=ONE+TWO ν. These are the TWO actual ordinary pole coordinates. Their prescribed λ values must coincide.

The [new source](../../scripts/genus_two/oct03_q0_degree_five_second_jet_compatibility.py) calculates their difference for ε=±ONE. It asserts α²=a, the exact interpolation identity H(a)c(a)=a²J′(a)/ρ and the defining second-jet equation for each λ value. Every inverted term is recorded as a genuine nonzero ordinary-pole coefficient. It removes numerator factors only when supported on those explicit physical opens and checks every cleared denominator against them. It uses no Gröbner basis, root sweep or derivative-norm gate.

The [receipt](../../../litt3-computation-data/oct03_q0_degree_five_second_jet_compatibility/compatibility.json) records raw numerator vR+ in the positive case, with ONLY v removed; the negative case has exactly R− and no removed factor. Both residuals are the displayed monic polynomials. Both compatibility differences are NONZERO rational functions, so they define finite sets rather than an unconstrained family.

The single sequential worker completed BOTH cases in0.089578 mathematical CPU seconds, without timeout. A hard OS ten-CPU-second cap backed the Python timer. No settled input or completed earlier gate was replayed. The exact λ rational functions and the two full pole rows are preserved in the receipt.

Their degrees SEVEN and FOUR bound the number of possible geometric v-values by ELEVEN. All other actual-map conditions remain. In particular this is only a finite reduction of genuine same-source maps, not an existence or exclusion assertion for any residual parameter.
