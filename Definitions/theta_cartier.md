# Frobenius exact differentials and Raynaud theta notation

ID: `theta_cartier`. Uses [base conventions](base_conventions.md).

For relative Frobenius F_C:C→C^(1), use Joshi's exact-differential
bundle notation B_{1,C}, defined by

    0 → O_(C^(1)) → F_(C*) O_C → B_{1,C} → 0.

For g(C)≥2 it is stable of slope g(C)−1 and rank p−1 by
[Joshi, Theorem1.1](https://comptes-rendus.academie-sciences.fr/mathematique/item/10.1016/j.crma.2004.02.019.pdf).

This convention fixes the twist: B_{1,C} is on C^(1), not on C. For an
etale q:W→C the comparison uses q^(1)*B_{1,C}=B_{1,W}. The a-number is
a(C)=dim H^0(C^(1),B_{1,C}), equivalently the dimension of the Cartier
kernel on regular differentials. Ordinarity means Frobenius on
H^1(O_C) is invertible; it is not preserved by arbitrary etale covers.

For genus two in odd characteristic, Pauly's normalized Raynaud bundle
R_kappa is a separate rank-four degree-zero construction. Set
gamma_kappa(x)=O_C(x)⊗kappa^-1 for a theta characteristic kappa. The
J[2]-linearized bundle O_J(2Theta)⊗H⁰(2Theta)^* descends under [2] to M,
and R_kappa=gamma_kappa^*M⊗kappa^-1; see
[Pauly, Section2.2](https://arxiv.org/pdf/0804.3001#page=5).
Its relation to bundles without theta is proved in
[the rank-four theorem](../Theorems/jacobians/theta_divisors/genus_two_rank_four_theta.md).

Theta_C denotes Raynaud's effective determinant divisor for B_(1,C), with support

    {N∈J(C^(1)): H^0(C^(1),B_{1,C}⊗N)≠0}.

Its existence/properness is supplied by Raynaud's theorem where used;
it is not the classical principal theta divisor. Its numerical class
is (p-1) times the principal polarization.

For A⊂J(C^(1)), let pi:J→Q=J/A. A *bad coset* is a q∈Q whose ENTIRE
fiber is contained in Theta_C. Its generic defect delta_q is the minimum
of h^0(B_{1,C}⊗N) on a nonempty open of that fiber. Finite bad support is
weaker than absence of bad cosets. A determinant zero scheme retains
multiplicity, whereas a set of its geometric points does not.

For X←Z→Y, the *two-endpoint parameter family* consists of actual line
bundles f^(1)*L⊗g^(1)*M on Z^(1). Generic vanishing on this family is
an additional assertion, not implied by the definition of a bi-etale span.
