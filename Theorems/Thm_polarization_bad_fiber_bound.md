# Intrinsic polarization bounds for finite bad fibers and determinant defects

Version 2, 2026-09-07. Author prose; not independently audited.

Let k be algebraically closed, J an abelian variety, A⊂J an abelian
subvariety, π:J→Q=J/A, and r=dim Q≥1. Let L be ample on J with a
nonzero section s. The vector bundle E=π_*L carries its induced
section σ. Put B=Z(σ), whose support parametrizes the fibers entirely
contained in div(s), and assume B is finite. Then

    length(B) ≤ V(J,A,L) := r! χ(J,L)/χ(A,L|A).

No chosen complement or external-product splitting is a hypothesis.
For an L-orthogonal complement P and ψ=π|P, this is exactly

    V(J,A,L)=c_1(L|P)^r/deg ψ.

All degrees and lengths are scheme-theoretic; inseparable isogenies
are allowed.

Suppose locally s is the determinant of a square cohomology matrix,
and let δ_z be its generic corank along π^(-1)(z). For every z∈supp B,

    I_(B,z)⊂m_z^(δ_z),
    length(O_(B,z))≥w_r(δ_z),   w_r(d):=binomial(r+d−1,r).

Consequently

    ∑_(z∈supp B) w_r(δ_z) ≤ floor(V(J,A,L)).

A finite symmetry group preserving the quotient and determinant
family makes δ constant on each orbit, so the same budget is the
sum of orbit size times w_r(δ).

In particular, let q:U→Y be ANY connected finite étale cover of degree
n≥2 in characteristic p>0, with h=g(Y)≥2. On scalar Frobenius twists
take J=J(U^(1)), A=im(q^(1)*), and the Raynaud determinant pair
(L,s) for B_U. Put

    r=(n−1)(h−1),       κ=deg ker(q^(1)*:J(Y^(1))→J(U^(1))).

The integer κ is the degree of the maximal abelian intermediate
étale cover of q, so κ divides n, including when p divides n. If
the bad-fiber scheme B is finite, then

    ∑_(z∈supp B) w_r(δ_z)
       ≤ floor(r! (p−1)^r κ/n^h)
       ≤ floor(r! (p−1)^r/n^(h−1)).

Here δ_z=generic_(N∈π^(-1)(z)) h^0(U^(1),B_U⊗N). Finiteness of B
is an additional assumption for arbitrary q; neither ordinarity nor
the displayed degree budget establishes it.

For the audited ordinary cyclic étale triple U/Y in characteristic
five, with Y ordinary of genus two and U ordinary, finiteness IS
known. One has r=2, κ=3, V=32/3, hence

    ∑_(z∈B) δ_z(δ_z+1)/2≤10.

There are at most ten bad geometric cosets and δ_z≤2. With
Q≅E^2 and R=[[-1,-1],[1,0]], every defect-two point lies in
Q[2]∪ker(R−1). Outside that union all bad points have defect one
and form at most one free orbit under ⟨R,−1⟩≅C_6. Every finite
prime-to-five abelian character refinement from the complementary
P has generic defect along the actual Y-parameter family at most 90.

These bounds do not eliminate isolated defect-one exceptions,
produce a second map, or obstruct arbitrary common étale covers.
[Proof](../Solutions/Sol_polarization_bad_fiber_bound.md).
The ordinary cyclic-triple finiteness input remains separately audited;
that audit is not an audit of this generalization.
