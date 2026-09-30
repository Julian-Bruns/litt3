# Proof: polarization and intersection multiplicity

[Statement](../../../Theorems/jacobians/theta_divisors/polarization_bad_fiber_bound.md).

## 1. The orthogonal complement and multiplicity bound

Write i:A→J, L_A=L|A, and take the polarization-orthogonal complement

    P=(ker(i^∨λ_L:J→A^∨))^0_red.

For addition a:A×P→J and ρ=π|P, put e=deg a=deg ρ and L_P=L|P.
The cross homomorphism P→A^∨ vanishes, so seesaw gives

    a^*L≅L_A⊠L_P,       ρ^*(π_*L)≅H^0(A,L_A)⊗L_P.          (1)

This complement construction works in arbitrary characteristic:
[Conrad, Theorem5.1.10 and proof](https://math.stanford.edu/~conrad/papers/cmchina.pdf).
Ample line bundles on abelian varieties have no higher cohomology,
so π_*L is locally free and (1) holds under base change.

The coordinates of ρ^*σ are sections of L_P with finite base scheme
B_P=P×_Q B. Choose r general linear combinations whose intersection Z
is zero-dimensional; successively avoid each positive-dimensional
component, since none is contained in the finite base locus. Then

    length Z=c_1(L_P)^r,       B_P⊂Z.

Let I_z be the ideal of B in the regular local ring R_z=O_(Q,z), and
write e_(I_z)(R_z) for its Hilbert–Samuel multiplicity, following
[Stacks, Definition43.15.1 and Theorem43.15.5](https://stacks.math.columbia.edu/tag/0AZU).
At w over z, the parameter ideal J_w of Z satisfies
J_w⊂I_z O_(P,w). Comparing lengths of powers gives

    length(O_(Z,w))=e_(J_w)(O_(P,w))
                   ≥e_(I_z O_(P,w))(O_(P,w)).
    ∑_(w|z) e_(I_z O_(P,w))(O_(P,w))=e·e_(I_z)(R_z).       (2)

The equality in the second line follows from finite flatness: before
taking leading Hilbert–Samuel coefficients, the corresponding sum of
lengths is e·length(R_z/I_z^m) for every m. Thus inseparable kernels
retain their full scheme degree. Summing (2) bounds ∑_z e_(I_z)(R_z)
by c_1(L_P)^r/e. The inclusion B_P⊂Z also bounds length(B) by this ratio.

Finally Riemann–Roch and the isogeny projection formula give

    eχ(J,L)=χ(A,L_A)χ(P,L_P),       c_1(L_P)^r=r!χ(P,L_P).

Hence the ratio is V=r!χ(J,L)/χ(A,L_A). These standard abelian-variety
identities are in
[Milne, Abelian Varieties, I, Theorem11.1](https://www.jmilne.org/math/CourseNotes/AV.pdf).

## 2. Determinant defects cost their r-th powers

At the generic point of A_z=π^(-1)(z), remove an invertible block
of the cohomology matrix. Its remaining δ_z-square block vanishes
modulo the fiber ideal I, so the determinant belongs to I^δ_z.
This holds along the whole fiber: its successive normal coefficients
are sections of L|A_z⊗Sym^j(T_z^*Q), and generic vanishing for
j<δ_z implies vanishing everywhere on the integral A_z. Base change
therefore gives I_z⊂m_z^δ_z.

Multiplicity decreases under enlarging a primary ideal. Since R_z
is regular of dimension r,

    e_(I_z)(R_z)≥e_(m_z^δ_z)(R_z)=δ_z^r.

Section1 proves ∑_z δ_z^r≤V. Symmetries preserving the determinant
family and quotient preserve δ_z, so each orbit costs its size
times δ_z^r.

## 3. The ratio and norm kernel for an étale cover

For q:U→Y of degree n and g(Y)=h, work on scalar Frobenius twists.
Put f=q^*:J(Y)→A and κ=deg f. Jacobian autoduality makes norm
adjoint to pullback and gives Nm_q q^*=[n]. Consequently

    f^*(Θ_U|A)≡nΘ_Y,       χ(A,Θ_U|A)=n^h/κ.                (3)

The complement P=((ker Nm_q)^0)_red is orthogonal to A, with

    ker ρ=A∩P=ker λ_(Θ_U|A),       deg ρ=(n^h/κ)^2.

Moreover q^*Nm_q=[n] on A, since this equality holds after pullback
by the faithfully flat isogeny f. Norm vanishes on P, so A∩P⊂J[n]
as group schemes. Thus [M]ρ(α)=0 implies [nM]α=0.
See [Milne, Jacobian Varieties, Section6](https://www.jmilne.org/math/xnotes/JVs.pdf)
for autoduality and the
[bounded norm audit](../../../Research/audits/NORM_COMPLEMENT_ANNIHILATOR_AUDIT_2026_09_13.md)
for this kernel argument.

To interpret κ, take the étale Galois closure W→Y of q, with
group G and U=W/H. Descent of a trivial line on W amounts to a
character of G, since W is geometrically connected and proper.
The descended line is trivial on U exactly when the character
vanishes on H. This holds over every coefficient scheme and yields

    ker(q^*)≅D(G^ab/im(H)),                                 (4)

with D Cartier duality. Thus κ is the degree of the maximal abelian
intermediate étale cover and divides n. Infinitesimal characters are
retained, including μ_p from étale cyclic p-covers.

Riemann–Hurwitz gives r=(n−1)(h−1). The Raynaud line has class
(p−1)Θ_U, by
[Tong, Sections1.2.1–1.2.3](https://arxiv.org/pdf/0712.2046).
Substituting (3) gives, whenever the bad scheme is finite,

    ∑_z δ_z^r≤floor(r!(p−1)^r κ/n^h).                       (5)

## 4. Cyclic triples and character refinements

The [cyclic-triple theorem](ordinary_cyclic_triple_finite_bad_cosets.md)
supplies finite bad support, with zero excluded, for n=3,h=2,p=5.
Here κ=3, r=2 and V=32/3, so

    ∑_z δ_z²≤10.                                          (6)

The audited [low-genus theorem](low_genus_raynaud_cosets.md),
applied to the genus-four curve U in characteristic five, gives
\(\delta_z=1\) for every bad two-dimensional coset. This excludes
the former defect-two alternatives everywhere, not only on free
symmetry orbits. On Q=E² the group Γ=⟨R,−1⟩≅C6 preserves the
bad set; each free orbit has six points. By (6) there can be at
most one such orbit. The low-genus step itself does not require
ordinary U. The full-kernel extension of the finiteness theorem now
removes that assumption as well. Its product-coefficient refinement
also removes ordinary Y; the numerical budget is unchanged.

For a finite prime-to-five character subgroup Λ⊂P(k), the associated
actual abelian cover b_Λ:W_Λ→U has

    generic_L h^0(W_Λ^(1),B_{1,W_Λ}⊗(qb_Λ)^(1)*L)
       =∑_(α∈Λ) δ_(ρ(α)),                                 (7)

with δ=0 off B. This is étale base change and character decomposition.
Each fiber of ρ contains at most9 elements of Λ; since δ≤δ², (6)
bounds (7) by90. This is generic defect along the Y-parameter family;
the value may be positive.
