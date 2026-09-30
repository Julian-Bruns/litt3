# Small supported norm functions and the next comparison pole

Version 1, 24 September 2026. On the fixed X:y^3=P(x), let g be a
nonconstant rational function whose only pole is O and whose zeros
are supported over the four roots of A. Then:

- Pole order ten is impossible.
- If the pole order is 3,6,9,12,15 or18, then g belongs to k(x).
- In particular every such function of pole order at most twelve
  belongs to k(x); at order twelve its zero multiplicities on the
  four base roots are three times a composition of four.

The second assertion uses the uniform infinity Cartier criterion and
a character comparison, with no support enumeration. Its endpoint
input is one 7x7 determinant. It replaces the455-case pole-twelve
calculation and extends the conclusion to poles fifteen and eighteen.
The order-ten exclusion still uses a286-case geometric cube test,
independently reconstructed in two implementations.

For an actual jointly minimal comparison of the specified embedded
lambda_X lines, Norm(z) has this support and pole order delta.
Combining the order-ten exclusion with the complete pole3,6,9
exclusions gives delta>=12. Thus line/tensor recognition holds for
all actual covering degrees at most eleven. At larger degrees these
are only norm restrictions; they do not construct or exclude a cover.

[Proof and retained independent evidence](../../Proofs/cartier_and_spin/small_supported_norm_functions.md).
