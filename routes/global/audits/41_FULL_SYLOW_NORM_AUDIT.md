# Audit of file 41: full Sylow-seven norm dichotomy

- **Verdict:** PASS.
- **Auditor:** `/root/norm_polarization_refinement`.
- **Audited revision:** theorem text corresponding to SHA-256
  `39a525f6974570890a3ac9a91d63ae40117a4253034ebc7e729f1db5849664c2`
  after addition of the audit link.
- **Date:** 2026-09-04.

## Checks performed

The independent audit recomputed the group degrees and all genus formulas,
the full-norm and cyclic-quotient cases, the ranks contributed by the
cyclotomic modules, and the explicit sharpness model at (s=2,m=1).  It
also checked the splitting-field model and the claim that every order-seven
norm can be nonzero while the full Sylow norm is zero.

## Findings

No substantive issue was found.  The auditor made only precision suggestions:

- interpret the characteristic polynomial in the division algebra as the
  reduced characteristic polynomial;
- make the use of central idempotents explicit in the rational decomposition;
- note that the full norm is 
  \(|Q|\) times the quotient norm when passing through a stabilizer;
- state explicitly why (T^j-1) is invertible on the relevant nontrivial
  cyclotomic summands.

These are explanatory refinements, not changes to any conclusion.  The audit
also confirmed that the (s=2,m=1) example is a genuine representation-level
barrier and is not asserted to come from a curve.
