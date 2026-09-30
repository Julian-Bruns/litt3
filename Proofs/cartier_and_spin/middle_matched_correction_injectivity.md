# Proof of global matched-correction injectivity

Use the [statement](../../Theorems/cartier_and_spin/middle_matched_correction_injectivity.md).
The original H tensor is the actual residual tensor in
[correction rigidity](middle_character_correction_rigidity.md); its
identification with the full Laurent Hom equations was checked there
and separately in the local continuation. We do not replace the
source coordinates by their finite-field values.

## Geometric covering and polynomial identities

If b0=b1=b2=0 and b!=0, the previously certified closed-boundary
theorem gives injectivity of all15 columns of H(b). In particular
its final seven columns Q(b) are injective.

Otherwise let j be the first nonzero index, with j in{0,1,2}. Scale
the homogeneous source block to bj=1 and put earlier coordinates
equal to zero. The remaining9-j coordinates are independent affine
variables. The new exact certificates give matrices Lj of polynomial
entries such that
\[
L_j(b)Q(b)=I_7.
\]
The maximum degrees are4,4,3 for j=0,1,2. The identities hold in
the polynomial rings over F25, so hold after every geometric
specialization. They use no determinant denominator or field-point
equation. Homogeneity transports injectivity back to the unnormalized
source block.

Multiplying Pp+QA=0 by L gives A=-LPp. Substitution gives the
displayed residual equation, and the reverse substitution proves
scheme equivalence. These two polynomial operations retain all
exceptional parameter values. For p=0 they force A=0. The actual
auxiliary reconstruction is unique, so a matched actual map with
these zero lower coordinates is zero.

## Compact evidence and independent verification

The tensor is
[residual_system.npz](../../../litt3-computation-data/remaining_structural_replies_20260925/extracted/character/middle_character/data/residual_system.npz).
The source
[inverse constructor](../../scripts/arithmetic/middle_polynomial_correction_inverse.py)
sets up an exact coefficient linear system for LQ=I. It saves that
coefficient solution before expanding any derived matrix. The three
compact certificates are
[stratum0](../../../litt3-computation-data/overnight_three_replies_20260926/middle_b0_correction_inverse4_checkpointed.linear.npz),
[stratum1](../../../litt3-computation-data/overnight_three_replies_20260926/middle_b1_correction_inverse4_checkpointed.linear.npz), and
[stratum2](../../../litt3-computation-data/overnight_three_replies_20260926/middle_b2_correction_inverse3_checkpointed.linear.npz).

Each stores the original tensor hash, normalized source index,
degree bound, selected original rows and exact F25 coefficient array.
The monomial ordering is ascending total degree followed by the
combinations-with-replacement enumeration in the source. Together
these data reconstruct L without a matrix solver.

The separate
[compact verifier](../../scripts/arithmetic/verify_middle_inverse_checkpoint.py)
reconstructs L and multiplies it by the original affine-linear Q
using explicit integer F25 tables and polynomial coefficient
addition. All49 entries are compared with I7. It does not call Sage,
a Groebner routine or the constructor's linear-system solver.
The executed receipts are
[stratum0](../../../litt3-computation-data/overnight_three_replies_20260926/verify_middle_b0_compact_inverse4.json),
[stratum1](../../../litt3-computation-data/overnight_three_replies_20260926/verify_middle_b1_compact_inverse4.json), and
[stratum2](../../../litt3-computation-data/overnight_three_replies_20260926/verify_middle_b2_compact_inverse3.json).

Reproduction: run the compact verifier on the tensor and each NPZ
checkpoint, supplying a separate --output receipt path. The script
requires Python and NumPy. Expanded polynomial matrices on strata1
and2 also passed the earlier independent substitution checker; those
larger expansions are not needed for this proof.

The new claim is only correction injectivity. The ongoing ideal
calculations for nonzero p, other character cases, and the target
extension condition are not used as proved inputs.
