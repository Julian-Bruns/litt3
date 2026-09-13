# Canonical tensors, Cartier operations, and markings

ID: `canonical_tensors`. Uses [base conventions](Def_base_conventions.md)
and [correspondences](Def_correspondences.md).

A weight-d regular canonical tensor on C is a section of omega_C^d,
d≥1. Etale maps identify the pullback canonical line bundle with that
of the source; all comparisons use this ACTUAL differential pullback.
Preserving a tensor means equality of pullbacks. Preserving its line
means equality up to a nonzero constant, not an arbitrary function.

The canonical ring is R(C)=⊕_(d≥0)H^0(C,omega_C^d). For an actual span,
its canonical intersection A is the intersection of the two embedded
graded rings inside R(Z). If it is k[s], d=deg(s) is its primitive
weight. This polynomial-ring alternative is a theorem for coreless spans.

For a tensor with uniform zero divisor eD, D reduced, e/d is the
zero-multiplicity/weight ratio. An *equal-weight-zero tensor* has
div(s)=dD. Its marking D has degree 2g(C)-2. A *canonically sized
marking* is any reduced divisor of that degree. This is a condition
on an actual finite point set, not an assertion that every span has one.
Write L_D=omega_C(-D).

If p|d, omega_C^d has the canonical Frobenius connection. In a local
frame e for omega_C^(d/p), nabla(ae^p)=e^p⊗da. A section is horizontal
when nabla(s)=0. If s is nonzero, eta=(nabla s)/s is a rational one-form.
Its regularity requires a separate argument (e.g. zeros divisible by p).

Ordinary Cartier C acts inverse-Frobenius-semilinearly on regular
one-forms. The twisted operator C_n takes weight pn+1 to weight n+1;
locally, if a=Σ_(i=0)^(p-1)a_i^p t^i, then

    C_n(a(dt)^(pn+1))=a_(p-1)(dt)^(n+1).

An eigenform line is a one-dimensional subspace stable under Cartier;
its eigenvalue may be zero. Nonzero-eigenvalue and Cartier-zero cases
must not be conflated. A uniform zero divisor means the SAME positive
multiplicity at every zero, not merely equal total degree.

For an equal-weight-zero tensor, S_s and S_[s] denote the canonical
exact- and line-preserving quotients constructed by theorem
`canonical_marked_quotient`. Their existence is not a convention applied
to arbitrary higher-multiplicity tensors.
