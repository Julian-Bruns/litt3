# Ordinary indigenous bundles, inverse Cartier characters, and eigenform tangents

Author source-checked deductions and direct proofs,2026-09-05:
 /root/ordinary_indigenous_inverse_character_check and
 /root/cartier_eigenform_tangent_character_test.
Consolidated2026-09-07 without changing either character or its scope;
not independently audited.

## 1. Exact criterion and its two different character spaces

Let k be algebraically closed of characteristic5, C smooth projective
connected of genus g≥2, d=2 or4, r=5−4/d, e=d/2. Suppose

    0≠s∈H⁰(C,ω_C^d), C_(d−1)(s^r)=s, div(s)=eD, D reduced.

Let π:P→C be a connected component of the normalized canonical root
cover, with tautological differential η^d=π^*s. Use its ACTUAL cyclic
deck group G of order dividing d, not necessarily d; η has faithful
character χ. All characters are F₅-valued.

The associated indigenous projective bundle is unmarked, active,
nilpotent and admissible. It is ordinary in Mochizuki's sense iff

    T_s:H⁰(C,ω_C²)→H⁰(C,ω_C²), t↦C₁(s^(4/d)t)

is bijective, equivalently iff Cartier is bijective on
H⁰(P,ω_P)_(χ⁻¹). The intertwiner is I(t)=π^*t/η, k-linear,
and that space has dimension3g−3.

Separately, write E_d(C) for the finite normalized eigenform SCHEME
of the [finite-pool theorem](FINITE_GENERALIZED_CARTIER_EIGENFORM_POOLS_AND_ETALE_COMPATIBILITY.md),
and S_e for the natural locally closed divisor-incidence stratum
of sections with divisor e times a reduced divisor. Then

    J:T_s(E_d(C)∩S_e) ≅ ker(C_P|H⁰(P,ω_P)_χ),
    J(u)=π^*u/η^(d−1).                                    (1)

The two kernels have EQUAL DIMENSION by polarization, Section5.
Consequently the indigenous bundle is ordinary iff E_d(C)∩S_e
is reduced at s, with tangent dimension exactly dim ker T_s.
For d=2 the stratum is open and this also tests E₂(C) itself.
For d=4 it tests ONLY the equimultiple intersection, not arbitrary
quartic eigenform tangents. No canonical kernel identification is claimed.

## 2. Indigenous object and the precise square Hasse invariant

The [deformation-data translation](CARTIER_EIGENFORMS_AS_MULTIPLICATIVE_DEFORMATION_DATA.md)
gives C_P(η)=η and local signatures3/2 at D,1 elsewhere.
[Bouw–Wewers, Section4.3, equation(6), Proposition4.8/Theorem4.11](https://arxiv.org/html/math/0505275v2)
therefore gives no markings or spikes. Its p-curvature is nowhere
zero, with surjective dual: admissibility in Mochizuki II Definition2.4.

For a separating z, θ=dz, ∂=∂/∂z, write s=aθ^d and v=a^(−4/d).
In the normalized rank2 model with Hodge generator e₀,

    ∇_∂e₀=v ∂^⊗5,    Ψ(∂^⊗5)(e₀)=−∂^⊗5.

The inverse Kodaira–Spencer map divides the Hodge projection by v.
Thus the square Hasse invariant is

    H_E=−s^(4/d)∈H⁰(C,ω_C⁴)=Hom(τ_C^⊗5,τ_C), div(H_E)=2D. (2)

The rational computation determines the global map. The minus sign
uses Ψ=∇_∂^5−∇_(∂^5) and does not affect bijectivity.
The normalized determinant τ_C^⊗5 is harmless: tensor by κ^5,
κ²=ω_C, with its canonical zero-p-curvature connection. This
trivializes the determinant with connection and preserves projective,
adjoint, p-curvature and square-Hasse data.

[Mochizuki, ChapterII Proposition2.6(1), Lemma2.11/Proposition2.12,
Definition3.1](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf)
(PDF pp.69,73–74,80) identifies the dual induced Frobenius on
H¹(C,τ_C) with Cartier composed with the dual square Hasse invariant.
By(2) this is−T_s. His ordinary condition is precisely its
invertibility. Absolute inverse-Frobenius notation expresses the same
relative-Frobenius linear test over the perfect field k.

## 3. One valuation calculation for both descent maps

The root cover has ramification index2 over D, including on a
connected component, and is etale elsewhere. Tame tensor pullback gives

    d ord_Q(η)=2e+d(2−1)=2d, so ord_Q(η)=2.

For a rational j-differential u with order h at D,

    ord_Q(π^*u/η^(j−1))=2h+j−2(j−1)=2h−j+2.               (3)

For j=2 this is2h and the character isχ⁻¹. Hence I identifies
regular quadratics with H⁰(P,ω_P)_(χ⁻¹). For j=d, (3) is
2(h−e+1), and the character isχ^(1−d)=χ. Thus J identifies

    H⁰(C,ω_C^d(−(e−1)D)) ≅ H⁰(P,ω_P)_χ.                 (4)

Converses follow by multiplying an eigenform by η or η^(d−1):
the resulting rational tensor is invariant and descends in the
separable function-field extension. Formula(3) then proves regularity
and the required vanishing downstairs. Ramified REGULAR descent is
not presumed. Away from D the cover is etale and η nonvanishing.

For I, write η=bθ, t=cθ², b^d=a, so b⁴=a^(4/d).
Cartier functoriality and C(f⁵β)=fC(β) give

    π^*T_s(t)=θ C_P(b⁴cθ)=bθ C_P((c/b)θ)=η C_P(I(t)).     (5)

Dividing by η proves the claimed intertwining.

## 4. Exact finite-scheme and divisor-stratum tangents

In a basis of H⁰(ω_C^d), the eigenform equations are x_i^5−P_i(x)=0,
where P_i(s) is the fifth power of the i-th Cartier coordinate
of s^r. Taking fifth powers cancels inverse Frobenius. Differentiating
POLYNOMIAL equations gives

    dP_i|_s(u)=r(coordinate_i C_(d−1)(s^(r−1)u))^5,
    T_sE_d(C)={u:C_(d−1)(s^(r−1)u)=0}.                   (6)

No inverse Frobenius on a dual-number ring is used.

The divisor-incidence stratum has tangent
T_sS_e=H⁰(ω_C^d(−(e−1)D)): locally an e-fold moving zero has
perturbation divisible by z^(e−1), since e is invertible.
Smoothness and the global equality are explicit here. For d=2,
S₁ is the open simple-zero locus. For d=4, set
L=O(D)⊗ω_C^(−2), so L²=O. Locally S₂ consists of q² for reduced
q∈H⁰(ω_C²⊗L), with q∼−q. Pic(C)[2] is etale; on each fixed
L this is a free-sign quotient of an open vector space, smooth
of dimension3g−3. Its tangent map v↦2qv has exactly the stated image.

For J, write u=cθ^d and η=bθ. Since d(r−1)=4(d−1),

    π^*C_(d−1)(s^(r−1)u)
      =θ^(d−1)C_P(a^(r−1)cθ)
      =η^(d−1)C_P((c/b^(d−1))θ)
      =η^(d−1)C_P(J(u)).                                 (7)

Combine(4),(6),(7) and injective pullback to prove(1). Cartier
preserves χ because χ takes values in F₅*, rather than silently
changing the character. Both spaces in(4) have dimension3g−3.

## 5. Polarization equates kernel dimensions, not operators

For ANY smooth projective P/k with cyclic action of order dividing4,
and any character ρ, we claim

    dim ker(C_P|H⁰(ω_P)_ρ)=dim ker(C_P|H⁰(ω_P)_(ρ⁻¹)).     (8)

Use H=H¹_dR(P/k), Frobenius F, Verschiebung V and its perfect
alternating cup pairing. The automorphism-compatible BT1 conventions
in [Cais–Ulmer, Sections2/4, equations(2.1)/(4.2)](https://arxiv.org/html/2307.16346v2)
are im V=ker F=H⁰(ω_P), im F=ker V, and V|H⁰(ω_P)=C_P;
F,V are adjoint up to Frobenius. Since the characters are F₅-valued,
F,V preserve each H_ρ.

Put A_ρ=ker(F|H_ρ), B_ρ=ker(V|H_ρ). Rank-nullity and the BT1
identities give dim A_ρ+dim B_ρ=dim H_ρ. Therefore

    dim(A_ρ∩B_ρ)=dim H_ρ/(A_ρ+B_ρ).

The perfect pairing pairs ρ withρ⁻¹; adjointness gives
A_ρ^⊥=A_(ρ⁻¹), B_ρ^⊥=B_(ρ⁻¹). Hence the dual of this quotient
is A_(ρ⁻¹)∩B_(ρ⁻¹), proving(8). This is our linear-algebra
deduction, not a quoted theorem about the eigenform scheme.
A finite local k-algebra is reduced iff its tangent space is zero,
so(1),(5),(8) prove the reducedness/ordinariness criterion.

## 6. Hypotheses that remain additional

This tests one specified root-cover character block, not ordinary
Cartier on C or all of P. Reducedness of D does not force its kernel
to vanish. A disconnected FULL root cover is allowed; replacing its
component's actual G by μ_d would be incorrect.

The indigenous construction and its unique extension commute with
etale pullback. Thus compatible normalized sections yield compatible
projective indigenous bundles on the ACTUAL common source. Applying
the [conditional simultaneous-lifting theorem](33_MOCHIZUKI_CANONICAL_LIFTING_LIMIT.md)
still requires ordinariness on both endpoints AND that source.
Endpoint ordinariness does not supply the third condition; the
[finite destruction counterexample](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md)
shows this failure explicitly. None of these results gives an
unmarked common-cover exclusion.
