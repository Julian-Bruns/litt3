# Proof: entire single-cubic extensions force degree twenty

Version1, 3 October2026. [Theorem](../../Theorems/cartier_and_spin/canonical_split_full_cubic_extension_degree_twenty_boundary.md). Frozen pending fresh bounded whole scope/presentation audit and root registration. No computation is used.

## 1. Original source, adjoint and possible error

Retain BOTH actual finite étale equal-degree r≥12 maps to X from the SAME smooth projective C₀, their ACTUAL functions and cubics, disjoint reduced infinity divisors, and
\[
k(C₀)=k(t,x₁,x₂),\quad q₀(x₂)=t⁶q₀(x₁),\quad
\operatorname{div}(t)=H₁-H₂,\quad \theta₁=\kappa t^{16}\theta₂.
\]
The accepted [actual conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) makes C₀ the normalization of the integral Cartier image C in the smooth surface S. Its affine coordinates are u=x₂+1,v=t³(x₁+1), with u²−v²=d(t⁶−1). The boundary sections satisfy D±²=−3,D₊D₋=0. For D=D₊+D₋ and L=D+3F, one has K_S=−D−2F,L²=6,K_SL=−4. Actual field generation and disjoint infinities give CF=r,CD±=0,CL=3r; actual étaleness gives g(C₀)=8r+1.

The accepted [paired adjoint theorem](canonical_split_paired_cubic_adjoint_counterterms.md) constructs the EFFECTIVE R=C−6L, with RF=r−12,RD±=0 and ν*R equal to the exact conductor divisor Δ. The same normalization-duality section supplies ρ,a,b, with actual restrictions a=ρy₂,b=t¹⁰ρy₁. It does not assume that a normalization cubic function descends to C without its conductor multiplier.

For
\[
\mathcal D(t)=v,\quad \mathcal D(u)=0,\quad\mathcal D(v)=-3dt⁵,
\]
the GENERAL second-leg identity is
\[
a³-P(u-1)\rho³
=cQ(\rho\mathcal Da-a\mathcal D\rho)+Q²\varepsilon₂,
\qquad\varepsilon₂\in H⁰(C-8L),\quad c\ne0.
\tag{1}
\]
Here Q defines the actual C, and c=3/λ is the exact nonzero residue calibration. The paired actual first-leg identity is also retained throughout; no source-free polynomial identity is substituted for either leg.

## 2. The entire factor forces its individual error to vanish

Assume ENTIRE ρ divides a globally. Then h=a/ρ belongs to3D+10F∞ as a genuine rational function and restricts to the ACTUAL y₂. Its Wronskian becomes ρ²𝒟h, so(1) gives
\[
\rho³(h³-P(u-1))=cQ\rho²\mathcal Dh+Q²\varepsilon₂.
\tag{2}
\]
C shares no component with R because C is integral and CF=r>r−12=RF. Thus generic prime valuations in(2) force the ENTIRE2R divisor in ε₂. Its residual bundle is
\[
(C-8L)-2R=4L-C,\qquad(4L-C)F=8-r<0.
\]
It has no nonzero section. Hence ε₂=0, even in degrees where the GENERAL paired error may be nonzero. This is a full-factor implication, not automatic vanishing of all paired errors.

## 3. A genuine rational derivative gives the residual critical divisor

The derivative 𝒟h is a global section of4D+12F∞. On the finite affine surface the vector field is regular, including the six nodes of reducible conic fibers, and h has no allowed pole. At either boundary, the derivation fixes1/u and has at most a simple tangential pole, giving boundary pole at most four. At the generic infinity fiber away from D, write s=t⁻¹ and h=s⁻¹⁰h₀. The scaled field Δ=s²𝒟 is regular and
\[
\mathcal Dh=s^{-12}\Delta h₀,
\]
since coefficient10 is zero. These separate prime-divisor calculations also control the boundary corners; no covariant derivative of an unspecified R frame is being asserted.

With ε₂=0, cancel ρ² in(2). Since Q and ρ share no prime component, the resulting Cartier identity forces the entire factor ρ in 𝒟h. Therefore
\[
G=\mathcal Dh/\rho\in H⁰(S,O_S(A)),\qquad
A=4D+12F_\infty-R,
\]
\[
h³-P(u-1)=cQG,\qquad AF=20-r,\quad AD±=0.
\tag{3}
\]
This section is nonzero. Otherwise P(u−1) would be a cube in k(S). At every simple P root α, its factor u−(α+1) has a reduced affine divisor: v²=q₀(α)−dt⁶ has q₀(α)≠0 and six simple finite branch values. The P factor consequently has valuation one at a prime of that fiber, incompatible with a cube.

## 4. Monicity removes the entire boundary and all vertical components

View the numerator in(3) as a section of10D+30F∞. The rational function h³ has poles at most9 along EACH boundary, while monic P(u−1) has exact pole10 because u has a simple pole there. Thus the numerator section is NONZERO at both generic boundary points. C avoids D, so Q's section is a unit there. It follows that div(G) has NO boundary component.

All other effective component intersections with D± are nonnegative. Since AD±=0, div(G) is disjoint from both boundaries. Every vertical prime of this smooth conic bundle meets at least one boundary positively, whether a smooth fiber or a component of one of the six reducible fibers. Therefore div(G) has NO vertical component at all. This conclusion does not assume a vertical-adjoint exclusion for R; R itself may still contain F∞.

If r>20, the negative fiber degree AF already contradicts nonzero effective G. Hence henceforth12≤r≤20, with0≤AF≤8.

## 5. Auxiliary infinity points are units, including the R-fiber case

At infinity put s=t⁻¹,U=s³u,V=s³v. The conic is U²−V²=d(1−s⁶), and on its rational infinity fiber put
\[
z=U+V,\qquad U=(z+d/z)/2,\quad V=(z-d/z)/2,
\qquad\delta=-3Uz\partial_z.
\]
Every ACTUAL C₀ point over infinity has s as parameter and U a unit: x₂ has exact pole three by actual étaleness, and t simple pole. Thus C avoids the TWO auxiliary points P± where U=0; Q's section is a unit at each.

The full ratio h has allowed poles3D+10F∞, so h∞=h₀|F∞ is a Laurent function with pole bounds3 and3 and no finite pole. If its derivative δh∞ is nonzero, its total polar degree is at most8. If R does not contain F∞, local regular frames in the full identity give
\[
\rho_\infty(h_\infty³-U^{10})=cQ_\infty\delta h_\infty.
\tag{4}
\]
This forces h∞ nonconstant: otherwise the nonzero ρ∞ would imply h∞³=U¹⁰ in k(z), impossible. At an auxiliary point U is a parameter and δ=U·unit·∂U. Let k≥0 be the local section zero order of ρ∞. If h∞ has a positive zero order n, then n≤6 by its total polar bound. For n=1,2,3,4,6, δh∞ has order n, whereas the left of(4) has the larger order k+min(3n,10); here3n≠10, so there is no leading cancellation. For n=5, the left has exact order k+10 while the derivative has zero order at most8, again impossible. Hence h∞ is a UNIT at BOTH auxiliary points. From(3), G is a unit there too.

If R DOES contain F∞, its positive s-order makes the restricted identity before dividing ρ give δh∞=0. A fifth-power Laurent function with boundary pole bounds3 and3 is constant. If this constant is nonzero, (3) again makes G a unit at the auxiliary points. If it is zero, the numerator restricts to−U¹⁰, so G|F∞ has zero order10 at EACH auxiliary point, since Q is a unit there. This contradicts its effective restriction degree AF≤8.

Thus in every case G meets infinity only where U is a unit. This argument makes NO bound on the number of actual branches over an image and never equates at most three tangent phases with at most three branches.

## 6. Every component contribution is divisible by five

Write div(G)=Σm_jZ_j, where all components are horizontal, f_j=Z_jF>0 and Σm_jf_j=20−r. They avoid D, and all their infinity intersections have U a unit. On each normalization u=s⁻³U has exact pole order3e at a branch of base index e and no other pole. Therefore
\[
\deg(u:\widetilde Z_j\to P¹)=3f_j.
\tag{5}
\]
Restriction of(3) gives h³=P(u−1) on each component, hence a genuine nonconstant AUXILIARY cubic map to X. It is used only for genus and is not either original finite étale leg.

Differentiating(3), using 𝒟P=0 and 𝒟h=ρG, gives
\[
\frac{\mathcal DG}{G}
=\frac3c\frac{\rho h²}{Q}-\frac{\mathcal DQ}{Q}.
\tag{6}
\]
At a generic G component the right side is regular. Q is a unit there because GF=20−r<r=CF. All functions and the derivation are regular at that finite horizontal generic point; if the same component occurs in R, its zero ρ causes no pole. If5∤m_j, logarithmic differentiation therefore forces 𝒟 tangency to Z_j. Its induced derivation is nonzero: Dt=v cannot be identically zero, because tangency would then also require Dv=−3dt⁵=0 on a horizontal component. Since Du=0 and k is perfect, u is a fifth power on that one-variable field. Hence5 divides deg u=3f_j and5|f_j.

If5 divides m_j the product m_jf_j is already divisible by five. Thus EVERY component contribution is divisible by five, so5 divides20−r. The range0≤20−r≤8 leaves only r15 or20.

## 7. The degree-fifteen auxiliary curves contradict genus

At r15 the total fiber degree of G is five. The divisibility argument leaves exactly one reduced component of fiber degree5, or five times a degree-one component.

For div(G)=5Z with ZF=1, the normalization is P¹. By(5), u has degree3. The auxiliary cubic h³=P(u−1) gives the genus-nine field of X, of degree3 over k(u), so equality of these degrees identifies it with the rational field of Z, impossible.

For reduced ZF=5, tangency gives u=f⁵ with deg f=3 and separating t of degree5. The conic field is generated by t,u,v, with quadratic degree at most2 over k(t,u). This degree divides5, hence is one; therefore k(Ẑ)=k(t,u)=k(t,f). Both t and f are separating and generate the field, so Castelnuovo–Severi gives genus at most(5−1)(3−1)=8.

On the other hand h³=P(f⁵−1)=[P^{1/5}(f−1)]⁵. If w=P^{1/5}(f−1), the identity h=(w²/h)⁵ gives h=h₀⁵; Frobenius injectivity yields h₀³=P^{1/5}(f−1). This is the inverse Frobenius twist of X, still genus9. Its trigonal coordinate f has degree3 on Ẑ, so the field inclusion has degree one. The resulting genus9 contradicts the bound8. This is the already independently audited auxiliary genus step; no new original étale leg was introduced.

Thus only r20 remains.

## 8. The retained degree-twenty boundary and the actual swap

At r20, G has fiber degree zero and no horizontal or vertical component. Its divisor is EMPTY. G is a nonzero nowhere-zero section, NOT the zero section. It trivializes A and forces
\[
R\sim4D+12F=4L,\qquad C\sim6L+R=10L.
\]
In its induced trivialization G is a nonzero scalar, and(3) is exactly the stated cubic and derivative boundary normal form.

Since L²=6,K_SL=−4, the necessary values are C²=600,K_SC=−40,pₐ(C)=281. Actual étaleness gives g(C₀)=161, so δ=120 and degΔ=240. Also RL=24. In the blowup basis B=D₋,D₊=B+3F−ΣEᵢ, the class10L is20B+60F−10ΣEᵢ, giving all six allocations10. These are exact boundary data, not existence evidence.

For the OTHER actual endpoint, b=t¹⁰a₁ with a₁∈3D+10F₀+R and a₁|C₀=ρy₁. The same error-factor argument in the general first-leg identity forces ε₁=0 under full b divisibility. To transport the geometric proof, use the ACTUAL swap τ=t⁻¹,u₁=v/t³,v₁=u/t³. It exchanges F₀,F∞ and retains both original endpoint maps and their joint field. For Ωt=dt∧du/v and Ωτ=dτ∧du₁/v₁, one has Ωτ=−t⁻²Ωt. Together with θ₁=κt¹⁶θ₂, this changes the rational adjoint representative by t¹⁸ up to a nonzero scalar, exactly matching its change from C−6D−18F∞ to C−6D−18F₀. The SAME effective conductor divisor R is preserved; the first extension changes by the same factor. Hence the full-factor condition is invariant, and the argument applies to b in the swapped endpoint coordinates.

The theorem retains r20 as an OPEN actual-source boundary and says nothing about a genuinely mixed constant row. Degrees r≤11 are excluded separately by the accepted conic genus bound. No auxiliary map or abstract polynomial normal form replaces the original pair of finite étale maps from the SAME source.

## Audit provenance

The degree-fifteen full-factor implication and exact swapped frame passed the [fresh source-argument audit](../../Research/notes/oct03_ten_hour/split_fifteen_full_single_cubic_audit.md) and the [canonical presentation audit](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_FULL_CUBIC_EXTENSION_EXCLUSION_AUDIT_2026_10_03.md). The direct monic boundary proof, auxiliary unit treatment including R containing F∞, and full-factor error vanishing passed the [fresh direct-extension audit](../../Research/notes/oct03_ten_hour/split_full_cubic_zero_error_degree_extension_audit.md). The stronger all-degree boundary scope is recorded in its [self-contained note](../../Research/notes/oct03_ten_hour/split_full_cubic_degree_twenty_boundary.md) and submitted to its own fresh bounded whole-scope review. No settled numerical certificate is replayed.
