# Proof: no repeated horizontal conductor component in degree fifteen

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_MULTIPLE_HORIZONTAL_CONDUCTOR_EXCLUSION_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. The actual image and forced auxiliary points

Keep BOTH original degree-fifteen finite étale X maps on the SAME C₀, all their ACTUAL coordinate functions and cubics, the original θ₁=κt¹⁶θ₂ identity, disjoint reduced actual infinity fibers, and the exact split joint field k(C₀)=k(t,x₁,x₂). The accepted conic image is integral with this normalization and has CF=15,CD±=0. Its effective EXACT conductor-adjoint R=C−6L has RF=3,RD±=0 and ν*R=Δ.

The accepted [vertical-adjoint exclusion](canonical_fifteen_split_disjoint_vertical_adjoint_exclusion.md) removes F∞ from R. The accepted local auxiliary-point obstruction forces R|F∞ to contain BOTH points P± where U=s³u=0, s=t⁻¹. Indeed the actual simple poles of t and pole-three x₂ make C avoid these points. If ρ were a unit at one of them, the actual whole cubic and residue would give h³−U¹⁰=unit·δh for a regular h, with δ=U·unit·∂U; its first non-fifth-power exponent comparison is impossible.

The same statement holds at F₀ after swapping the TWO actual endpoints. The swap uses τ=t⁻¹,u₁=v/t³,v₁=u/t³ and the SAME conductor section under its canonical rational change. The exact frame transport Ωτ=−t⁻²Ωt and θ₁=κt¹⁶θ₂ changes the adjoint representative by t¹⁸, preserving its effective R divisor. Thus the first-leg auxiliary points are the two affine points t=v=0,u=±c, c²=−d. We will use this swapped forcing after showing that R has no vertical component in the multiple-horizontal sector.

## 2. Multiplicity reduces to two boundary-disjoint sections

Suppose a horizontal prime Z occurs in R with multiplicity m≥2. Since RF=3, its fiber degree is one and m≤3. If m=3, the entire nonzero infinity restriction R|F∞ would be supported at its single section value, contradicting the two distinct forced auxiliary points. Thus m=2. Its double infinity value must be one of the forced auxiliary points, and the remaining degree-one horizontal component must meet the other; a boundary point instead would leave room for only one auxiliary point.

Neither horizontal component is a boundary, and there is no fiber-degree budget for an additional boundary. With RD±=0, all effective intersections are now nonnegative. Every vertical prime meets at least one boundary positively, so no vertical component occurs, and both horizontal components avoid both boundaries. Therefore
\[
R=2Z+Z',\qquad Z\ne Z',\qquad ZF=Z'F=1,\quad ZD=Z'D=0.
\tag{1}
\]
A proper degree-one morphism from an integral component to the smooth rational base is finite and birational; base normality makes it an isomorphism. Thus Z,Z′ are genuinely smooth sections. This is not merely a statement about their normalizations.

In particular R has no F₀ component, and the swapped auxiliary obstruction in Section1 applies. The two sections meet opposite auxiliary points at BOTH F₀ and F∞.

## 3. Both extensions contain the ENTIRE double factor

The paired whole identities, whose errors vanish in degree15, are
\[
a³-P(u-1)\rho³=\gamma₂Q(\rho\mathcal Da-a\mathcal D\rho),
\]
\[
b³-t^{30}P(v/t³-1)\rho³
=\gamma₁Q(\rho Eb-bE\rho),
\tag{2}
\]
where γᵢ≠0, Q defines the actual C, and
\[
\mathcal Dt=v,\quad\mathcal Du=0,\quad\mathcal Dv=-3dt⁵;
\qquad Et=-tu,\quad Eu=-3(u²+d),\quad Ev=-3uv.
\]
At the generic point of Z all frames are regular and Q is a unit, since CF=15>Z F. Write ρ=f²r with r a unit. If 𝒟 is transverse to Z and a has local order α=0 or1, its Wronskian has order1+α: the coefficient α−2 is nonzero in characteristic5. The first numerator has order3α, since its polynomial term has order at least6. Orders0 versus1, or3 versus2, contradict(2). Thus ord_Z a≥2. The same calculation for E,b gives ord_Z b≥2 if E is transverse.

Tangency of either field would give exactly an excluded constant-q₀ section. Because Z avoids D, its u(t),v(t) are polynomials of degree at most3. If 𝒟 is tangent, its nonzero restricted derivation kills u, so u is constant; a polynomial of degree≤3 with zero differential in characteristic5 is constant. The conic equation v²=u²+d−dt⁶ is a square polynomial only when u²=−d, because otherwise its six roots are simple. Thus u=α₂,v=α₁t³ with αᵢ²=−d. Swapping endpoints gives the same conclusion for E tangency. Neither induced field can vanish generically: Dt=v=0 would contradict Dv=−3dt⁵, and Et=−tu=0 would contradict Eu=−3(u²+d).

The accepted [constant-component theorem](canonical_fifteen_split_constant_q0_conductor_exclusion.md) excludes those four sections. Hence BOTH fields are transverse and the full factors are
\[
2Z\le\operatorname{div}(a),\qquad 2Z\le\operatorname{div}(b).
\tag{3}
\]
The [independent doubled-factor audit](../../Research/notes/oct03_ten_hour/split_fifteen_double_conductor_factor_audit.md) checked this implication in its complete actual-source scope. No descent of an unmultiplied normalization function is assumed.

## 4. Explicit auxiliary section shape and its nonzero linear coefficient

Both sections have degree-one base map and avoid D, so u(t),v(t) have degree at most3. Their infinity auxiliary values give deg u≤2 and a leading v coefficient of square−d. Their zero auxiliary values give v(0)=0,u(0)²=−d. Comparing the t¹ and t⁵ coefficients of the conic equation consequently gives
\[
u=A₀+B₂t²,\quad v=C₁t+C₃t³,
\quad A₀²=C₃²=-d,\quad C₁²=2A₀B₂,\quad B₂²=2C₁C₃.
\tag{4}
\]
If B₂ or C₁ is zero, both vanish and the section is an excluded constant-q₀ section. Therefore C₁≠0 for each surviving section.

For completeness these relations give the exact twelve nonconstant possibilities. Choose c²=−d and a primitive cube root ω. Then
\[
u=\epsilon₀c(1+2\omega^{2k}t²),\qquad
v=\epsilon_\infty c(t³+2\omega^k t),
\]
\[
\epsilon₀,\epsilon_\infty\in\{1,-1\},\qquad k\in\{0,1,2\}.
\tag{5}
\]
Indeed C₁³=2dC₃ follows from(4), and(5) exhausts its three nonzero roots for each C₃ and each A₀ sign. This list is only an auxiliary conductor-component normal form. The two sections in(1) have opposite ε₀ and opposite ε∞ because their actual auxiliary values differ at both endpoints. No intersection classification of the sections is needed below.

## 5. The zero-fiber cubic restriction has impossible parity

Let p=Z′∩F₀. This is t=v=0,u=A₀, with A₀²=−d. The coordinates(t,v) are regular parameters on the smooth surface near p because u is a unit. The other section Z meets the OPPOSITE auxiliary point at F₀, so its local equation is a unit at p. The first-leg actual simple zeros of t have x₁ pole three, hence v=t³(x₁+1) is a unit at every actual C₀ point over F₀. Thus C avoids p and Q is a unit there.

The local prime equation of Z′ is
\[
w=v-C₁t-C₃t³.
\]
At its generic point or in this local ring, ρ=w·unit because the double Z factor is a unit at p. When restricting a derivative to ρ=0, derivatives of that unit frame disappear. Directly,
\[
\mathcal Dw|Z'
=-3dt⁵-(C₁+3C₃t²)(C₁t+C₃t³)
=-C₁²t+C₁C₃t³,
\tag{6}
\]
where C₃²=−d cancels the t⁵ coefficient. Since C₁≠0, this has EXACT order one at p. Thus the section 𝒟ρ|Z′ has odd order one as well; all remaining frame factors are units.

Suppose a|Z′ is generically nonzero. Restrict the first whole identity(2) to Z′, where ρ=0, and cancel a in its function field. It gives the intrinsic regular-section equality
\[
a²=-\gamma₂Q\mathcal D\rho\quad\text{on }Z'.
\tag{7}
\]
At p the right side has order one because Q is a unit and(6) has order one. The square on the left must have even order. This contradiction does not depend on the choice of common regular R frame: its derivative changes by a term multiple of ρ, which vanishes on Z′.

Hence a|Z′ is zero. Cartier divisibility gives Z′|a globally. Combining with(3), the ENTIRE R=2Z+Z′ divides a. This contradicts the accepted [degree-fifteen full single-cubic extension exclusion](canonical_fifteen_split_full_cubic_extension_exclusion.md). The hypothesized repeated horizontal component is therefore impossible.

## Scope and provenance

The new parity calculation passed the [fresh independent focused check](../../Research/notes/oct03_ten_hour/split_fifteen_double_auxiliary_parity_check.md). Its original doubled-factor and twelve-section inputs passed the [independent factor audit](../../Research/notes/oct03_ten_hour/split_fifteen_double_conductor_factor_audit.md). The current canonical proof requires its own fresh bounded whole presentation/scope audit before integration.

A longer [finite contact exploration](../../Research/notes/oct03_ten_hour/split_fifteen_mixed_row_contact_obstruction.md) remains useful partial provenance, explicitly pending its own whole audit; NONE of its proposed finite crossing classifications is a dependency of this parity proof. No numerical computation or fixed-P crossing check is required here.

Only repeated HORIZONTAL components are excluded. A configuration containing a boundary and repeated VERTICAL components requires separate analysis. BOTH actual finite étale maps, actual cubics, canonical identity and split joint field remain on the SAME C₀ throughout, and on the original T when present. Neither the section normal form nor a replacement auxiliary curve is an actual-source construction, and the unmarked common-cover problem remains outside this conclusion.
