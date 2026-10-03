# Supporting proof: Raynaud cyclic refinements

This proves the Raynaud specialization in the
[simultaneous growth theorem](../../../Theorems/jacobians/ordinary_covers/prime_avoiding_section_growth.md).
Use the [relative Frobenius convention](../../../Definitions/theta_cartier.md).
All covers below are actual covers of curves, not isogenies substituted
for them.

## Apply the simultaneous coefficient theorem

Use the [general section-growth theorem](prime_avoiding_section_growth.md)
with the single bundle B_C on C^(1) and the stated subvariety T.
It constructs actual connected cyclic character covers of C^(1),
with arbitrarily many distinct contributing tame characters, avoiding
all prescribed primes. Pull these covers back by relative Frobenius
C to C^(1). A universal homeomorphism preserves their connectedness,
and the Frobenius square recovers the original character cover on
the twist. Étale base change gives B_(C_j)=q_j^(1)*B_C, hence
\[
a(C_j)=\sum_{L\in\Lambda_j}h^0(C^{(1)},B_C\otimes L)
\ge a(C)+j.
\]
The a-number is bounded by the eventual nilpotent Frobenius dimension
Delta(C_j), proving both inequalities. The coefficient theorem already
supplies pairwise-coprime new orders and nested actual cyclic covers.

## Why the Raynaud geometric hypothesis holds

By the [dimension theorem](../theta_divisors/raynaud_rank_one_dimension.md),
Raynaud theta has no translated abelian divisor component, for
any hyperbolic curve in any characteristic. An irreducible component
T has dimension g(C)-1>=1. If T lay in a translate of a proper
abelian subvariety, equality of dimensions would make it an abelian
divisor translate. This is excluded. Hence every component generates
the whole Jacobian up to translation, and the coefficient theorem
applies with A0=J(C^(1)). This one argument replaces the former
nonordinary, simple-Jacobian, low-genus and small-characteristic cases.

## Pulling the tower through the actual second leg

Apply the second-leg part of the coefficient theorem to the actual
twisted map g^(1), avoiding all degree primes of g. It proves that
Z_j=Z times_C C_j is connected. Étale Frobenius base change gives
B_Z=g^(1)*B_C, so its section-growth inequality is exactly
\[
a(Z_j)\ge a(Z)+j.
\]
The two original endpoint maps remain finite étale after composing
with the retained projection to Z. No Galois hypothesis on g or
simultaneous Galois closure is needed.

## Provenance and scope

The [original tower audit](../../../Research/audits/PRIME_AVOIDING_CYCLIC_DEFECT_AUDIT_2026_09_15.md)
and the later finite-family review remain the evidence for the actual
cyclic construction and retained two maps. Version3 replaces only the
geometric case list by the independently reviewed all-characteristic
dimension theorem. No arithmetic calculation was repeated.

The [original author note](../../../../litt3-computation-data/unmarked_ideas_20260915/prime_avoiding_cyclic_towers_original.md)
records the initial construction when a theta component generates the
whole Jacobian. That hypothesis is now established for every hyperbolic
curve. Poonen's arithmetic-progression theorem remains the density input.

The covers add new primes indefinitely. Their defect may be
sublinear in degree. Neither the original two-leg source nor any
refined source is asserted to be jointly minimal. In particular
this construction does not contradict finite-prime-support
stabilization or the existence of tails approaching normalized
ordinary p-rank.
