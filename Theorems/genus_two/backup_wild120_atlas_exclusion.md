# The backup excludes the conductor-two degree120 orbifold atlas

Version1,2026-09-10. Proved; fresh focused audit PASS by
/root/audit_backup_wild120_dictionary. Audited prose and exact ideal
calculation, not Lean verification.

Let C=C_alpha over bar(F5) be the specified genus-two backup

    v²=u(u-1)(u-2)(u-3)(u-alpha), alpha³+alpha+1=0.

There is no representable finite etale atlas C->S whose coarse map
has degree120, where S is a smooth proper effective orbifold with
coarse curve P1 and exactly these two stacky points:

- one wild point with inertia order20 and different exponent27;
- one tame point with inertia order3.

In particular, the backup small-wild cored row(120,20,27,3) is excluded.
Actual completions must be the same fixed-base Galois extension across
the wild fiber. An arbitrary rational map with matching numerical
ramification alone is not asserted to be excluded by this proof.

The proof gives a reusable necessary normal form on any genus-two
curve: a regular cubic section S*eta³, a rational primitive DR=S²,
and a shared scalar lambda with R(DS)^5=lambda(D²S)^5 on its zero
divisor. On C_alpha the three exhaustive polynomial charts all have
exact Groebner basis[1], over F125 and hence over its algebraic closure.
The slowest independent replay takes under five seconds internally;
no bounded coefficient-field point search or long atlas census is used.

This does not yet exclude the related degree240 row, whose cubic
section lies in a nontrivial two-torsion twist after an actual double.

[Proof](../../Solutions/genus_two/backup_wild120_atlas_exclusion.md) ·
[replay](../../scripts/genus_two/verify_backup_wild120.sage) ·
[audit](../../Research/audits/BACKUP_WILD120_DICTIONARY_AUDIT_2026_09_10.md).
