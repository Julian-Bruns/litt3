# Proof record: Intrinsic polarization bounds for finite bad fibers

Canonical statement: [polarization_bad_fiber_bound](../Theorems/Thm_polarization_bad_fiber_bound.md).
Version 2, 2026-09-07, /root/library_generalization_cleanup_max.
Author prose; no independent whole-statement audit. Version 1's
complement-dependent bound is retained below as an identity; the
extension removes that hypothesis and applies to arbitrary étale degrees.

## 1. Eliminate the auxiliary complement from the bound

Write i:A→J, L_A=L|A, and choose

    P=(ker(i^∨ λ_L:J→A^∨))^0_red.

Because λ_(L_A)=i^∨λ_Li is an isogeny, P complements A. For addition
a:A×P→J and ψ=π|P, one has deg(a)=deg(ψ)=e. The cross homomorphism
P→A^∨ is zero. The seesaw principle, with the restrictions on both
axes fixed, therefore gives the actual line-bundle identity

    a^*L≅L_A⊠L_P,           L_P=L|P.                         (1)

Picard-zero twists are included in these restrictions. This is the
polarization construction of the complement, not an additional
assumption on (J,A,L). See [Conrad, Theorem 5.1.10 and its proof](https://math.stanford.edu/~conrad/papers/cmchina.pdf)
for the algebraic construction in arbitrary characteristic.

Ample bundles on abelian varieties have no higher cohomology. Thus
E=π_*L is locally free and commutes with base change. Pulling back
along ψ identifies the family with A×P→P, so (1) gives

    ψ^*E=H^0(A,L_A)⊗L_P.

The coordinates of ψ^*σ are sections of L_P with finite base scheme
B_P=P×_Q B. Choose r general linear combinations. They intersect
properly: at each step avoid the finitely many positive-dimensional
components of the preceding intersections, none of which lies in
the full finite base locus. Their intersection contains B_P and
has length c_1(L_P)^r. Finite flatness of ψ gives

    e length(B)=length(B_P)≤c_1(L_P)^r.                       (2)

Riemann--Roch and the projection formula for the isogeny a give

    e χ(J,L)=χ(A,L_A)χ(P,L_P),
    c_1(L_P)^r=r!χ(P,L_P).

Substitution in (2) proves length(B)≤r!χ(J,L)/χ(A,L_A).
These identities use scheme degree, so no separability condition is
needed. The standard cohomology and intersection identities are
recorded in [Milne, Abelian Varieties, I, Theorem 11.1](https://www.jmilne.org/math/CourseNotes/AV.pdf).

## 2. Generic determinant corank gives a local length budget

At the generic point of A_z=π^(-1)(z), remove an invertible block of
a local square cohomology matrix. The remaining δ_z-square block
has every entry in the fiber ideal I, so its determinant is in I^δ_z.
This generic vanishing order holds along the entire fiber: the
successive normal coefficients are sections of

    L|A_z ⊗ Sym^j(T_z^*Q).

Each is a vector-bundle section on the integral A_z. For j<δ_z it
vanishes generically, hence identically; induction gives s∈I^δ_z
along A_z. Base change for π_*L on the infinitesimal neighborhood
then puts all coordinates of σ in m_z^δ_z. Thus

    O_(Q,z)/I_(B,z) ↠ O_(Q,z)/m_z^δ_z.

The smooth r-dimensional local ring on the right has length
w_r(δ_z)=binomial(r+δ_z−1,r). Summing these local estimates proves
the defect budget. The argument only needs the determinant family;
it does not require ordinarity or a curve automorphism group.
If a symmetry preserves that family and the quotient, its orbits
have constant δ and may be grouped in the same sum.

## 3. The polarization ratio for any actual étale cover

Let q:U→Y have degree n≥2 and h=g(Y)≥2. All the following Jacobians
and maps are on scalar Frobenius twists. Write f=q^*:J(Y)→A for
the induced isogeny and κ=deg f. Norm is adjoint to pullback under
the principal Jacobian polarizations, and Nm_q q^*=[n]. Therefore

    f^*(Θ_U|A)≡nΘ_Y,
    χ(A,Θ_U|A)=n^h/κ.                                     (3)

This is numerical equivalence, sufficient for χ. The pullback/norm
identity is the functorial form of Jacobian autoduality; see
[Milne, Jacobian Varieties, Section 6](https://www.jmilne.org/math/xnotes/JVs.pdf).

Here κ has an intrinsic covering interpretation even when p|n.
Take the finite étale Galois closure W→Y of this ONE cover, with
group G and U=W/H. Descent of a line bundle trivialized on W is a
character G→G_m: universally H^0(W_T,O)=H^0(T,O), so the descent
cocycle of the trivial line has constant coefficients on W_T.
Its descent is trivial on U precisely when the character is trivial
on H. As an fppf group scheme this gives

    ker(q^*)≅D(G^ab/im(H)),                                 (4)

where D denotes Cartier duality for the constant finite abelian
group. This argument retains infinitesimal characters, so (4)
includes, for example, μ_p kernels from cyclic étale p-covers.
The quotient G^ab/im(H) defines the largest abelian intermediate
étale cover of q. Its order is κ and divides [G:H]=n. This single-leg
Galois closure asserts nothing about a simultaneous closure for a
bi-étale span.

Riemann--Hurwitz gives g(U)=n(h−1)+1 and r=(n−1)(h−1). For the
Raynaud determinant line L, its numerical class is (p−1)Θ_U.
Thus χ(J,L)=(p−1)^g(U) and
χ(A,L|A)=(p−1)^h n^h/κ. Sections 1–2 give the exact budget

    ∑_z w_r(δ_z)≤floor(r!(p−1)^r κ/n^h).                    (5)

The Raynaud class, symmetry, and determinant conventions are in
[Tong, Sections 1.2.1–1.2.3](https://arxiv.org/pdf/0712.2046).
Finiteness of B remains a hypothesis of (5); it is not inferred
from these polarization identities.

## 4. The audited cyclic triple and its character refinements

Use the actual ordinary triple in
[ordinary_cyclic_triple_finite_bad_cosets](../Theorems/Thm_ordinary_cyclic_triple_finite_bad_cosets.md),
whose bad locus is finite and avoids zero. With n=3,h=2,p=5 and
κ=3, formula (5) gives V=32/3 and

    ∑_z δ_z(δ_z+1)/2≤10.                                   (6)

This also recovers the old coordinates: P=E^2, ψ=H with
H=[[2,−1],[−1,2]], deg ψ=9, and (4H)^2/9=96/9=32/3.

On Q, Γ=⟨R,−1⟩≅C6. The only point fixed by all of Γ is zero:
ker(R−1) has order 9 and its intersection with Q[2] is trivial.
Since zero is good, every bad orbit has size at least 2. A defect
δ≥3 would cost at least 2·6>10 in (6), so δ≤2. A free orbit with
δ=2 would cost 6·3>10. Hence every defect-two point is fixed by
R or −1, and lies in ker(R−1) or Q[2]. Outside that union the
defect is 1, and at most one free orbit fits into (6).

For a finite prime-to-five character subgroup Λ⊂P(k), the actual
abelian cover b_Λ:W_Λ→U has, by the projection formula,

    generic_L h^0(W_Λ^(1),B_(W_Λ)⊗(qb_Λ)^(1)*L)
       =∑_(α∈Λ) δ_(ψ(α)).                                 (7)

Here δ is set to zero off B. Each fiber of ψ has at most 9 elements
of Λ, and δ≤δ(δ+1)/2, so (6) bounds (7) by 90, independently of |Λ|.
The character-cover construction and generic finite intersection
are exactly those in the audited triple proof. Equation (7) measures
the generic defect along the actual Y-parameter family; it is not
the a-number of W_Λ. No second map is constructed, and any actual
second étale map remains on the same source after refinement.

Isolated defect-one points still satisfy every displayed estimate.
This theorem supplies neither their absence nor a common-cover
obstruction.
