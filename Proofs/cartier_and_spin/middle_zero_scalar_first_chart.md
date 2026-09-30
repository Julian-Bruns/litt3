# Proof of the normalized zero-scalar chart exclusion

[Statement](../../Theorems/cartier_and_spin/middle_zero_scalar_first_chart.md).
The identification of the retained tensor with the actual Laurent
lifting equations is the accepted input from
[correction rigidity](middle_character_correction_rigidity.md).
Its file SHA-256 is
34a68016e3d0cb28d3ac40632d1d491f17f7f5717bbe785e4f7b8acc44a8f2b3.

Since H is homogeneous linear in b, divide every source coordinate
by b2. Put R=F25[b3,...,b9] and M=rows_R H(0,0,1,b3,...,b9).
Two exact computations establish M=R^15.

The [first construction](../../scripts/arithmetic/prepare_middle_module_idealization.py)
forms I=(H*v, v_i*v_j for0<=i<=j<15) in R[v0,...,v14]. The degree-one
part in v is exactly M. The msolve F4 basis consists of the fifteen
v_i and the defining polynomial a^2+4a+2 for F25. Its
[executed receipt](../../../litt3-computation-data/overnight_three_replies_20260926/msolve_idealization_middle_b2.json)
and [exact basis](../../../litt3-computation-data/overnight_three_replies_20260926/msolve_idealization_middle_b2.gb)
are retained. This is ordinary ideal membership. Radical membership
would hold automatically for this square-zero ideal and is not used.

The [independent direct computation](../../scripts/arithmetic/middle_direct_module_check.py)
instead works with the original thirty module generators over F25,
without v-variables, idealization or radical operations. Singular
computes a module standard basis of fifteen vectors. They form a
constant unit-triangular basis, and reduction of every standard basis
vector is zero. The complete basis, fifteen zero remainders, tensor
hash and executed outcome are in the
[direct receipt](../../../litt3-computation-data/overnight_three_replies_20260926/direct_module_middle_b2.json).
The independent run completed successfully in6590.33 seconds. Both
methods apply over the full polynomial coefficient ring, not a point
sample. No separate expanded polynomial left inverse is claimed.

For reproduction, run the direct source under Sage with the retained
original `residual_system.npz`, `--source-stratum 2`, and a new
`--output` path. The exact tensor is linked from the correction-rigidity
proof. The idealization source and msolve command are separately
retained in the first receipt. Source parameters are never restricted
to finite-field rational values.

Full row generation gives a polynomial left inverse existentially.
Specializing at any geometric source value therefore preserves
injectivity of H. Homogeneity returns the result to b2!=0 without
normalizing any other parameter. No implication for b0 or b1 nonzero
follows from this calculation.
