# Frobenius exact differentials and Raynaud theta notation

ID: `theta_cartier`. Uses [base conventions](Def_base_conventions.md).

On C^(1) define B_C by the exact sequence

    0 → O_(C^(1)) → F_(C*) O_C → B_C → 0.

This convention fixes the twist: B_C is on C^(1), not on C. For an
etale q:W→C the comparison uses q^(1)*B_C=B_W. The a-number is
a(C)=dim H^0(C^(1),B_C), equivalently the dimension of the Cartier
kernel on regular differentials. Ordinarity means Frobenius on
H^1(O_C) is invertible; it is not preserved by arbitrary etale covers.

Theta_C denotes Raynaud's effective determinant divisor, with support

    {N∈J(C^(1)): H^0(C^(1),B_C⊗N)≠0}.

Its existence/properness is supplied by Raynaud's theorem where used;
it is not the classical principal theta divisor. Its numerical class
is (p-1) times the principal polarization.

For A⊂J(C^(1)), let pi:J→Q=J/A. A *bad coset* is a q∈Q whose ENTIRE
fiber is contained in Theta_C. Its generic defect delta_q is the minimum
of h^0(B_C⊗N) on a nonempty open of that fiber. Finite bad support is
weaker than absence of bad cosets. A determinant zero scheme retains
multiplicity, whereas a set of its geometric points does not.

For X←Z→Y, the *two-endpoint parameter family* consists of actual line
bundles f^(1)*L⊗g^(1)*M on Z^(1). Generic vanishing on this family is
an additional assertion, not implied by the definition of a bi-etale span.
