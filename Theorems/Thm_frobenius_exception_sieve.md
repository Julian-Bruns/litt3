# Frobenius localization and explicit stabilization of finite theta exceptions

Version 2, 2026-09-07. Author prose; not independently audited.

Let Q/F_q be an abelian variety, F its q-power Frobenius, and Γ a
finite group of geometric group automorphisms normalized by Frobenius:
Fγ=α(γ)F for some α∈Aut(Γ). Let B be a finite F- and Γ-stable set.
If a stable stratum has at most t Γ-orbits, then

    z∈⋃_(1≤m≤t, γ∈Γ) ker(F^m−γ)       for every z in that stratum.

Each F^m−γ is an isogeny with finite étale kernel. The automorphisms
need not individually be defined over F_q. If m is the least return
time of Γz under F and F^m z=γz, then the field degree of z is

    m·min{k≥1 : α^((k−1)m)(γ)⋯α^m(γ)γ∈Stab_Γ(z)}.

When α=1 and Γ acts freely, this is m·ord(γ). The field degree is
always at most the number of points in the stable stratum.

Suppose B is the support of a finite F_q-defined determinant bad-fiber
scheme in quotient dimension r, with Frobenius- and Γ-invariant
generic defect δ and polarization budget ∑_B w_r(δ)≤K, where
w_r(d)=binomial(r+d−1,r). A stable stratum with δ≥d and all Γ-orbits
of size at least s has at most

    t=floor(K/(s w_r(d)))

orbits; if t=0 it is empty. Its points have field degree at most
floor(K/w_r(d)). More precisely the closed points satisfy

    ∑_(z closed in B) [k(z):F_q] w_r(δ_z)≤K.

For any actual connected étale cover f:U→Y of degree n≥2 in
characteristic p, with h=g(Y)≥2 and finite bad locus, put
J=J(U^(1)), A=im(f^(1)*), Q=J/A, r=(n−1)(h−1),
κ=deg ker(f^(1)*), and take

    K=floor(r! (p−1)^r κ/n^h),
    M_K=lcm_(1≤j≤K) |Q(F_(q^j))|.

Here F_q is an actual field of definition of the quotient family,
and an empty lcm is 1. Choose a complementary P⊂J(U^(1)), write
e=deg(ψ:P→Q), and let N be the prime-to-p part of eM_K. Every
exceptional prime-to-p character in P lies in P[N]. The degree
N^(2r) character cover of U already reaches the stabilized generic
defect along the Y-parameter family, at most e_(p')K. This value is
unchanged for every finite prime-to-p character subgroup containing
P[N]. One may choose the principal-polarization complement, for
which e=(n^h/κ)^2. No bad-locus finiteness for arbitrary U/Y is
asserted here.

Apply this to a connected cyclic étale triple U/Y in characteristic
five, with Y ordinary of genus two and U ordinary. On scalar twists
put J=J(U^(1)), A=im J(Y^(1)), Q=J/A, and let B be the bad cosets for
the Raynaud divisor. Choose F_q defining the cover, the ordinary
elliptic E, and the product identification Q≅E^2 with
R=[[-1,-1],[1,0]]. Then

    B⊂Q[2] ∪ ker(R−1) ∪ ⋃_(s=±1, j=0,1,2) ker(F−sR^j).

Write π=Frob_q on E, π^2−aπ+q=0, and put

    N_s=q+1−sa,
    D_s=q^2−q+1+a^2+sa(q+1),
    d_s=gcd(q−1,a+s),       s=±1.

The kernels of F−sI, F−sR, F−sR^2 have orders N_s^2,D_s,D_s
and integer annihilators N_s,D_s/d_s,D_s/d_s, respectively.
Also ker(R−1) is the diagonal E[3]. Every point of B is killed by

    M(q,a)=lcm(6,N_+,N_−,D_+/d_+,D_−/d_−).

Outside Q[2]∪ker(R−1), bad points have defect one and form at most
one free C_6-orbit. Their field degrees are 1,2,3, or 6 according
as F acts by I,−I,R^(±1), or −R^(±1).

On the complementary P≅E^2, ψ=π|P has matrix
H=[[2,−1],[−1,2]]. Put N equal to the prime-to-five part of 3M(q,a).
Every exceptional prime-to-five character α∈P(k), meaning
ψ(α)∈B, lies in P[N]. The actual character refinement with group
of characters P[N] has degree N^4 over U and already reaches the
stabilized generic defect along the Y-parameter family. That defect
is at most 90 and is unchanged for every finite prime-to-five
character subgroup Λ containing P[N]. It need not be zero.

The bounds depend on the actual finite-field model. Candidate
membership does not imply badness. Finite bad support is essential;
no generic-moduli torsion assertion or common-cover exclusion follows.
[Proof](../Solutions/Sol_frobenius_exception_sieve.md).
The elliptic kernel calculation was independently derived by
/root/frobenius_c6_exception_kernel_calculation, 2026-09-06; this was
not a full theorem audit. Version 2's extensions are author prose.
