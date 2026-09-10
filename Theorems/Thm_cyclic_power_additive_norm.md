# Cyclic-power norm obstruction for mixed additive operators

Version1, 2026-09-10. Proved; focused independent medium audit PASS.
This is a pure integral-module theorem, not a cover-descent theorem.

Let p=5, a>=1, q=p^a, O=Z/p^(a+1), and let K be a free O-module,
of arbitrary possibly infinite rank. Define

    F=(1+e)^q-1, N=F/e, M=K[e]/F K[e].

Let Phi be an O-linear automorphism of K, acting coefficientwise.
Suppose L:M→M is additive, commutes with e, and reduces modulo p
to e²Phi. Then, for every eta in K:

1. L(x)=N eta is soluble if and only if eta belongs to pK.
2. When it is soluble, the reductions of ALL solutions are precisely
   e^(q-1)(K/pK) inside M/pM.

More precisely, for A=L Phi^-1 the coefficient remainder of degree
at most one gives an O-module normal form

    coker A ≅ K ⊕ e(K/p^aK),   [N eta]=(p^a eta,0).

For finite rank f of K, A has f(q-2) unit Smith factors, f factors
p^a, and f zero factors. The infinite-rank assertion instead uses
a direct primitive-kernel argument and no dimension counting.

In particular take K=W_(a+1)(k), with k perfect, viewed as a free
Z/p^(a+1)-module, and Phi coefficient Witt Frobenius. The assertion
permits arbitrary mixed coefficient-linear and coefficient-Frobenius
corrections. It does not require L to be W_(a+1)(k)-semilinear.

Any application to an actual Hodge comparison still has to identify
its additive deck-equivariant part and account for nonlinear divided
repair terms. The theorem alone does not establish cyclic25 descent
or solve the unmarked common-cover problem.

[Proof](../Solutions/Sol_cyclic_power_additive_norm.md) ·
[Audit](../Research/audits/CYCLIC_POWER_ADDITIVE_PREPARATION_AUDIT_2026_09_10.md) ·
[Exact diagnostic](../scripts/verify_cyclic_power_additive_carry.py).
