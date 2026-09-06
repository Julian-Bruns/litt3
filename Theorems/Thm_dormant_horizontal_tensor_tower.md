# Horizontal tensors form an explicit Frobenius tower

Let C/k have genus g>=2 in characteristic five, let theta^2=omega_C,
and let a dormant projective rank-two oper have fixed-theta descent W:
det W=O_C and F_C^*W is the nonsplit oper bundle G_2(theta).
Fix tau^3=O_C and put V=W tensor theta tensor tau^2.
Assume 5 does not divide g-1, so V is stable by the rank-two criterion.

For n>=0 there is an intrinsic order-two differential operator on
omega_C^(2+5n) tensor tau, locally represented in a separating coordinate
and a horizontal frame of tau by

    a |-> a''-r a,

where u''=r u is the scalar oper equation. Its target is
omega_C^(4+5n) tensor tau. The kernel on global sections is canonically
5-semilinearly isomorphic to

    H^0(C,V tensor omega_C^n).

Consequently its dimension is h^0(V) when n=0, and is exactly
4n(g-1) for n>=1. This holds in all these weights, not just for a
particular numerical example.

For n>=1, the tensor has a reduced zero divisor exactly when its
corresponding section of V tensor omega_C^n is nowhere zero. Such
sections exist in a nonempty open subset: the rank-two bundle is
globally generated. For genus nine and weight seven, there is therefore
a 32-dimensional solution space and many tensors with reduced zeros
for EVERY dormant oper. Their existence alone is no Hermitian-atlas
obstruction. In the Hermitian extension setup, surjections
pi:V -> omega^2 tensor tau correspond, by the rank-two determinant
pairing and this identification, to these reduced weight-seven tensors.

When tau=O_C, the n=0 kernel is also the tangent space to the dormant-oper
scheme at the chosen oper. These statements are compatible with etale pullback
of the specified oper and torsion line; no matching of two independently
chosen endpoint opers is asserted.

Author prose, /root, 2026-09-06; not independently audited.
[Proof](../Solutions/Sol_dormant_horizontal_tensor_tower.md).
