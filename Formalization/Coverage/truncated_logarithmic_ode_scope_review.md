# Universal truncated logarithmic ODE

The terminal declaration is
`Litt3.CartierAndSpin.truncated_logarithmic_ode_solution` in
`Solutions/CartierAndSpin/TruncatedLogarithmicODE.lean`.
For every field `K`, prime natural number `p`, and literal characteristic
`p` structure on `K`, it constructs an actual unit `u` in
`AdjoinRoot ((Polynomial.X : K[X]) ^ p)` satisfying
`truncatedPolynomialDerivation K p u = AdjoinRoot.mk (X^p) F * u`,
provided the actual polynomial coefficient equality
`F.coeff (p-1) = (F.coeff 0)^p` holds. There is no degree condition on
`F` and no perfectness condition on `K`.

## Construction and mathematical scope

1. `TruncatedPolynomialDerivation` defines the actual quotient algebra
   and lifts the literal polynomial derivative. The ideal is stable
   because the derivative of `X^p` is zero in characteristic `p`.
   Neither a derivation nor ideal-stability conclusion is assumed.
2. `Definitions/CartierAndSpin/TruncatedODE.lean` gives a genuine
   well-founded recursion on natural numbers, starting at constant
   coefficient one. The next coefficient is the convolution of the
   preceding coefficients with `F`, divided by the next natural number.
   Only indices strictly below `p` are used in the resulting polynomial.
3. `TruncatedODELowerEquations` proves all equations below index `p-1`
   from that recursion. Denominators are precisely `1,...,p-1`; they are
   proved nonzero uniformly using primality and characteristic, without
   prime-specific enumeration or matrix computation.
4. `LogarithmicLaurentCoefficient` derives the logarithmic coefficient
   equality from the already constructed intrinsic Laurent Cartier
   operator and its forward logarithmic fixedness. It does not use a
   logarithmic converse, a connection kernel, or a solution of this ODE.
5. `LogarithmicPowerSeriesCoefficient` specializes this equality to
   literal full power-series units. Its final version removes coefficient
   perfectness using the actual injective map to the algebraic closure
   and coefficientwise compatibility of differentiation and extension.
6. `TruncatedODEObstruction` uses the actual unit power series with
   constant one represented by the recursively constructed polynomial.
   Its logarithmic derivative agrees with `F` below `p-1`. The universal
   logarithmic coefficient equality and the displayed hypothesis give
   agreement at `p-1` as well. Multiplication by this actual unit proves
   that the residual differential equation has every coefficient below
   `p` equal to zero.
7. `TruncatedLogarithmicODE` proves this residual lies in the actual
   ideal `(X^p)`, so the literal quotient equation follows. Its unit is
   genuine: `U-1` is divisible by `X`, whose image is nilpotent. This unit
   argument is additionally proved over arbitrary commutative rings.

The theorem proves a full truncated-algebra solution. It deliberately
does not itself assert a solution in the original field. That step
requires the actual p-basis Taylor scalar-extension representation and
descent of the resulting linear connection kernel; it belongs to the
separate `TaylorPBasisConnection` bridge. No field-level solution or
singularity is smuggled into this theorem's hypothesis.

All proof steps are symbolic in `p` and use actual polynomial, power
series, Laurent series and quotient constructions. The use of the
algebraic closure is solely an injective coefficient extension in the
forward logarithmic identity and is unrelated to a simultaneous Galois
closure of any source-cover diagram.

## Verification

`lake build Solutions.CartierAndSpin.TruncatedLogarithmicODE` passed on
3 October 2026. Focused transitive audit
`../litt3-computation-data/formalization-20261003/verification/20261003T071523Z/report.json`
passed for this root and 300 transitive Litt3 theorem declarations. The
only logical axioms were `Classical.choice`, `Quot.sound` and `propext`;
there were no forbidden dependencies or source changes during the check.
