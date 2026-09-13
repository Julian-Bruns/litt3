# The selected actual neutral degree-five cover is obstructed at the fourth Witt level

Version1,2026-09-11. Full source replay by /root and bounded independent
geometric/local-frame audit PASS by /root/audit_neutral5_returned_w4.
Exact arithmetic and mathematical prose, not Lean verification.

Use the explicit genus-two pair over F625 in
[explicit_genus_two_witt_obstruction](../explicit_genus_two_witt_obstruction.md),
with t^4+4t^3+t²+4t+3=0 and its ORIGINAL canonical marked C2.
Choose the R=u(u-1) quadratic resolvent and its actual D10-monodromy
degree-five quotient h:T→C in
[explicit_non_galois_neutral_five](explicit_non_galois_neutral_five.md).
Retain the pulled-back marked T2 and the entire previous periodic tuple,
including the original nonsplit flat square-trivial line.

The compatible marked third lifts are exactly the established affine
line T3(b), b in k. In the normalization of the supplied obstruction_dual
row in neutral5_hyperelliptic_hodge.json, their next Hodge obstruction is

    epsilon_T(T3(b)) = 1+3t^3    for EVERY b in k.

This scalar is nonzero, with inverse 2+4t²+4t³. Consequently NONE of
these third lifts admits a compatible fourth Witt extension. No choice
of the fourth smooth curve digit repairs this failure. In particular,
the original marked T2 admits compatible third lifts but NO compatible
W4 lift and NO full compatible marked Witt tower.

The assertion is for this ONE resolvent and marking. It does not assert
that every connection on the underlying genus-six curve is obstructed,
or that the other thirteen neutral degree-five sources have this scalar.
It neither proves nor disproves general non-Galois full-tower descent
(N5), and it does not supply or exclude an unmarked common cover of the
fixed main/backup endpoints.

[Proof and exact replay](../../../Proofs/deformations/cyclic_descent/neutral_five_fourth_obstruction.md) ·
[Audit](../../../Research/audits/RETURNED_NEUTRAL5_W4_AUDIT_2026_09_11.md) ·
[Fresh replay receipt](../../../Research/computations/neutral5_w4_fresh_replays_20260911.json).
