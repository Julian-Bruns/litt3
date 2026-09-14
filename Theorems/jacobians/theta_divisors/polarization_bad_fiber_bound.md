# Intrinsic polarization bounds for finite bad fibers and determinant defects

Version4, 2026-09-14.

Let k be algebraically closed, J an abelian variety, A⊂J an abelian
subvariety, π:J→Q=J/A, and r=dim Q≥1. Let L be ample on J with a
nonzero section s. The vector bundle E=π_*L carries its induced
section σ. Put B=Z(σ), whose support parametrizes the fibers entirely
contained in div(s), and assume B is finite. Then

    ∑_(z∈supp B) e_(I_z)(O_(Q,z)) ≤ V(J,A,L) := r! χ(J,L)/χ(A,L|A),
    length(B) ≤ V(J,A,L).

Here I_z is the ideal of B at z and e_(I_z) is Hilbert–Samuel
multiplicity.

No chosen complement or external-product splitting is a hypothesis.
For an L-orthogonal complement P and ρ=π|P, this is exactly

    V(J,A,L)=c_1(L|P)^r/deg ρ.

All degrees and lengths are scheme-theoretic; inseparable isogenies
are allowed.

Suppose locally s is the determinant of a square cohomology matrix,
and let δ_z be its generic corank along π^(-1)(z). For every z∈supp B,

    I_z⊂m_z^(δ_z),       e_(I_z)(O_(Q,z))≥δ_z^r.

Consequently

    ∑_(z∈supp B) δ_z^r ≤ floor(V(J,A,L)).

A finite symmetry group preserving the quotient and determinant
family makes δ constant on each orbit, so the same budget is the
sum of orbit size times δ^r.

In particular, let q:U→Y be ANY connected finite étale cover of degree
n≥2 in characteristic p>0, with h=g(Y)≥2. On scalar Frobenius twists
take J=J(U^(1)), A=im(q^(1)*), and the Raynaud determinant pair
(L,s) for B_{1,U}. Put

    r=(n−1)(h−1),       κ=deg ker(q^(1)*:J(Y^(1))→J(U^(1))).

The norm complement P=((ker Nm_q)^0)_red has quotient isogeny
ρ:P→J/A with

    ker ρ=A∩P ⊂ J[n],       deg ρ=(n^h/κ)^2.

The kernel inclusion is scheme-theoretic, including when p divides n.
In particular, if [M] kills a point ρ(α), then [nM] kills α.

The integer κ is the degree of the maximal abelian intermediate
étale cover of q, so κ divides n. If the bad-fiber scheme B is finite, then

    ∑_(z∈supp B) δ_z^r
       ≤ floor(r! (p−1)^r κ/n^h)
       ≤ floor(r! (p−1)^r/n^(h−1)).

Here δ_z=generic_(N∈π^(-1)(z)) h^0(U^(1),B_{1,U}⊗N). Finiteness of B
is an additional assumption for arbitrary q; neither ordinarity nor
the displayed degree budget establishes it.

For the audited ordinary cyclic étale triple U/Y in characteristic
five, with Y ordinary of genus two and U ordinary, finiteness IS
known. One has r=2, κ=3, V=32/3, hence

    ∑_(z∈B) δ_z²≤10.

There are at most ten bad geometric cosets and δ_z≤2. With
Q≅E^2 and R=[[-1,-1],[1,0]], every defect-two point lies in
Q[2]∪ker(R−1). Outside that union all bad points have defect one
and form at most one free orbit under ⟨R,−1⟩≅C_6. Every finite
prime-to-five abelian character refinement from the complementary
P has generic defect along the actual Y-parameter family at most 90.

These bounds do not eliminate isolated defect-one exceptions,
produce a second map, or obstruct arbitrary common étale covers.
[Proof](../../../Proofs/jacobians/theta_divisors/polarization_bad_fiber_bound.md).
The multiplicity bound and norm kernel have bounded audits; the
ordinary cyclic-triple finiteness input is separately audited.
