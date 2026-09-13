# Finite compatible Witt height translates exactly along a neutral dihedral tower

Version1,2026-09-11. Author corollary of the audited tower and
neutral-Galois finite-descent theorems; no separate audit claimed.

Use any ONE of the fourteen actual towers in
[neutral_dihedral_towers](neutral_dihedral_towers.md), with its
original marked second lifts and prescribed full previous tuples.
Let H(T_a) be the supremum of Witt lengths N>=2 for which that
marked T_(a,2) admits SOME compatible W_N(k) extension. Put H=∞
when these lengths are unbounded, without asserting an inverse system.

Then, for every a>=1,

    H(T_a)=H(T_1)+(a-1).

More precisely, an existing compatible W_N extension on T_a with
N>=a+2 produces one on the ORIGINAL T_1 through W_(N-a+1).
Conversely any compatible W_N extension on T_1 produces some
compatible extension on T_a through W_(N+a-1).

The latter construction need not preserve every adjacent map at
its newest digit. The former does preserve the original quotient
marking at the recovered precision. It does not change either
special-fiber cover to a replacement one.

In particular, IF the selected R=u(u-1) source has no compatible
fourth lift, then its whole resolvent tower has EXACT heights

    H(T_a)=a+2  (a>=1).

This last hypothesis is the new returned Pro assertion and is not
proved by this corollary. A finite supremum rules out a full tower;
an infinite supremum alone does not construct a full tower. These
are one-leg examples, not common covers of the fixed endpoint pairs.

[Proof](../../../Proofs/deformations/cyclic_descent/neutral_dihedral_height_translation.md).
