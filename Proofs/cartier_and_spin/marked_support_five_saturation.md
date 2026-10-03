# Proof: the exact marked divisor quotient is the root obstruction

[Statement](../../Theorems/cartier_and_spin/marked_support_five_saturation.md).
Let L be the free group of degree-zero divisors on Z union{O}.
The class map has image Gamma and kernel the principal supported
divisors, identified with U by the divisor map. Constants are
removed; over the algebraically closed field all constants have
every required root.

For g in U_(d), write div(g)=dD. Sending g to [D] gives
a map U_(d)->Gamma[d]. It is onto: every class in Gamma[d]
has a supported representative D, and dD is principal.
Its kernel is exactly U^d. Indeed [D]=0 gives h with div(h)=D;
then g/h^d is constant, and the converse is immediate.
The displayed cyclic factors follow from the exact invariant
factors of Gamma. In particular this obstruction vanishes
for every g exactly when gcd(d,m)=1. This uses divisors,
so does not assume an etale Kummer sequence when p divides d.

For the effective residue problem, divide g by
prod_i(x-alpha_i)^(e_i). Every remaining finite valuation
is nonnegative and divisible by d; degree zero gives the same
divisibility at O. If gcd(d,m)=1, the preceding root criterion
gives h with effective finite support and the asserted pole.
An invariant h makes g invariant. Thus a noninvariant g
requires pole_O(h)>=B and gives the lower bound
dB+3sum e_i.

Conversely choose an effective minimizing function h of pole B
from the exact marked lattice and multiply h^d by that complete-
fibre product. Its residues are the chosen e_i and its pole is
exactly dB+3sum e_i. It remains noninvariant: if h^d were
gamma-invariant, gamma(h)/h would be a constant lambda with
lambda^d=lambda^3=1. Since gcd(d,m)=1 implies gcd(d,3)=1,
lambda=1, contradicting noninvariance of h. Multiplication by
the invariant product does not change this. It proves sharpness
for every residue choice and the uniform zero-residue threshold.

The complete relation lattice independently supplies Gamma,
its invariant factors and B. It replaces the older Weil-resultant
annihilator calculation entirely; no function-space search or
resultant replay is needed. Original resultant evidence and its
independent audits remain external provenance. The actual
modular phase condition and total valuation congruence are
distinct hypotheses, so this argument does not improve an
arbitrary actual-norm range without the latter condition.
