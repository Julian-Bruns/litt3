# The neutral degree-five first-repair line has constant next obstruction

Version1,2026-09-11. Focused independent audit PASS by
/root/audit_backup_cored_completion. Prose and exact local arithmetic,
not Lean verification. No obstruction value is asserted.

Use the actual R=u(u-1) cover h:T→C, canonical marked C2 and full
previous periodic data of
[explicit_non_galois_neutral_five](explicit_non_galois_neutral_five.md).
Write W for its D10 Galois closure and D for its quadratic resolvent.
Thus W→D is cyclic5, W→T is degree2, and the actual cyclic normal
cokernel is k[e]/e², e=sigma-1.

Let T3(b)=T3ref+xi+b*h*kC, b in k=bar(F5), be the COMPLETE affine
line of compatible marked third lifts, with xi and kC specified in
the linked theorem's solution. The fourth-level intrinsic obstruction
is independent of the parameter:

    epsilon_T(T3(b))=epsilon_T(T3(0)) for every b in k.

The same equality holds after pullback to the given etale doubles
W3(b)→T3(b). Therefore the geometric zero set of the fourth obstruction
on this line is either all of k or empty.

This theorem does NOT decide which alternative occurs. It proves no
compatible W4 lift, no full compatible tower, and no counterexample
to non-Galois full-tower descent. It applies to this selected actual
cover and marked input, not every neutral degree-five cover.

[Proof](../../Solutions/deformations/neutral_five_fourth_parameter_independence.md) ·
[Audit](../../Research/audits/NEUTRAL5_PARAMETER_INDEPENDENCE_AUDIT_2026_09_11.md).
