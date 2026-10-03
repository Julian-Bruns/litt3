# Proof: the fixed-origin reduced-fiber differential gate

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/WILD140_ORDINARY_FOUR_PAIR_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/wild140_fixed_origin_cubic_ode_reduction.md).

The five fixed branch points form P¹(F₅) minus4. The PGL₂(F₅) stabilizer of4 acts transitively on this five-point set, so a projective change over F₅ sends any selected fixed origin to infinity while preserving that set. The transformed moving point is t′, still outside F₅. The resulting double cover is isomorphic, up to a nonzero y scale, to Yₜ′. Both original endpoint maps are retained through that coordinate isomorphism. Expanding its quintic in w=z+1 gives w⁵−(t′+1)w⁴−w+(t′+1).

We first explain the necessary differential gate, including its reduced-fiber hypothesis. Write σ=dw/y, with divisor2P. The full ordinary carrier gives dG=cF³σ and seven simple zeros of F. Put D=dF/σ. At a zero of F take the uniformizer u=F and write σ=s(u)du with s(0)≠0. The constant coefficient of C(F³σ) is s′(0)¹⁄⁵; exactness forces s′(0)=0. Thus dD/(Fσ) is regular at that point. It is regular away P and those zeros as well. Since D∈L(10P), its even part is a polynomial of degree at most five and its odd part is y times a polynomial of degree at most two. The fifth-degree even term differentiates to zero, so dD has pole at most ten. Dividing by Fσ, which has pole five at P, shows
\[
E=dD/(F\sigma)\in L(5P).
\]
This argument is necessary for a REDUCED F fiber; it is not an equivalent replacement for the full Cartier gate.

Normalize F=A+y(w−b), with a=lc(A)≠0. Put V=Φ+Φ′(w−b)/2. Then D=yA′+V. Write E=C₂+εy. The coefficient of w⁶ in dD/σ=FE forces ε=a. Comparing the even and odd parts gives
\[
(w-b)C_2+aA=V',\qquad
AC_2+a\Phi(w-b)=\Phi A''+\Phi'A'/2.
\]

Scale w=a²X,y=a⁵Y,F=a⁷F₀. Put Q=q/a²,L=−a⁻⁸,T=b/a² and B=a₁/a⁵. Then Ψ=X⁵+QX⁴+LX+QL. The original highest odd and even Cartier rows give
\[
l=3+2Q+2T,\qquad
\mathcal A=X^3+lX^2+BX-B(l-T)+3Tl^2+QT^3-L.
\]
The odd differential equation determines the quadratic C₂=c₂X²+c₁X+c₀, where
\[
c_2=2Q-1,\quad c_1=(Q-1)T-l,\quad c_0=Tc_1-B.
\]
Its remaining constant coefficient and the even equation must vanish. The w⁵ coefficient of the even equation is2(Q−1), so Q=1. Its w⁴ coefficient then is2T, so T=0. Its w³ coefficient then is3B, so B=0. Consequently l=0, 𝒜=X³−L and C₂=X². These implications use nonzero scalar coefficients only; no exceptional denominator or parameter value was omitted.

The [exact symbolic source](../../scripts/genus_two/oct03_wild140_fixed_origin_ode_identities.py) verifies these three coefficients, all remaining differential equations, and ALL remaining original Cartier rows. Its [receipt](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/ode_identity_receipt.json) preserves the identities. The check completed in2.8 seconds on one core, without a Gröbner-basis calculation. An earlier distinct generic fixed-origin Cartier Gröbner probe stopped at its six-second bound and supplied no input.

The identity Q=1 is a²=q, so L=−q⁻⁴. Smoothness excludes L=0,−1 in Ψ=(X+1)(X⁴+L). Direct differentiation verifies the displayed primitive G₀, and direct resultant calculation gives Res(N,N′)=2L¹⁰(L+1)². Thus its norm is squarefree; since N(0)=L²≠0, the same hyperelliptic branch calculation as in the [moving-origin exclusion](wild140_moving_origin_cubic_even_part_exclusion.md) shows that F₀ has seven simple zeros. This family survives both the differential and reduced-fiber gates.

Any other primitive differs by a fifth power in L(20P), hence by K₀+K₅X⁵+K₁₀X¹⁰. The primitive G₀ has exact pole eighteen, so exact pole twenty requires K₁₀≠0. At F₀=0 one has Y=(L−X³)/X and
\[
D=dF_0/\sigma=X^5+2LX+L,
\qquad G_0\equiv2D^2+3(X^{10}+LX^5+L^2)\pmod N.
\]
The last identity is verified after multiplying by X; X is invertible in the norm algebra because N(0)=L². Absorb the displayed correction packet and scale G by c⁻¹. The [actual weak completion invariant](../quotient_geometry/weak_local_completed_extension_invariant.md) then gives the stated necessary congruence. In this packet notation d₀=3+K₁₀/c, so d₀≠3 is exactly the original pole-twenty condition. The [row source](../../scripts/genus_two/oct03_wild140_fixed_origin_completion_rows.py) and [receipt](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/completion_rows.json) preserve all seven remainder equations. They have not yet been solved.

No sufficiency for a global carrier, invariant-ring generation, source atlas or second étale endpoint map is inferred. All original carrier hypotheses and both actual source maps remain in force.
