# Proof: finite graded modules for mixed second-return loci

24 September 2026. The incoming
[report](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/originals/return/second_return_partial/REPORT.md)
retains the actual full nineteen-coordinate reconstruction, including
coefficient Frobenius. The tensor T has size19x80x35. Its specialized
matrix at z_i=xi_i^25 gives the actual Hom conditions, not just a
splitting type or a necessary quotient invariant.

For one indicated coordinate support, let S be its polynomial ring
and form the cokernel C of the rows of T(z) in S^35. The provided
finite graded computations prove C_4=0 or C_5=0, as appropriate for
that support. A homogeneous module generated in degree zero with
such a vanishing degree is zero on projective space: multiplication
propagates vanishing to all higher degrees, so its support is only
the irrelevant affine origin. Therefore T(z) has full column rank
at every nonzero geometric specialization. The map xi->xi^[25] is
surjective on geometric points and discards none of them.

Every retained graded certificate is checked by its exact rank
minor and the commutativity identities for the reduced quotient
actions. The verifier reconstructed all120 five-coordinate cases
and the six larger strata. It does not infer that a discovery basis
is a complete Groebner basis. All checks passed in
[the replay log](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/logs/return_replay.log).
The [source verifier](../../scripts/arithmetic/pro_cubic_returns_boundary_20260924/return/second_return_partial/verify.py)
and its graded-module implementation are retained locally.

The unchanged A,B,L,T,ADD,MUL,NEG,INV,Q arrays were separately
compared entry for entry with the previously rebuilt exact input
package; all agreed. Thus the focused replay did not need to repeat
the earlier full quotient construction. No geometric parameter was
restricted to a finite field. The theorem excludes these actual
second returns only; it is not a proof of full-family nonperiodicity.
