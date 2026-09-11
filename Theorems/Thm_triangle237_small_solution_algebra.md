# The remaining degree84 coefficient algebra has rank at most two

Version1,2026-09-11. Focused geometric audit PASS. This is a structural
bound, not an exclusion of the remaining maps.

Fix the backup C_alpha and one of its dormant potentials P over
K=F_(5^15). Use the normalized polynomials A18,B14,C6 and scale s of
triangle237_cofactor_necessary_system, with the FULL passport, both
derivative identities and horizontal equation. Impose the guards

    s*disc(C)*C(0)*C(1)*C(2)*C(3)*C(alpha) != 0.

Then:

1. These guards and equations force ALL other passport squarefree and
   disjointness conditions. Every geometric solution is an actual tame
   degree84 map on the specified backup, with the specified dormant P.
2. There are at most TWO normalized geometric solutions for this P.
   Every coefficient of every such solution lies in F_(5^30).
3. The guarded coefficient algebra over K is finite étale of rank0,1or2:
   it is 0,K,K×K,or F_(5^30). Its reduced Gröbner basis for a
   degree-compatible order has degree at most two.

The assertion applies after exact affine eliminations and adjoining
proved consequences. It does NOT apply to the larger system retaining
only C(0)!=0, and does not bound certificate degree or solver runtime.
Finite-field membership is a necessary constraint, not authorization to
replace a geometric search by an uncertified smaller-field search.

[Proof](../Solutions/Sol_triangle237_small_solution_algebra.md) ·
[Audit](../Research/audits/DEGREE84_DECORATED_FIELD_BOUND_AUDIT_2026_09_11.md).
