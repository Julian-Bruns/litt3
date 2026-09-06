# Ordinary HN polygons of all full tensor powers of the Cartier bundle

Let C be a smooth projective connected curve of genus g≥2 over an
algebraically closed field of odd characteristic p. Put s=g−1 and
B=F_*O_C/O_(C^(1)). For every n≥0, the ranks and slopes divided by s
of the ordinary HN filtration of B^(⊗n) depend only on n and p.

For H_n(z)=∑_μ rank(gr_μ) z^(pμ/s), define

    A(z)=z^2+z^4+⋯+z^(2p−2),
    D(z)=z^(-2)+z^(-4)+⋯+z^(-2p+4).

All H_n exponents are integers, and

    H_0=1,   H_1=(p−1)z^p,
    H_n=z^(2p)H_(n−2)+p z^(3p−1)A(z)^(n−2)D(z), n≥2.

Equal exponents are combined; the coefficient is the rank of the
HN factor, which need not be stable. For n≥2,

    μ_max/s=(2n−1)(p−1)/p,
    μ_min/s=1+(2n−1)/p.

The construction commutes with finite étale base change without a
covering-degree restriction. Since B^∨≅B⊗ω_(C^(1))^(-1), all mixed
tensor powers of B and B^∨ and canonical line twists have the same
universality, with the corresponding slope shift.

The assertion concerns full tensor powers, not arbitrary subquotients
or a deduction for symmetric powers. These universal normalized
polygons do not exclude common finite étale covers.

[Proof](../Solutions/Sol_all_tensor_cartier_hn.md).
Audited prose: PASS, `/root/all_cartier_tensor_hn_major_audit`,
2026-09-06, no breaking objection;
[audit record](../routes/global/audits/ALL_CARTIER_TENSOR_HN_AUDIT_2026_09_06.md).
The differential-operator model and other legacy proof inputs remain
proof-local references, not newly registered dependencies.
