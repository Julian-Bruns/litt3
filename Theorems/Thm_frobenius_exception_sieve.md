# Frobenius localization of finite theta exceptions

Let Q/F_q be an abelian variety, F its q-power Frobenius, Γ a finite
group of F_q-defined group automorphisms, and B a finite F- and
Γ-stable set of geometric points. If a stable stratum has at most
t Γ-orbits, every point z in it satisfies

    F^m(z)=γ(z) for some 1≤m≤t and γ∈Γ.

Each F^m−γ is an isogeny with finite étale kernel. If t=1 and Γ
acts freely, the field degree of z over F_q equals the order of the
particular γ with F(z)=γ(z).

Apply this to a connected cyclic étale triple U/Y in characteristic
five, with Y ordinary of genus two and U ordinary. On scalar twists
let J=J(U^(1)), A=im J(Y^(1)), Q=J/A, and B the set of cosets of A
entirely contained in Theta_U. Choose a finite field F_q defining the
cover, an ordinary elliptic E, and the product identification Q≅E^2
with cyclic action R=[[-1,-1],[1,0]]. Then

    B⊂Q[2] ∪ ker(R−1) ∪ ⋃_(s=±1, j=0,1,2) ker(F−sR^j).

Write π=Frob_q on E, π^2−aπ+q=0, and define

    N_s=q+1−sa,
    D_s=q^2−q+1+a^2+sa(q+1),
    d_s=gcd(q−1,a+s),       s=±1.

The kernels of F−sI, F−sR, F−sR^2 have orders N_s^2,D_s,D_s,
and are annihilated respectively by N_s,D_s/d_s,D_s/d_s.
Also ker(R−1) is the diagonal E[3]. Thus every point of B is killed by

    M(q,a)=lcm(6,N_+,N_−,D_+/d_+,D_−/d_−).

Outside Q[2]∪ker(R−1), the bad points, if present, have generic
defect one and form one free C_6-orbit. Their field degree is 1,2,3,
or 6 according as F acts by I,−I,R^(±1), or −R^(±1).

The bound depends on the actual field of definition. Membership in
this finite candidate set does not imply badness or goodness. No
generic-moduli torsion assertion or common-cover exclusion follows.

[Proof](../Solutions/Sol_frobenius_exception_sieve.md).
Verification: author prose. The elliptic kernel calculation was
independently derived by `/root/frobenius_c6_exception_kernel_calculation`,
2026-09-06; this was not a full theorem audit.
