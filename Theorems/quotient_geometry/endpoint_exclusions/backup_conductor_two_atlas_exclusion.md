# Conductor-two atlas exclusions on the genus-two backup

Version2,2026-09-14. Proved by the normal form below and exact polynomial
ideals; the geometric dictionary and its double-cover transfer are audited.

Let C over bar(F5) be

    v²=u(u-1)(u-2)(u-3)(u-alpha),     alpha³+alpha+1=0.

There is no representable finite etale atlas C->S to a smooth proper
effective orbifold with coarse curve P1 and exactly one wild and one tame
stacky point having either profile

| Coarse degree | Wild inertia | Wild different | Tame inertia |
|---|---|---|---|
| 120 | 20 | 27 | 3 |
| 240 | 40 | 47 | 6 |

**Necessary normal form.** On any smooth genus-two curve v²=F(u) in
characteristic5, with F a monic quintic, O=infinity, eta=du/v and D=v*d/du,
either atlas produces a two-torsion line kappa, a section
s=S*eta³ of omega_C³ tensor kappa with reduced zero divisor, and

    R in L(15O),     lambda!=0,
    DR=S²,          R*(DS)^5=lambda*(D²S)^5 at finite zeros of s.

For degree120, kappa is trivial. For degree240 it is the class of the
actual etale double obtained by adjoining the square root of the coarse
function. Interpret S on that double when kappa is nontrivial. These
identities use the common fixed-base Galois completion at the wild fiber.

The proof expresses this normal form uniformly for all16 two-torsion
lines. On the displayed C, its32 exhaustive coefficient charts have
31 unit ideals and one ideal containing lambda. This excludes solutions
over the full algebraic closure. Numerical ramification data without
the actual atlas and its common local extension are insufficient.

[Proof](../../../Proofs/quotient_geometry/endpoint_exclusions/backup_conductor_two_atlas_exclusion.md) ·
[verifier](../../../scripts/genus_two/verify_backup_conductor_two.sage).
