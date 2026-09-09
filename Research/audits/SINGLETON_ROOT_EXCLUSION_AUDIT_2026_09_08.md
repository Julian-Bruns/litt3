# Singleton root exclusion: bounded mathematical audit

Auditor: `/root/audit_singleton_root_exclusion_medium`.
Date: 2026-09-08.
Verdict: **PASS for the geometric reduction and the three exhaustive
necessary-condition systems. Full exclusion is conditional on exact unit
certificates being extracted and replayed.** No substantive mathematical
objection found. This auditor performed read-only reasoning and no solver
or certificate computation, under the one-core resource policy.

Reviewed: `Research/SINGLETON_ROOT_EXCLUSION_DRAFT.md`,
`scripts/probe_singleton_norm.sage`, the canonical statement and proof of
`singleton_cartier_theta_bound`, and the statement of
`backup_raynaud_quadric`. The quadric is not needed by this norm proof.

## Checks needed for the surprising stronger scope

1. For geometric `m=Fr_J^{-1}(M)=[D-2O]`, relative curve Frobenius pulls
   the rational frame of `O(D^(1)-2O^(1))` back to a frame with divisor
   `5D-10O`. Consequently `eta/h` represents a twisted canonical section
   with divisor `2P` precisely when `div(h)=5D-2P-8O`. This is compatible
   with `V Fr_J=[5]`; no prime-to-five hypothesis is used. The Cartier
   kernel is the ordinary rational Cartier kernel in this frame.
   For nonbranch P the twisted canonical space is one-dimensional, so
   theta membership forces this particular section into that kernel.

2. Riemann--Roch supplies an effective degree-two D. The function
   `n=h(u-b)^2` has divisor `5D+2 iota(P)-12O`. If D avoids O its exact
   pole order is 12, giving monic degree-six A after scaling and
   `deg B<=3`. If `D=Q+O`, `Q!=O`, its exact pole order is 7, forcing
   `deg A<=3` and degree-one B with nonzero leading coefficient. The
   excluded `D=2O` would give `2P~2O`, impossible for nonbranch P.

3. Taking norms gives `(u-b)^2 R^5`, with the indicated degree of R;
   scalar absorption is legitimate over the algebraic closure. Thus
   `eta/h=(A/v-B)du/R^5`. The B term is Cartier-zero because `deg B<=3`;
   `A/v=AF^2/v^5`. The only possible Cartier coefficients are those of
   degrees 4, 9, 14 in `AF^2`. Multiplication by rational fifth powers
   and scalar normalization preserve the zero condition. This checks
   the actual twisted Cartier condition, not an untwisted replacement.

4. When D avoids P and O, n is nonzero at P and zero at its distinct
   conjugate, whence `A(b)!=0`. For `D=Q+O`, Q cannot equal P: orders
   at least five and two on the two sheets would imply that both A and
   B are divisible by `(u-b)^2`, contradicting degree-one B. This also
   proves `A(b)!=0` on that boundary. It remains valid if D contains
   `iota(P)` or another branch point; none is incorrectly discarded.

5. If D avoids O and contains P, the same two-sheet argument allows
   division of both A and B by `(u-b)^2`, including `D=2P`. The resulting
   norm is the monic polynomial `(u-b)^3 (u-x(Q))^5`. Expanding it gives
   exactly the seven coefficient conditions in the draft and script.
   The saturation `z F(b)=1` imposes precisely the required nonbranch
   condition here. In the other charts `z A(b)=1` is necessary; omission
   of further geometric restrictions only enlarges the solution set.

6. Direct coefficient comparison also checks all ten open-chart norm
   equations and all six O-boundary norm equations. The script imposes
   the original Cartier conditions by a kernel basis in the first two
   charts and explicitly in the third. Its basis-dimension assertions
   are runtime checks, not audited numerical outputs here.

No additional chart is needed. Therefore verified unit identities for
these exact systems imply exclusion of every nonbranch geometric
`(P,M)` in the proposed statement, including M with five-primary part.
The residual length-sixteen divisor can then have support only at the
forced Weierstrass/nonzero-kernel points. This support conclusion is a
consequence, not an input to the argument; it makes no assertion about
the distribution of multiplicities among those points.

This audit does not independently certify the diagnostic Groebner
outputs, audit the earlier degree-sixteen theorem in full, or establish
any common-cover exclusion. Both actual finite etale legs remain part
of the original unsolved problem.

## Root completion receipt,2026-09-08 06:02 CEST

This paragraph is by /root, NOT an additional auditor verdict. The
reviewed draft is now the canonical
[superseding family statement](../../Theorems/Thm_family_singleton_root_exclusion.md) and
[superseding family proof](../../Solutions/Sol_family_singleton_root_exclusion.md).
This historical audit concerned the former specialized proof, NOT that
new argument; the family has its own separately linked2026-09-08 audit.
The specialized proof, scripts and certificates below were removed after
the general audit PASS, and remain recoverable in Git. Their hashes here
are historical evidence, not an instruction to reopen or recreate them.
Statement SHA256:652977a96a22c1f7e86be21efe1fbea9bd1764ddc4a1eb25382ad56a66221b78.
The corrected source is scripts/backup_singleton_root_exclusion.sage.
Its default replay checks full Cartier kernels against the ORIGINAL
matrix before constructing either parametrized chart. Generic matrix
arithmetic replaces the failed default backend. All three corrected
original polynomial unit identities replayed PASS in0.535s total,
with a negative mutation check and no polynomial solver. Source and
geometric equations agree with the audited draft. The obsolete draft
and probe were removed, not retained as alternative entry points.

Corrected certificate SHA256 values (Research/computations):

- singleton_norm_open.json:3e0b75158d7c5fd17fb004e2da2cdae84a7b166e14db6bedb1bf0f5173f02d52
- singleton_norm_contains_O.json:7a9f7a06e3432e21ee3de61e1f0451f9be37e23d535dbcbddc40c02ff83554ad
- singleton_norm_contains_P.json:89e9e7f697c04f5007ad57e55ce4224dcd888644ac19ffc27eb4f45ac55aea75

## Pre-promotion correction reported by root

Root subsequently tested the matrix-kernel parametrizations against the
original Cartier matrix and found that the default dense implementation
over the chosen non-Conway GF(125) returned a purported right-kernel
basis whose product with that matrix was NONZERO. Explicit replay
assertions added to `scripts/backup_singleton_root_exclusion.sage` failed.
Thus the earlier open and O-boundary parametrizations do not represent
the required full Cartier kernels, and their unit outputs, even with
valid identities for their entered polynomials, are **not evidence for
exclusion of the complete geometric charts**. The basis-dimension checks
mentioned above were insufficient.

The PASS applies to the geometric reduction and written coefficient
systems, conditional on a correct, complete parametrization of those
Cartier kernels. Before either affected chart can support exclusion,
its basis must be recomputed using a reliable implementation, checked
against the original matrix, checked for completeness by dimension/rank,
and its resulting unit certificate regenerated and replayed. Root plans
to use `implementation='generic'`; this audit has not verified that repair.
The P-boundary system imposes Cartier equations directly and does not
use the defective kernel calculation. Root reports that no exclusion
theorem was promoted and that the earlier theta/quadric results are
unaffected (the quadric kernel calculations already use the generic
implementation). No additional computation was performed by this auditor.
