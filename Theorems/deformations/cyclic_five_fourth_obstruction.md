# The selected defect-growing cyclic-five cover has no fourth lift

Version1,2026-09-11. Six fresh complete replays and focused independent
geometric audit PASS. Prose and exact arithmetic, not Lean verification.

Use the original marked genus-two/F625 pair of
[explicit_genus_two_witt_obstruction](explicit_genus_two_witt_obstruction.md),
t^4+4t^3+t²+4t+3=0, mu=4+4t, z=u²/v and eta=du/v.
The actual connected cyclic-five cover h:T→C has

    w_U^5-H w_U=v Q(u),       H=3t²+t+3,
    w_O=w_U-(z^-3+t z^-1),
    Q=u^5+(3t+3)u^4+(t²+4t+3)u^3+(3t²+4t+1)u²
        +(3t²+3t+3)u+t²+4t+2.

Its smooth projective source has genus six and defect two. Retain the
original pulled-back marked T2 and full periodic tuple. Its compatible
third lifts are exactly T3(d,b), (d,b)∈k², specified by the particular
repair and two kernel vectors in the linked primary input data.

In the normalization row0=Lambda_C*Tr_h, with
Lambda_C=(3t²+t+1,3t+4,3), the next obstruction satisfies

    E0(d,b)=4+2t+2t²+4t³=3/mu ≠0   for EVERY (d,b)∈k².

The scalar's inverse is3+3t. At the supplied particular repair the
complete pair is E(0,0)=(3/mu,0); constancy of E1 is not asserted.
No compatible third lift has any compatible fourth extension.

Consequently H(T)=3, where H is the maximum compatible marked Witt
length extending the original W2 data. More generally, for every actual
cyclic degree-5^a refinement T_a→C whose degree-five quotient is this h,

    H(T_a)=a+2,       a≥1.

This is a statement about these marked tuples and covers, not other
connections on their curves or unmarked common covers.

[Proof and replay](../../Solutions/deformations/cyclic_five_fourth_obstruction.md) ·
[Primary data](../../Research/computations/cyclic5_small_field_fourth_inputs.json) ·
[Fresh receipts](../../Research/computations/cyclic5_w4_fresh_replays_20260911.json) ·
[Audit](../../Research/audits/CYCLIC5_FOURTH_LIFT_AUDIT_2026_09_11.md).
