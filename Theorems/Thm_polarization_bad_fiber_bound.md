# Polarization bounds for finite bad-fiber schemes and determinant defects

Let k be algebraically closed, J an abelian variety, A⊂J an abelian
subvariety, π:J→Q=J/A, and P a complementary abelian subvariety. Put
ψ=π|P, r=dim P=dim Q≥1, and e=deg ψ. Let L be ample on J with
nonzero section s. Assume addition a:A×P→J satisfies

    a^*L≅L_A⊠L_P

for ample L_A and L_P, including any Picard-zero twists. The bundle
E=π_*L has section σ corresponding to s. Let B=Z(σ), the scheme
whose support parametrizes fibers entirely contained in div(s).
If B is finite, then

    e length(B)≤c_1(L_P)^r.

Both degree and length are scheme-theoretic; ψ need not be separable.

Now suppose J=J(C^(1)) in characteristic p>0, and (L,s) is the
Raynaud determinant line bundle and section for B_C, with numerical
class (p−1)Theta. For z∈supp B put
δ_z=generic_(N∈π^(-1)(z)) h^0(C^(1),B_C⊗N). Then

    I_(B,z)⊂m_z^(δ_z),
    length(O_(B,z))≥binomial(r+δ_z−1,r).

Under the finiteness assumption,

    ∑_(z∈supp B) binomial(r+δ_z−1,r)
       ≤floor(c_1(L_P)^r/e).

If a finite group preserves the quotient, determinant family, and
bad scheme, δ is constant on each orbit; the same inequality is the
sum of orbit size times the corresponding binomial coefficient.

For an ordinary cyclic étale triple U/Y over F̄_5 with Y ordinary
of genus two and U ordinary, use J=J(U^(1)) and A=im J(Y^(1)).
Then r=2, e=9, c_1(L_P)^2=96, and

    ∑_(z∈B) δ_z(δ_z+1)/2≤10.

There are at most ten bad geometric cosets and δ_z≤2. Under
Q≅E^2 and R=[[-1,-1],[1,0]], every defect-two point lies in
Q[2]∪ker(R−1). Outside that union, all possible bad points have
defect one and form at most one free orbit under ⟨R,−1⟩≅C_6.

These bounds do not eliminate reduced isolated defect-one exceptions.
[Proof](../Solutions/Sol_polarization_bad_fiber_bound.md).
Verification: author prose, not independently audited.
