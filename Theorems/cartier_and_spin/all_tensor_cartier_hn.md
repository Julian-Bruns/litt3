# Harder–Narasimhan polygons of tensor powers of the Cartier bundle

Version3,3 October2026.
Let C be a smooth projective connected curve of genus g≥2 over an
algebraically closed field of odd characteristic p. Put s=g−1,
F:C→C1=C^(1), B=F_*O_C/O_C1, ω1=ω_C1 and T=T_C.

## Full tensor powers

For H_n(z)=∑_μ rank(gr_μ) z^(pμ/s), define

    A(z)=z^2+z^4+⋯+z^(2p−2),
    D(z)=z^(-2)+z^(-4)+⋯+z^(-2p+4).

All exponents are integers, and

    H_0=1,   H_1=(p−1)z^p,
    H_n=z^(2p)H_(n−2)+p z^(3p−1)A(z)^(n−2)D(z), n≥2.

Equal exponents are combined; their coefficients are the ranks of HN
factors, not necessarily stable. Thus all normalized HN
polygons depend only on n,p. For n≥2,

    μ_max/s=(2n−1)(p−1)/p,   μ_min/s=1+(2n−1)/p.

Since B^∨≅B⊗ω1^(-1), mixed tensor powers and canonical line twists
are obtained by the corresponding slope shift.

## Filtered bundle model and characteristic-five consequences

Let D_+^(≤m) be the O_C-module of k-linear differential operators of
order≤m killing1. Action modulo pth powers gives an isomorphism

    F_*D_+^(≤p−2) ≅ End_0(B).

Its order filtration is the HN filtration: the jth quotient is the
stable rank-p bundle F_*T^j of slope (p−1−2j)s/p, 1≤j≤p−2.
Also End(B)=O_C1⊕End_0(B); the scalar line joins its zero-slope factor.
This is a filtered vector-bundle statement, not compatibility with
operator composition.

For p=5 there is an exact HN sequence

    0 → F_*T → Sym²(B)⊗ω1^(-1) → (F_*T)^∨ → 0,

and the primitive summand for the Raynaud alternating pairing satisfies

    Λ²(B)⊗ω1^(-1) = O_C1⊕P,   P≅F_*T².

The isomorphism for P is the intrinsic Wronskian on exact one-forms,
followed by the canonical twist. In particular P is stable of slope0; Sym²(B) has rank-five factors
of slopes12s/5 and8s/5, and B⊗B has ranks5,6,5 at slopes12s/5,2s,8s/5.

All constructions commute with finite étale base change, without any
covering-degree restriction. Full tensor polygons do not determine
arbitrary subquotients or imply the separate all-symmetric-power
theorem.

[Proof](../../Proofs/cartier_and_spin/all_tensor_cartier_hn.md).
