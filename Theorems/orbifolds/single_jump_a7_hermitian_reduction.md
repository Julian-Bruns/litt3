# A single-jump wild orbifold is the alternating Hermitian quotient

Version1, 2026-09-10. Fresh focused audit PASS by
`/root/audit_a7_small_wild_reduction`; audited prose, not Lean verification.

Let k be algebraically closed of characteristic five. Let S be a smooth,
proper, connected effective Deligne--Mumford curve admitting a finite
etale atlas by a smooth projective scheme curve. Suppose its coarse
curve is P1 and it has exactly two stacky points:

- one wild point with inertia order20 and different exponent23;
- one tame point with inertia order7.

Then S is isomorphic over k to [H/A7], for an actual subgroup
A7 < PSU_3(5) acting on the Hermitian genus-ten curve H. Consequently
there are actual representable finite etale maps

    S -> [H/PSU_3(5)] -> [H/PGU_3(5)]

of degrees50 and3. In particular, EVERY curve atlas of S is a
Hermitian-orbifold atlas; this conclusion is independent of its genus
or the degree of that atlas.

The specified backup C_alpha therefore cannot be an atlas of S.
This excludes its small-wild cored row

    (n,e,delta,d)=(280,20,23,7),

using the already completed all405-pair Hermitian-atlas certificate.
It does NOT assert that numerical ramification and different alone make
an arbitrary rational map an orbifold atlas. Actual local Galois
extensions, common to every point in the branch fiber, are essential.

[Proof](../../Solutions/orbifolds/single_jump_a7_hermitian_reduction.md) ·
[finite arithmetic check](../../scripts/orbifolds/check_a7_wild_profile.py) ·
[audit](../../Research/audits/A7_SMALL_WILD_REDUCTION_AUDIT_2026_09_10.md).
