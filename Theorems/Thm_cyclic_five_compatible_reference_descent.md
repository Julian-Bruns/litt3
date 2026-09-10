# One extra Witt digit recovers a cyclic-five map when the lower reference is compatible

Version2,2026-09-10. The two positive cases and their focused medium
audit are unchanged. This version updates the historical limitation:
the separate deck-translate argument now proves uniform D5 in
[cyclic_five_delayed_descent](Thm_cyclic_five_delayed_descent.md).
This proof remains a prerequisite, not an invocation of that theorem.
Not Lean verification.

Work over k=bar(F5), W_n=W(k)/(5^n), with the following actual curves
and projective filtered data. For t^5-t!=0 put

    G=u(u-1)(u-2)(u-3), F=G(u-t), Y:v²=F, eta=du/v,
    A=(t+1)²G, a=A/F², r=3a''/a+(a'/a)².

The active connection r on Y is indigenous-ordinary. Let C→Y be the
bad etale double with k(C)=k(u,kappa,gamma),

    kappa²=u(u-3), gamma²=(u-1)(u-2)(u-t), v=kappa*gamma.

Let Y1→Y be a connected cyclic-five etale cover and T=C×_Y Y1,
h:T→C the ORIGINAL degree-five map. Assume the actual pulled-back
connection on T has defect two. Retain the full previous filtered
Higgs--de Rham tuple, its graded identification and the actual flat
square-trivial twist pulled from O(W_t-O). Compatible W_n curves mean
that these data extend through W_(n-1).

Use the actual cohomological normal form supplied by this construction:
V_C=H1(C,T_C) has a five-dimensional bijective Psi part and a zero
line. With R=k[e]/e^5, e=sigma-1, V_T is free of rank six over R;
its semilinear Fitting parts have ranks five and one, with nilpotent
operator e²u(e)Frob, u a unit. Coefficient Frobenius fixes e. In
normalized source and target bases,

    ker Psi_T=e³R, coker Psi_T=R/e²,
    h*(ker Psi_C)=k e^4.

The commuting double involution tau acts as -1 on both defect spaces.
These are hypotheses about the actual cohomology and operators, not
substitutes for the actual curves or maps.

1. Start with the canonical marked C2 and its lifted cover T2→C2.
   If the GIVEN T2 has a compatible W4 extension T4, its GIVEN W3
   truncation T3 admits an etale map to a compatible C3 extending h.

2. More generally let n>=2 and start with compatible C_n and the
   pulled-back T_n→C_n. Suppose the GIVEN T_n extends compatibly to
   T_(n+2). For n>=3 assume in addition that SOME compatible
   C^0_(n+1) extending C_n exists. Then the GIVEN T_(n+1) admits an
   etale map to a compatible C_(n+1) extending the specified map over
   W_n. The full previous tuple, graded identification and twist match.

The conclusion does not assert that T_(n+2) itself descends, or that
C→Y lifts. The extra existence hypothesis in Part2 is automatic at
n=2 by the canonical reference. The proof here does not establish it
at later levels. That additional implication, full-tower descent and
the scoped main C10 exclusion are proved by the separate theorem above.

[Proof](../Solutions/Sol_cyclic_five_compatible_reference_descent.md) ·
[Scoped audit](../Research/audits/D5_TWO_DIGIT_DESCENT_AUDIT_2026_09_10.md).
