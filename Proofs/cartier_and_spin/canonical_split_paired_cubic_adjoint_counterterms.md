# Proof: two actual cubic extensions and their common global error

Version1, 3 October2026. [Fresh independent whole audit PASS](../../Research/audits/CANONICAL_SPLIT_PAIRED_CUBIC_ADJOINT_COUNTERTERMS_AUDIT_2026_10_03.md), with no required corrections. No computation is used.

## 1. The actual image and conductor section

The accepted [conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) gives the smooth rational surface S, six reducible fibers, D±²=−3,D₊D₋=0 and
\[
K_S=-D-2F,\quad L=D+3F,\quad L²=6.
\]
The actual field equality makes C₀→C the normalization of the integral Cartier image. Disjointness of H₁,H₂ makes C disjoint from D and ν*F∞=H₂,ν*F₀=H₁. The simple zeros and poles of t make its actual degree-r map separating. The actual intersection and genus identities are
\[
CF=r,\quad CD_\pm=0,\quad CL=3r,\quad K_SC=-2r,
\qquad g(C₀)=8r+1.
\]
Write δ=pₐ(C)−g(C₀). Adjunction gives C²=18r+2δ.

As in the accepted [degree-thirteen adjoint proof](canonical_thirteen_split_disjoint_cubic_adjoint_exclusion.md), finite duality identifies ν*ω_C⊗ω_C₀⁻¹ with the actual conductor. The nonzero θ₂ with divisor16H₂ consequently gives
\[
\sigma_C\in H⁰(C,O_C(C-D-18F_\infty)).
\]
Its pullback zero divisor is exactly Δ, the conductor divisor. This does not assume that a normalization function descends to C.

For E_k=−D−kF, k=18 or8, h⁰(E_k)=0 by negative fiber degree. Surface Riemann–Roch and Serre duality give χ(E_k)=k−1 and h²(E_k)=h⁰((k−2)F)=k−1, hence H¹(E_k)=0. Thus σ_C lifts to S. Its divisor intersects each D± by−15, so it contains at least5D. Dividing out the canonical section of5D gives the effective section ρ of
\[
R=C-6D-18F_\infty=C-6L.
\]
As C avoids D, ν*R=Δ, RF=r−12,RD±=0.

## 2. The second endpoint uses the SAME adjoint

Conductor multiplication makes σ_Cy₂ regular as a section of C−D−8F∞. Its restriction kernel is−D−8F∞, whose H¹ vanishes. Its extension has intersection−5 with each boundary, hence fixed factor2D. Dividing that factor gives a section a of3D+10F∞+R whose restriction to the actual normalization is ρy₂, using the canonical nonvanishing boundary section on C.

For the other ACTUAL endpoint, σ_Cy₁ is regular in
\[
O_C(C-D-18F_\infty+10F₀).
\]
This follows from its actual pole divisor10H₁ and the SAME conductor multiplication. The extension kernel is−D−18F∞+10F₀, linearly equivalent to−D−8F∞ because F₀−F∞=div(t). Its H¹ therefore vanishes too. The extension again has boundary intersection−5, giving fixed factor2D. After division it gives
\[
a₁\in H⁰(S,O_S(3D+10F₀+R)),\quad a₁|C=\rho y₁.
\]
Multiplication by t¹⁰ changes its allowed fiber poles from10F₀ to10F∞. Thus b=t¹⁰a₁ is a global section of3D+10F∞+R, with actual restriction b=t¹⁰ρy₁. No second choice of adjoint or arbitrary singular-image cubic root has been introduced.

## 3. The two derivations and their exact residue constants

Both displayed derivations preserve u²−v²=d(t⁶−1), as direct substitution shows. For E one may alternatively swap the actual endpoints: τ=t⁻¹,u₁=v/t³,v₁=u/t³ satisfy u₁²−v₁²=d(τ⁶−1), and E=t²𝒟₁ for the natural first-leg derivation 𝒟₁(τ)=v₁,𝒟₁(u₁)=0,𝒟₁(v₁)=−3dτ⁵.

For Ω=dt∧du/v, of divisor−D−2F∞, direct contraction gives
\[
\iota_{\mathcal D}\Omega=du,
\qquad \iota_E\Omega=-t⁴d(v/t³)=-t⁴dx₁.
\tag{1}
\]
The conic differential identity udu−vdv=3dt⁵dt verifies the second formula even when using the u-chart. It is an identity of rational forms, hence extends wherever either representation is regular.

Use a rational R frame and the compatible defining section Q of C in C=6D+18F∞+R. Finite duality and the ACTUAL construction of σ_C identify the residue of Ω/Q with a nonzero constant times θ₂/ρ on the normalization, exactly as in the degree-thirteen proof. The boundary factors are nonvanishing on C and have their canonical trivialization. The first contraction therefore gives
\[
\mathcal DQ=\lambda₂\rho y₂²=\lambda₂a²/\rho
\quad\text{on }C,
\quad\lambda₂\in k^\times.
\tag{2}
\]
The SAME residue, using the second contraction, gives
\[
\frac{du}{\mathcal DQ}=\frac{-t⁴dx₁}{EQ}.
\]
The actual canonical identity says dx₁=κt¹⁶(y₁²/y₂²)du. Substitution into(2) gives
\[
EQ=-κ\lambda₂t^{20}\rho y₁²
=\lambda₁b²/\rho,
\qquad\lambda₁=-κ\lambda₂.
\tag{3}
\]
All equalities in(2)–(3) are identities in the actual function field of C. Its coordinate differentials are nonzero because its two endpoint maps are finite étale, hence separating.

## 4. Global pole bundles, including the transverse second field

The function P₂=P(u−1) has poles bounded by10D+30F∞. The function
\[
P₁=t^{30}P(v/t³-1)
\]
has the SAME bound. Indeed, expansion in powers of v−t³ has factors t^{30−3j},0≤j≤10, so there is no pole at F₀. Its boundary poles are at most10 and at infinity it is t³⁰P(V−1), with pole at most30. Moreover 𝒟P₂=0 and EP₁=0: E fixes v/t³, and E(t³⁰)=0 in characteristic5.

Consequently
\[
N₂=a³-P₂\rho³,\qquad N₁=b³-P₁\rho³
\]
are global sections of10D+30F∞+3R. The a³ and b³ terms have the smaller boundary bound9D, and are included using the canonical boundary section. Their actual restrictions vanish. As C is a prime Cartier divisor, divisibility by its defining section is GLOBAL and gives
\[
W_i=N_i/Q\in H⁰(S,O_S(4D+12F_\infty+2R)).
\tag{4}
\]
This is global sheaf divisibility, not interpolation on a fiber.

We verify the same bundle for
\[
J₂=\rho\mathcal Da-a\mathcal D\rho,
\qquad J₁=\rho Eb-bE\rho.
\tag{5}
\]
On the affine surface the derivations are regular, including the six conic nodes. Their formulas have no other finite vertical pole. The derivative of a common local R frame cancels in each Wronskian, so these local expressions transform with precisely the square of that frame.

At either boundary use h=1/u as its local normal parameter. The fields have pole at most one in their tangential coefficients, while
\[
\mathcal D(h)=0,\qquad E(h)=3(1+dh²)
\tag{6}
\]
are regular. Relative to a common R frame, a and b have allowed pole3 in h and ρ has none. In differentiating that relative h⁻³ weight, the second field introduces at most one further pole, by(6); the first introduces none. Differentiating the regular coefficients introduces at most the one allowed tangential pole. Both Wronskians thus have boundary bound4D+2R.

At infinity put s=t⁻¹,U=s³u,V=s³v. Direct calculation gives
\[
s²\mathcal D(s)=-sV,\quad s²\mathcal D(U)=-3UV,
\quad s²\mathcal D(V)=-3(U²+ds⁶),
\]
\[
s²E(s)=U,\quad s²E(U)=-3ds⁵,\quad s²E(V)=0.
\tag{7}
\]
Both scaled fields are regular. Unlike the first, s²E is transverse to F∞ at U≠0. Let e be a local R frame, and write a=e s⁻¹⁰a₀,ρ=eρ₀ with a₀,ρ₀ regular; the same expression holds with b in place of a. For either field V₀, the R-frame derivatives cancel and its Wronskian is
\[
e²s^{-10}\bigl(\rho₀V₀a₀-a₀V₀\rho₀
-10s^{-1}V₀(s)\rho₀a₀\bigr).
\]
The coefficient10 is zero in characteristic5. Formula(7) therefore bounds the fiber pole by12, even for E. This calculation can be made away from D; together with the boundary valuation calculation it controls every prime divisor. S is smooth, so absence of further divisorial poles proves that BOTH sections in(5) belong to4D+12F∞+2R. It also explains why common-frame cancellation, rather than differentiating a line-bundle section in an unspecified frame, is essential.

## 5. The second Cartier division produces the exact errors

Differentiate N₂=QW₂ by 𝒟 and restrict to C. Since 𝒟P₂=0 and P₂ρ³=a³ there, one gets
\[
W₂\mathcal DQ=(3a²/\rho)J₂.
\]
By(2), W₂=(3/λ₂)J₂ on C. The same calculation with E,P₁,b and(3) gives W₁=(3/λ₁)J₁. Cancellation is legitimate in k(C), since ρ and the actual yᵢ are nonzero functions.

Set γᵢ=3/λᵢ. Each Wᵢ−γᵢJᵢ is a global section of the bundle in(4) and vanishes on the integral C. Dividing by Q once more gives
\[
\varepsilon_i\in H⁰(S,O_S(4D+12F_\infty+2R-C))
=H⁰(S,O_S(C-8L)).
\]
Rearranging proves the paired identities, with γ₁=−κ⁻¹γ₂. The argument is independent of r; it retains the exact possible error when a generic fiber degree count is insufficient.

## 6. Degrees fifteen, sixteen and seventeen

For the error bundle A=C−8L, AF=r−16 and AD±=0. A nonzero effective section is impossible when r≤15 by negative fiber degree. Hence both errors vanish in those degrees.

At r=16 an effective error divisor has fiber degree0, so every component is vertical. Every vertical irreducible component of this conic bundle meets at least one boundary positively. Since its two boundary intersections are zero, the effective divisor must be zero. The section therefore trivializes A and forces C linearly8L. Conversely H⁰(A)=k in that class because S is projective and connected. Thus both errors are scalars there, and vanish outside that class.

The six-fiber blowup basis has B=D₋,D₊=B+3F−ΣEᵢ and
\[
C=rB+3rF-\sum a_iE_i,\qquad\sum a_i=3r.
\]
The linear class C=8L is exactly r=16 and aᵢ=8 for all six. Its invariant values follow from L²=6,K_SL=−4 and actual étaleness: C²=384,pₐ(C)=177,g(C₀)=129,δ=48,R=2L,degΔ=96.

More generally, if an error is nonzero, C cannot be a component of its effective zero divisor because AF=r−16<CF=r. Positivity of intersection with the distinct integral C gives
\[
0\le AC=C²-8CL=2δ-6r,
\]
so δ≥3r.

At r=17 an effective error divisor has fiber degree1. It has exactly one horizontal component H, with multiplicity1, and H is a section: its proper degree-one morphism to the smooth base is an isomorphism. If H is nonboundary, all intersections with D± are nonnegative, and the two zero totals exclude all vertical components and force H disjoint from both boundaries. If H is one boundary, the zero intersection with the opposite boundary excludes every vertical component meeting that opposite side, including smooth whole fibers. The remaining vertical components are the components of the six reducible fibers meeting the affected section, and their total intersection with it is3, to cancel its square−3. This is the stated exact effective-divisor classification; it is not an existence claim for an actual error or source.

## 7. The derivative-square corollary and its exceptional sectors

Assume both errors vanish. Let Z be a multiplicity-one irreducible component of R, neither a boundary nor F₀ or F∞, and suppose a,b are generically nonzero on Z. At its generic point all frames can be chosen regular and Q is nonzero, since C cannot be a component of R: RF=CF−12<CF. Restricting the paired identities to ρ=0 and cancelling a,b gives
\[
a²=-\gamma₂Q\mathcal D\rho,
\qquad b²=-\gamma₁QE\rho.
\tag{8}
\]
In particular both derivatives of the local equation of Z are nonzero. The simple-pole residue of Ω/ρ along Z, with(1), gives
\[
\frac{du}{\mathcal D\rho}
=\frac{-t⁴dx₁}{E\rho}.
\tag{9}
\]
It is a nonzero rational differential on the normalization of Z, so du and dx₁ are nonzero there. Dividing(8) and then using(9), together with γ₁/γ₂=−κ⁻¹, gives
\[
\frac{\mathcal D\rho}{E\rho}
=-κ^{-1}(a/b)²=-t^{-4}\frac{dx₂}{dx₁},
\]
which proves the square formula. A change of common R frame multiplies both derivatives along ρ=0 by the same unit; a/b is unchanged. Thus the formula is intrinsic to this generic component.

If a nonboundary component away from F∞ has multiplicity at least2 in R, both regular derivations send ρ to a function still vanishing there. Restricting the whole identities immediately gives a³=b³=0 on that component, so both extensions vanish identically. If either a or b vanishes on a reduced component, the cancellations in(8) are unavailable and no derivative-square conclusion is asserted. Boundary and excluded fiber components also require their own local frames and remain separate.

The coordinate functions on Z are auxiliary functions. In particular a/ρ and b/ρ cannot be restricted to Z to invent endpoint maps. The low-genus discussion and rational examples in [the exploration note](../../Research/notes/oct03_ten_hour/split_second_cubic_conductor_gauss.md) show why the square condition alone is not an exclusion. The theorem preserves BOTH actual cubics, exact residues and integral errors for further actual-source arguments; it does not solve the unmarked common-cover problem.
