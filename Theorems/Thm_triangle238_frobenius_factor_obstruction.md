# Uniform (2,3,8) covers force an excluded intermediate map

Version1, 2026-09-09. Pro proof and exact certificates replayed by /root;
author-checked prose/computation, not a new independent audit or Lean proof.

Let C/bar(F5) be a smooth projective genus-two curve with Aut(C)=C2
and geometric moduli Frobenius orbit length at least three. If C admits
an ACTUAL finite separable tame degree-48 map to P1, with precisely the
three complete branch fibers of types

                         2^24, 3^16, 8^6,

then C has an actual intermediate map to P1 of at least one of the types

             degree24: (3,3,4),
             degree12: (2,2,2,3),
             degree16: (2,4,8).

The intermediate maps have the indicated COMPLETE uniform fibers and
no other branch points. No base change to another source is substituted.
The statement does not require Jacobian ordinariness or simplicity.

For the specified backup C_alpha all three alternatives are already
excluded. Thus it admits NO such degree-48 map over the full algebraic
closure, regardless of the coefficient field of the map. This removes
one backup cored profile, not all common covers. BACKUP_CANDIDATE.md
owns the remaining case list; the selected main pair is unchanged.

There are exactly77 labeled monodromy classes. Aut(C)=C2 excludes54;
21 have the displayed intermediate maps; only2 remain. A source with
moduli Frobenius orbit at least3 cannot occur among only2 possible covers.
Completeness is independently certified by exact character mass477/16,
computed in two ways over all147,273 partitions of48. Local replay3.7s;
C++ regeneration0.13s. No claim that all77 classes realize in char5.

[Proof](../Solutions/Sol_triangle238_frobenius_factor_obstruction.md) ·
[Exact replay](../Research/computations/triangle238_verification.txt).
