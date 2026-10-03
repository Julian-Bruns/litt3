# Proof: zero-error original cubics have forced auxiliary conductor factors

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_SPLIT_ZERO_ERROR_AUXILIARY_CUBIC_FACTOR_CONSTRAINTS_FIDELITY_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. The actual paired identities and actual auxiliary avoidance

Keep BOTH original finite étale maps on the SAME C₀/T, their ACTUAL cubics, disjoint reduced infinities, joint field, q₀ identity and θ₁=κt¹⁶θ₂. The accepted [conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) and [paired cubic theorem](canonical_split_paired_cubic_adjoint_counterterms.md) supply C⊂S, its normalization C₀, the SAME exact conductor R=C−6L and original ρ,a,b.

For an individual zero error the corresponding exact identity is
\[
a³-P(u-1)\rho³=\gamma₂Q(\rho\mathcal Da-a\mathcal D\rho),
\]
\[
b³-t^{30}P(v/t³-1)\rho³
=\gamma₁Q(\rho Eb-bE\rho),
\tag{1}
\]
where Q defines the ACTUAL C, γᵢ≠0 have the established residue calibration, and
\[
\mathcal Dt=v,\quad\mathcal Du=0,\quad\mathcal Dv=-3dt⁵,
\qquad Et=-tu,\quad Eu=-3(u²+d),\quad Ev=-3uv.
\tag{2}
\]
An identity in(1) is used ONLY when its OWN error εᵢ is zero. No implication from one zero error to the other is assumed.

At F₀ the auxiliary points have t=v=0,u²=−d. Original t has a simple zero at every H₁ point, while actual x₁ has pole order three. Thus v=t³(x₁+1) is a unit at every actual branch over zero. C avoids both auxiliary points. At F∞ use s=t⁻¹,U=s³u,V=s³v. At every actual H₂ point, s is a parameter and x₂ has pole three, so U is a unit. C avoids both auxiliary U=0 points there too. Hence the actual local Q coefficient is a unit at EVERY point used below. This fact cannot be replaced by an arbitrary conic-polynomial model.

## 2. Auxiliary section slopes and exact contacts

Consider j distinct nonconstant boundary-disjoint section components at an auxiliary F₀ point p=(0,u₀,0),u₀²=−d. Their coordinates have degree≤3: a boundary-disjoint section has no finite pole, and t⁻³u,t⁻³v are regular at infinity. The conic gives the local forms
\[
u=u₀+u₂t²+u₃t³,\qquad v=ct+v₂t²+v₃t³.
\tag{3}
\]
If c=0, then u−u₀ has order≥4 and its degree bound forces u constant; the conic then gives v=±√(−d)t³. These are the constant-q₀ sections explicitly excluded by the premise. Hence c≠0.

Coefficient comparison gives
\[
u₂=c²/(2u₀),\qquad u₃=cv₂/u₀,
\qquad v₂(u₂c/u₀-v₃)=0.
\tag{4}
\]
If v₂=0, the remaining equations force v₃=c³/(8u₀²),c⁶=d³; for fixed u₀,c there is ONE section. If v₂≠0, they force
\[
v₃=c³/(2u₀²),\qquad v₂²=3c⁴/u₀²,
\qquad c⁶=-d³.
\tag{5}
\]
There are exactly TWO opposite nonzero v₂ choices, with intersection contact two. The two sixth-power cases cannot coincide for the same slope. Thus at most two distinct sections share a slope; their contact is two. All other pairs have contact one. For each component Zᵢ,
\[
\sum_{k\ne i}I_p(Z_i,Z_k)=j-1+e_i,
\qquad e_i\in\{0,1\}.
\tag{6}
\]
No paired square-ratio or auxiliary source realization is assumed in this elementary section geometry.

## 3. The first whole cubic forces surface order at least j

At p, t,v are surface parameters. The leading vector field is D₀=v∂t. The R coefficient has leading homogeneous term
\[
\rho_j=\prod_i(v-c_it)=v^jR(q),\qquad q=t/v,
\qquad R(q)=\prod_i(1-c_iq).
\tag{7}
\]
R has EXACT degree j and every root has multiplicity≤2. The absence of other local R components is essential here.

Assume ε₂=0 and suppose a has first nonzero homogeneous term of degree ℓ<j. A constant is impossible in(1). Write a_ℓ=v^ℓA(q),degA≤ℓ. Its cube has degree3ℓ, the first possible Wronskian degree j+ℓ, while the Pρ³ term has degree at least3j. Unit-frame derivative corrections occur one degree later and do not affect these terms.

If2ℓ<j, the cube has strictly smaller degree than every possible right term, impossible. If2ℓ>j, the leading Wronskian must vanish:
\[
RA'-AR'=0.
\tag{8}
\]
Then A/R∈k(q⁵). Its finite pole orders are≤2, whereas those of any rational fifth power are divisible by five. Therefore there are no finite poles. Since degA<j, it also has a zero at infinity, and hence is zero. This contradicts A≠0. This argument also covers j=5 when the leading derivative coefficient of R vanishes.

For1≤j≤5 the equality2ℓ=j has only(j,ℓ)=(2,1),(4,2), with homogeneous equation
\[
A³=c_*\bigl(RA'-AR'\bigr),\qquad c_*=\gamma₂Q(p)\ne0.
\tag{9}
\]
For j=2, degree-one A gives left degree three and right at most two. A nonzero constant gives right exact degree one, since R has exact degree two and characteristic≠2. Neither can work.

For j=4, degree-two A gives left degree six and right at most five. Degree-one A gives right exact degree four, with nonzero leading factor1−4, whereas its cube has degree three. A nonzero constant gives right degree three, since coefficient4 is nonzero. Again no possibility works. Consequently
\[
a\in(t,v)^j.
\tag{10}
\]
No corresponding assertion for j≥6 or additional/repeated local components has been established.

## 4. Exact residue forces every associated component

If a is generically nonzero on Zᵢ, restricting its OWN zero-error identity and cancelling gives
\[
a²|Z_i=-\gamma₂Q|Z_i\mathcal D\rho|Z_i.
\tag{11}
\]
For its graph v=fᵢ(t)=cᵢt+…, one has
\[
\mathcal D(v-f_i(t))|Z_i=-3dt⁵-f_i'f_i=-c_i²t+O(t²).
\]
This prime normal order is exactly one. Other local graph factors contribute the exact contacts(6); the derivative of their common unit disappears on ρ=0. Hence
\[
\operatorname{ord}_p(\mathcal D\rho|Z_i)=j+e_i.
\tag{12}
\]
Q is a unit. An odd value of j+eᵢ contradicts a square. An even value forces ord_p(a|Zᵢ)=(j+eᵢ)/2<j for j≥2, contrary to(10). For j=1 the odd case already applies. Therefore a vanishes identically on EVERY prime section in the cluster; each entire section divides it globally.

For the original first endpoint, use the accepted ACTUAL swap τ=t⁻¹,u₁=v/t³,v₁=u/t³ and common-adjoint transport. Its original extension a₁=ρy₁ differs from b only by t¹⁰, a vertical factor. Thus the same argument at its auxiliary zero fiber gives the associated b factors at F∞ whenever its OWN ε₁ is zero. Horizontal multiplicities do not change under this transport.

## 5. An isolated linear branch has odd normals for BOTH finite fields

Now assume only an isolated smooth multiplicity-one branch at F₀, with graph v=f(t)=ct+…,c≠0. It need not be a global section. Write ρ=e(v−f),e a local unit. On its prime,
\[
\mathcal D(v-f)=-c²t+O(t²),
\qquad E(v-f)=u(tf'-3f)=-2u₀ct+O(t²).
\tag{13}
\]
Both normal orders are exactly one. Unit derivatives disappear after restriction. If ε₂=0 and a is nonzero on this component, its residue square(11) has odd order one, impossible. If ε₁=0 and b is nonzero, its OWN residue square with E has the same odd order, also impossible. Thus each individual zero error forces that individual's factor, and BOTH zero errors force BOTH original factors.

## 6. Infinity frames retain the same isolated implication

At infinity, Δ=s²D and Ξ=s²E are regular and
\[
\Delta s=-sV,\quad\Delta U=-3UV,\quad
\Delta V=-3(U²+ds⁶),
\]
\[
\Xi s=U,\quad\Xi U=-3ds⁵,\quad\Xi V=0.
\tag{14}
\]
At an isolated auxiliary graph U=f(s)=cs+…,V(0)=V₀≠0, their prime normal derivatives are
\[
\Delta(U-f)=V(sf'-3f)=-2V₀cs+O(s²),
\qquad\Xi(U-f)=-c²s+O(s²).
\tag{15}
\]
Both again have exact order one.

Use a regular common R frame e away from D and compatible coefficients
\[
\rho=e\rho₀,\quad a=e s^{-10}a₀,\quad b=e s^{-10}b₀,
\qquad Q=e s^{-18}q.
\tag{16}
\]
Frame derivatives cancel in each Wronskian. The relative weight term−10s⁻¹V₀(s)ρ₀a₀ or b₀ is ZERO in characteristic five. Thus each individual zero error gives its regular local identity
\[
a₀³-P_\infty\rho₀³
=\gamma₂q(\rho₀\Delta a₀-a₀\Delta\rho₀),
\]
\[
b₀³-P(V-1)\rho₀³
=\gamma₁q(\rho₀\Xi b₀-b₀\Xi\rho₀),
\tag{17}
\]
where P∞=s³⁰P(s⁻³U−1) is regular. The actual q is a unit. The own-error residue squares with(15) therefore force the corresponding original factor, exactly as in Section5. This proves the isolated implication for either endpoint without inferring one zero error from the other.

## 7. Scope, conditional mixed application and audit provenance

Clustered cross-end factor forcing is NOT a consequence. The semisimple field in an auxiliary two-section cluster has a different homogeneous equation and can admit nonzero linear coefficients for some slope ratios. The isolated no-other-local-component premise cannot be dropped. Nonzero general errors, constant-q₀ or repeated cluster sections, vertical components through p and clusters of size≥6 remain separate.

As a conditional source application, suppose16≤r≤19 and R is a reduced union of nonconstant boundary-disjoint sections with no vertical part, BOTH errors zero, and each component meets at least one auxiliary endpoint where it occurs ALONE. Sections5–6 put every horizontal component into both a,b, contradicting the accepted [horizontal-factor theorem](canonical_split_sixteen_nineteen_horizontal_cubic_factor_exclusion.md). In particular this applies to four sections consisting of two auxiliary-zero-only and two auxiliary-infinity-only sections, each pair occupying distinct auxiliary points at its endpoint. It is not a whole four-section or higher-degree source exclusion.

The first constituent source is [the cluster note](../../Research/notes/oct03_ten_hour/split_auxiliary_five_section_local_factor_lemma.md), SHA256 `cfdee49d41e8099af6f483406674c376e2b6bdac246e540f3c260338e3f46d17`, with [fresh whole PASS receipt](../../Research/notes/oct03_ten_hour/split_auxiliary_five_section_local_factor_audit.md). The second is [the isolated BOTH-factor note](../../Research/notes/oct03_ten_hour/split_isolated_auxiliary_both_cubic_factor_lemma.md), SHA256 `3d7d6980727fc8245e9e1a615d5fa8599fe0278ec221f16f224ed0ebaa67ec8b`, with [fresh whole PASS receipt](../../Research/notes/oct03_ten_hour/split_isolated_auxiliary_both_cubic_factor_audit.md), SHA256 `df96bc1a3d16faf9b02722db65ef2caf28ef462e9317233ad05b238a3343ed49`. The canonical synthesis requires only a fresh focused scope and presentation check against these accepted arguments, not a numerical replay.

Both ACTUAL maps, cubics, canonical identities and joint field remain on their SAME original C₀/T. Auxiliary conductor coordinates are not endpoint maps. General higher-degree source geometry and the unmarked common-cover problem remain OPEN.
