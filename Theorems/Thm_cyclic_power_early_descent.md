# Uniform early descent and full towers for cyclic powers of five

Version1,2026-09-10. Proved; fresh focused geometric audit PASS by
/root/audit_uniform_early_comparison. No coefficient correction needed.
Audited prose, not Lean verification. Exact local checks also PASS.

Let k=bar(F5), a>=4, q=5^a, and h:T->C an ACTUAL connected finite
etale cyclic-q cover of smooth projective curves, g(C)>=2. Retain the
active admissible nilpotent projective connection on C, its full
weight-one maximal-Higgs periodic tuple, prescribed projective graded
identification and actual square-trivial flat periodicity line. Upper
special-fiber data are the original pullbacks. A compatible W_j curve
means that specified full tuple is carried through W_(j-1).

Assume Psi_C has a bijective part of dimension3g(C)-4 and one zero
line, and dim ker Psi_T=2. Use the actual integral deck/cochain inputs
of the preceding cyclic theorems: source and normal lattices regular,
integral deck-linear sections and primitives, nil block e²Phi with
e=sigma-1, and h*(ker Psi_C)=k e^(q-1). Coefficient Witt Frobenius
fixes the abstract sigma, retaining source and target twists.

Fix a GIVEN compatible initial reference C_(a+3)^0 and the lift of
the ORIGINAL cover, with their W2 marking. Then for EVERY2<=n<=a:

Given compatible C_n and the original marked h_n:T_n->C_n extending
that marking, any GIVEN compatible W_(n+a+1) extension of T_n has
its GIVEN W_(n+1) truncation descend compatibly along the original map

    h_(n+1): T_(n+1)->C_(n+1),

where C_(n+1) extends the given C_n. Lower compatibility is a conclusion,
not an assumed property of an auxiliary reference. The Hodge line,
projective grading and actual flat periodicity line are pullbacks.

Together with the established late n>=a+1 theorem and the results for
a<=3, EVERY GIVEN full compatible cyclic-power tower under these inputs
descends uniquely along its ORIGINAL map and algebraizes over W(k).
No claim says the given longest finite extension itself descends at
its full precision. No unmarked common-cover nonexistence follows
without the separate two-leg hypotheses and reduction.

[Proof](../Solutions/Sol_cyclic_power_early_descent.md) ·
[exact local checks](../scripts/uniform_early_descent_checks.py) ·
[audit](../Research/audits/UNIFORM_EARLY_CYCLIC_COMPARISON_AUDIT_2026_09_10.md).
