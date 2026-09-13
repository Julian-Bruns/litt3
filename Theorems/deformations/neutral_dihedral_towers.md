# Actual neutral dihedral towers with unbounded finite Witt repair

Version1,2026-09-11. Independent bounded audit PASS by
/root/audit_actual_heisenberg_defect. Mathematical prose and exact
finite-algebra checks, not Lean verification.

Fix any of the FOURTEEN noncanonical quadratic resolvents D→C of
[explicit_non_galois_neutral_five](explicit_non_galois_neutral_five.md).
Retain that theorem's explicit F625 base pair, its canonical marked C2,
and its full original periodic data. Write E for the ordinary elliptic
quotient of D, choose an elliptic origin at a branch point, and let
E_a→E be its compatible iterated etale Verschiebung isogenies.

For a>=0 and q=5^a, form the actual curves

    W_a=D x_E E_a,       T_a=W_a/<tau>,       T_0=C,

where tau lifts the original free double involution using [-1] on E_a.
Then W_a→C is Galois with group C_q semidirect C2, with inversion
action. The maps W_a→D and T_a→C have degrees q and q respectively;
the latter is non-Galois when a>=1. Adjacent T_(a+1)→T_a maps are
finite etale of degree5. Their genera are2q+1 andq+1.

For EVERY a>=1 the actual Hodge defects and semilinear Fitting types are

| Curve | Defect | Bijective dimension | Nilpotent block lengths |
| --- | ---: | ---: | --- |
| W_a | 2 | 4q | q-1,q+1 |
| T_a | 1 | 2q-1 | q+1 |

Consequently all adjacent degree-five quotient maps are defect-neutral.

For every a>=0 the originally pulled-back marked T_(a,2) admits SOME
compatible extension through W_(a+2)(k). The source curve varies with a.
For a>=1 no compatible third truncation extends the ORIGINAL map
T_(a,2)→C2 to any compatible C3: the base obstruction is nonzero.

For every fixed a>=1, existence of a full compatible marked tower on
T_a is equivalent to existence on T_1 in the SAME resolvent tower.
The downward implication preserves the original quotient marking.
Neither existence nor nonexistence of such a full tower is asserted here.

This theorem does not equate the fourteen different T_1 cases, include
the excluded canonical resolvent, or construct a two-leg common source
for the fixed main/backup endpoints. It shows that fixed defect alone
does not bound finite source-only repair length across varying covers.

[Proof](../../Solutions/deformations/neutral_dihedral_towers.md) ·
[Audit](../../Research/audits/NEUTRAL_DIHEDRAL_TOWERS_AUDIT_2026_09_11.md).
