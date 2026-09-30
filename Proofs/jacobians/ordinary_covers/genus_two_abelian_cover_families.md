# Proof: Hodge degree controls the exceptional parameters

[Statement](../../../Theorems/jacobians/ordinary_covers/genus_two_abelian_cover_families.md).

## 1. The Hodge bound

The Abel pullback of [m] is defined over U/F_q. Kummer theory identifies
its geometric character lines with all of J(C_t)[m]; hence it is
connected of degree N=m^4, and Riemann–Hurwitz gives genus N+1.

After a finite base change B→P1_t, trivialize the deck group as
G=(Z/m)^4 and extend the cover to a tame admissible cover D→C of
stable curves over B. This is
[Abramovich–Corti–Vistoli, *Twisted bundles and admissible covers*,
Corollary 3.0.5 and Theorem 4.3.2](https://arxiv.org/pdf/math/0106211#page=11);
§2.2 assumes |G| prime to the residue characteristic, as here.
All degrees below are geometric, on one component after extending
constants; write b=deg(B→P1).

Write λ_C=det f_*ω_(C/B), κ_C=(ω_(C/B))², and δ_C for the total
node thickness; similarly for D. The integral Mumford isomorphism,
[Freixas i Montplet, *An arithmetic Riemann–Roch theorem for pointed
stable curves*, Theorem 3.10, n=0](https://www.numdam.org/article/ASENS_2009_4_42_2_335_0.pdf#page=13),
gives

    12 deg λ_C=κ_C+δ_C.

It applies in characteristic p. At an admissible node the cover has
local form x=z^e, y=w^e with e prime to p. Since dx/x=e dz/z, the
relative dualizing sheaf pulls back without a ramification term.
Thus κ_D=Nκ_C. A base node of thickness r has N/e source nodes of
thickness r/e, contributing Nr/e²≤Nr. Consequently

    δ_D≤Nδ_C,           deg λ_D≤N deg λ_C.                 (1)

For this genus-two family, deg λ_C=b. Indeed, du/y and u du/y
are a dualizing basis at every finite parameter, including the
nodal collisions. Near infinity put s=1/t and adjoin sqrt(s).
The equation in y'=sqrt(s)y is

    y'²=∏_(i=0)^3(u−a_i)(su−1).

Regarded as a binary sextic it has a nodal special fiber at infinity:
in z=1/u, Y=y'/u³ the equation is
Y²=z(s−z)∏(1−a_i z). The dualizing basis du/y', u du/y'
has wedge s^(−1) times the old wedge. Thus the old determinant
section has precisely the zero divisor pulled back from infinity,
of degree b. Resolving node thickness does not alter this Hodge bundle.

Frobenius on the proper nodal family gives a regular map
F_B^*R¹f_*O_D→R¹f_*O_D. Its determinant is a section of
λ_D^(p−1), nonzero because one smooth fiber is ordinary. Its
zero divisor therefore has degree at most (p−1)Nb by (1).
Over the preimage of U this is the pullback of the original family's
Hasse section, with the full ramification multiplicities. Dividing
by b bounds its zero divisor on U by (p−1)N. That divisor is defined
over F_q. Multiply the polynomial of its reduced support by
∏(t−a_i) to obtain the claimed E of degree at most (p−1)m^4+4.

Bounded audit: PASS, /root/audit_four_torsion_degree, 2026-09-14,
medium reasoning, for the Hodge calculation, admissible-node inequality
and descent of the divisor bound. The cited tame reduction supplies
the audit's stated geometric prerequisite.

## 2. One ordinary exponent-four fiber

For p=5, m=4 and a_i=i, étale base change and the character decomposition
give, with B_(1,C) the exact-differential bundle,

    a(C_(4),t)=Σ_(L in J(C_t^(1))[4]) h0(B_(1,C_t)⊗L).

The [maximal-two theorem](genus_two_maximal_two_cover.md) makes the
16 order-dividing-two terms zero whenever t is outside F25.
It remains to check the 240 exact-order-four classes at one parameter.

The verifier works in F5[a]/(a^6+a^4+4a^3+a²+2), with t=a^126
of degree 3 over F5. On C_t^(1) put τ=t^5, α=(0,1,2,3,τ),
F1(u)=∏(u−α_j). For i=0,1,2,3 choose r_j²=α_i−α_j,
r_i=0, and let s_j be their elementary symmetric functions. Set

    U_r=(α_i−u)²+s_2(α_i−u)+s_4,
    V_r=(s_3−s_1s_2)(α_i−u)−s_1s_4.

[Zarhin, *Division by 2 on odd degree hyperelliptic curves and their jacobians*,
Theorem 3.2 and Example 3.7](https://arxiv.org/html/1809.03061v2)
give a class H_i represented by (U_r,V_r) with
2H_i=[(α_i,0)−O]. The checker also verifies
F1−(s_1U_r+V_r)²=(u−α_i)U_r². The four displayed two-classes
are independent, so the H_i generate all J[4]≅(Z/4)^4.

The certificate constructs all 256 distinct classes and checks their
actual orders. For each of the 240 order-four classes (U,V) it verifies
deg U=2 and gcd(U,F1)=1, then evaluates both the original four-by-four
Cartier determinant and the compressed quadric of the
[Raynaud determinant theorem](../theta_divisors/raynaud_genus_two_determinant.md).
Every determinant is nonzero and the two tests agree. Together with
the 16 lower-order terms this proves the required ordinary fiber.
The finite torsion and determinant certificate retains its original
computational evidence.

## 3. Both original legs

If W→C_t is Galois with normal 5-subgroup P and abelian exponent-four
quotient, W/P is dominated by C_(4),t and is ordinary. By
[Crew, Corollary 1.8.3](https://numdam.org/item/CM_1984__52_1_31_0.pdf#page=7),
W is ordinary, with no bound on |P|. For an actual span X←Z→C_t,
the genuine Galois closure of the C_t-leg still maps étale to X
via Z. Pullback of a nonzero Cartier-zero differential from a
nonordinary X contradicts ordinarity of W.

The selected parameter has degree r>K≥(336000−1)! over F25,
so also degree greater than 1028 over F5. The maximal-two theorem
is still useful: it gives the complete exceptional set and a-number,
whereas (1) bounds an exceptional divisor without identifying its roots.
