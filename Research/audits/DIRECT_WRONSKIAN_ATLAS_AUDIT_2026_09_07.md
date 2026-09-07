# Direct Wronskian atlas audit

- Verdict: accepted, conditional on the stated scalar reconstruction input.
- Auditor: fresh bounded agent `direct_wronskian_atlas_audit`.
- Date: 2026-09-07.
- Scope: [statement](../../Theorems/Thm_direct_wronskian_atlas.md) and
  [proof](../../Solutions/Sol_direct_wronskian_atlas.md), both infinity
  charts, Cartier complement, complement gauge, nonvanishing observation,
  and scaling criterion. This is a prose audit, not formal verification.
- Objections: none. Inverse Frobenius is correctly restricted to a fixed
  geometric point; the existing scalar gluing theorem is an input.
- Specific check: replacing eta by eta+t^48 g, with g regular at O,
  changes lambda by g(0)t^31 and V_0 by t^240 g^5 U. Since kappa=t^-17,
  the residual changes by U t^155(g^5-g(0)^5)-t^48 g, of valuation at
  least48 on both pole charts. Thus the local cocycle change includes
  the necessary lambda correction and leaves the test unchanged.
- Other checks: the local determinant is a unit; the pole111 cancellation
  for V_0 and pole112 cancellation for U have the stated coefficients.
  The nine-dimensional affine complement gauge and its unique affine-part
  normalization are valid. B_U=0 would split the quotient extension and
  contradict stability. The scale equation is d^3 B_U=A_U and has exactly
  three nonzero roots when the vectors are nonzero proportional.
- Evidence limitation: inspected the exact sample script and saved output;
  did not rerun them. Finite samples do not prove atlas nonexistence or
  resolve the original unmarked common-cover problem.
